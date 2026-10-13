*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZHR_DPO_ROZDEL..................................*
DATA:  BEGIN OF STATUS_ZHR_DPO_ROZDEL                .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZHR_DPO_ROZDEL                .
CONTROLS: TCTRL_ZHR_DPO_ROZDEL
            TYPE TABLEVIEW USING SCREEN '9001'.
*.........table declarations:.................................*
TABLES: *ZHR_DPO_ROZDEL                .
TABLES: ZHR_DPO_ROZDEL                 .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
