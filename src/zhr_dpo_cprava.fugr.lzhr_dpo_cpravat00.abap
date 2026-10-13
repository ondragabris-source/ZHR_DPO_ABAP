*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZHR_DPO_CPRAVA..................................*
DATA:  BEGIN OF STATUS_ZHR_DPO_CPRAVA                .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZHR_DPO_CPRAVA                .
CONTROLS: TCTRL_ZHR_DPO_CPRAVA
            TYPE TABLEVIEW USING SCREEN '9001'.
*.........table declarations:.................................*
TABLES: *ZHR_DPO_CPRAVA                .
TABLES: ZHR_DPO_CPRAVA                 .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
