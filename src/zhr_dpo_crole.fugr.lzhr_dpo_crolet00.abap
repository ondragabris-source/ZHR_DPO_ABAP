*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZHR_DPO_CROLE...................................*
DATA:  BEGIN OF STATUS_ZHR_DPO_CROLE                 .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZHR_DPO_CROLE                 .
CONTROLS: TCTRL_ZHR_DPO_CROLE
            TYPE TABLEVIEW USING SCREEN '9001'.
*.........table declarations:.................................*
TABLES: *ZHR_DPO_CROLE                 .
TABLES: *ZHR_DPO_CROLET                .
TABLES: ZHR_DPO_CROLE                  .
TABLES: ZHR_DPO_CROLET                 .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
