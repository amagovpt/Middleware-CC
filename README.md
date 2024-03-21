# Middleware Oficial de Identificação Eletrónica em Portugal - Cartão de Cidadão, da Chave Móvel Digital e Sistema de Certificação de atributos profissionais

> **⚠ IMPORTANTE: Suporte ao novo Cartão de Cidadão.**
>
> Para adaptar-se ao novo Cartão de Cidadão, que em breve será emitido, garantindo a padronização europeia estabelecida na diretiva UE 1157/2019, novas funcionalidades e mais segurança dos documentos de identificação, procedeu-se à atualização da aplicação desktop Autenticação.gov e do SDK do middleware do Cartão de Cidadão, que se disponibiliza aqui em modo "pre-release": https://github.com/amagovpt/autenticacao.gov/releases
> 
> As principais mudanças na versão desktop da aplicação Autenticação.gov são:
> 
> * Interface sem contacto (contactless) para assinar documentos e ler dados de identidade do Cidadão. Veja aqui no manual: [Manual de Utilização](https://amagovpt.github.io/docs.autenticacao.gov/user_manual.html)
> 
> Em relação ao SDK do middleware do Cartão de Cidadão, as principais mudanças são:
> 
>* Para usar a interface com contato, basta atualizar o software, sem precisar de alterações significativas na integração com o SDK.
>
>* Para usar a interface sem contacto (contactless), é necessário usar métodos novos do SDK, a [documentação](https://amagovpt.github.io/docs.autenticacao.gov/manual_sdk.html) deve ser consultada, bem como os [exemplos](https://github.com/amagovpt/docs.autenticacao.gov/tree/main/SDK_Examples).
> 
>* Os certificados e chaves criptográficas do novo Cartão de Cidadão usam um algoritmo criptográfico de curvas elípticas (ECDSA) em vez do algoritmo RSA usado nas versões anteriores do Cartão de Cidadão. Esta mudança deve ser levada em conta nas aplicações que utilizam os métodos de criptografia do SDK ou que verificam dados assinados pelo Cartão de Cidadão.

> Esta nova atualização do software garante a compatibilidade com o novo modelo do Cartão de Cidadão e com os modelos antigos do documento que ainda estejam válidos e em uso.

## Introdução
### Objectivos

O objectivo deste projecto é disponibilizar uma nova versão de middleware que facilite e potencie a utilização do Cartão de Cidadão
e da assinatura com Chave Móvel Digital

## Documentação

O código fonte da documentação e os documentos técnicos deste projecto foram transferidos para o repositório https://github.com/amagovpt/docs.autenticacao.gov.

### Manual de Utilização

O Manual de Utilização pretende descrever todas as funcionalidades providenciadas pelo middleware do Cartão de Cidadão.

[Manual de Utilização (online)](https://amagovpt.github.io/docs.autenticacao.gov/user_manual.html)

[Manual de Utilização (download pdf)](https://amagovpt.github.io/docs.autenticacao.gov/Manual_de_Utilizacao_v3.pdf)

### SDK

Está disponível um SDK, com o objetivo de disponibilizar a integração com outras aplicações, das funcionalidades desenvolvidas no âmbito deste projeto.
Existem SDK's para as linguagens C, C++, JAVA e C#.

Poderá aceder ao manual no seguinte URL:

[Manual do SDK (online)](https://amagovpt.github.io/docs.autenticacao.gov/manual_sdk.html)

[Manual do SDK (download pdf)](https://amagovpt.github.io/docs.autenticacao.gov/Manual_de_SDK.pdf)

A documentação da API disponibilizada pelo SDK está disponível nos seguintes URLs:


[Documentação Técnica do SDK C++ (online)](https://amagovpt.github.io/docs.autenticacao.gov/sdk/cpp/)

[Documentação Técnica do SDK Java (online)](https://amagovpt.github.io/docs.autenticacao.gov/sdk/java/)

## Compilar o Middleware do Cartão de Cidadão

### Linux

1. Instalação das dependências.
   As dependências para a compilação do Middleware em Linux (nomes de pacotes válidos para a distribuição Ubuntu 22.04), são as seguintes:

   ```bash
   sudo apt install build-essential libpcsclite-dev libpoppler-qt5-dev libzip-dev libopenjp2-7-dev libpng-dev openjdk-11-jdk qtbase5-dev qt5-qmake qtbase5-private-dev qtdeclarative5-dev qtquickcontrols2-5-dev qml-module-qtquick-controls2 libssl-dev libxerces-c-dev libxml-security-c-dev swig libcurl4-openssl-dev libcjson-dev libeac-dev
   ```

   As dependências para execução do Middleware em Linux (nomes de pacotes válidos para a distribuição Ubuntu 22.04), são as seguintes:
   ```bash
   sudo apt install pcscd qml-module-qt-labs-folderlistmodel qml-module-qt-labs-settings qml-module-qt-labs-platform qml-module-qtgraphicaleffects qml-module-qtquick-controls qml-module-qtquick-controls2 qml-module-qtquick-dialogs qml-module-qtquick-layouts qml-module-qtquick-templates2 qml-module-qtquick-window2 qml-module-qtquick2 qt5-gtk-platformtheme libnsspem fonts-lato policykit-1
   ```

2. Clonar o repositório

   ```bash
   git clone REPOSITORY_URL
   ```

3. Compilar o projecto na directoria eidmw

   ```bash
   cd pteid-mw-pt/_src/eidmw
   qmake pteid-mw.pro
   make
   ```

4. Caso pretenda instalar a aplicação e as bibliotecas que fazem parte do projeto:

   ```bash
   sudo make install && sudo ldconfig
   ```

   A aplicação utilitária será instalada em: /usr/local/bin/eidguiV2 e as bibliotecas do projeto em /usr/local/lib/.


### Windows

Instruções para compilação em Windows (Visual Studio 2017)

É importante assegurar que as dependências são compiladas com a mesma versão de Visual Studio que será usada para compilar o Middleware.
Será assim necessário compilar as seguintes bibliotecas (versões utilizadas para a última release Windows):

- OpenSSL 3.0.8 - https://www.openssl.org/source/openssl-3.0.8.tar.gz
- xerces-c 3.2.4 - https://xerces.apache.org/xerces-c/build-3.html
- libcurl 7.80.0 - https://curl.haxx.se/download.html
- zlib 1.2.11 - https://www.zlib.net/fossils/zlib-1.2.11.tar.gz
- libzip 1.6.1 - https://libzip.org/download/
- libpng 1.6.37 - http://www.libpng.org/pub/png/libpng.html
- openjpeg 2.4 - https://www.openjpeg.org/
- libxml-security-c 2.0.4 - http://archive.apache.org/dist/santuario/c-library/xml-security-c-2.0.4.tar.gz
- cJSON 1.7.15 - https://github.com/DaveGamble/cJSON/archive/refs/tags/v1.7.15.zip 

Para compilar a aplicação GUI, projeto disponível em eidmw/eidguiV2, é necessária uma dependência adicional:

- poppler-qt5 0.87 - https://poppler.freedesktop.org/releases.html

Para o caso do Qt5 (versão igual ou superior a 5.12) estão disponíveis binários pré-compilados, poderá ser utilizado o instalador disponível em:  `https://download.qt.io/archive/online_installers/4.0/`

Ferramentas adicionais a instalar:

- 7-zip
- Windows Platform SDK
- Windows Cryptographic Provider Development Kit
- Visual Studio
- doxygen - disponível em http://www.doxygen.nl/download.html
- Swigwin 4.0.1 - disponível em  https://sourceforge.net/projects/swig/files/swigwin/swigwin-4.0.1/
- Java JDK
- Wix - disponível em https://wixtoolset.org/releases/
- Wix Visual Studio Extension - https://marketplace.visualstudio.com/items?itemName=WixToolset.WixToolsetVisualStudio2017Extension
- Git for Windows - disponível em https://gitforwindows.org/

Após configurado o ambiente conforme acima descrito, efetuar os seguintes passos:

1. Clonar repositório
2. Configurar os caminhos para as dependências (x86 e x64) e ferramentas no ficheiro `pteid-mw-pt\windows\set_path_autenticacao.gov.bat`
3. Abrir a Solução de VS2017 através do script `pteid-mw-pt\windows\ezbuild_sln_autenticacao.gov.bat
4. Seleccionar a configuração `Release | Win32` ou `Release | x64`
5. Compilar o projecto através do menu `Build solution`

Em alternativa, pode ser editado o script `pteid-mw-pt\windows\ezbuild_sln_autenticacao.gov.bat` para compilar na consola. As instruções estão no próprio ficheiro.

## Contactos
Para questões, sugestões ou comentários contacte-nos através da página: [Contactos](https://www.autenticacao.gov.pt/contactos?appRedirect=AutenticacaoGovDesktop).
