*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZHR_DPO_ZASTUP..................................*
DATA:  BEGIN OF STATUS_ZHR_DPO_ZASTUP                .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZHR_DPO_ZASTUP                .
CONTROLS: TCTRL_ZHR_DPO_ZASTUP
            TYPE TABLEVIEW USING SCREEN '9001'.
*.........table declarations:.................................*
TABLES: *ZHR_DPO_ZASTUP                .
TABLES: ZHR_DPO_ZASTUP                 .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
