//USERIDC JOB ,                                                                 
// MSGCLASS=H,TIME=(,4),REGION=28M,COND=(16,LT),NOTIFY=USERID                   
//*************************************************************                 
//* @START_RRS_COPYRIGHT@                                     *                 
//* LICENSED MATERIALS - PROPERTY OF IBM                      *                 
//*                                                           *                 
//* RESTRICTED MATERIALS OF IBM                               *                 
//*                                                           *                 
//* (C) COPYRIGHT IBM CORP. 2007                              *                 
//*                                                           *                 
//* @END_RRS_COPYRIGHT@                                       *                 
//*************************************************************                 
//*                                                           *                 
//*************************************************************                 
//* COBCOMPL -- PROCEDURE FOR DOING A                         *                 
//*                - COBOL COMPILE OF BATCH PROGRAMS          *                 
//*                - LINKEDIT OF COMPILED PROGRAMS            *                 
//*                                                           *                 
//*************************************************************                 
//*                                                           *                 
//* CUSTOMIZE THIS PROCEDURE AS PER YOUR SITE REQUIREMENTS    *                 
//*                                                           *                 
//* THIS PROCEDURE WILL BE USED BY THE GENERATED JCL FILES    *                 
//* TO COMPILE THE GENERATED COBOL PROGRAMS.                  *                 
//*                                                           *                 
//* CUSTOMIZATION TASKS:                                      *                 
//*                                                           *                 
//*    1) MODIFY THE DEFAULT PARAMATER VALUES TO MATCH YOUR   *                 
//*       SITE INFORMATION.  YOU MAY OVERRIDE THE DEFAULT     *                 
//*       VALUES DURING THE INVOCATION OF THIS PROCEDURE.     *                 
//*                                                           *                 
//*         NAME                PURPOSE                       *                 
//*       ---------   -------------------------------------   *                 
//*       LANGLIB     COBOL COMPILER LIBRARY                  *                 
//*       LNKLIB      LINKLIB DATASET                         *                 
//*       COBDSN      YOUR COBOL SOURCE DATASET               *                 
//*       COBMBR      YOUR COBOL SOURCE PROGRAM TO COMPILE    *                 
//*       OBJDSN      YOUR OBJECT DATASET                     *                 
//*       COPYLIB     YOUR COPY MEMBER DATASET                *                 
//*                                                           *                 
//*************************************************************                 
//COBCOMPL  PROC COBDSN=HLQ.SRCLIB,                                  
// COBMBR=DUMMY,                                                                
// LANGLIB=COBOL.V3R3M0.SIGYCOMP,                                               
// OBJDSN=HLQ.OBJLIB,                                                
// COPYLIB=HLQ.COPYLIB,                                              
// LOADDSN=HLQ.LOADLIB,                                              
// LNKLIB=CEE.SCEELKED                                                          
//*                                                                             
//*                                                                             
//COBOL  EXEC PGM=IGYCRCTL,REGION=4096K,                                        
//             PARM=('ADATA',                                                   
//             'LIB',                                                           
//             'TEST',                                                          
//             'LIST',                                                          
//             'NODBCS')                                                        
//STEPLIB  DD  DSNAME=&LANGLIB,                                                 
//             DISP=SHR                                                         
//SYSLIN   DD  DSN=&OBJDSN(&COBMBR),                                            
//             DISP=SHR                                                         
//SYSLIB   DD  DSN=&COPYLIB,DISP=SHR                                            
//         DD  DSN=CEE.SCEESAMP,DISP=SHR                                        
//SYSXMLSD DD  DUMMY                                                            
//SYSIN    DD  DSN=&COBDSN(&COBMBR),DISP=SHR                                    
//SYSPRINT DD  SYSOUT=*                                                         
//SYSADATA DD  DUMMY                                                            
//SYSLIN   DD  DUMMY                                                            
//SYSUT1   DD  UNIT=SYSALLDA,SPACE=(CYL,(2,5))                                  
//SYSUT2   DD  UNIT=SYSALLDA,SPACE=(CYL,(2,5))                                  
//SYSUT3   DD  UNIT=SYSALLDA,SPACE=(CYL,(2,5))                                  
//SYSUT4   DD  UNIT=SYSALLDA,SPACE=(CYL,(2,5))                                  
//SYSUT5   DD  UNIT=SYSALLDA,SPACE=(CYL,(2,5))                                  
//SYSUT6   DD  UNIT=SYSALLDA,SPACE=(CYL,(2,5))                                  
//SYSUT7   DD  UNIT=SYSALLDA,SPACE=(CYL,(2,5))                                  
//*                                                                             
//*************************************************************                 
//*                                                           *                 
//* LINK-EDIT THE COBOL PROGRAM                               *                 
//*                                                           *                 
//*************************************************************                 
//*                                                                             
//LINK   EXEC PGM=HEWL,COND=(8,LT),REGION=1024K,                                
//       PARM=('MAP')                                                           
//SYSLIB   DD  DSNAME=&LNKLIB,                                                  
//             DISP=SHR                                                         
//SYSLMOD  DD  DSN=&LOADDSN(&COBMBR),                                           
//             DISP=SHR                                                         
//SYSUT1   DD  UNIT=SYSALLDA,SPACE=(TRK,(10,10))                                
//OBJ0000  DD  DSN=&OBJDSN(&COBMBR),                                            
//             DISP=SHR                                                         
//SYSLIN   DD  DUMMY                                                            
//SYSPRINT DD  SYSOUT=*                                                         
// PEND
//*                                                                             
//*************************************************************                 
//*                                                           *                 
//* BUILD THE COBOL PROGRAM                                   *                 
//*                                                           *                 
//*************************************************************                 
//*                                                                             
//FSD       EXEC PROC=COBCOMPL,COBMBR=FSD
//LINK.SYSLIN  DD *                                                             
 INCLUDE OBJ0000                                                                
/*                                                                              
//                                                                              
