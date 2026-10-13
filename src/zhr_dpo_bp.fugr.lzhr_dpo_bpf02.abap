*----------------------------------------------------------------------*
***INCLUDE LZHR_DPO_BPF02.
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form ZHR_UPDATE_INFO
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
form zhr_update_info .
  clear zhr_dpo_bp-short.

  select single short from hrp1000 into zhr_dpo_bp-short
                           where objid eq zhr_dpo_bp-orgeh
                             and otype eq 'O'
                             and PLVAR eq '01'
                             and langu eq sy-langu
                             AND begda LE sy-datum
                             AND endda GE sy-datum
                             AND istat EQ '1'.
endform.
