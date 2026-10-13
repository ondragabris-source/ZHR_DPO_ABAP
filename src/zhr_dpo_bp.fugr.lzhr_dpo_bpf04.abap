*----------------------------------------------------------------------*
***INCLUDE LZHR_DPO_BPF04.
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form ZHR_DPO_BP_SORT
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
form zhr_dpo_bp_sort .
*  data: lt_data type standard table of zhr_dpo_bp.
*
*  field-symbols: <ls_data> like line of lt_data.
*
*  check sy-ucomm <> 'SAVE'.
*
*  loop at total[] assigning <ls_data> casting.
*    append <ls_data> to lt_data.
*  endloop.
*
*  sort lt_data by short.
*
*  clear: total[], total.
*
*  loop at lt_data into <vim_total_struc>.
*    append total to total[].
*  endloop.

endform.
