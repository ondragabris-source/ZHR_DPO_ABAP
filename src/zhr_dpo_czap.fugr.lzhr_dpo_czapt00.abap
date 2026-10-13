*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZHR_DPO_CZAP....................................*
DATA:  BEGIN OF STATUS_ZHR_DPO_CZAP                  .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZHR_DPO_CZAP                  .
CONTROLS: TCTRL_ZHR_DPO_CZAP
            TYPE TABLEVIEW USING SCREEN '9001'.
*.........table declarations:.................................*
TABLES: *ZHR_DPO_CZAP                  .
TABLES: *ZHR_DPO_CZAPT                 .
TABLES: ZHR_DPO_CZAP                   .
TABLES: ZHR_DPO_CZAPT                  .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
