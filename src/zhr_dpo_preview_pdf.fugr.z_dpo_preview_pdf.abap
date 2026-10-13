FUNCTION z_dpo_preview_pdf.
*"----------------------------------------------------------------------
*"*"Lokální rozhraní:
*"  IMPORTING
*"     REFERENCE(IV_FORM) TYPE  FPNAME
*"     REFERENCE(IV_DPO_REQUEST) TYPE  ZHR_DPO_REQUEST
*"  EXPORTING
*"     VALUE(EV_PDF_STREAM) TYPE  FPCONTENT
*"     REFERENCE(ES_FORMOUTPUT) TYPE  FPFORMOUTPUT
*"  RAISING
*"      ZCX_SD_SDP_MAIN
*"----------------------------------------------------------------------



  DATA: lv_funcname     TYPE funcname,
        lx_main         TYPE REF TO zcx_sd_sdp_main,
        lx_root         TYPE REF TO cx_root,
        ls_output       TYPE fpformoutput,
        lt_ptab         TYPE abap_func_parmbind_tab,
        ls_ptab         LIKE LINE OF lt_ptab,
        ls_docparams    TYPE sfpdocparams,
        lt_etab         TYPE abap_func_excpbind_tab,
        ls_etab         TYPE abap_func_excpbind,
        lo_value        TYPE REF TO data,
        lv_text         TYPE string,
        lt_message      TYPE bapirettab,
        lt_address      TYPE STANDARD TABLE OF zhr_dpo_form_headsign_s,
        ls_address      TYPE zhr_dpo_form_headsign_s,
        lv_attachment   TYPE string,
        ls_outputparams TYPE sfpoutputparams.

  "Get FM name
  TRY.

      CALL FUNCTION 'FP_FUNCTION_MODULE_NAME'
        EXPORTING
          i_name     = iv_form
        IMPORTING
          e_funcname = lv_funcname.

    CATCH cx_root INTO lx_root.
      RAISE EXCEPTION TYPE zcx_sd_sdp_main
        EXPORTING
          previous = lx_main.
  ENDTRY.



  ls_outputparams-nodialog = 'X'. " suppress printer dialog popup
  ls_outputparams-getpdf = 'X'. " launch print preview

*  IF sy-title NE 'Call test environment'.

  CALL FUNCTION 'FP_JOB_OPEN'
    CHANGING
      ie_outputparams = ls_outputparams
    EXCEPTIONS
      cancel          = 1
      usage_error     = 2
      system_error    = 3
      internal_error  = 4
      OTHERS          = 5.

  IF sy-subrc <> 0.
    MESSAGE e002(zsd_sdp) INTO lv_text.
    zcl_sd_sdp_helper=>append_message_from_syst( CHANGING ct_message = lt_message ).
    RAISE EXCEPTION TYPE zcx_sd_sdp_main
      EXPORTING
        bapirettab = lt_message.
  ENDIF.

*  ENDIF.

  ls_docparams-fillable = ''.
  ls_docparams-dynamic = ''.
*  if iv_langu is NOT INITIAL.

  ls_docparams-langu = sy-langu.
*  ENDIF.
* IMPORTING
*"     VALUE(/1BCDWB/DOCPARAMS) TYPE  SFPDOCPARAMS OPTIONAL
*"     VALUE(IS_FOOTER) TYPE  ZHR_DPO_FORM_INTER_FOOTER_S
*"     VALUE(IS_BODY) TYPE  ZHR_DPO_FORM_INTER_BODY_S
*"     VALUE(IS_HEADER) TYPE  ZHR_DPO_FORM_INTER_HEAD_S
  DATA: ls_footer     TYPE  zhr_dpo_form_inter_footer_s,
        ls_footer_req TYPE zhr_dpo_form_request_footer_s,
        ls_body_req   TYPE zhr_dpo_form_request_body_s,
        ls_header_req TYPE zhr_dpo_form_request_head_s,
        ls_approvers  TYPE zhr_dpo_form_app_s,
        ls_body       TYPE zhr_dpo_form_inter_body_s,
        ls_header     TYPE zhr_dpo_form_inter_head_s.

  DATA(lo_request) = NEW zcl_hr_dpo_request( ).
  DATA(ls_request) = lo_request->read_request( iv_dpo_request      = iv_dpo_request ).
  DATA(lt_text) = lo_request->convert_string_to_text_table( iv_string = ls_request-text  ).
  DATA(lt_history) = lo_request->get_history( ).
  lo_request->read_customizing( ).
  DATA(ls_texts) = lo_request->get_long_texts_all( iv_dpo_request ).
  DATA(lt_fork)    = lo_request->show_approval_fork(
                       iv_dpo_request         = iv_dpo_request
                       iv_only_next_approvers = ''
                     ).

  DATA(lt_attch_tab) = lo_request->read_attachment_tab( iv_dpo_request = ls_request-dpo_request iv_with_agreements = abap_true ) .






  CASE iv_form.

    WHEN 'ZHR_DPO_FORM_INTER'.




      ls_body-formated_body = lt_text.
