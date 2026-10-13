*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZHR_DPO_CPRAVAST................................*
DATA:  BEGIN OF STATUS_ZHR_DPO_CPRAVAST              .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZHR_DPO_CPRAVAST              .
CONTROLS: TCTRL_ZHR_DPO_CPRAVAST
            TYPE TABLEVIEW USING SCREEN '9001'.
*.........table declarations:.................................*
TABLES: *ZHR_DPO_CPRAVAST              .
TABLES: ZHR_DPO_CPRAVAST               .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
