*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZHR_DPO_CPARAM..................................*
DATA:  BEGIN OF STATUS_ZHR_DPO_CPARAM                .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZHR_DPO_CPARAM                .
CONTROLS: TCTRL_ZHR_DPO_CPARAM
            TYPE TABLEVIEW USING SCREEN '9001'.
*.........table declarations:.................................*
TABLES: *ZHR_DPO_CPARAM                .
TABLES: *ZHR_DPO_CPARAMT               .
TABLES: ZHR_DPO_CPARAM                 .
TABLES: ZHR_DPO_CPARAMT                .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
