*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZHR_DPO_CROZDEL.................................*
DATA:  BEGIN OF STATUS_ZHR_DPO_CROZDEL               .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZHR_DPO_CROZDEL               .
CONTROLS: TCTRL_ZHR_DPO_CROZDEL
            TYPE TABLEVIEW USING SCREEN '9001'.
*.........table declarations:.................................*
TABLES: *ZHR_DPO_CROZDEL               .
TABLES: ZHR_DPO_CROZDEL                .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
