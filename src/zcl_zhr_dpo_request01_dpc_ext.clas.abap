class ZCL_ZHR_DPO_REQUEST01_DPC_EXT definition
  public
  inheriting from ZCL_ZHR_DPO_REQUEST01_DPC
  create public .

public section.

  methods /IWBEP/IF_MGW_APPL_SRV_RUNTIME~CREATE_STREAM
    redefinition .
  methods /IWBEP/IF_MGW_APPL_SRV_RUNTIME~EXECUTE_ACTION
    redefinition .
  methods /IWBEP/IF_MGW_APPL_SRV_RUNTIME~GET_STREAM
    redefinition .
  methods /IWBEP/IF_MGW_CORE_SRV_RUNTIME~CHANGESET_BEGIN
    redefinition .
  methods /IWBEP/IF_MGW_CORE_SRV_RUNTIME~CHANGESET_END
    redefinition .
  methods /IWBEP/IF_MGW_CORE_SRV_RUNTIME~CHANGESET_PROCESS
    redefinition .
protected section.

  methods NO_CACHE .

  methods APPROVALFORKSET_GET_ENTITYSET
    redefinition .
  methods APPROVALTYPESET_GET_ENTITYSET
    redefinition .
  methods AUTHSTRUCSET_GET_ENTITY
    redefinition .
  methods CLAIMITEMATTCHSE_CREATE_ENTITY
    redefinition .
  methods CLAIMITEMATTCHSE_GET_ENTITYSET
    redefinition .
  methods CREATORSET_GET_ENTITYSET
    redefinition .
  methods DEPUTYACTIVITYSE_GET_ENTITYSET
    redefinition .
  methods DEPUTYSET_CREATE_ENTITY
    redefinition .
  methods DEPUTYSET_DELETE_ENTITY
    redefinition .
  methods DEPUTYSET_GET_ENTITYSET
    redefinition .
  methods LONGTEXTALLSET_GET_ENTITY
    redefinition .
  methods LONGTEXTALLSET_UPDATE_ENTITY
    redefinition .
  methods LONGTEXTSET_GET_ENTITY
    redefinition .
  methods NEXTSTATUSSET_GET_ENTITYSET
    redefinition .
  methods NOTIFICATIONSET_GET_ENTITY
    redefinition .
  methods NOTIFICATIONSET_GET_ENTITYSET
    redefinition .
  methods NOTIFICATIONSET_UPDATE_ENTITY
    redefinition .
  methods OTHERAPPROVERS01_GET_ENTITYSET
    redefinition .
  methods OTHERAPPROVERSSE_CREATE_ENTITY
    redefinition .
  methods OTHERAPPROVERSSE_DELETE_ENTITY
    redefinition .
  methods OTHERAPPROVERSSE_GET_ENTITY
    redefinition .
  methods OTHERAPPROVERSSE_GET_ENTITYSET
    redefinition .
  methods OTHERAPPROVERSSE_UPDATE_ENTITY
    redefinition .
  methods OTHERROLESET_GET_ENTITYSET
    redefinition .
  methods PROCESSSET_UPDATE_ENTITY
    redefinition .
  methods REQATTCHPREVIEWS_DELETE_ENTITY
    redefinition .
  methods REQHISTORYSET_GET_ENTITY
    redefinition .
  methods REQHISTORYSET_GET_ENTITYSET
    redefinition .
  methods REQUESTATTCHDIRS_DELETE_ENTITY
    redefinition .
  methods REQUESTATTCHDIRS_GET_ENTITYSET
    redefinition .
  methods REQUESTDATASET_CREATE_ENTITY
    redefinition .
  methods REQUESTDATASET_GET_ENTITY
    redefinition .
  methods REQUESTDATASET_GET_ENTITYSET
    redefinition .
  methods REQUESTDATASET_UPDATE_ENTITY
    redefinition .
  methods ROLENEXTSET_GET_ENTITYSET
    redefinition .
  methods STATUSSET_GET_ENTITYSET
    redefinition .
  methods TEMPLATESET_GET_ENTITYSET
    redefinition .
  methods THEMESET_GET_ENTITYSET
    redefinition .
  methods VHEMPLOYEESET_GET_ENTITYSET
    redefinition .
  methods WERKSTEXTUNIONSE_GET_ENTITYSET
    redefinition .
  methods OTHERAPPROVERS01_GET_ENTITY
    redefinition .
private section.
ENDCLASS.



CLASS ZCL_ZHR_DPO_REQUEST01_DPC_EXT IMPLEMENTATION.


  method /IWBEP/IF_MGW_APPL_SRV_RUNTIME~CREATE_STREAM.



    DATA: lf_result          TYPE            flag,
          lt_message         TYPE            bapirettab,
          lo_message         TYPE REF TO     /iwbep/if_message_container,

          lo_facade          TYPE REF TO /iwbep/if_mgw_dp_int_facade,
          lt_request_headers TYPE tihttpnvp.

    CASE iv_entity_name.





      WHEN 'RequestAttch'.

        DATA: ls_att  TYPE ZHR_DPO_ATT_S.

* Read the HTTP Request headers.
        lo_facade ?= /iwbep/if_mgw_conv_srv_runtime~get_dp_facade( ).
        lt_request_headers = lo_facade->get_request_header( ).

        CALL METHOD ZCL_HR_DPO_SERVICE=>stream_update_attach
          EXPORTING
            iv_entity_set_name = iv_entity_set_name
            iv_source_name     = iv_source_name
            is_media_resource  = is_media_resource
            it_key_tab         = it_key_tab
            it_navigation_path = it_navigation_path
            iv_slug            = iv_slug
*           io_tech_request_context = io_tech_request_context
            it_request_headers = lt_request_headers
            ir_dpc_ext         = me
          IMPORTING
            et_message         = lt_message
            es_att             = ls_att.

        copy_data_to_ref( EXPORTING is_data = ls_att
                          CHANGING  cr_data = er_entity ).

    ENDCASE.


    IF lt_message[] IS NOT INITIAL.
      lo_message = mo_context->get_message_container( ).
      lo_message->add_messages_from_bapi( it_bapi_messages = lt_message iv_add_to_response_header = abap_true ).
*        raise exception type /iwbep/cx_mgw_busi_exception
*        exporting
*          message_container = lo_message.

    ENDIF.



  endmethod.


  METHOD /iwbep/if_mgw_appl_srv_runtime~execute_action.

    DATA: ls_entity TYPE zcl_zhr_dpo_request01_mpc=>ts_requestdata.
    DATA: ls_requestdata TYPE  zcl_zhr_dpo_request01_mpc=>ts_requestdata.
    DATA ls_request_id TYPE zhr_dpo_request_s.
    DATA lv_uname TYPE sy-uname.
    DATA lt_message TYPE bapiret2_t.
    DATA lv_term_id TYPE zhr_dpo_id_term.
    DATA: ls_mailcontacts TYPE  zcl_zhr_dpo_term_mpc=>ts_mailcontacts.
    DATA: ls_pdflink      TYPE  zcl_zhr_dpo_request01_mpc=>ts_pdflink_line.

