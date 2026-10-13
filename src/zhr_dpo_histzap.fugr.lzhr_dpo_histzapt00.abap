*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZHR_DPO_HISTZAP.................................*
DATA:  BEGIN OF STATUS_ZHR_DPO_HISTZAP               .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZHR_DPO_HISTZAP               .
CONTROLS: TCTRL_ZHR_DPO_HISTZAP
            TYPE TABLEVIEW USING SCREEN '9001'.
*.........table declarations:.................................*
TABLES: *ZHR_DPO_HISTZAP               .
TABLES: ZHR_DPO_HISTZAP                .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
