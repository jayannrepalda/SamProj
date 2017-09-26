      *********************** DGG ******************************
      *                                                             *
      *    COPY BOOK FOR THE PARAMETERS TO THE
      **** PROGRAM FOR PERFORMING VSAM/QSAM BATCH OPERATIONS                      
      *                                                               
      *********************** DGG ******************************
      ***************************************************************
       01 PARMS.                   
          02 HEADER-AREA.                          
             05 ACTION                     PICTURE X(8).
          02 RESPONSE-AREA.                          
             05 PARM-IN-FILE-STATUS pic xx.
                88 parm-inputfile-success value "00".
             05 PARM-IN-VSAM-CODE.
                10 PARM-IN-VSAM-CODE-R15-RETURN PIC S9(4) Usage Comp-5.
                10 PARM-IN-VSAM-CODE-FUNCTION PIC S9(4) Usage Comp-5.
                10 PARM-IN-VSAM-CODE-FEEDBACK PIC S9(4) Usage Comp-5.
             05 PARM-OUT-FILE-STATUS pic xx.
                88 parm-outputfile-success value "00".