*    READ TABLE it_parameter ASSIGNING FIELD-SYMBOL(<fs_param>) WITH KEY name = 'DpoRequest'.
*    IF sy-subrc EQ 0.

    IF line_exists( it_parameter[ name =  'DpoRequest' ] ).
      DATA(lv_dpo_request) =  CONV zhr_dpo_request(  it_parameter[ name =  'DpoRequest' ]-value  ).
      lv_dpo_request  = |{ lv_dpo_request ALPHA = IN }|.
    ENDIF.

    DO 5 TIMES.

      CALL FUNCTION 'ENQUEUE_EZHR_DPO_ZAD'
        EXPORTING
          dpo_request    = lv_dpo_request
        EXCEPTIONS
          foreign_lock   = 1
          system_failure = 2
          OTHERS         = 3.
      IF sy-subrc <> 0.

        WAIT UP TO 1 SECONDS .

      ELSE.
        EXIT.
      ENDIF.
    ENDDO.

    DATA(lo_request) = NEW zcl_hr_dpo_request( ).
    CASE iv_action_name.
      WHEN 'ChangeTermOnRequest'.
        READ TABLE it_parameter ASSIGNING FIELD-SYMBOL(<fs_param>) WITH KEY name = 'TermId'.
        IF sy-subrc EQ 0.
          CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'
            EXPORTING
              input  = <fs_param>-value
            IMPORTING
              output = lv_term_id.
        ENDIF.
        ls_request_id = lo_request->change_term( iv_dpo_request = lv_dpo_request iv_dpo_term = lv_term_id ).
        copy_data_to_ref( EXPORTING is_data = ls_request_id
                       CHANGING  cr_data = er_data ).
      WHEN 'PDFFormInt'
        OR 'PDFFormExt'.
        ls_request_id-dpo_request = lv_dpo_request.
        ls_request_id-return_code = 'OK'.
        copy_data_to_ref( EXPORTING is_data = ls_request_id
                       CHANGING  cr_data = er_data ).

      WHEN 'Delete'.

        IF line_exists( it_parameter[ name =  'RequestID' ] ).
          lv_dpo_request =  CONV zhr_dpo_request(  it_parameter[ name =  'RequestID' ]-value  ).
          lv_dpo_request  = |{ lv_dpo_request ALPHA = IN }|.

          DATA(ls_return) =  lo_request->delete_request( EXPORTING iv_dpo_request = lv_dpo_request
                                                                   iv_delete_status = 'VYM'
                                                         IMPORTING et_message = lt_message ).
          copy_data_to_ref( EXPORTING is_data = ls_request_id
                       CHANGING  cr_data = er_data ).
          IF lt_message[] IS NOT INITIAL.
            DATA(lo_message) = mo_context->get_message_container( ).
            lo_message->add_messages_from_bapi( it_bapi_messages = lt_message iv_add_to_response_header = abap_true ).
          ENDIF.
        ENDIF.

      WHEN 'Storno'.

        IF line_exists( it_parameter[ name =  'RequestID' ] ).
          lv_dpo_request =  CONV zhr_dpo_request(  it_parameter[ name =  'RequestID' ]-value  ).
          lv_dpo_request  = |{ lv_dpo_request ALPHA = IN }|.

          ls_return =  lo_request->delete_request( EXPORTING iv_dpo_request = lv_dpo_request
                                                         iv_delete_status = 'STO'
                                                         IMPORTING et_message = lt_message ).
          copy_data_to_ref( EXPORTING is_data = ls_request_id
                       CHANGING  cr_data = er_data ).
          IF lt_message[] IS NOT INITIAL.
            lo_message = mo_context->get_message_container( ).
            lo_message->add_messages_from_bapi( it_bapi_messages = lt_message iv_add_to_response_header = abap_true ).
          ENDIF.
        ENDIF.
      WHEN 'NextStep'.
        IF line_exists( it_parameter[ name =  'RequestID' ] ).
          lv_dpo_request =  CONV zhr_dpo_request(  it_parameter[ name =  'RequestID' ]-value  ).
          lv_dpo_request  = |{ lv_dpo_request ALPHA = IN }|.
        ENDIF.
        DATA(lv_next_status) = it_parameter[ name = 'NextStatus' ]-value.
        DATA(lv_clarification) = it_parameter[ name = 'Clarification' ]-value.
        lv_uname = SWITCH #( it_parameter[ name = 'actual_user' ]-value WHEN '' THEN zcl_pe_all_change_user=>get_uname( iv_appl_id = 'ZHR_DPO_REQUEST' )
                                                                        ELSE it_parameter[ name = 'actual_user' ]-value ).
        lo_request->read_request( iv_dpo_request = lv_dpo_request iv_read_tmp_request = abap_true  ).
        ls_return = lo_request->set_next_status( iv_next_status = CONV #( lv_next_status ) iv_clarification = CONV #( lv_clarification ) iv_uname = lv_uname ).
        IF ls_return-return_code = 'OK'.
          lo_request->save_req( ).
        ENDIF.
        copy_data_to_ref( EXPORTING is_data = ls_request_id
                       CHANGING  cr_data = er_data ).
      WHEN 'Create'.

        READ TABLE it_parameter ASSIGNING <fs_param> WITH KEY name = 'OriginUser'.
        IF sy-subrc EQ 0.
          lv_uname = <fs_param>-value.
        ENDIF.
        IF lv_uname IS INITIAL.
          lv_uname = zcl_pe_all_change_user=>get_uname( iv_appl_id = 'ZHR_DPO_REQUEST' ).
        ENDIF.
*
        lo_request->init_form_data( iv_uname = lv_uname ).
        lo_request->save_as_draft( ).
        ls_request_id = CORRESPONDING #( lo_request->get_request( ) ).

        copy_data_to_ref( EXPORTING is_data = ls_request_id
                          CHANGING  cr_data = er_data ).

      WHEN 'CopyRequest'.
        IF line_exists( it_parameter[ name =  'RequestID' ] ).
          lv_dpo_request =  CONV zhr_dpo_request(  it_parameter[ name =  'RequestID' ]-value  ).
          lv_dpo_request  = |{ lv_dpo_request ALPHA = IN }|.
        ENDIF.

        READ TABLE it_parameter ASSIGNING <fs_param> WITH KEY name = 'OriginUser'.
        IF sy-subrc EQ 0.
          lv_uname = <fs_param>-value.
        ENDIF.
        IF lv_uname IS INITIAL.
          lv_uname = zcl_pe_all_change_user=>get_uname( iv_appl_id = 'ZHR_DPO_REQUEST' ).
        ENDIF.
        ls_request_id-dpo_request =  lo_request->copy_request( iv_dpo_request = lv_dpo_request iv_origin_user = lv_uname ).

        copy_data_to_ref( EXPORTING is_data = ls_request_id
                          CHANGING  cr_data = er_data ).


      WHEN 'Save'.

        READ TABLE it_parameter ASSIGNING <fs_param> WITH KEY name = 'button_press'.
        IF <fs_param> IS ASSIGNED.
          CASE <fs_param>-value.

            WHEN 'SaveOnly'.
              lo_request->read_request( iv_dpo_request = lv_dpo_request iv_read_tmp_request = abap_true  ).
              lo_request->save_req(
                   iv_button_as_draft = ' '
              ).

            WHEN 'SaveAsDraft'.
              lo_request->read_request( iv_dpo_request = lv_dpo_request iv_read_tmp_request = abap_true  ).

              lo_request->save_req(
                   iv_button_as_draft = 'X'
              ).
            WHEN 'SaveAndSend'.

              DATA(ls_request) = lo_request->read_request( iv_dpo_request = lv_dpo_request iv_read_tmp_request = abap_true  ).
              lo_request->save_req(
                  iv_button_as_draft = 'N' ).

              IF ( ls_request-url IS NOT INITIAL AND zcl_hr_dpo_a004=>add_or_get( iv_request = lv_dpo_request )->get_complete( ) = abap_true )
              OR ls_request-url IS INITIAL.
                lv_uname = it_parameter[ name = 'actual_user' ]-value.
                IF lv_uname IS INITIAL.
                  lv_uname = zcl_pe_all_change_user=>get_uname( iv_appl_id = 'ZHR_DPO_REQUEST' ).
                ENDIF.
                lo_request->button_press( iv_button =  'SENT_TO_APPROVE' iv_process = lo_request->gs_data_db-process iv_uname =  lv_uname  ).
                lo_request->save_req( ).
              ELSE.
                DATA: ls_message TYPE bapiret2,
                      lv_par1    TYPE sy-msgv1.
                CALL FUNCTION 'BALW_BAPIRETURN_GET2'
                  EXPORTING
                    type   = 'E'
                    cl     = 'ZHR_DPO'
                    number = '029'
                    par1   = lv_par1
                  IMPORTING
                    return = ls_message.
                .
                APPEND ls_message TO lt_message.
                DATA(ls_request_struct) = lo_request->get_request( ) .
                ls_request_id-dpo_request = ls_request_struct-dpo_request .
                ls_request_id-return_code = '505'.
                copy_data_to_ref( EXPORTING is_data = ls_request_id
                                  CHANGING  cr_data = er_data ).

                IF lt_message[] IS NOT INITIAL.
                  lo_message = mo_context->get_message_container( ).
                  lo_message->add_messages_from_bapi( it_bapi_messages = lt_message iv_add_to_response_header = abap_true ).
*                  RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
*                    EXPORTING
*                      message_container = lo_message.
                ENDIF.
              ENDIF.
          ENDCASE.


          ls_request_struct = lo_request->get_request( ) .
          ls_request_id-dpo_request = ls_request_struct-dpo_request .
        ENDIF.
        copy_data_to_ref( EXPORTING is_data = ls_request_id
                         CHANGING  cr_data = er_data ).


      WHEN 'GetMailContacts'.
        READ TABLE it_parameter ASSIGNING <fs_param> WITH KEY name = 'button_press'.
        IF sy-subrc EQ 0.
          DATA(ls_list) =   zcl_hr_dpo_term=>mail_contacts( iv_button_press = CONV #( <fs_param>-value ) ).
        ENDIF.
        ls_mailcontacts-mails = ls_list.
        copy_data_to_ref( EXPORTING is_data = ls_mailcontacts
                        CHANGING  cr_data = er_data ).

      WHEN 'GetPDFLink'.
        READ TABLE it_parameter ASSIGNING <fs_param> WITH KEY name = 'button_press'.
        IF sy-subrc EQ 0.
          ls_pdflink-pdflink =   zcl_hr_dpo_service=>get_manual_link( iv_button_press = CONV #( <fs_param>-value ) ).
        ENDIF.
        copy_data_to_ref( EXPORTING is_data = ls_pdflink
                        CHANGING  cr_data = er_data ).

      WHEN 'GetEmailSubjectBody'.
        IF line_exists( it_parameter[ name =  'RequestID' ] ).
          lv_dpo_request =  CONV zhr_dpo_request(  it_parameter[ name =  'RequestID' ]-value  ).
          lv_dpo_request  = |{ lv_dpo_request ALPHA = IN }|.
        ENDIF.
        IF line_exists( it_parameter[ name =  'button_press' ] ).
          DATA(lv_button_press) =  CONV zhr_dpo_request(  it_parameter[ name =  'button_press' ]-value  ).

        ENDIF.
        DATA(ls_mail) = lo_request->get_mail_union( iv_dpo_request = lv_dpo_request iv_button = CONV #( lv_button_press )  ).
        copy_data_to_ref( EXPORTING is_data = ls_mail
                       CHANGING  cr_data = er_data ).

    ENDCASE.

    CALL FUNCTION 'DEQUEUE_EZHR_DPO_ZAD'
      EXPORTING
        dpo_request = lv_dpo_request.



  ENDMETHOD.


  METHOD /iwbep/if_mgw_appl_srv_runtime~get_stream.

    CASE iv_entity_name.

      WHEN 'WordTemplate'.

        CALL METHOD zcl_hr_dpo_service=>stream_word_template
          EXPORTING
            iv_entity_set_name      = iv_entity_set_name
            iv_source_name          = iv_source_name
            it_key_tab              = it_key_tab
            it_navigation_path      = it_navigation_path
            io_tech_request_context = io_tech_request_context
            ir_dpc_ext              = me
          IMPORTING
            er_stream               = er_stream.

      WHEN 'ShowPdf'.



        CALL METHOD zcl_hr_dpo_service=>stream_get_doc_pdf_show
          EXPORTING
            iv_entity_set_name      = iv_entity_set_name
            iv_source_name          = iv_source_name
            it_key_tab              = it_key_tab
            it_navigation_path      = it_navigation_path
            io_tech_request_context = io_tech_request_context
            ir_dpc_ext              = me
          IMPORTING
            er_stream               = er_stream.


      WHEN 'ReqAttchPreview'.
*        DATA(lv_uname) = zcl_pe_all_change_user=>get_uname( iv_appl_id = 'ZHR_DPO_REQUEST' ).
*        SELECT * FROM zhr_dpo_zastup
*                     INTO TABLE @DATA(lt_zastup)
*                     WHERE deputy  = @lv_uname.
*
*        DO.
*          DATA(ls_auth_struc) = NEW zcl_hr_dpo_request( )->get_authorization_structure(
*        EXPORTING
*          iv_uname            = lv_uname
*          iv_dpo_process      = 'P-CENTR'  ).
**
*          IF ls_auth_struc-display_pdf EQ abap_true.
** ma opravneni
*            EXIT.
*          ENDIF.
*          IF lt_zastup[] IS NOT INITIAL.
*            READ TABLE lt_zastup ASSIGNING FIELD-SYMBOL(<fs_zastup>) INDEX 1.
*            IF sy-subrc EQ 0.
*              lv_uname = <fs_zastup>-creator.
*            ENDIF.
** skus zastupce.
*          ELSE.
*            EXIT.
*          ENDIF.
*
*        ENDDO.
*        IF ls_auth_struc-display_pdf EQ abap_true.
*
          CALL METHOD zcl_hr_dpo_service=>stream_get_attachment_preview
            EXPORTING
              iv_entity_set_name      = iv_entity_set_name
              iv_source_name          = iv_source_name
              it_key_tab              = it_key_tab
              it_navigation_path      = it_navigation_path
              io_tech_request_context = io_tech_request_context
              ir_dpc_ext              = me
            IMPORTING
              er_stream               = er_stream.
*        ENDIF.
      WHEN OTHERS.

    ENDCASE.




  ENDMETHOD.


  method /IWBEP/IF_MGW_CORE_SRV_RUNTIME~CHANGESET_BEGIN.
**TRY.
*CALL METHOD SUPER->/IWBEP/IF_MGW_CORE_SRV_RUNTIME~CHANGESET_BEGIN
*  EXPORTING
*    IT_OPERATION_INFO   =
**    it_changeset_input  =
**    io_changeset_helper =
**  CHANGING
**    cv_defer_mode       =
*    .
**  CATCH /iwbep/cx_mgw_busi_exception.
**  CATCH /iwbep/cx_mgw_tech_exception.
**ENDTRY.

     cv_defer_mode = 'X'.
  endmethod.


  method /IWBEP/IF_MGW_CORE_SRV_RUNTIME~CHANGESET_END.
**TRY.
*CALL METHOD SUPER->/IWBEP/IF_MGW_CORE_SRV_RUNTIME~CHANGESET_END
*    .
**  CATCH /iwbep/cx_mgw_busi_exception.
**  CATCH /iwbep/cx_mgw_tech_exception.
**ENDTRY.
  endmethod.


  method /IWBEP/IF_MGW_CORE_SRV_RUNTIME~CHANGESET_PROCESS.
**TRY.
*CALL METHOD SUPER->/IWBEP/IF_MGW_CORE_SRV_RUNTIME~CHANGESET_PROCESS
*  CHANGING
*    CT_CHANGESET_DATA =
*    .
**  CATCH /iwbep/cx_mgw_busi_exception.
**  CATCH /iwbep/cx_mgw_tech_exception.
**ENDTRY.
  endmethod.


  method approvalforkset_get_entityset.

    data lv_dpo_request type zhr_dpo_request.

    read table  it_filter_select_options[] assigning field-symbol(<fs_so>) with key property = 'DpoRequest'.
    check <fs_so> is assigned.
    loop at <fs_so>-select_options[] assigning field-symbol(<fs_req>).
      call function 'CONVERSION_EXIT_ALPHA_INPUT'
        exporting
          input  = <fs_req>-low
        importing
          output = lv_dpo_request.


      exit.
    endloop.


    et_entityset = zcl_hr_dpo_request=>show_approval_fork( iv_dpo_request =  lv_dpo_request  iv_only_next_approvers = abap_false  ).


  endmethod.


  method APPROVALTYPESET_GET_ENTITYSET.
     DATA: ls_entity LIKE LINE OF ET_ENTITYSET.
    DATA lr_appr_type TYPE RANGE OF ZHR_DPO_APPR_TYPE.
    DATA lv_field TYPE string.
    FIELD-SYMBOLS: <lt_range> TYPE ANY TABLE.



    LOOP AT io_tech_request_context->get_filter( )->get_filter_select_options( ) ASSIGNING FIELD-SYMBOL(<ls_filter_sel_opt>).
      lv_field = 'LR_' && <ls_filter_sel_opt>-property.
      ASSIGN (lv_field) TO <lt_range>.
      CHECK sy-subrc = 0.
      io_tech_request_context->get_filter( )->convert_select_option(
        EXPORTING
          is_select_option = <ls_filter_sel_opt>                 " Key name
        IMPORTING
          et_select_option = <lt_range>                 " Ranges table
      ).
*      CATCH /iwbep/cx_mgw_tech_exception. " Technical Exception
    ENDLOOP.

    DATA(lt_appr_type) = ZCL_HR_DPO_REQUEST=>get_domain_values( 'ZHR_DPO_APPR_TYPE'  ).

    LOOP AT lt_appr_type ASSIGNING FIELD-SYMBOL(<fs_appr_type>).
      ls_entity-approval_kind = <fs_appr_type>-domvalue_l.
      ls_entity-description   = <fs_appr_type>-ddtext  .
      APPEND ls_entity TO et_entityset.
    ENDLOOP.


      DELETE et_entityset WHERE approval_kind   NOT IN lr_appr_type.
  endmethod.


  METHOD authstrucset_get_entity.


    DATA lt_message TYPE bapiret2_t.
    DATA: lv_dpo_request TYPE zhr_dpo_request.
    DATA: lv_uname       TYPE sy-uname.
    DATA: ls_authority_struc TYPE zhr_dpo_prava_s.

    DATA(lv_adm_name) = zcl_pe_all_change_user=>get_uname( iv_appl_id = 'ZHR_DPO_REQUEST' ).


    LOOP AT it_key_tab ASSIGNING FIELD-SYMBOL(<fs_key>).
      IF <fs_key>-name = 'DpoRequest'.
        lv_dpo_request = |{ <fs_key>-value ALPHA = IN }|..
      ENDIF.
      IF <fs_key>-name = 'Uname'.
        lv_uname = |{ <fs_key>-value ALPHA = IN }|..
        IF lv_uname = 'undefined'.
          CLEAR lv_uname.
        ENDIF.
      ENDIF.
    ENDLOOP.

    IF lv_uname IS INITIAL.
      lv_uname = lv_adm_name.
    ENDIF.

* je to zástupce, zjisti jeho oprávňení
    IF lv_uname NE lv_adm_name.
      SELECT SINGLE * FROM zhr_dpo_zastup
                      INTO @DATA(ls_zastup)
                      WHERE creator = @lv_uname
                        AND deputy  = @lv_adm_name.


    ENDIF.


*     IF lv_adm_name IS NOT INITIAL AND lv_adm_name NE sy-uname..
*       CLEAR ls_zastup.
*       lv_uname = lv_adm_name.
*       DATA(lv_no_subst) = abap_true.
*     ENDIF.

*    IF lv_uname IS INITIAL.
*      lv_uname = sy-uname.
*    ENDIF.

    IF lv_dpo_request IS NOT INITIAL.
      SELECT SINGLE dpo_type, dpo_req_full FROM zhr_dpo_zad INTO @DATA(ls_process)
                           WHERE dpo_request = @lv_dpo_request.
      IF ls_process-dpo_type IS INITIAL.
        ls_process-dpo_type = 'P-CENTR'.
      ENDIF.
    ENDIF.


    DATA(lo_request) = NEW zcl_hr_dpo_request( ).
    ls_authority_struc = lo_request->get_authorization_structure( EXPORTING iv_dpo_request =  lv_dpo_request
                                               iv_uname      =  lv_uname
                                               iv_dpo_process    = ls_process-dpo_type
                                               IMPORTING et_message = lt_message ).
*    IF lv_no_subst = abap_true.
*     CLEAR ls_authority_struc-request_deputy_o.
*    ENDIF.

    CASE ls_zastup-activity."opravnení zástupce
      WHEN 'C'. "jenom zadavani
        CLEAR:
        ls_authority_struc-request_deputy_o,
        ls_authority_struc-request_next_step_o,
        ls_authority_struc-request_text_edit_o,
        ls_authority_struc-request_send_o .
      WHEN 'A'."jenom schvalování
        CLEAR:
         ls_authority_struc-request_deputy_o,
         ls_authority_struc-request_create_o,
         ls_authority_struc-request_delete_o,
         ls_authority_struc-request_text_edit_o,
         ls_authority_struc-term_create_o.
      WHEN 'F' . "vše
        CLEAR: ls_authority_struc-request_deputy_o.
      WHEN OTHERS.
    ENDCASE.


*    IF lv_dpo_request IS NOT INITIAL AND ls_authority_struc-request_disp IS INITIAL.
*      MESSAGE e026(zhr_dpo) INTO DATA(lv_msg) WITH ls_process-dpo_req_full.
*      zcl_ca_uniframe_utils=>add_sy_msg_to_returntab(
*     CHANGING
*        ct_messages = lt_message ).
*    ENDIF.

    er_entity = CORRESPONDING #( ls_authority_struc ).

    IF lt_message[] IS NOT INITIAL.
      DATA(lo_message) = mo_context->get_message_container( ).
      lo_message->add_messages_from_bapi( it_bapi_messages = lt_message iv_add_to_response_header = abap_true ).
      RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
        EXPORTING
          message_container = lo_message.
    ENDIF.


    no_cache( ).

*      catch /iwbep/cx_mgw_busi_exception.
*      catch /iwbep/cx_mgw_tech_exception.

*    endtry.
  ENDMETHOD.


  method CLAIMITEMATTCHSE_CREATE_ENTITY.
**try.
*CALL METHOD SUPER->CLAIMITEMATTCHSE_CREATE_ENTITY
*  EXPORTING
*    IV_ENTITY_NAME          =
*    IV_ENTITY_SET_NAME      =
*    IV_SOURCE_NAME          =
*    IT_KEY_TAB              =
**    io_tech_request_context =
*    IT_NAVIGATION_PATH      =
**    io_data_provider        =
**  importing
**    er_entity               =
*    .
**  catch /iwbep/cx_mgw_busi_exception.
**  catch /iwbep/cx_mgw_tech_exception.
**endtry.



  endmethod.


  method CLAIMITEMATTCHSE_GET_ENTITYSET.
**try.
*CALL METHOD SUPER->CLAIMITEMATTCHSE_GET_ENTITYSET
*  EXPORTING
*    IV_ENTITY_NAME           =
*    IV_ENTITY_SET_NAME       =
*    IV_SOURCE_NAME           =
*    IT_FILTER_SELECT_OPTIONS =
*    IS_PAGING                =
*    IT_KEY_TAB               =
*    IT_NAVIGATION_PATH       =
*    IT_ORDER                 =
*    IV_FILTER_STRING         =
*    IV_SEARCH_STRING         =
**    io_tech_request_context  =
**  importing
**    et_entityset             =
**    es_response_context      =
*    .
**  catch /iwbep/cx_mgw_busi_exception.
**  catch /iwbep/cx_mgw_tech_exception.
**endtry.
   break dzc26y2.


  endmethod.


  method CREATORSET_GET_ENTITYSET.


    DATA(lt_creator_list) =  zcl_hr_dpo_roles=>get_creator_list( ).
    et_entityset = CORRESPONDING #( lt_creator_list ).

  endmethod.


  method DEPUTYACTIVITYSE_GET_ENTITYSET.

   et_entityset = zcl_hr_dpo_roles=>get_deputy_activity( ).


  endmethod.


  method deputyset_create_entity.


    data ls_key type zhr_dpo_zastup.
    data lt_message type bapiret2_t.
    data   lo_message         TYPE REF TO     /iwbep/if_message_container.

    try.
        io_data_provider->read_entry_data( importing es_data = er_entity ).
      catch cx_static_check.
    endtry.


    move-corresponding er_entity to ls_key.
    data(lv_return_code) = zcl_hr_dpo_roles=>create_deputy( exporting is_entry = ls_key
       importing et_message = lt_message ).

    if lt_message[] is not initial.
      lo_message = mo_context->get_message_container( ).
      lo_message->add_messages_from_bapi( it_bapi_messages = lt_message iv_add_to_response_header = abap_true ).

    endif.

    no_cache( ).

  endmethod.


  method DEPUTYSET_DELETE_ENTITY.

  DATA: lv_creator TYPE uname,
        lv_deputy  TYPE uname,
        lt_message TYPE bapiret2_t.
 data   lo_message         TYPE REF TO     /iwbep/if_message_container.

  READ TABLE it_key_tab ASSIGNING FIELD-SYMBOL(<fs_key>) WITH KEY name = 'Creator'.
  IF sy-subrc EQ 0.
   lv_creator = <fs_key>-value.
  ENDIF.
  READ TABLE it_key_tab ASSIGNING <fs_key> WITH KEY name = 'CreatorDeputy'.
  IF sy-subrc EQ 0.
   lv_deputy = <fs_key>-value.
  ENDIF.

  DATA(lv_return_code) =  zcl_hr_dpo_roles=>delete_deputy( exporting
      iv_creator  = lv_creator
      iv_deputy   = lv_deputy
    importing      et_message  = lt_message                 " Návratová tabulka
       )
    .
   if lt_message[] is not initial.
      lo_message = mo_context->get_message_container( ).
      lo_message->add_messages_from_bapi( it_bapi_messages = lt_message iv_add_to_response_header = abap_true ).

    endif.

  endmethod.


  method deputyset_get_entityset.


    DATA(lt_deputy_list) =  zcl_hr_dpo_roles=>get_deputy_list( ).
    et_entityset = CORRESPONDING #( lt_deputy_list ).

  endmethod.


  method longtextallset_get_entity.
**try.
*CALL METHOD SUPER->LONGTEXTALLSET_GET_ENTITY
*  EXPORTING
*    IV_ENTITY_NAME          =
*    IV_ENTITY_SET_NAME      =
*    IV_SOURCE_NAME          =
*    IT_KEY_TAB              =
**    io_request_object       =
**    io_tech_request_context =
*    IT_NAVIGATION_PATH      =
**  importing
**    er_entity               =
**    es_response_context     =
*    .
**  catch /iwbep/cx_mgw_busi_exception.
**  catch /iwbep/cx_mgw_tech_exception.
**endtry.
    data lv_dpo_request type zhr_dpo_request.

    loop at it_key_tab[] assigning field-symbol(<fs_key>) where name = 'DpoRequest'.
      call function 'CONVERSION_EXIT_ALPHA_INPUT'
        exporting
          input  = <fs_key>-value
        importing
          output = lv_dpo_request.
    endloop.




    data(lo_request) = new zcl_hr_dpo_request( ).

    lo_request->read_request( lv_dpo_request ).
    lo_request->read_customizing( ).

    er_entity = corresponding #( lo_request->get_long_texts_all( lv_dpo_request ) ).




  endmethod.


  method longtextallset_update_entity.
**try.
*CALL METHOD SUPER->LONGTEXTALLSET_UPDATE_ENTITY
*  EXPORTING
*    IV_ENTITY_NAME          =
*    IV_ENTITY_SET_NAME      =
*    IV_SOURCE_NAME          =
*    IT_KEY_TAB              =
**    io_tech_request_context =
*    IT_NAVIGATION_PATH      =
**    io_data_provider        =
**  importing
**    er_entity               =
*    .
**  catch /iwbep/cx_mgw_busi_exception.
**  catch /iwbep/cx_mgw_tech_exception.
**endtry.
    data: lv_dpo_request type zhr_dpo_request.
    data: ls_approver type zhr_dpo_rozdel_s,
          lt_message  type standard table of bapiret2.

    read table it_key_tab assigning field-symbol(<fs_key>)
                        with key name = 'DpoRequest'.
    if sy-subrc eq 0.
      call function 'CONVERSION_EXIT_ALPHA_INPUT'
        exporting
          input  = <fs_key>-value
        importing
          output = lv_dpo_request.

    endif.


    try.
        io_data_provider->read_entry_data( importing es_data = er_entity ).
      catch cx_static_check.
    endtry.

    data(lo_request) = new zcl_hr_dpo_request( ).
    lo_request->read_request( lv_dpo_request ).
    data(ls_return) =   lo_request->save_all_longtexts(
        exporting
          is_longtext = er_entity
         importing
           et_message  = lt_message

      ).

  endmethod.


  method longtextset_get_entity.


    DATA lv_template_code TYPE zhr_dpo_templ_code.

    loop at it_key_tab[] assigning field-symbol(<fs_key>) where name = 'TemplateCode'.

      lv_template_code = <fs_key>-value.
    endloop.


    data(lo_request) = new zcl_hr_dpo_request( ).

    er_entity = CORRESPONDING #( lo_request->get_long_text( lv_template_code ) ).



  endmethod.


  METHOD nextstatusset_get_entityset.


    DATA: lv_dpo_request TYPE zhr_dpo_request,
          lt_message     TYPE STANDARD TABLE OF bapiret2.

    READ TABLE it_key_tab ASSIGNING FIELD-SYMBOL(<fs_key>)
       WITH KEY name = 'DpoRequest'.
    IF sy-subrc = 0.
      lv_dpo_request = |{ <fs_key>-value ALPHA = IN }|.
    ENDIF.


    DATA(lo_request) = NEW zcl_hr_dpo_request( ).

    lo_request->read_customizing( ).

    lo_request->read_request(
      EXPORTING
        iv_dpo_request      =    lv_dpo_request              " ID žádosti
        iv_read_tmp_request =   abap_true                " Nové vstup.hodnoty

    ).

    DATA(lt_output) = lo_request->get_next_status_tab(
                        EXPORTING
                          iv_ignore_appl_stat = abap_true
                          iv_dpo_request = lv_dpo_request                 " ID žádosti
                        IMPORTING
                           et_message     = lt_message                 " Návratová tabulka
 ).

    et_entityset[] = CORRESPONDING #( lt_output ).

  ENDMETHOD.


  method NOTIFICATIONSET_GET_ENTITY.
**try.
*CALL METHOD SUPER->NOTIFICATIONSET_GET_ENTITY
*  EXPORTING
*    IV_ENTITY_NAME          =
*    IV_ENTITY_SET_NAME      =
*    IV_SOURCE_NAME          =
*    IT_KEY_TAB              =
**    io_request_object       =
**    io_tech_request_context =
*    IT_NAVIGATION_PATH      =
**  importing
**    er_entity               =
**    es_response_context     =
*    .
**  catch /iwbep/cx_mgw_busi_exception.
**  catch /iwbep/cx_mgw_tech_exception.
**endtry.
  endmethod.


  method NOTIFICATIONSET_GET_ENTITYSET.


    DATA: lv_termid      TYPE zhr_dpo_id_term,
       lv_dpo_request TYPE zhr_dpo_request,
       lt_message     TYPE bapiret2_t.

 loop at it_key_tab[] assigning field-symbol(<fs_key>).
     CASE <fs_key>-name.
       WHEN 'TermId'.
         call function 'CONVERSION_EXIT_ALPHA_INPUT'
           exporting
             input         = <fs_key>-value
          IMPORTING
            OUTPUT        = lv_termid
                   .


       WHEN 'DpoRequest'.
         call function 'CONVERSION_EXIT_ALPHA_INPUT'
           exporting
             input         = <fs_key>-value
          IMPORTING
            OUTPUT        = lv_dpo_request
                   .

       WHEN OTHERS.
     ENDCASE.

    endloop.


    data(lo_notif) = new zcl_hr_dpo_notif( ).

    et_entityset = CORRESPONDING #( lo_notif->GET_NOTIF_HISTORY(
                                      exporting
                                        iv_term        = lv_termid               " DPO Termín
                                        iv_dpo_request = lv_dpo_request                 " ID žádosti
                                       importing
                                         et_message     = lt_message               " Návratová tabulka
                                    ) ).
  endmethod.


  method NOTIFICATIONSET_UPDATE_ENTITY.
**try.
*CALL METHOD SUPER->NOTIFICATIONSET_UPDATE_ENTITY
*  EXPORTING
*    IV_ENTITY_NAME          =
*    IV_ENTITY_SET_NAME      =
*    IV_SOURCE_NAME          =
*    IT_KEY_TAB              =
**    io_tech_request_context =
*    IT_NAVIGATION_PATH      =
**    io_data_provider        =
**  importing
**    er_entity               =
*    .
**  catch /iwbep/cx_mgw_busi_exception.
**  catch /iwbep/cx_mgw_tech_exception.
**endtry.
  endmethod.


  method NO_CACHE.

     DATA ls_header TYPE ihttpnvp.
    ls_header-name = 'Cache-Control' ##NO_TEXT.
    ls_header-value = 'no-cache, no-store' ##NO_TEXT.
    me->set_header( EXPORTING is_header = ls_header ).
    ls_header-name = 'X-Content-Type-Options' ##NO_TEXT.
    ls_header-value = 'nosniff' ##NO_TEXT.
    me->set_header( EXPORTING is_header = ls_header ).



  endmethod.


  METHOD otherapprovers01_get_entity.
    DATA(lv_dpo_request) = CONV zhr_dpo_request( it_key_tab[ name = 'DpoRequest' ]-value  ).
    DATA(lv_pernr) = CONV pernr_d( it_key_tab[ name = 'Pernr' ]-value  ).
    DATA(lt_entity) = zcl_hr_dpo_request=>show_approval_fork( iv_dpo_request = CONV #( |{ lv_dpo_request ALPHA = IN } | )
                                                              iv_only_next_approvers = abap_true
                                                              iv_pernr = CONV #( |{ lv_pernr ALPHA = IN } | )    ).

    IF line_exists( lt_entity[ 1 ] ).
      er_entity =  lt_entity[ 1 ].
    ENDIF.
  ENDMETHOD.


  method OTHERAPPROVERS01_GET_ENTITYSET.



      DATA: lv_dpo_request TYPE zhr_dpo_request.



      READ TABLE it_key_tab ASSIGNING FIELD-SYMBOL(<fs_key>)
                             WITH KEY name = 'DpoRequest'.
      IF sy-subrc EQ 0.
        lv_dpo_request =  <fs_key>-value .
        lv_dpo_request =  |{ lv_dpo_request ALPHA = IN }|.
      ENDIF.



    et_entityset = zcl_hr_dpo_request=>show_approval_fork( iv_dpo_request =  lv_dpo_request iv_only_next_approvers = abap_true   ).
    READ TABLE IT_FILTER_SELECT_OPTIONS ASSIGNING FIELD-SYMBOL(<fs_role>)
                                          WITH KEY property = 'RoleKey'.
      IF sy-subrc EQ 0.
        DELETE et_entityset WHERe role_key NOT IN <fs_role>-select_options.
      ENDIF.


    sort et_entityset BY ordernr.



  endmethod.


  METHOD otherapproversse_create_entity.


    DATA: ls_approver TYPE zhr_dpo_rozdel_s,
          lt_message  TYPE STANDARD TABLE OF bapiret2.


    DATA(lv_dpo_request) = CONV zhr_dpo_request( it_key_tab[ name = 'DpoRequest' ]-value  ).
         lv_dpo_request  = |{ lv_dpo_request ALPHA = IN }|.

    TRY.
        io_data_provider->read_entry_data( IMPORTING es_data = er_entity ).
      CATCH cx_static_check.
    ENDTRY.

    DATA(lo_request) = NEW zcl_hr_dpo_request( ).
    lo_request->read_request( lv_dpo_request ).

    MOVE-CORRESPONDING er_entity TO ls_approver.
    ls_approver-dpo_request = lv_dpo_request.

    lo_request->add_next_approver(
      EXPORTING
        is_approver = ls_approver

      IMPORTING
         et_message  = lt_message
).

    IF lt_message[] IS NOT INITIAL.

*      DATA(lo_message) = mo_context->get_message_container( ).
     DATA(lo_message) = /iwbep/if_mgw_conv_srv_runtime~get_message_container( ).
      lo_message->add_messages_from_bapi( it_bapi_messages = lt_message iv_determine_leading_msg = abap_true  ).

       CLEAR er_entity.

        RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
        EXPORTING
          textid             = /iwbep/cx_mgw_busi_exception=>business_error
          message_container = lo_message.

    ENDIF.



  ENDMETHOD.


  method otherapproversse_delete_entity.
    data: lv_dpo_request type zhr_dpo_request,
          lv_role        type zhr_dpo_role,
          lv_pernr       type pernr_d,
          lv_uname       type sy-uname,
          lt_message     type bapiret2_t.

    loop at it_key_tab assigning field-symbol(<fs_key>).
      if <fs_key>-name = 'DpoRequest'.
        call function 'CONVERSION_EXIT_ALPHA_INPUT'
          exporting
            input         = <fs_key>-value
         IMPORTING
            OUTPUT        = lv_dpo_request
                  .


      endif.
      if <fs_key>-name = 'RoleKey'.
        lv_role = <fs_key>-value.
      endif.
      if <fs_key>-name = 'Pernr'.
        lv_pernr = <fs_key>-value.
      endif.

    endloop.

   select single usrid from pa0105
                            into lv_uname
                            where pernr = lv_pernr
                              and begda LE sy-datum
                              and endda GE sy-datum
                              and usrty = '0001'.



    data(lo_request) = new zcl_hr_dpo_request( ).

    lo_request->delete_next_approver(
      exporting
        iv_dpo_request = lv_dpo_request                " ID žádosti
        iv_role        = lv_role                 " Role
        iv_uname       = lv_uname                 " Jméno uživatele
       importing
         et_message     =  lt_message                " Návratová tabulka
       receiving
         rs_return      = data(ls_return)                 " Tabulka osob ve vybraných rolích
    ).
    if lt_message[] is not initial.
      data(lo_message) = mo_context->get_message_container( ).
      lo_message->add_messages_from_bapi( it_bapi_messages = lt_message iv_add_to_response_header = abap_true ).
*      raise exception type /iwbep/cx_mgw_busi_exception
*        exporting
*          message_container = lo_message.
    endif.


  endmethod.


  METHOD otherapproversse_get_entity.

    DATA(lv_dpo_request) = CONV zhr_dpo_request( it_key_tab[ name = 'DpoRequest' ]-value  ).
    DATA(lv_pernr) = CONV pernr_d( it_key_tab[ name = 'Pernr' ]-value  ).
    DATA(lt_entity) = zcl_hr_dpo_request=>show_approval_fork( iv_dpo_request = CONV #( |{ lv_dpo_request ALPHA = IN } | )
                                                              iv_only_next_approvers = abap_true
                                                              iv_pernr = CONV #( |{ lv_pernr ALPHA = IN } | )    ).

    IF line_exists( lt_entity[ 1 ] ).
       er_entity =  lt_entity[ 1 ].
    ENDIF.
  ENDMETHOD.


  method OTHERAPPROVERSSE_GET_ENTITYSET.


      DATA: lv_dpo_request TYPE zhr_dpo_request.



      READ TABLE it_key_tab ASSIGNING FIELD-SYMBOL(<fs_key>)
                             WITH KEY name = 'DpoRequest'.
      IF sy-subrc EQ 0.
        lv_dpo_request =  <fs_key>-value .
        lv_dpo_request =  |{ lv_dpo_request ALPHA = IN }|.
      ENDIF.



    et_entityset = zcl_hr_dpo_request=>show_approval_fork( iv_dpo_request =  lv_dpo_request iv_only_next_approvers = abap_true   ).
    READ TABLE IT_FILTER_SELECT_OPTIONS ASSIGNING FIELD-SYMBOL(<fs_role>)
                                          WITH KEY property = 'RoleKey'.
      IF sy-subrc EQ 0.
        DELETE et_entityset WHERe role_key NOT IN <fs_role>-select_options.
      ENDIF.


    sort et_entityset BY ordernr.


  endmethod.


  METHOD otherapproversse_update_entity.

    DATA: ls_approver TYPE zhr_dpo_rozdel_s,
          lt_message  TYPE STANDARD TABLE OF bapiret2.



    DATA(lv_dpo_request) = CONV zhr_dpo_request( it_key_tab[ name = 'DpoRequest' ]-value  ).
    DATA(lv_role) = CONV zhr_dpo_request( it_key_tab[ name = 'RoleKey' ]-value  ).
    lv_dpo_request = |{ lv_dpo_request ALPHA = IN }|.


    TRY.
        io_data_provider->read_entry_data( IMPORTING es_data = er_entity ).
      CATCH cx_static_check.
    ENDTRY.

    DATA(lo_request) = NEW zcl_hr_dpo_request( ).

    MOVE-CORRESPONDING er_entity TO ls_approver.
    ls_approver-role = lv_role.
    ls_approver-dpo_request = lv_dpo_request.

    lo_request->update_next_approver(
      EXPORTING
        is_approver = ls_approver

      IMPORTING
         et_message  = lt_message
    ).

    IF lt_message[] IS NOT INITIAL.
      DATA(lo_message) = mo_context->get_message_container( ).
      lo_message->add_messages_from_bapi( it_bapi_messages = lt_message iv_add_to_response_header = abap_true ).

    ENDIF.
  ENDMETHOD.


  method OTHERROLESET_GET_ENTITYSET.
**try.
*CALL METHOD SUPER->OTHERROLESET_GET_ENTITYSET
*  EXPORTING
*    IV_ENTITY_NAME           =
*    IV_ENTITY_SET_NAME       =
*    IV_SOURCE_NAME           =
*    IT_FILTER_SELECT_OPTIONS =
*    IS_PAGING                =
*    IT_KEY_TAB               =
*    IT_NAVIGATION_PATH       =
*    IT_ORDER                 =
*    IV_FILTER_STRING         =
*    IV_SEARCH_STRING         =
**    io_tech_request_context  =
**  importing
**    et_entityset             =
**    es_response_context      =
*    .
**  catch /iwbep/cx_mgw_busi_exception.
**  catch /iwbep/cx_mgw_tech_exception.
**endtry.

  et_entityset = CORRESPONDING  #( zcl_hr_dpo_request=>get_other_roles( ) ).


  endmethod.


  method PROCESSSET_UPDATE_ENTITY.
**try.
*CALL METHOD SUPER->PROCESSSET_UPDATE_ENTITY
*  EXPORTING
*    IV_ENTITY_NAME          =
*    IV_ENTITY_SET_NAME      =
*    IV_SOURCE_NAME          =
*    IT_KEY_TAB              =
**    io_tech_request_context =
*    IT_NAVIGATION_PATH      =
**    io_data_provider        =
**  importing
**    er_entity               =
*    .
**  catch /iwbep/cx_mgw_busi_exception.
**  catch /iwbep/cx_mgw_tech_exception.
**endtry.



   TRY.
      io_data_provider->read_entry_data( IMPORTING es_data = er_entity ).
    CATCH cx_static_check.
  ENDTRY.


  endmethod.


  method REQATTCHPREVIEWS_DELETE_ENTITY.
**try.
*CALL METHOD SUPER->REQATTCHPREVIEWS_DELETE_ENTITY
*  EXPORTING
*    IV_ENTITY_NAME          =
*    IV_ENTITY_SET_NAME      =
*    IV_SOURCE_NAME          =
*    IT_KEY_TAB              =
**    io_tech_request_context =
*    IT_NAVIGATION_PATH      =
*    .
**  catch /iwbep/cx_mgw_busi_exception.
**  catch /iwbep/cx_mgw_tech_exception.
**endtry.
    break dzc26y2.
  endmethod.


  method REQHISTORYSET_GET_ENTITY.
**try.
*CALL METHOD SUPER->REQHISTORYSET_GET_ENTITY
*  EXPORTING
*    IV_ENTITY_NAME          =
*    IV_ENTITY_SET_NAME      =
*    IV_SOURCE_NAME          =
*    IT_KEY_TAB              =
**    io_request_object       =
**    io_tech_request_context =
*    IT_NAVIGATION_PATH      =
**  importing
**    er_entity               =
**    es_response_context     =
*    .
**  catch /iwbep/cx_mgw_busi_exception.
**  catch /iwbep/cx_mgw_tech_exception.
**endtry.

    break dzc26y2.

  endmethod.


  method reqhistoryset_get_entityset.

    data: lv_dpo_request type zhr_dpo_request.

    READ TABLE it_key_tab ASSIGNING FIELD-SYMBOL(<fs_key>)
                          WITH KEY name = 'DpoRequest'.
    IF sy-subrc EQ 0.
       lv_dpo_request = <fs_key>-value.
        call function 'CONVERSION_EXIT_ALPHA_INPUT'
          exporting
            input         = lv_dpo_request
          IMPORTING
           OUTPUT        = lv_dpo_request
                  .
    ENDIF.

*    loop at it_filter_select_options[] assigning field-symbol(<fso>) where property eq 'DpoRequest'.
*
*      data(lr_dpo_request) = <fso>-select_options[].
*      loop at lr_dpo_request assigning field-symbol(<fs_request>).
*        lv_dpo_request = <fs_request>-low.
*        call function 'CONVERSION_EXIT_ALPHA_INPUT'
*          exporting
*            input         = lv_dpo_request
*          IMPORTING
*           OUTPUT        = lv_dpo_request
*                  .
*
*        exit.
*      endloop.
*      exit.
*    endloop.

    data(lo_request) = new zcl_hr_dpo_request( ).

*lo_request->read_customizing( ).

    data(lt_output) = lo_request->get_history( iv_dpo_request = lv_dpo_request  ).


    DATA(ls_request) = lo_request->read_request( lv_dpo_request ).
    IF ls_request-button_as_draft NE abap_true
    AND lines( lt_output[] ) GT 1.
      DELETE lt_output INDEX 1.
    ENDIF.

    et_entityset[] = corresponding #( lt_output ).


  endmethod.


  method REQUESTATTCHDIRS_DELETE_ENTITY.
**try.
*CALL METHOD SUPER->REQUESTATTCHDIRS_DELETE_ENTITY
*  EXPORTING
*    IV_ENTITY_NAME          =
*    IV_ENTITY_SET_NAME      =
*    IV_SOURCE_NAME          =
*    IT_KEY_TAB              =
**    io_tech_request_context =
*    IT_NAVIGATION_PATH      =
*    .
**  catch /iwbep/cx_mgw_busi_exception.
**  catch /iwbep/cx_mgw_tech_exception.
**endtry.


    DATA: lv_guid(40) TYPE c.
    DATA: lv_dpo_request TYPE zhr_dpo_request.
    DATA: ls_attch TYPE ZHR_DPO_ATT_S.

    READ TABLE it_key_tab ASSIGNING FIELD-SYMBOL(<fs_key>) WITH KEY name = 'Guid'.
    IF sy-subrc EQ 0.
      ls_attch-guid = <fs_key>-value.
    ENDIF.
    READ TABLE it_key_tab ASSIGNING <fs_key> WITH KEY name = 'DpoRequest'.
    IF sy-subrc EQ 0.
      call function 'CONVERSION_EXIT_ALPHA_INPUT'
        exporting
          input         = <fs_key>-value
        IMPORTING
          OUTPUT        = ls_attch-dpo_request
                .


    ENDIF.


    DATA(lo_request) = NEW zcl_hr_dpo_request( ).
    lo_request->read_request( ls_attch-dpo_request ).
    lo_request->delete_attachment(
      exporting
        is_attch   = ls_attch
*      importing
*        et_message =                  " Návratová tabulka
      receiving
         rs_return  = DATA(ls_return)               " Dpo Žádost
    ).




  endmethod.


  METHOD requestattchdirs_get_entityset.

    DATA: lv_dpo_request TYPE zhr_dpo_request.

    DATA(lt_filter_so) = io_tech_request_context->get_filter( )->get_filter_select_options( ).

    READ TABLE it_key_tab ASSIGNING FIELD-SYMBOL(<fs_key>)
                        WITH KEY name = 'DpoRequest'.
    IF sy-subrc EQ 0.
      lv_dpo_request = <fs_key>-value.
      CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'
        EXPORTING
          input  = lv_dpo_request
        IMPORTING
          output = lv_dpo_request.
    ENDIF.

    IF line_exists( lt_filter_so[ property = 'UNAME' ] ).
      DATA(lv_uname) = lt_filter_so[ property = 'UNAME' ]-select_options[ 1 ]-low.
    ELSE.
      lv_uname =  zcl_pe_all_change_user=>get_uname( iv_appl_id = 'ZHR_DPO_REQUEST' ).
    ENDIF.

    DATA(lo_request) = NEW zcl_hr_dpo_request( ).
    lo_request->read_request(
      EXPORTING
        iv_dpo_request      =    lv_dpo_request     ).

    et_entityset = CORRESPONDING #( lo_request->read_attachment_tab( iv_dpo_request = lv_dpo_request iv_dpo_term = '0000000000'
                                     iv_uname = CONV #( lv_uname ) ) ).


  ENDMETHOD.


  method REQUESTDATASET_CREATE_ENTITY.

 DATA:
    lr_form_io TYPE REF TO zcl_hr_dpo_request,
    lr_form    TYPE REF TO zcl_ca_uniframe,
    lr_data    TYPE REF TO zcl_zhr_dpo_request01_mpc=>ts_requestdata,
    ls_key     TYPE zca_uf_key.

*     DATA:
*    lr_form_io TYPE REF TO zcl_hr_dpo_request.
*    lr_form    TYPE REF TO zcl_ca_uniframe,
*    lr_data    TYPE REF TO zcl_zhr_dpo_request01_mpc=>ts_requestdata,
*    ls_key     TYPE zca_uf_key.

    DATA:
    lt_messages      TYPE bapirettab,
*    lr_form          TYPE REF TO zcl_ca_uniframe,
    lr_msg_container TYPE REF TO /iwbep/if_message_container,
    ls_control       TYPE zca_uf_gw_control_data,
    ls_control_be    TYPE zca_uf_control_data,
    ls_buttons       TYPE zca_uf_buttons_visibility_ui,
    lv_name          TYPE string,
*    ls_key           TYPE zca_uf_key,
    lv_result        TYPE sysubrc.

  FIELD-SYMBOLS:
    <fs_key>      LIKE LINE OF it_key_tab.

*  LOOP AT it_key_tab ASSIGNING <fs_key>.
*    lv_name = <fs_key>-name.
*    TRANSLATE lv_name TO UPPER CASE.
*    CASE lv_name.
*      WHEN 'FORMTYPE'.
*        ls_key-form_type = <fs_key>-value.
*      WHEN 'FORMID'.
*        ls_key-form_id = <fs_key>-value.
*      WHEN 'LINEID'.
*        ls_key-line_id = <fs_key>-value.
*      WHEN 'STEPID'.
*        ls_key-step_id = <fs_key>-value.
*      WHEN 'WIID'.
*        ls_key-wi_id = <fs_key>-value.
*      WHEN 'OPERATION'.
*        ls_control-operation = <fs_key>-value.
*      WHEN 'PROCESSMODE'.
*        ls_control-process_mode = <fs_key>-value.
*    ENDCASE.
*  ENDLOOP.

  ls_control-process_mode = 'NEW'.
  ls_control-operation = 'LOAD'.
  ls_key-form_type = 'HR_DPO_REQ'.

  "pokud bude mod NEW, vygeneruje se u instance novy FormID, ktery
  "pouzijeme v UI pro binding hodnot
  zcl_ca_uniframe=>create_instance(
    EXPORTING
      iv_process_mode = ls_control-process_mode
      is_key          = ls_key
    IMPORTING
      ev_result       = lv_result
      et_messages     = lt_messages
      er_form         = lr_form ).



   TRY.
      io_data_provider->read_entry_data( IMPORTING es_data = er_entity ).
    CATCH cx_static_check.
  ENDTRY.

*  DATA(lr_form_io) = NEW zcl_hr_dpo_request( ).

  MOVE-CORRESPONDING er_entity TO ls_key.

  zcl_ca_uniframe=>get_instance(
    IMPORTING
      er_form = lr_form ).

  CHECK lr_form IS BOUND.

  lr_form_io ?= lr_form.
*
  CREATE DATA lr_data.
  ASSIGN lr_data->* TO FIELD-SYMBOL(<fs_data>).
  MOVE-CORRESPONDING er_entity TO <fs_data>.

  lr_form_io->read_customizing( ).
  lr_form_io->prepare_to_save( CHANGING chs_requestdata = <fs_data> ).

  lr_form_io->set_request_data(
    EXPORTING
      ir_protocol_data = lr_data ).

  lr_form_io->save_as_draft( ).

  IF <fs_data>-term_id IS NOT INITIAL.

    lr_form_io->update_term_in_history(
      i_term_id      = <fs_data>-term_id
      i_old_term_id  = '0'
      iv_dpo_request = <fs_data>-dpo_request
    ).
  ENDIF.

  <fs_data>-dpo_request = lr_form_io->gs_data_db-dpo_request.

  er_entity = CORRESPONDING #( <fs_data>  ).

  endmethod.


  METHOD requestdataset_get_entity.



    IF line_exists( it_key_tab[ name = 'DpoRequest' ]  ).
      DATA(lv_dpo_request) = CONV zhr_dpo_request( it_key_tab[ name = 'DpoRequest' ]-value  ).
      DATA(lo_request) = NEW zcl_hr_dpo_request( ).
      lo_request->read_request( iv_dpo_request = |{ lv_dpo_request ALPHA = IN }|   iv_read_tmp_request = abap_true  ).
      er_entity = CORRESPONDING #( lo_request->get_request( ) ).
    ENDIF.

  ENDMETHOD.


  METHOD requestdataset_get_entityset.

    DATA r_uname TYPE RANGE OF sy-uname.
    DATA lv_term_string TYPE string.
    DATA lv_process TYPE zhr_dpo_process.
    DATA lt_output_final TYPE zhr_dpo_zad_t.
    DATA ls_output TYPE zhr_dpo_zad_struct.
    CONSTANTS: c_quot TYPE c VALUE `'`.


    DATA(lv_uname) = zcl_pe_all_change_user=>get_uname( iv_appl_id = 'ZHR_DPO_REQUEST' ).
    IF lv_uname IS NOT INITIAL .
      r_uname = VALUE #( sign = 'I' option = 'EQ' ( low = lv_uname ) ).
    ENDIF.

    LOOP AT it_filter_select_options[] ASSIGNING FIELD-SYMBOL(<fso>).
      CASE <fso>-property.
        WHEN 'TasksUnfinished'.
          DATA(lr_taskunfinished) = <fso>-select_options[].
        WHEN 'RequestorNameFull'.
          DATA(lr_requestorname) = <fso>-select_options[].
        WHEN 'Orgeh'.
          DATA(lr_orgeh) = <fso>-select_options[].
        WHEN 'Creator'.
          DATA(lr_creator) = <fso>-select_options[].
        WHEN 'Name'.
          DATA(lr_name) = <fso>-select_options[].
        WHEN 'DpoReqFull'.
          DATA(lr_request_full) = <fso>-select_options[].
        WHEN 'RequestDate'.
          DATA(lr_request_date) = <fso>-select_options[].
        WHEN 'Status'.
          DATA(lr_status) = <fso>-select_options[].
        WHEN 'TermDate'.
          DATA(lr_termdate) = <fso>-select_options[].
        WHEN 'Process'.
          DATA(lr_process) = <fso>-select_options[].
          LOOP AT lr_process ASSIGNING FIELD-SYMBOL(<fs_process>).
            lv_process = <fs_process>-low.
          ENDLOOP.
        WHEN 'DpoYear'.
          DATA(lr_request_year) = <fso>-select_options[].
        WHEN 'DpoRequest'.
          DATA(lr_request) = <fso>-select_options[].
        WHEN 'DpoType'.
          DATA(lr_request_type) = <fso>-select_options[].
        WHEN OTHERS.
      ENDCASE.
    ENDLOOP.

    IF it_filter_select_options[] IS INITIAL AND iv_filter_string IS NOT INITIAL.
      FIND 'P-CENTR' IN iv_filter_string.
      IF sy-subrc EQ 0.
        DATA r_status LIKE LINE OF lr_process.

        r_status-sign = 'I'.
        r_status-option = 'EQ'.
        r_status-low = 'P-CENTR'.
        APPEND r_status TO lr_process.
        lv_process = zcl_hr_dpo_const=>dpo_process.
      ENDIF.


      lv_term_string = iv_filter_string. "( ( ( ( substringof ( 'fdf'
      FIND c_quot IN iv_filter_string MATCH OFFSET DATA(lv_offset).
      lv_term_string = iv_filter_string+lv_offset.
      FIND c_quot IN  lv_term_string+1 MATCH OFFSET lv_offset.
      lv_offset = lv_offset + 1.
      lv_term_string = lv_term_string(lv_offset).
      REPLACE ALL OCCURRENCES OF c_quot IN lv_term_string WITH ''.
      TRANSLATE lv_term_string TO UPPER CASE.

    ENDIF.

    IF r_uname[] IS NOT INITIAL AND lr_creator IS INITIAL.
      lr_creator[] = CORRESPONDING #( r_uname[] ).
    ENDIF.

    DATA(lo_request) = NEW zcl_hr_dpo_request( ).

    LOOP AT lr_name ASSIGNING FIELD-SYMBOL(<fs_name>).
      <fs_name>-low =  '%' && <fs_name>-low && '%'.
      TRANSLATE <fs_name>-low TO UPPER CASE.
    ENDLOOP.

    IF lv_process IS NOT INITIAL.

      DATA(lt_output) = lo_request->get_request_list(
            request_range = lr_request
            request_type_range = lr_request_type
            request_year_range = lr_request_year
            request_date_range = lr_request_date
            status_range  = lr_status
            process_range = lr_process
            request_full_range = lr_request_full
            requestor_full_name = lr_requestorname
            name_range = lr_name
            creator_range = lr_creator
            iv_process = lv_process
            orgeh = lr_orgeh
            term_date = lr_termdate
            iv_from_term_string = lv_term_string
            task_unfinished = lr_taskunfinished

    ).
      et_entityset[] = CORRESPONDING #( lt_output ).

    ELSE.

      lv_process = zcl_hr_dpo_const=>dpo_process.
      lr_process =  VALUE #( sign = 'I' option = 'EQ' ( low = zcl_hr_dpo_const=>dpo_process ) ).
      lt_output = lo_request->get_request_list(
           request_range = lr_request
           request_type_range = lr_request_type
           request_year_range = lr_request_year
           request_date_range = lr_request_date
           status_range  = lr_status
           process_range = lr_process
           request_full_range = lr_request_full
           requestor_full_name = lr_requestorname
           name_range = lr_name
           creator_range = lr_creator
           iv_process = lv_process
           orgeh = lr_orgeh
            term_date = lr_termdate
           task_unfinished = lr_taskunfinished
           iv_from_term_string = lv_term_string

   ).

      lv_process = zcl_hr_dpo_const=>dpo_dohoda.
      lr_process =  VALUE #( sign = 'I' option = 'EQ' ( low = zcl_hr_dpo_const=>dpo_dohoda ) ).
      lt_output_final = lo_request->get_request_list(
           request_range = lr_request
           request_type_range = lr_request_type
           request_year_range = lr_request_year
           request_date_range = lr_request_date
           status_range  = lr_status
           process_range = lr_process
           request_full_range = lr_request_full
           requestor_full_name = lr_requestorname
           name_range = lr_name
           creator_range = lr_creator
           iv_process = lv_process
           orgeh = lr_orgeh
            term_date = lr_termdate
           task_unfinished = lr_taskunfinished
           iv_from_term_string = lv_term_string

   ).
      LOOP AT lt_output INTO ls_output.
        APPEND ls_output TO lt_output_final.
      ENDLOOP.
      SORT lt_output_final BY request_date DESCENDING dpo_request DESCENDING..

      et_entityset[] = CORRESPONDING #( lt_output_final ).


    ENDIF.
  ENDMETHOD.


  METHOD requestdataset_update_entity.

    DATA:
      lr_form_io TYPE REF TO zcl_hr_dpo_request,
      lr_form    TYPE REF TO zcl_ca_uniframe,
      lr_data    TYPE REF TO zcl_zhr_dpo_request01_mpc=>ts_requestdata,
      ls_key     TYPE zca_uf_key.


    DATA:
      lt_messages      TYPE bapirettab,
*    lr_form          TYPE REF TO zcl_ca_uniframe,
      lr_msg_container TYPE REF TO /iwbep/if_message_container,
      ls_control       TYPE zca_uf_gw_control_data,
      ls_control_be    TYPE zca_uf_control_data,
      ls_buttons       TYPE zca_uf_buttons_visibility_ui,
      lv_name          TYPE string,
      ls_request       TYPE zhr_dpo_zad_struct,
*    ls_key           TYPE zca_uf_key,
      lv_result        TYPE sysubrc.

    FIELD-SYMBOLS:
      <fs_key>      LIKE LINE OF it_key_tab.


    TRY.
        io_data_provider->read_entry_data( IMPORTING es_data = er_entity ).
      CATCH cx_static_check.
    ENDTRY.

    lr_form_io = NEW zcl_hr_dpo_request( ).


    CREATE DATA lr_data.
    ASSIGN lr_data->* TO FIELD-SYMBOL(<fs_data>).
    MOVE-CORRESPONDING er_entity TO <fs_data>.

    ls_request = lr_form_io->read_request( iv_dpo_request =  <fs_data>-dpo_request iv_read_tmp_request = abap_true ).
    <fs_data>-process = ls_request-process.
    <fs_data>-status  = ls_request-status.
*    <fs_data>-theme = ls_request-theme.
*    <fs_data>-template_code = ls_request-template_code.
    <fs_data>-changes = 'X'.
    <fs_data>-next_status = ls_request-next_status.
    <fs_data>-dpo_step = ls_request-dpo_step.
    <fs_data>-request_date = ls_request-request_date.
    IF <fs_data>-template_code IS INITIAL AND ls_request-template_code IS NOT INITIAL.
      <fs_data>-template_code = ls_request-template_code.
    ENDIF.
    IF <fs_data>-dpo_type IS INITIAL AND ls_request-dpo_type IS NOT INITIAL.
      <fs_data>-dpo_type = ls_request-dpo_type.
    ENDIF.



    lr_form_io->read_customizing( ).

    lr_form_io->set_request_data(
      EXPORTING
        ir_protocol_data = lr_data ).

    IF <fs_data>-term_id IS NOT INITIAL.

      lr_form_io->update_term_in_history(
        i_term_id      = <fs_data>-term_id
        iv_dpo_request = <fs_data>-dpo_request
      ).
    ENDIF.

    lr_form_io->save_req( ).



    <fs_data>-dpo_request = lr_form_io->gs_data_db-dpo_request.

    er_entity = CORRESPONDING #( <fs_data>  ).


  ENDMETHOD.


  method ROLENEXTSET_GET_ENTITYSET.

    DATA(lt_role_list) =  zcl_hr_dpo_roles=>GET_ROLE_NEXT( ).
    et_entityset = CORRESPONDING #( lt_role_list ).

  endmethod.


  METHOD statusset_get_entityset.
    TRY.
        CALL METHOD super->statusset_get_entityset
          EXPORTING
            iv_entity_name           = iv_entity_name
            iv_entity_set_name       = iv_entity_set_name
            iv_source_name           = iv_source_name
            it_filter_select_options = it_filter_select_options
            is_paging                = is_paging
            it_key_tab               = it_key_tab
            it_navigation_path       = it_navigation_path
            it_order                 = it_order
            iv_filter_string         = iv_filter_string
            iv_search_string         = iv_search_string
            io_tech_request_context  = io_tech_request_context
          IMPORTING
            et_entityset             = et_entityset
            es_response_context      = es_response_context.
      CATCH /iwbep/cx_mgw_busi_exception.
      CATCH /iwbep/cx_mgw_tech_exception.
    ENDTRY.

    SORT et_entityset BY status_num.
  ENDMETHOD.


  METHOD templateset_get_entityset.
**try.
*CALL METHOD SUPER->TEMPLATESET_GET_ENTITYSET
*  EXPORTING
*    IV_ENTITY_NAME           =
*    IV_ENTITY_SET_NAME       =
*    IV_SOURCE_NAME           =
*    IT_FILTER_SELECT_OPTIONS =
*    IS_PAGING                =
*    IT_KEY_TAB               =
*    IT_NAVIGATION_PATH       =
*    IT_ORDER                 =
*    IV_FILTER_STRING         =
*    IV_SEARCH_STRING         =
**    io_tech_request_context  =
**  importing
**    et_entityset             =
**    es_response_context      =
*    .
**  catch /iwbep/cx_mgw_busi_exception.
**  catch /iwbep/cx_mgw_tech_exception.
**endtry.

    DATA lr_theme TYPE RANGE OF zhr_dpo_csabl-theme.
    DATA lr_template_code TYPE RANGE OF zhr_dpo_csabl-template_code.
    DATA: ls_entity LIKE LINE OF et_entityset.
    DATA: lv_field TYPE string.
    FIELD-SYMBOLS: <lt_range> TYPE ANY TABLE.

    LOOP AT io_tech_request_context->get_filter( )->get_filter_select_options( ) ASSIGNING FIELD-SYMBOL(<ls_filter_sel_opt>).
      lv_field = 'LR_' && <ls_filter_sel_opt>-property.
      ASSIGN (lv_field) TO <lt_range>.
      CHECK sy-subrc = 0.
      io_tech_request_context->get_filter( )->convert_select_option(
        EXPORTING
          is_select_option = <ls_filter_sel_opt>                 " Key name
        IMPORTING
          et_select_option = <lt_range>                 " Ranges table
      ).
*      CATCH /iwbep/cx_mgw_tech_exception. " Technical Exception
    ENDLOOP.

    SELECT theme, a~template_code, template_text, process FROM zhr_dpo_csabl AS a
                          INNER JOIN zhr_dpo_csablt AS b
                          ON a~template_code EQ b~template_code
                          INTO TABLE @DATA(lt_template_list)
                          WHERE theme IN @lr_theme
                            AND a~template_code IN @lr_template_code
                            AND b~spras EQ @sy-langu.

    LOOP AT lt_template_list ASSIGNING FIELD-SYMBOL(<fs_template>).
      MOVE-CORRESPONDING <fs_template> TO ls_entity.
      ls_entity-template_desc = <fs_template>-template_text.
      ls_entity-process = <fs_template>-process.
      APPEND ls_entity TO et_entityset.
    ENDLOOP.

    SORT et_entityset BY template_code.


  ENDMETHOD.


  METHOD themeset_get_entityset.

    DATA: ls_entity LIKE LINE OF et_entityset.
    DATA lr_theme TYPE RANGE OF zhr_dpo_csabl-theme.
    DATA lv_field TYPE string.
    FIELD-SYMBOLS: <lt_range> TYPE ANY TABLE.

    LOOP AT io_tech_request_context->get_filter( )->get_filter_select_options( ) ASSIGNING FIELD-SYMBOL(<ls_filter_sel_opt>).
      lv_field = 'LR_' && <ls_filter_sel_opt>-property.
      ASSIGN (lv_field) TO <lt_range>.
      CHECK sy-subrc = 0.
      io_tech_request_context->get_filter( )->convert_select_option(
        EXPORTING
          is_select_option = <ls_filter_sel_opt>                 " Key name
        IMPORTING
          et_select_option = <lt_range>                 " Ranges table
      ).
*      CATCH /iwbep/cx_mgw_tech_exception. " Technical Exception
    ENDLOOP.

    DATA(lt_theme) = zcl_hr_dpo_request=>get_domain_values( 'ZHR_DPO_THEME'  ).



    LOOP AT lt_theme ASSIGNING FIELD-SYMBOL(<fs_theme>).

      ls_entity-theme = <fs_theme>-domvalue_l.
      ls_entity-theme_desc = <fs_theme>-ddtext  .
      APPEND ls_entity TO et_entityset.
    ENDLOOP.


    DELETE et_entityset WHERE theme NOT IN lr_theme.

  ENDMETHOD.


  method vhemployeeset_get_entityset.

    data: lv_pernr   type persno,
          lv_pernr_c(8) type c,
          lv_name    type pad_vorna,
          lv_surname type pad_nachn,
          lv_uname   type syuname,
          lv_role    type zhr_dpo_role,
          lv_dpo_request type zhr_dpo_request.

    clear: et_entityset.

*    lv_uname = zcl_pe_all_change_user=>get_uname( iv_appl_id = zcl_pa_vs_all_data=>application_id_common ).
*    lv_uname = zcl_pe_all_change_user=>get_uname( iv_appl_id = 'ZHR_DPO_REQUEST' ).

    lv_pernr_c = zcl_pa_vs_utils=>get_param_from_filter( iv_name = 'Pernr' it_filter_select_options = it_filter_select_options ).
    IF lv_pernr_c CN '0123456789  '.
     CLEAR lv_pernr.
    ELSE.
      lv_pernr = lv_pernr_c.
    ENDIF.
*    lv_name = zcl_pa_vs_utils=>get_param_from_filter( iv_name = 'Name' it_filter_select_options = it_filter_select_options ).
    lv_surname = zcl_pa_vs_utils=>get_param_from_filter( iv_name = 'Fullname' it_filter_select_options = it_filter_select_options ).
    lv_name = zcl_pa_vs_utils=>get_param_from_filter( iv_name = 'Fullname' it_filter_select_options = it_filter_select_options ).
    IF  lv_surname CA '0123456789'.
     CLEAR lv_surname.
    ENDIF.
    IF  lv_name CA '0123456789'.
     CLEAR lv_name.
    ENDIF.
     lv_role = zcl_pa_vs_utils=>get_param_from_filter( iv_name = 'Role' it_filter_select_options = it_filter_select_options ).
     lv_uname = zcl_pa_vs_utils=>get_param_from_filter( iv_name = 'Uname' it_filter_select_options = it_filter_select_options ).

     IF lv_uname IS INITIAL AND lv_pernr IS INITIAL AND lv_surname IS INITIAL AND lv_role EQ 'KONZUL'.

     ELSE.
     READ TABLE it_filter_select_options ASSIGNING FIELD-SYMBOL(<fs_name>)
                                         with key property = 'DpoRequest'.
     IF sy-subrc EQ 0.
       LOOP AT <fs_name>-select_options ASSIGNING FIELD-SYMBOL(<fs_val>).
       call function 'CONVERSION_EXIT_ALPHA_INPUT'
         exporting
           input        = <fs_val>-low
        IMPORTING
          OUTPUT        = lv_dpo_request
                 .
        EXIT.
       ENDLOOP.
     ENDIF.
     SELECT SINGLE requestor FROM zhr_dpo_zad
                             INTO lv_uname
                              WHERE dpo_request = lv_dpo_request.


  IF lv_name IS NOT INITIAL.
    CONCATENATE '*' lv_name '*' INTO lv_name.
  ENDIF.
  IF lv_surname IS NOT INITIAL.
    CONCATENATE '*' lv_surname '*' INTO lv_surname.
  ENDIF.
      et_entityset = zcl_hr_dpo_roles=>search_employee(
              iv_pernr      =     lv_pernr
              iv_name       =     lv_name
              iv_surname    =     lv_surname
              iv_for_uname  =     lv_uname
              iv_role        = lv_role
            ).

    ENDIF.

  endmethod.


  method WERKSTEXTUNIONSE_GET_ENTITYSET.
**try.
*CALL METHOD SUPER->WERKSTEXTUNIONSE_GET_ENTITYSET
*  EXPORTING
*    IV_ENTITY_NAME           =
*    IV_ENTITY_SET_NAME       =
*    IV_SOURCE_NAME           =
*    IT_FILTER_SELECT_OPTIONS =
*    IS_PAGING                =
*    IT_KEY_TAB               =
*    IT_NAVIGATION_PATH       =
*    IT_ORDER                 =
*    IV_FILTER_STRING         =
*    IV_SEARCH_STRING         =
**    io_tech_request_context  =
**  importing
**    et_entityset             =
**    es_response_context      =
*    .
**  catch /iwbep/cx_mgw_busi_exception.
**  catch /iwbep/cx_mgw_tech_exception.
**endtry.



    DATA(lo_reqeust) = NEW zcl_hr_dpo_request( ).


    et_entityset = CORRESPONDING #( lo_reqeust->GET_WERKS_UNION_TEXT( ) ).


  endmethod.
ENDCLASS.