*      ls_body-title = ls_request-name.


*      ls_header-name_from = ls_request-requestor_name_full.
      ls_header-date_header = ls_request-request_date.

      READ TABLE lt_fork ASSIGNING FIELD-SYMBOL(<fs_fork>)
                            WITH KEY role_key = 'VED_SP'.
      IF sy-subrc EQ 0.

        DATA(ls_contact_data) = zcl_hr_dpo_roles=>get_pernr_details( <fs_fork>-pernr ).
*        ls_header-handles_phone = ls_contact_data-cell_numbr.
*        ls_header-name_to       = <fs_fork>-name_full.
        CONCATENATE <fs_fork>-name_full <fs_fork>-department INTO ls_header-name_to SEPARATED BY space.

      ENDIF.
      ls_header-our_brand = ls_request-dpo_req_full.
      READ TABLE lt_history ASSIGNING  FIELD-SYMBOL(<fs_hist>)
                                       WITH KEY role = 'ZAD'
                                                next_status = 'ROJ'.

      IF sy-subrc EQ 0.
        CLEAR ls_contact_data.
        DATA(lv_pernr) = zcl_pa_vs_utils=>get_pernr_by_uname( iv_uname = <fs_hist>-uname ).
        ls_contact_data = zcl_hr_dpo_roles=>get_pernr_details( lv_pernr ).
        CONCATENATE ls_contact_data-full_name '/' ls_contact_data-cell_numbr INTO ls_header-handles_phone SEPARATED BY space.
      ENDIF.

      DATA(lt_hist_tmp) = lt_history[].
      SORT lt_hist_tmp BY role orig_user datum DESCENDING time DESCENDING.
      DELETE ADJACENT DUPLICATES FROM lt_hist_tmp COMPARING role orig_user.
      SORT lt_hist_tmp BY datum time.



      LOOP AT lt_hist_tmp ASSIGNING <fs_hist>
                                       WHERE ( role = 'ZAD_NEXT'
                                          OR role = 'ZAD'
                                          OR role = 'HRBP' )
*                                          or role = 'SP' )
                                         AND clarification EQ ''
                                         AND form_id IS NOT INITIAL.

        lv_pernr = zcl_pa_vs_utils=>get_pernr_by_uname( iv_uname = <fs_hist>-orig_user ).
        IF line_exists( lt_fork[ pernr = lv_pernr ] ) AND <fs_hist>-role NE 'ZAD'." u zadatela nekontrolujeme priznak approved
          IF lt_fork[ pernr = lv_pernr ]-approved = ''.
            CONTINUE.
          ENDIF.
        ENDIF.
        ls_approvers-datum = <fs_hist>-datum.
        ls_approvers-name_full = <fs_hist>-name_full.
        ls_approvers-time = <fs_hist>-time.
        DATA(lv_dpo_step_minus) = <fs_hist>-dpo_step .
        READ TABLE lt_history ASSIGNING FIELD-SYMBOL(<fs_hist_minus>)
                                              WITH KEY dpo_step = lv_dpo_step_minus.
        IF sy-subrc EQ 0.
          ls_approvers-form_id = <fs_hist_minus>-form_id.
        ENDIF.
        APPEND ls_approvers TO ls_footer-approvers.
        IF <fs_hist>-role CS 'ZAD'.
          lv_pernr = zcl_pa_vs_utils=>get_pernr_by_uname( iv_uname = <fs_hist>-orig_user ).
          ls_contact_data = zcl_hr_dpo_roles=>get_pernr_details( lv_pernr ).
          IF ls_header-name_from IS INITIAL.

            ls_header-name_from = ls_contact_data-full_name .
          ELSE.
            ls_header-name_from = ls_header-name_from && ','.
            CONCATENATE ls_header-name_from ls_contact_data-full_name INTO ls_header-name_from SEPARATED BY space .
          ENDIF.
        ENDIF.
      ENDLOOP.

