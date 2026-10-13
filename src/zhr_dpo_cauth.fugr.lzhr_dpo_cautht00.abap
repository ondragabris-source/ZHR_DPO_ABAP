*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZHR_DPO_CAUTH...................................*
DATA:  BEGIN OF STATUS_ZHR_DPO_CAUTH                 .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZHR_DPO_CAUTH                 .
CONTROLS: TCTRL_ZHR_DPO_CAUTH
            TYPE TABLEVIEW USING SCREEN '9001'.
*.........table declarations:.................................*
TABLES: *ZHR_DPO_CAUTH                 .
TABLES: ZHR_DPO_CAUTH                  .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
