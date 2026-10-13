*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZHR_DPO_CHRBP...................................*
DATA:  BEGIN OF STATUS_ZHR_DPO_CHRBP                 .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZHR_DPO_CHRBP                 .
CONTROLS: TCTRL_ZHR_DPO_CHRBP
            TYPE TABLEVIEW USING SCREEN '9001'.
*.........table declarations:.................................*
TABLES: *ZHR_DPO_CHRBP                 .
TABLES: ZHR_DPO_CHRBP                  .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
