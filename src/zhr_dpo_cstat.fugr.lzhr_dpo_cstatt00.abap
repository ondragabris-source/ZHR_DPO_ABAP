*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZHR_DPO_CSTAT...................................*
DATA:  BEGIN OF STATUS_ZHR_DPO_CSTAT                 .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZHR_DPO_CSTAT                 .
CONTROLS: TCTRL_ZHR_DPO_CSTAT
            TYPE TABLEVIEW USING SCREEN '9001'.
*.........table declarations:.................................*
TABLES: *ZHR_DPO_CSTAT                 .
TABLES: *ZHR_DPO_CSTATT                .
TABLES: ZHR_DPO_CSTAT                  .
TABLES: ZHR_DPO_CSTATT                 .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
