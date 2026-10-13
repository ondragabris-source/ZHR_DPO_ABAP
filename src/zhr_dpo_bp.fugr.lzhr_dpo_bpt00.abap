*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZHR_DPO_BP......................................*
DATA:  BEGIN OF STATUS_ZHR_DPO_BP                    .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZHR_DPO_BP                    .
CONTROLS: TCTRL_ZHR_DPO_BP
            TYPE TABLEVIEW USING SCREEN '9001'.
*.........table declarations:.................................*
TABLES: *ZHR_DPO_BP                    .
TABLES: ZHR_DPO_BP                     .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
