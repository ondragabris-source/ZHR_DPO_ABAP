*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZHR_DPO_ZAD.....................................*
DATA:  BEGIN OF STATUS_ZHR_DPO_ZAD                   .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZHR_DPO_ZAD                   .
CONTROLS: TCTRL_ZHR_DPO_ZAD
            TYPE TABLEVIEW USING SCREEN '9001'.
*.........table declarations:.................................*
TABLES: *ZHR_DPO_ZAD                   .
TABLES: ZHR_DPO_ZAD                    .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
