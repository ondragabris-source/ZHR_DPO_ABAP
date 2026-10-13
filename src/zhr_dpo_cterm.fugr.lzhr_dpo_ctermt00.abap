*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZHR_DPO_CTERM...................................*
DATA:  BEGIN OF STATUS_ZHR_DPO_CTERM                 .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZHR_DPO_CTERM                 .
CONTROLS: TCTRL_ZHR_DPO_CTERM
            TYPE TABLEVIEW USING SCREEN '9001'.
*.........table declarations:.................................*
TABLES: *ZHR_DPO_CTERM                 .
TABLES: *ZHR_DPO_CTERMT                .
TABLES: ZHR_DPO_CTERM                  .
TABLES: ZHR_DPO_CTERMT                 .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
