*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZHR_DPO_CVED....................................*
DATA:  BEGIN OF STATUS_ZHR_DPO_CVED                  .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZHR_DPO_CVED                  .
CONTROLS: TCTRL_ZHR_DPO_CVED
            TYPE TABLEVIEW USING SCREEN '9001'.
*.........table declarations:.................................*
TABLES: *ZHR_DPO_CVED                  .
TABLES: ZHR_DPO_CVED                   .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
