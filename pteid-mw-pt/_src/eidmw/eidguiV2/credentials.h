/*
    The credentials for the CMD service should be in this file.
    To be able to build with support for CMD, please contact info.cidadao@ama.pt
*/

#ifndef CREDENTIALS_H
#define CREDENTIALS_H

/* CMD */
#define CMD_SUPPORT 1                   // CHANGE TO 1 TO SUPPORT CMD
#if CMD_SUPPORT

    #define CMD_BASIC_AUTH_APPID        // INSERT CMD APP ID HERE  
    #define CMD_BASIC_AUTH_USERID       // INSERT CMD USER ID HERE 
    #define CMD_BASIC_AUTH_PASSWORD     // INSERT CMD PASSWORD HERE

#else

    #define CMD_BASIC_AUTH_USERID       "" 
    #define CMD_BASIC_AUTH_PASSWORD     "" 
    #define CMD_BASIC_AUTH_APPID        "" 
    #pragma message ("\n\n\
#############################################################################\n\
##                              WARNING                                    ##\n\
#############################################################################\n\
This build has no support for Chave Movel Digital Signature feature. \
For further information contact AMA at info.cidadao@ama.pt.\
\n\n")

#endif
 
#endif
