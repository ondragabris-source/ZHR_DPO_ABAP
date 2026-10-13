*&---------------------------------------------------------------------*
*& Report ZPE_DPO_UPDATE_WORD_TEMP
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
report zpe_dpo_upd_word_tmp.

DATA:     lv_date       type string,
          it_tab        type filetable,
          lv_filename   type string,
          lv_rc         type i,
          lv_length     type i,
          lv_mimetype   type W3CONTTYPE,
          lv_docx       TYPE xstring,
          lt_data_tab   type standard table of x255,
          es_att        TYPE ZHR_DPO_ATT_S,
          et_message    TYPE BAPIRETTAB,
          ef_result     TYPE xflag.

PARAMETERS: p_req TYPE zhr_dpo_request DEFAULT '9999999999',
            p_code TYPE ZHR_DPO_TEMPL_CODE,
            p_file TYPE filename.

INITIALIZATION.

  AUTHORITY-CHECK OBJECT 'S_TCODE'
     ID 'TCD' FIELD 'ZHRPA_DPO_UPD_WORD'.
  IF sy-subrc <> 0.
* Implement a suitable exception handling here
    MESSAGE e024(zhr_dpo) INTO DATA(lv_text).
* Nemáte autorizaci na spuštění programu.
  ENDIF.

AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_file.



 call method cl_gui_frontend_services=>file_open_dialog
      exporting
        window_title     = 'Select File'
        default_filename = '*.*'
*       MULTISELECTION   = 'X'
      changing
        file_table       = it_tab
        rc               = lv_rc.

    read table it_tab assigning field-symbol(<fs_itab>) index 1.
    if sy-subrc eq 0.
     p_file = <fs_itab>.
    endif.


 START-OF-SELECTION.

   lv_filename = p_file.
*--------------------
    call method cl_gui_frontend_services=>gui_upload
      exporting
        filename   = lv_filename
        filetype   = 'BIN'
      importing
        filelength = lv_length
      changing
        data_tab   = lt_data_tab.

    CALL FUNCTION 'SCMS_BINARY_TO_XSTRING'
  EXPORTING
    input_length = lv_length
  IMPORTING
    buffer       = lv_docx
  TABLES
    binary_tab   = lt_data_tab.


lv_mimetype = 'application/vnd.openxmlformats-officedocument.wordprocessingml.document'.

DATA(lo_instance) = new zcl_hr_dpo_request( ).

DELETE from ZHR_DPO_REQ_ATT WHERE dpo_request = p_req AND template_code = p_code.
*
call method lo_instance->add_attachment
  exporting
    iv_dpo_request = p_req
    iv_template_code = p_code
    iv_data        = lv_docx
    iv_filename    = lv_filename
    iv_mimetype    = lv_mimetype
  importing
    es_att         = es_att
*   ef_valid       = ef_valid
    ef_result      = ef_result
    et_message     = et_message.
