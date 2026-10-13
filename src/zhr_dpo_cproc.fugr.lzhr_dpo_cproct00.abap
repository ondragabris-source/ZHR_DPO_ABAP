*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZHR_DPO_CPROC...................................*
DATA:  BEGIN OF STATUS_ZHR_DPO_CPROC                 .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZHR_DPO_CPROC                 .
CONTROLS: TCTRL_ZHR_DPO_CPROC
            TYPE TABLEVIEW USING SCREEN '9001'.
*.........table declarations:.................................*
TABLES: *ZHR_DPO_CPROC                 .
TABLES: *ZHR_DPO_CPROCT                .
TABLES: ZHR_DPO_CPROC                  .
TABLES: ZHR_DPO_CPROCT                 .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
