*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZHR_DPO_CA004IT.................................*
DATA:  BEGIN OF STATUS_ZHR_DPO_CA004IT               .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZHR_DPO_CA004IT               .
CONTROLS: TCTRL_ZHR_DPO_CA004IT
            TYPE TABLEVIEW USING SCREEN '9001'.
*.........table declarations:.................................*
TABLES: *ZHR_DPO_CA004IT               .
TABLES: *ZHR_DPO_CA004ITT              .
TABLES: ZHR_DPO_CA004IT                .
TABLES: ZHR_DPO_CA004ITT               .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