* pridaj prilohy



      SELECT SINGLE url FROM zhr_dpo_csabl INTO @DATA(lv_url)
                      WHERE template_code = @ls_request-template_code.
      IF lt_attch_tab[] IS NOT INITIAL OR lv_url IS NOT INITIAL.
        REFRESH ls_footer-attachments[].
        lv_attachment = TEXT-002.
        APPEND lv_attachment TO ls_footer-attachments.
      ENDIF.
      IF lv_url IS NOT INITIAL.

        lv_attachment = TEXT-004.
        APPEND lv_attachment TO ls_footer-attachments.
      ENDIF.
      IF lt_attch_tab[] IS NOT INITIAL.
        LOOP AT lt_attch_tab ASSIGNING FIELD-SYMBOL(<fs_attch_tab>).
          lv_attachment = <fs_attch_tab>-filename.
          APPEND lv_attachment TO ls_footer-attachments.
        ENDLOOP.
      ENDIF.


*      lt_hist_tmp[] = lt_history[].
*      SORT lt_hist_tmp BY role uname datum DESCENDING time DESCENDING.
*      LOOP AT lt_hist_tmp ASSIGNING <fs_hist>
*                                         WHERE role = 'SP'
*                                           AND next_status = 'ASP'.
*        .
*        ls_approvers-datum = <fs_hist>-datum.
*        ls_approvers-name_full = <fs_hist>-name_full.
*        ls_approvers-time = <fs_hist>-time.
*        lv_dpo_step_minus = <fs_hist>-dpo_step .
*        READ TABLE lt_history ASSIGNING <fs_hist_minus>
*                                              WITH KEY dpo_step = lv_dpo_step_minus.
*        IF sy-subrc EQ 0.
*          ls_approvers-form_id = <fs_hist_minus>-form_id.
*        ENDIF.
*        APPEND ls_approvers TO ls_footer-approvers.
*        EXIT.
*
*      ENDLOOP.



      CALL FUNCTION lv_funcname
        EXPORTING
          /1bcdwb/docparams  = ls_docparams
          is_footer          = ls_footer
          is_body            = ls_body
          is_header          = ls_header
        IMPORTING
          /1bcdwb/formoutput = ls_output
        EXCEPTIONS
          usage_error        = 1
          system_error       = 2
          internal_error     = 3
          OTHERS             = 4.
      IF sy-subrc <> 0.
* Implement suitable error handling here
      ENDIF.

    WHEN 'ZHR_DPO_FORM_REQUEST'.


      LOOP AT lt_history ASSIGNING <fs_hist>
                                       WHERE role = 'VED_SP'
                                         AND clarification EQ ''.
        .
        ls_approvers-datum = <fs_hist>-datum.
        ls_approvers-name_full = <fs_hist>-name_full.
        ls_approvers-time = <fs_hist>-time.
        lv_dpo_step_minus = <fs_hist>-dpo_step .""
        READ TABLE lt_history ASSIGNING <fs_hist_minus>
                                              WITH KEY dpo_step = lv_dpo_step_minus.
        IF sy-subrc EQ 0.
          ls_approvers-form_id = <fs_hist_minus>-form_id.
        ENDIF.

        APPEND ls_approvers TO ls_footer_req-approvers.
      ENDLOOP.

      REFRESH lt_text.
      DATA(lt_text_sp) = lo_request->convert_string_to_text_table( iv_string = ls_texts-long_text_sp  ).
      DATA(lt_text_un) = lo_request->convert_string_to_text_table( iv_string = ls_texts-long_text_union  ).

      LOOP AT lt_text_sp INTO DATA(ls_text_sp).

        IF ls_text_sp CS TEXT-001.
          IF ls_request-werks_param EQ 'ZAD_ZAVODSP_MB'
          OR ls_request-werks_param IS INITIAL.
            SELECT SINGLE term_date, location FROM zhr_dpo_term INTO @DATA(ls_term)
                                       WHERE term_id = @ls_request-term_id.
            IF sy-subrc EQ 0.
              DATA lv_date(12) TYPE c.
              WRITE ls_term-term_date TO lv_date.
              REPLACE FIRST OCCURRENCE OF 'XX' IN ls_text_sp WITH lv_date.
              REPLACE FIRST OCCURRENCE OF 'XX' IN ls_text_sp WITH ls_term-location.
              APPEND ls_text_sp TO lt_text.
              CONTINUE.
            ENDIF.
          ELSE.
            LOOP AT lt_text_un INTO DATA(ls_text).
              APPEND ls_text TO lt_text.
            ENDLOOP.
            CONTINUE.
          ENDIF.
        ENDIF.
        APPEND ls_text_sp TO lt_text.
      ENDLOOP.

