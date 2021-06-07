/*-****************************************************************************

 * Copyright (C) 2017-2019 André Guerreiro - <aguerreiro1985@gmail.com>
 * Copyright (C) 2017-2019 Adriano Campos - <adrianoribeirocampos@gmail.com>
 * Copyright (C) 2019 Miguel Figueira - <miguel.figueira@caixamagica.pt>
 *
 * Licensed under the EUPL V.1.2

****************************************************************************-*/

#include <algorithm>
#include "CMDSignature.h"
#include "MiscUtil.h"
#include "StringOps.h"
#include "PDFSignature.h"
#include "cmdServices.h"
#include "eidlibException.h"
#include "proxyinfo.h"
#include "Util.h"
#include "Hash.h"
#include "eidErrors.h"

static char logBuf[512];

namespace eIDMW
{

bool isDBG = false;

void printData(char *msg, unsigned char *data, unsigned int dataLen)
{
    if (NULL == msg)
    {
        printf("Data:\n");
    }
    else
    {
        printf("%s\n", msg);
    }

    for (unsigned int i = 0; i < dataLen; i++)
    {
        if ((i > 0) && (0 == (i % 20)))
            printf("\n");
        printf("%02x", data[i]);
    }
    printf("\n");
}

    CMDProxyInfo CMDProxyInfo::buildProxyInfo() {
        ProxyInfo proxyinfo;

        std::string endpoint = CMDSignature::getEndpoint();
        CMDProxyInfo cmd_proxyinfo;

        if (proxyinfo.isAutoConfig())
        {
            std::string proxy_host;
            long proxy_port;
            proxyinfo.getProxyForHost(endpoint, &proxy_host, &proxy_port);
            if (proxy_host.size() > 0)
            {
                cmd_proxyinfo.host = proxy_host.c_str();
                cmd_proxyinfo.port = proxy_port;
            }
        }
        else if (proxyinfo.isManualConfig()) {
            cmd_proxyinfo.host = proxyinfo.getProxyHost();
            try {
                cmd_proxyinfo.port = std::stol(proxyinfo.getProxyPort());
            }
            catch (...) {
                MWLOG_ERR(logBuf, "Error parsing proxy port to number value.");
            }
            if (proxyinfo.getProxyUser().size() > 0) {
                cmd_proxyinfo.user = proxyinfo.getProxyUser();
                cmd_proxyinfo.pwd = proxyinfo.getProxyPwd();
            }
        }

        if (proxyinfo.isAutoConfig() || proxyinfo.isManualConfig()){
            MWLOG_DEBUG(logBuf, "buildProxyInfo is returning host=%s, port=%lu", cmd_proxyinfo.host.c_str(), cmd_proxyinfo.port);
            MWLOG_DEBUG(logBuf, "buildProxyInfo proxy authentication? %s", (cmd_proxyinfo.user.size() > 0 ? "YES" : "NO"));
        }
        return cmd_proxyinfo;
    }

    CMDSignature::CMDSignature(std::string basicAuthUser, std::string basicAuthPassword, std::string applicationId) {
        m_basicAuthUser = basicAuthUser;
        m_basicAuthPassword = basicAuthPassword;
        m_applicationId = applicationId;
        cmdService = NULL;
    }

