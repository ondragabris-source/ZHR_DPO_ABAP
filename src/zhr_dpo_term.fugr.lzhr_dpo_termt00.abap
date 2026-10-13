*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZHR_DPO_TERM....................................*
DATA:  BEGIN OF STATUS_ZHR_DPO_TERM                  .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZHR_DPO_TERM                  .
CONTROLS: TCTRL_ZHR_DPO_TERM
            TYPE TABLEVIEW USING SCREEN '9001'.
*.........table declarations:.................................*
TABLES: *ZHR_DPO_TERM                  .
TABLES: ZHR_DPO_TERM                   .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
