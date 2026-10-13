*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZHR_DPO_CSABL...................................*
DATA:  BEGIN OF STATUS_ZHR_DPO_CSABL                 .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZHR_DPO_CSABL                 .
CONTROLS: TCTRL_ZHR_DPO_CSABL
            TYPE TABLEVIEW USING SCREEN '9001'.
*.........table declarations:.................................*
TABLES: *ZHR_DPO_CSABL                 .
TABLES: *ZHR_DPO_CSABLT                .
TABLES: ZHR_DPO_CSABL                  .
TABLES: ZHR_DPO_CSABLT                 .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