    CMDSignature::CMDSignature(std::string basicAuthUser, std::string basicAuthPassword, std::string applicationId, PTEID_PDFSignature *in_pdf_handler) {
        m_basicAuthUser = basicAuthUser;
        m_basicAuthPassword = basicAuthPassword;
        m_applicationId = applicationId;
        cmdService = NULL;
        m_pdf_handlers.push_back(in_pdf_handler);
    }

CMDSignature::~CMDSignature()
{
    m_pdf_handlers.clear();
    if (cmdService)
    {
        delete cmdService;
    }
}

std::string CMDSignature::getEndpoint()
{
    return CMDServices::getEndpoint();
}
void CMDSignature::cancelRequest()
{
    cmdService->cancelRequest();
}
void CMDSignature::set_pdf_handler(PTEID_PDFSignature *in_pdf_handler)
{
    m_pdf_handlers.clear();
    m_pdf_handlers.push_back(in_pdf_handler);
}

void CMDSignature::add_pdf_handler(PTEID_PDFSignature *in_pdf_handler)
{
    m_pdf_handlers.push_back(in_pdf_handler);
}

void CMDSignature::clear_pdf_handlers()
{
    m_pdf_handlers.clear();
}

void CMDSignature::set_string_handler(std::string in_docname_handle,
                                      CByteArray in_array_handler)
{
    m_docname_handle = in_docname_handle;
    m_array_handler = in_array_handler;
}

char *CMDSignature::getCertificateCitizenName()
{
    PDFSignature *pdf = m_pdf_handlers[0]->getPdfSignature();

    return pdf->getCitizenCertificateName();
}

char *CMDSignature::getCertificateCitizenID()
{
    PDFSignature *pdf = m_pdf_handlers[0]->getPdfSignature();

    return pdf->getCitizenCertificateID();
}

int CMDSignature::cli_getCertificate(std::string in_userId)
{
    if (m_pdf_handlers.empty() && m_array_handler.Size() == 0)
    {
        MWLOG_ERR(logBuf, "NULL handler");
        return ERR_NULL_PDF_HANDLER;
    }
    for (size_t i = 0; i < m_pdf_handlers.size(); i++)
    {
        if (NULL == m_pdf_handlers[i])
        {
            MWLOG_ERR(logBuf, "NULL pdf_handler");
            return ERR_NULL_PDF_HANDLER;
        }
    }

    if (isDBG)
    {
        printData((char *)"\nUserId: ", (unsigned char *)in_userId.c_str(), in_userId.size());
    }

    std::vector<CByteArray> certificates;
    int ret = cmdService->getCertificate(m_proxyInfo, in_userId, certificates);

    if (ret != ERR_NONE)
        return ret;

    if (0 == certificates.size())
    {
        MWLOG_ERR(logBuf, "getCertificate failed\n");
        return ERR_GET_CERTIFICATE;
    }

    if (m_pdf_handlers.size() > 0)
    {
        for (size_t i = 0; i < m_pdf_handlers.size(); i++)
        {
            PDFSignature *pdf = m_pdf_handlers[i]->getPdfSignature();
            if (NULL == pdf)
            {
                MWLOG_ERR(logBuf, "NULL Pdf\n");
                return ERR_NULL_PDF;
            }

            pdf->setBatch_mode(false);

            pdf->setExternCertificate(certificates.at(0));

            pdf->setIsCC(false);

            std::vector<CByteArray> newVec(certificates.begin() + 1, certificates.end());
            pdf->setExternCertificateCA(newVec);
        }
    }
    else
    {
        CByteArray externCertificate = certificates.at(0);
        m_string_certificate = externCertificate.ToString(false, false);
        if (isDBG)
        {
            printData((char *)"\n Certificate: ",
                      (unsigned char *)externCertificate.GetBytes(),
                      externCertificate.Size());
        }
    }

    return ERR_NONE;
}

/*  *********************************************************
    ***    CMDSignature::cli_sendDataToSign()          ***
    ********************************************************* */
int CMDSignature::cli_sendDataToSign(std::string in_pin)
{

    if (m_pdf_handlers.empty() && m_array_handler.Size() == 0)
    {
        MWLOG_ERR(logBuf, "NULL handler");
        return ERR_NULL_PDF_HANDLER;
    }
    for (size_t i = 0; i < m_pdf_handlers.size(); i++)
    {
        if (NULL == m_pdf_handlers[i])
        {
            MWLOG_ERR(logBuf, "NULL pdf_handler");
            return ERR_NULL_PDF_HANDLER;
        }
    }

    /* printData */
    if (isDBG)
    {
        printData((char *)"\nIN - User Pin: ", (unsigned char *)in_pin.c_str(), in_pin.size());
    }

    /*
            The actual signature input for RSA is a DigestInfo ASN.1 structure according to PKCS #1
            and we are always using SHA-256 digest so it should work like this
            For reference
            DigestInfo ::= SEQUENCE {
                    digestAlgorithm AlgorithmIdentifier,
                    digest OCTET STRING
                }
            */
    unsigned char sha256SigPrefix[] = {
        0x30, 0x31, 0x30, 0x0d, 0x06, 0x09,
        0x60, 0x86, 0x48, 0x01, 0x65, 0x03, 0x04, 0x02, 0x01,
        0x05, 0x00, 0x04, 0x20};

    std::string userPin = in_pin;
    CByteArray hashByteArray;
    std::string DocName;

    std::vector<CByteArray *> signatureInputs; //used only to keep track of pointers to be deleted
    std::vector<unsigned char *> signatureInputsBytes;
    std::vector<std::string> signDocNames;

    if (m_pdf_handlers.size() > 0)
    {
        for (size_t i = 0; i < m_pdf_handlers.size(); i++)
        {
            PDFSignature *pdf = m_pdf_handlers[i]->getPdfSignature();
            if (NULL == pdf)
            {
                MWLOG_ERR(logBuf, "NULL Pdf\n");
                return ERR_NULL_PDF;
            }
            /* Calculate hash */
            hashByteArray = pdf->getHash();
            DocName = pdf->getDocName();

            //Truncate docName to the first 44 UTF-8 characters not bytes
            truncateUtf8String(DocName, 44);
            signDocNames.push_back(DocName);

            CByteArray *signatureInput = new CByteArray(sha256SigPrefix, sizeof(sha256SigPrefix));
            signatureInput->Append(hashByteArray);
            signatureInputs.push_back(signatureInput);
            signatureInputsBytes.push_back(signatureInput->GetBytes());
        }
    }
    else
    {
        if (m_computeHash)
        {
            /* Calculate hash */
            CHash hash;
            hashByteArray = hash.Hash(tHashAlgo::ALGO_SHA256, m_array_handler);
        }
        else
        {
            hashByteArray = m_array_handler;
        }

        DocName = m_docname_handle;
        //Truncate docName to the first 44 UTF-8 characters not bytes
        truncateUtf8String(DocName, 44);
        signDocNames.push_back(DocName);

        CByteArray *signatureInput = new CByteArray(sha256SigPrefix, sizeof(sha256SigPrefix));
        signatureInput->Append(hashByteArray);
        signatureInputs.push_back(signatureInput);
        signatureInputsBytes.push_back(signatureInput->GetBytes());
    }

    // make document names sent to cmd service unique
    std::vector<std::string *> docNamesPtrs;
    for (size_t i = 0; i < signDocNames.size(); i++)
    {
        docNamesPtrs.push_back(&signDocNames[i]);
    }

    CPathUtil::generate_unique_filenames("", docNamesPtrs, "");

    if (0 == hashByteArray.Size())
    {
        MWLOG_ERR(logBuf, "getHash failed\n");
        return ERR_GET_HASH;
    }

    /* printData */
    if (isDBG)
    {
        printData((char *)"\nhash: ", hashByteArray.GetBytes(), hashByteArray.Size());
    }

    int ret;
    if (m_pdf_handlers.size() == 1 || m_array_handler.Size() > 0)
        ret = cmdService->ccMovelSign(m_proxyInfo, signatureInputsBytes[0], signDocNames[0], userPin);
    else
        ret = cmdService->ccMovelMultipleSign(m_proxyInfo, signatureInputsBytes, signDocNames, userPin);

    for (size_t i = 0; i < signatureInputs.size(); i++)
        delete signatureInputs[i];

    if (ret != ERR_NONE)
    {
        MWLOG_ERR(logBuf, "CMDSignature - Error @ sendDataToSign()");
        return ret;
    }

    return ERR_NONE;
} // namespace eIDMW

/*  *********************************************************
    ***    CMDSignature::signOpen()                       ***
    ********************************************************* */
int CMDSignature::signOpen(CMDProxyInfo proxyinfo, std::string in_userId, std::string in_pin, CByteArray &in_hash, std::string docname)
{
    set_string_handler(docname, in_hash);
    clear_pdf_handlers();
    m_computeHash = false;
    return signOpen(proxyinfo, in_userId, in_pin, 0, 0, 0, NULL, NULL, NULL);
}

int CMDSignature::signOpen(CMDProxyInfo proxyinfo, std::string in_userId, std::string in_pin, int page, double coord_x, double coord_y, const char *location, const char *reason, const char *outfile_path)
{
    m_userId = in_userId;
    if (cmdService)
    {
        delete cmdService;
    }
    cmdService = new CMDServices(m_basicAuthUser, m_basicAuthPassword, m_applicationId);
    m_proxyInfo = proxyinfo;

    int ret = cli_getCertificate(in_userId);
    if (ret != ERR_NONE)
        return ret;

    if (m_pdf_handlers.size() > 0)
    {

        std::vector<std::string *> filenames;
        for (size_t i = 0; i < m_pdf_handlers.size(); i++)
        {
            PDFSignature *pdf = m_pdf_handlers[i]->getPdfSignature();
            // output filename should not be trimmed
            filenames.push_back(new std::string(pdf->getDocName()));
        }

        if (m_pdf_handlers.size() > 1)
            CPathUtil::generate_unique_filenames(outfile_path, filenames, "_signed");
        else
            filenames[0]->assign(outfile_path);

        int error = ERR_NONE;
        for (size_t i = 0; i < m_pdf_handlers.size(); i++)
        {
            PDFSignature *pdf = m_pdf_handlers[i]->getPdfSignature();

            if (coord_x >= 0 && coord_y >= 0)
            {
                pdf->setVisibleCoordinates(page > 0 ? page : pdf->getPageCount(), coord_x, coord_y);
            }
            try{
                ret = pdf->signFiles(location, reason, filenames[i]->c_str(), false);
            } catch (eIDMW::CMWException &e) {
                throw PTEID_Exception(e.GetError());
            }

            delete filenames[i];

            if (ret != ERR_NONE)
            {
                MWLOG_ERR(logBuf, "PDFSignature::signFiles failed: %d", ret);
                error = ERR_SIGN_PDF;
            }
        }
        if (error != ERR_NONE)
            return error;
    }
    else
    {
        if (isDBG)
        {
            printf(" Sign String\n");
            printData((char *)"\n String: ",
                      (unsigned char *)m_docname_handle.c_str(), m_docname_handle.size());
        }
    }

    ret = cli_sendDataToSign(in_pin);
    return ret;
}

int CMDSignature::cli_getSignatures(std::string in_code,
                                    std::vector<PTEID_ByteArray *> out_sign)
{
    if (m_pdf_handlers.empty() && m_array_handler.Size() == 0)
    {
        MWLOG_ERR(logBuf, "NULL pdf_handlers");
        return ERR_NULL_PDF_HANDLER;
    }
    for (size_t i = 0; i < m_pdf_handlers.size(); i++)
    {
        if (NULL == m_pdf_handlers[i])
        {
            MWLOG_ERR(logBuf, "NULL pdf_handler");
            return ERR_NULL_PDF_HANDLER;
        }
    }

    /* printData */
    if (isDBG)
    {
        printData((char *)"\nReceived code: ",
                  (unsigned char *)in_code.c_str(),
                  in_code.size());
    }

    std::vector<CByteArray *> cbVector;
    for (size_t i = 0; i < out_sign.size(); i++)
    {
        cbVector.push_back(new CByteArray());
    }

    int ret = cmdService->getSignatures(m_proxyInfo, in_code, cbVector);

    if (ret != ERR_NONE)
    {
        for (size_t i = 0; i < cbVector.size(); i++)
            delete cbVector[i];
        return ret;
    }

    for (size_t i = 0; i < out_sign.size(); i++)
    {
        out_sign[i]->Clear();
        out_sign[i]->Append((const unsigned char *)cbVector[i]->GetBytes(), cbVector[i]->Size());
        delete cbVector[i]; // Append method copies bytes, so it is safe to free
    }

    return ERR_NONE;
}

int CMDSignature::signClose(std::string in_code)
{
    std::vector<PTEID_ByteArray *> signatures;
    if (m_pdf_handlers.size() > 0 || m_array_handler.Size() > 0)
    {
        for (size_t i = 0; i < (std::max)(m_pdf_handlers.size(), std::size_t{1}); i++)
        {
            signatures.push_back(new PTEID_ByteArray());
        }
    }
    else
    {
        return ERR_NULL_HANDLER;
    }

    int ret = cli_getSignatures(in_code, signatures);

    if (ret != ERR_NONE)
    {
        for (size_t i = 0; i < m_pdf_handlers.size(); i++)
            delete signatures[i];
        return ret;
    }

    if (m_pdf_handlers.size())
    {
        bool throwTimestampError = false;
        bool throwLTVError = false;
        int ret_had_errors = ERR_NONE;
        for (size_t i = 0; i < m_pdf_handlers.size(); i++)
        {
            try{
                PDFSignature *pdf = m_pdf_handlers[i]->getPdfSignature();
                // TODO: look for signature with right id and match it
                CByteArray signature_cba(signatures[i]->GetBytes(), signatures[i]->Size());

                ret = pdf->signClose(signature_cba);
            }
            catch (CMWException &e) {
                if (e.GetError() != EIDMW_TIMESTAMP_ERROR && e.GetError() != EIDMW_LTV_ERROR){
                    throw PTEID_Exception(e.GetError());
                }
                if (e.GetError() == EIDMW_TIMESTAMP_ERROR)
                    throwTimestampError = true;
                else
                    throwLTVError = true;
            }

            if (ret != ERR_NONE)
            {
                ret_had_errors = ret;
                MWLOG_ERR(logBuf, "SignClose failed");
            }
            if (isDBG)
            {
                printData((char *)"\nSignature: ", (unsigned char *)signatures[i]->GetBytes(), signatures[i]->Size());
            }
        }

        if (throwLTVError)
                throw PTEID_Exception(EIDMW_LTV_ERROR);

        if (throwTimestampError)
                throw PTEID_Exception(EIDMW_TIMESTAMP_ERROR);

        if (ret_had_errors != ERR_NONE)
            return ERR_SIGN_CLOSE;
    }
    else
    {
        if (isDBG)
        {
            printf("Sign Close String\n");
            printData((char *)"\n String: ",
                      (unsigned char *)m_docname_handle.c_str(), m_docname_handle.size());
        }

        CByteArray ba(signatures[0]->GetBytes(), signatures[0]->Size());
        m_string_signature = ba.ToString(false, false);
    }

    return ERR_NONE;
}

int CMDSignature::sendSms() {
    return cmdService->forceSMS(m_proxyInfo, m_userId);
}

}
