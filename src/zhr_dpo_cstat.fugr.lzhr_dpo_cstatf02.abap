*----------------------------------------------------------------------*
***INCLUDE LZHR_DPO_CSTATF02.
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form SORT_TAB
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
form sort_tab .

  TYPES: BEGIN OF tt_data.
    INCLUDE STRUCTURE zhr_dpo_cstat.
  TYPES description TYPE ZHR_DPO_RFP_STATUS_DESCR.
  TYPES: END OF tt_data.
  data: lt_data type standard table of tt_data.

  field-symbols: <ls_data> like line of lt_data.

  check sy-ucomm <> 'SAVE'.


  loop at total[] assigning <ls_data> casting.
    append <ls_data> to lt_data.
  endloop.

  sort lt_data by object status_num.

  clear: total[], total.

  loop at lt_data into total.
    append total to total[].
  endloop.


endform.
