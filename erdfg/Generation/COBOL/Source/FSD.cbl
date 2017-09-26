      *********************** FSD ******************************
      *                                                             *
      **** PROGRAM FOR PERFORMING VSAM/QSAM BATCH OPERATIONS                      
      *                                                               
      *   MODULE NAME = FSD
      *
      *   DESCRIPTIVE NAME = PERFORM VSAM/QSAM BATCH OPERATIONS ON A DATASET.      
      *                                                               
      *   FUNCTION = THIS MODULE PERFORMS VSAM/QSAM BATCH OPERATIONS ON A DATASET  
      *                                                               
      *   NOTES =                                                     
      *     DEPENDENCIES = N/A 
      *
      *     RESTRICTIONS = N/A                                        
      *                                                               
      *   MODULE TYPE = COBOL PROGRAM                                 
      *      PROCESSOR   = IBM ENTERPRISE COBOL                           
      *      MODULE SIZE = SEE LINK EDIT                              
      *      ATTRIBUTES  = REENTRANT                                  
      *                                                               
      *   ENTRY POINT = FSD                                    
      *      PURPOSE = SEE FUNCTION                                   
      *      LINKAGE =                                                
      *         CALL FSD USING PARMS.                      
      *                                                               
      *      INPUT   = PARMS                                    
      *                                                               
      *      OUTPUT  = RESPONSE IN THE PARMS DATA STRUCTURE                    
      *                                                               
      *   EXIT-NORMAL = RETURN CODE 0 NORMAL COMPLETION               
      *   EXIT-ERROR =                                                
      *      RETURN CODE = NONE                                       
      *      ABEND CODES =  NONE                                      
      *      ERROR-MESSAGES =                                         
      *                                                               
      *   EXTERNAL REFERENCES =                                       
      *      ROUTINES/SERVICES =                                      
      *      DATA-AREAS        =    NONE                              
      *      CONTROL-BLOCKS    =                                      
      *                                                               
      *   TABLES = NONE                                               
      *   CHANGE-ACTIVITY = NONE                                      
      *                                                               
      *********************** FSD ******************************
      ***************************************************************
       Identification Division.
         Program-ID. FSD.
       Environment DIVISION.
        Input-output section.
         FILE-CONTROL.
      *                                                               
           SELECT IN-INTERNAL-FILE
               Assign to SYSIN
               Organization is INDEXED
               RECORD KEY IS IN-RECORD-KEY
               Access mode is DYNAMIC
               File status is IN-FILE-STATUS IN-VSAM-CODE.
           Select OUT-INTERNAL-FILE
               Assign to SYSOUT
               Organization is sequential
               Access mode is sequential
               File status is OUT-FILE-STATUS.

       Data Division.
        File section.

        FD IN-INTERNAL-FILE
             record contains 80 characters
             data record is IN-FILE-RECORD.
        01 IN-FILE-RECORD.
             05 IN-RECORD-KEY PIC X(8).
             05 FILLER PIC X(72).
        FD OUT-INTERNAL-FILE
             label records are standard
             recording mode is F
             block contains 0 records
             record contains 80 characters
             data record is OUT-FILE-RECORD.
        01 OUT-FILE-RECORD.
             05 FILLER PIC X(80).
      *
      *
       Working-Storage Section.
        01 IN-VSAM-CODE.
           10 IN-VSAM-CODE-R15-RETURN PIC S9(4) Usage Comp-5.
           10 IN-VSAM-CODE-FUNCTION PIC S9(4) Usage Comp-5.
           10 IN-VSAM-CODE-FEEDBACK PIC S9(4) Usage Comp-5.
        01 Temp-data pic x(80).
        01 Program-flags.
          05 IN-FILE-STATUS pic xx value "00".
            88 inputfile-success value "00".
          05 OUT-FILE-STATUS pic xx value "00".
            88 outputfile-success value "00".
          05 Input-eof pic x value "0".
       77 DO-COPY-DATASET             PICTURE X(8) VALUE 'DUPLICAT'.
       LINKAGE SECTION.          
       COPY DGG.       
      *
       Procedure DIVISION USING PARMS.
      * Open the input and/or output files
           PERFORM Open-files.

      * Process the user request

           EVALUATE ACTION                                             
               WHEN DO-COPY-DATASET
                   PERFORM Copy-input-to-output,
               WHEN OTHER                                          
                   CONTINUE,                                           
           END-EVALUATE.                                               
           MOVE IN-FILE-STATUS
                TO PARM-IN-FILE-STATUS.
           MOVE OUT-FILE-STATUS
                TO PARM-OUT-FILE-STATUS.
           MOVE IN-VSAM-CODE
                TO PARM-IN-VSAM-CODE.
           PERFORM Close-files.
           goback.

      * ***************************************************
      * Utility method to open the input and/or output file
      * ***************************************************
        Open-files.
      * Open the input file
           OPEN I-O IN-INTERNAL-FILE
           if not inputfile-success
             display 'Error opening input file ' IN-FILE-STATUS
             stop run
           end-if
      * Open the output file
           OPEN OUTPUT OUT-INTERNAL-FILE
           if not outputfile-success
             display 'Error opening output file ' OUT-FILE-STATUS
             stop run
           end-if.
        Open-files-EXIT.
           EXIT.

      * ***************************************************
      * Utility method to close the input and/or output file
      * ***************************************************
        Close-files.
      * Close the input file
           CLOSE IN-INTERNAL-FILE.
      * Close the output file
           CLOSE OUT-INTERNAL-FILE.
        Close-files-EXIT.
           EXIT.

      * ****************************************************************************
      * Utility method for copying input data from the input file to the output file
      * ****************************************************************************
        Copy-input-to-output.
      * Loop until end of file for input file
           Move "0" to Input-eof
           Perform until
                   NOT inputfile-success OR
                   NOT outputfile-success

               PERFORM Read-next-input-data
               IF inputfile-success
                 PERFORM Write-output-data
               End-IF
           End-perform.
        Copy-input-to-output-EXIT.
           EXIT.

      * *******************************************
      * Utility method for reading from input file
      * *******************************************
        Read-input-data.
      *    Assume text to be read into Temp-data from IN-INTERNAL-FILE
           Move Spaces to Temp-data.
           READ IN-INTERNAL-FILE 
                into Temp-data
           END-READ.
        Read-input-data-EXIT.
           EXIT.


      * **********************************************************
      * Utility method to position the next record from input file
      * **********************************************************
        Start-next-input-data.
      *    Start from 
           START IN-INTERNAL-FILE 
                 KEY IS EQUAL TO IN-RECORD-KEY.
        Start-next-input-data-EXIT.
           EXIT.

      * **********************************************************
      * Utility method for reading the next record from input file
      * **********************************************************
        Read-next-input-data.
      *    Assume text to be read into Temp-data from IN-INTERNAL-FILE
           Move Spaces to Temp-data.
           READ IN-INTERNAL-FILE NEXT
                into Temp-data
           END-READ.
        Read-next-input-data-EXIT.
           EXIT.


      * *******************************************
      * Utility method for writing to output files
      * *******************************************
        Write-output-data.
      *    Assume text to be written to OUT-INTERNAL-FILE is in Temp-data
           Move Temp-data to OUT-FILE-RECORD.
           WRITE OUT-FILE-RECORD.
        Write-output-data-EXIT.
           EXIT.
       End program FSD.