* pridaj prilohy.
       SELECT SINGLE url FROM zhr_dpo_csabl INTO @lv_url
                      WHERE template_code = @ls_request-template_code.
      IF lt_attch_tab[] IS NOT INITIAL OR lv_url IS NOT INITIAL.
        REFRESH ls_footer_req-attachments[].
        lv_attachment = TEXT-002.
        APPEND lv_attachment TO ls_footer_req-attachments.
      ENDIF.
      IF lv_url IS NOT INITIAL.
        lv_attachment = TEXT-004.
        APPEND lv_attachment TO ls_footer_req-attachments.
      ENDIF.
      lv_attachment = TEXT-003.
      APPEND lv_attachment TO ls_footer_req-attachments.

      IF lt_attch_tab[] IS NOT INITIAL.

        LOOP AT lt_attch_tab ASSIGNING <fs_attch_tab>.
          lv_attachment = <fs_attch_tab>-filename.
          APPEND lv_attachment TO ls_footer_req-attachments.
        ENDLOOP.
      ENDIF.


      ls_body_req-formated_body = lt_text.
*      ls_body_req-title = ls_request-name.


      SORT lt_hist_tmp BY role uname datum DESCENDING time DESCENDING.
      READ TABLE lt_history ASSIGNING <fs_hist>
                            WITH KEY role = 'SP'
                                     next_status = 'ASP'.
      IF sy-subrc EQ 0.
        lv_pernr = zcl_pa_vs_utils=>get_pernr_by_uname( iv_uname = <fs_hist>-uname ).

        ls_contact_data = zcl_hr_dpo_roles=>get_pernr_details( lv_pernr ).

        CONCATENATE ls_contact_data-full_name  '/'  ls_contact_data-cell_numbr INTO  ls_header_req-handles_phone  SEPARATED BY space.

        ls_header_req-mailaddress = ls_contact_data-email.
        ls_header_req-fax = ls_contact_data-fax_number.
        ls_header_req-date_header = ls_request-request_date.
        ls_header_req-our_brand = ls_request-dpo_req_full.



      ENDIF.
      DATA: ls_head  TYPE thead,
            lt_lines TYPE  tline_t.

      SELECT SINGLE value FROM zhr_dpo_cparam
                          INTO ls_head-tdname
                          WHERE parameter_dpo = 'ZAD_ADRESA'.
      IF sy-subrc EQ 0.
        ls_head-tdid = 'ST'.
        ls_head-tdspras = sy-langu.
        ls_head-tdobject = 'TEXT'.

        CALL FUNCTION 'READ_TEXT'
          EXPORTING
*           CLIENT                  = SY-MANDT
            id                      = ls_head-tdid
            language                = ls_head-tdspras
            name                    = ls_head-tdname
            object                  = ls_head-tdobject
          TABLES
            lines                   = lt_lines
          EXCEPTIONS
            id                      = 1
            language                = 2
            name                    = 3
            not_found               = 4
            object                  = 5
            reference_check         = 6
            wrong_access_to_archive = 7
            OTHERS                  = 8.

        LOOP AT lt_lines ASSIGNING FIELD-SYMBOL(<fs_lines>).
          ls_address = <fs_lines>-tdline.
          APPEND ls_address TO lt_address.
        ENDLOOP.

        ls_header_req-signature = lt_address.
      ENDIF.



      ls_header-our_brand = ls_request-dpo_req_full.

      CALL FUNCTION lv_funcname
        EXPORTING
          /1bcdwb/docparams  = ls_docparams
          is_footer          = ls_footer_req
          is_body            = ls_body_req
          is_header          = ls_header_req
        IMPORTING
          /1bcdwb/formoutput = ls_output
        EXCEPTIONS
          usage_error        = 1
          system_error       = 2
          internal_error     = 3
          OTHERS             = 4.
      IF sy-subrc <> 0.
* Implement suitable error handling here
      ENDIF.

    WHEN OTHERS.

  ENDCASE.


  IF sy-subrc <> 0.
    MESSAGE e002(zsd_sdp) INTO lv_text.
    zcl_sd_sdp_helper=>append_message_from_syst( CHANGING ct_message = lt_message ).
    RAISE EXCEPTION TYPE zcx_sd_sdp_main
      EXPORTING
        bapirettab = lt_message.
  ELSE.
    ev_pdf_stream = ls_output-pdf.
    es_formoutput = ls_output.
  ENDIF.

*  IF sy-title NE 'Call test environment'.

  CALL FUNCTION 'FP_JOB_CLOSE'
    EXCEPTIONS
      usage_error    = 1
      system_error   = 2
      internal_error = 3
      OTHERS         = 4.

*  ENDIF.

ENDFUNCTION.
