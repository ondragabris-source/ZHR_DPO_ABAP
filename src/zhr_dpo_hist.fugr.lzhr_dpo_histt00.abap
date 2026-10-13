*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZHR_DPO_HIST....................................*
DATA:  BEGIN OF STATUS_ZHR_DPO_HIST                  .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZHR_DPO_HIST                  .
CONTROLS: TCTRL_ZHR_DPO_HIST
            TYPE TABLEVIEW USING SCREEN '9001'.
*.........table declarations:.................................*
TABLES: *ZHR_DPO_HIST                  .
TABLES: ZHR_DPO_HIST                   .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
