*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZHR_DPO_CZAD....................................*
DATA:  BEGIN OF STATUS_ZHR_DPO_CZAD                  .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZHR_DPO_CZAD                  .
CONTROLS: TCTRL_ZHR_DPO_CZAD
            TYPE TABLEVIEW USING SCREEN '9001'.
*.........table declarations:.................................*
TABLES: *ZHR_DPO_CZAD                  .
TABLES: *ZHR_DPO_CZADT                 .
TABLES: ZHR_DPO_CZAD                   .
TABLES: ZHR_DPO_CZADT                  .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
