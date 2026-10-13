class ZCL_ZHR_DPO_TERM_DPC_EXT definition
  public
  inheriting from ZCL_ZHR_DPO_TERM_DPC
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

  methods ADDREQUESTSET_GET_ENTITYSET
    redefinition .
  methods AUTHSTRUCSET_GET_ENTITY
    redefinition .
  methods DPONOTIFICATIONS_GET_ENTITY
    redefinition .
  methods NOTIFATTCHDIRSET_DELETE_ENTITY
    redefinition .
  methods NOTIFATTCHDIRSET_GET_ENTITYSET
    redefinition .
  methods REQUESTFORKSET_GET_ENTITYSET
    redefinition .
  methods STATUSNOTIFSET_GET_ENTITYSET
    redefinition .
  methods STATUSREQUESTSET_GET_ENTITYSET
    redefinition .
  methods STATUSTASKSET_GET_ENTITYSET
    redefinition .
  methods TASKSET_CREATE_ENTITY
    redefinition .
  methods TASKSET_DELETE_ENTITY
    redefinition .
  methods TASKSET_GET_ENTITY
    redefinition .
  methods TASKSET_GET_ENTITYSET
    redefinition .
  methods TASKSET_UPDATE_ENTITY
    redefinition .
  methods TERMREQUESTCOPYS_GET_ENTITY
    redefinition .
  methods TERMREQUESTCOPYS_GET_ENTITYSET
    redefinition .
  methods TERMREQUESTSET_GET_ENTITY
    redefinition .
  methods TERMREQUESTSET_GET_ENTITYSET
    redefinition .
  methods TERMREQUESTSET_UPDATE_ENTITY
    redefinition .
  methods TERMSET_CREATE_ENTITY
    redefinition .
  methods TERMSET_GET_ENTITY
    redefinition .
  methods TERMSET_GET_ENTITYSET
    redefinition .
  methods TERMSET_UPDATE_ENTITY
    redefinition .
  methods WORDTEMPLATELINK_GET_ENTITY
    redefinition .
  methods TERMREQUESTCOPYS_UPDATE_ENTITY
    redefinition .
private section.
ENDCLASS.



CLASS ZCL_ZHR_DPO_TERM_DPC_EXT IMPLEMENTATION.


  method /IWBEP/IF_MGW_APPL_SRV_RUNTIME~CREATE_STREAM.

DATA: lf_result          TYPE            flag,
          lt_message         TYPE            bapirettab,
          lo_message         TYPE REF TO     /iwbep/if_message_container,

          lo_facade          TYPE REF TO /iwbep/if_mgw_dp_int_facade,
          lt_request_headers TYPE tihttpnvp.

    CASE iv_entity_name.

      WHEN 'NotifAttch'.

        DATA: ls_att  TYPE ZHR_DPO_ATT_S.

* Read the HTTP Request headers.
        lo_facade ?= /iwbep/if_mgw_conv_srv_runtime~get_dp_facade( ).
        lt_request_headers = lo_facade->get_request_header( ).

        CALL METHOD ZCL_HR_DPO_SERVICE=>stream_update_attach_notif
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
        raise exception type /iwbep/cx_mgw_busi_exception
        exporting
          message_container = lo_message.

    ENDIF.



  endmethod.


  METHOD /iwbep/if_mgw_appl_srv_runtime~execute_action.

*   data: ls_entity type zcl_zhr_dpo_term01_mpc=>ts_.
    DATA: ls_requestdata TYPE  zcl_zhr_dpo_request01_mpc=>ts_requestdata.
    DATA: ls_mailcontacts TYPE  zcl_zhr_dpo_term_mpc=>ts_mailcontacts.
    DATA ls_response TYPE zhr_dpo_request_s.
    DATA lv_dpo_request TYPE zhr_dpo_request.
    DATA lv_term TYPE zhr_dpo_id_term.
    DATA lv_location TYPE zhr_dpo_location.
    DATA lv_frequency TYPE zhr_dpo_frequency.
    DATA lv_date_from TYPE sy-datum.
    DATA lv_date_to   TYPE sy-datum.
    DATA: lt_message      TYPE            bapirettab,
          lo_message      TYPE REF TO     /iwbep/if_message_container,
          lo_term         TYPE REF TO     zcl_hr_dpo_term,
          ls_term         TYPE zhr_dpo_term_struct,
          lv_dpo_req_full TYPE zhr_dpo_request_full.
    .

    READ TABLE it_parameter ASSIGNING FIELD-SYMBOL(<fs_param>) WITH KEY name = 'DpoRequest'.
    IF sy-subrc EQ 0.
      CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'
        EXPORTING
          input  = <fs_param>-value
        IMPORTING
          output = lv_dpo_request.

    ENDIF.
    READ TABLE it_parameter ASSIGNING <fs_param> WITH KEY name = 'TermId'.
    IF sy-subrc EQ 0.
      CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'
        EXPORTING
          input  = <fs_param>-value
        IMPORTING
          output = lv_term.
    ENDIF.


    CASE iv_action_name.

      WHEN 'NotificationToRequest'.
        READ TABLE it_parameter ASSIGNING <fs_param> WITH KEY name = 'Clarification'.
        IF sy-subrc EQ 0.
          DATA(lv_clarification) =  <fs_param>-value.
        ENDIF.
        READ TABLE it_parameter ASSIGNING <fs_param> WITH KEY name = 'NotifStatus'.
        IF sy-subrc EQ 0.
          DATA(lv_notifstatus) =  <fs_param>-value.
        ENDIF.
        DATA(lv_uname) = SWITCH sy-uname( it_parameter[ name = 'actual_user' ]-value WHEN '' THEN zcl_pe_all_change_user=>get_uname( iv_appl_id = 'ZHR_DPO_REQUEST' )
                                                                        ELSE it_parameter[ name = 'actual_user' ]-value ).

        READ TABLE it_parameter ASSIGNING <fs_param> WITH KEY name = 'StatusRequest'.
        IF sy-subrc EQ 0.
          DATA(lv_next_status) =  <fs_param>-value.
          DATA(lo_request) = NEW zcl_hr_dpo_request( ).
          lo_request->read_request( iv_dpo_request = lv_dpo_request iv_read_tmp_request = abap_true  ).
          DATA(ls_return) = lo_request->set_next_status( iv_next_status   = CONV #( lv_next_status )
                                                         iv_notif_status  = CONV #( lv_notifstatus )
                                                         iv_clarification = CONV #( lv_clarification )
                                                         iv_ignore_actual_status = abap_true
                                                         iv_uname = lv_uname ).
          IF ls_return-return_code = 'OK'.
            ls_response-dpo_request = lv_dpo_request.
            ls_response-return_code = 'OK'.
            copy_data_to_ref( EXPORTING is_data = ls_response
                          CHANGING  cr_data = er_data ).

            lo_request->save_req( ).
          ELSE.
            ls_response-dpo_request = lv_dpo_request.
            ls_response-return_code = 'FAIL'.
          ENDIF.
        ENDIF.
        copy_data_to_ref( EXPORTING is_data = ls_response
                       CHANGING  cr_data = er_data ).


      WHEN 'GetMailContacts'.
        READ TABLE it_parameter ASSIGNING <fs_param> WITH KEY name = 'button_press'.
        IF sy-subrc EQ 0.
          DATA(ls_list) =   zcl_hr_dpo_term=>mail_contacts( iv_button_press = CONV #( <fs_param>-value ) ).
        ENDIF.
        ls_mailcontacts-mails = ls_list.
        copy_data_to_ref( EXPORTING is_data = ls_mailcontacts
                        CHANGING  cr_data = er_data ).



      WHEN 'SaveTerm'.

        lo_term = NEW zcl_hr_dpo_term( ).
        lo_term->read_term( iv_term = lv_term ).
        ls_response = lo_term->save_term( ).
        copy_data_to_ref( EXPORTING is_data = ls_response
                       CHANGING  cr_data = er_data ).

      WHEN 'CreateTerm'.
        LOOP AT it_parameter ASSIGNING <fs_param>.
          IF <fs_param>-name  = 'Location'.
            lv_location = <fs_param>-value.
          ENDIF.
          IF <fs_param>-name  = 'Frequency'.
            lv_frequency = <fs_param>-value.
          ENDIF.
          IF <fs_param>-name  = 'DateFrom'.
            lv_date_from = <fs_param>-value.
          ENDIF.
          IF <fs_param>-name  = 'DateTo'.
            lv_date_to = <fs_param>-value.
          ENDIF.

        ENDLOOP.
        lo_term = NEW zcl_hr_dpo_term( ).

        DATA(ls_result) = lo_term->create_term( iv_location = lv_location
                                               iv_frequency = lv_frequency
                                               iv_date_from = lv_date_from
                                               iv_date_to   = lv_date_to ).

        copy_data_to_ref( EXPORTING is_data = ls_result
                         CHANGING  cr_data = er_data ).


      WHEN 'RemoveRequestFromTerm'.
        lo_term = NEW zcl_hr_dpo_term( ).
        ls_response =  lo_term->remove_request_from_term( EXPORTING iv_dpo_request = lv_dpo_request
                                                 iv_dpo_term = lv_term
                                                  ).

        copy_data_to_ref( EXPORTING is_data = ls_response
                          CHANGING  cr_data = er_data ).

      WHEN 'AddRequestToTerm'.
        READ TABLE it_parameter ASSIGNING <fs_param> WITH KEY name = 'DpoReqFull'.
        IF sy-subrc EQ 0.
          lv_dpo_req_full = <fs_param>-value.
        ENDIF.
        lo_term = NEW zcl_hr_dpo_term( ).
        ls_response =  lo_term->add_request_to_term( EXPORTING iv_dpo_request = lv_dpo_request
                                                 iv_dpo_term = lv_term
                                                  ).

        copy_data_to_ref( EXPORTING is_data = ls_response
                          CHANGING  cr_data = er_data ).

      WHEN 'NextStep'.
        IF line_exists( it_parameter[ name = 'actual_user' ] ).
          lv_uname = SWITCH sy-uname( it_parameter[ name = 'actual_user' ]-value WHEN '' THEN zcl_pe_all_change_user=>get_uname( iv_appl_id = 'ZHR_DPO_REQUEST' )
                                                                          ELSE it_parameter[ name = 'actual_user' ]-value ).
        ELSE.
          lv_uname = zcl_pe_all_change_user=>get_uname( iv_appl_id = 'ZHR_DPO_REQUEST' ).
        ENDIF.
        READ TABLE it_parameter ASSIGNING <fs_param> WITH KEY name = 'StatusTermNext'.
        IF sy-subrc EQ 0.
          lv_next_status =  <fs_param>-value.
        ENDIF.
        lo_term = NEW zcl_hr_dpo_term( ).
        ls_term =  lo_term->read_term( iv_term = lv_term ).
        ls_term-status = lv_next_status.
        lo_term->set_term( is_term = ls_term ).
        lo_term->update_requests_status( iv_uname = lv_uname ).
        ls_response = lo_term->save_term( ).
        copy_data_to_ref( EXPORTING is_data = ls_response
                       CHANGING  cr_data = er_data ).

      WHEN 'MultiChangeStatus'.

        lv_uname = SWITCH sy-uname( it_parameter[ name = 'OrigUser' ]-value WHEN '' THEN zcl_pe_all_change_user=>get_uname( iv_appl_id = 'ZHR_DPO_REQUEST' )
                                                                        ELSE it_parameter[ name = 'OrigUser' ]-value ).
*        READ TABLE it_parameter ASSIGNING <fs_param> WITH KEY name = 'OrigUser'.
*        IF sy-subrc EQ 0.
*          DATA(lv_orig_user) = CONV sy-uname( <fs_param>-value ).
*          IF lv_orig_user IS INITIAL.
*             lv_orig_user = sy-uname.
*          ENDIF.
*        ENDIF.
        lo_term = NEW zcl_hr_dpo_term( ).
        ls_term =  lo_term->read_term( iv_term = lv_term ).
        lo_term->update_req_stat_from_to(
          EXPORTING
            iv_status_from      = zcl_hr_dpo_cstat=>status_approved_by_head_of_sp
            iv_status_to        = zcl_hr_dpo_cstat=>status_sent_to_the_unions
            iv_origin_user      = lv_uname
        ).
        ls_response = lo_term->save_term( ).
        copy_data_to_ref( EXPORTING is_data = ls_response
                       CHANGING  cr_data = er_data ).

      WHEN 'GetEmailHeaderAndFooter'.
        DATA(ls_texts) = zcl_hr_dpo_term=>get_email_header_and_footer( ).
        copy_data_to_ref( EXPORTING is_data = ls_texts
                       CHANGING  cr_data = er_data ).

      WHEN 'DeleteTerm'.
        ls_result-term_id = lv_term.
        ls_result-return_code = 'OK'.
        lo_term = NEW zcl_hr_dpo_term( ).
        ls_term =  lo_term->read_term( iv_term = lv_term ).
        ls_result = lo_term->delete_term( IMPORTING et_message = lt_message ).
        copy_data_to_ref( EXPORTING is_data = ls_result
                       CHANGING  cr_data = er_data ).

        IF lt_message[] IS NOT INITIAL.
          lo_message = mo_context->get_message_container( ).
          lo_message->add_messages_from_bapi( it_bapi_messages = lt_message iv_add_to_response_header = abap_true ).
*          raise exception type /iwbep/cx_mgw_busi_exception
*            exporting
*              message_container = lo_message.

        ENDIF.

      WHEN OTHERS.

    ENDCASE.

  ENDMETHOD.


  method /IWBEP/IF_MGW_APPL_SRV_RUNTIME~GET_STREAM.

   case iv_entity_name.


      when 'ReqAttchPreview'.
*
        call method zcl_hr_dpo_service=>stream_get_attachment_preview
          exporting
            iv_entity_set_name      = iv_entity_set_name
            iv_source_name          = iv_source_name
            it_key_tab              = it_key_tab
            it_navigation_path      = it_navigation_path
            io_tech_request_context = io_tech_request_context
            ir_dpc_notif_ext              = me
          importing
            er_stream               = er_stream.

      when others.

    endcase.


  endmethod.


  method /IWBEP/IF_MGW_CORE_SRV_RUNTIME~CHANGESET_BEGIN.
**try.
*CALL METHOD SUPER->/IWBEP/IF_MGW_CORE_SRV_RUNTIME~CHANGESET_BEGIN
*  EXPORTING
*    IT_OPERATION_INFO  =
**    it_changeset_input =
**  changing
**    cv_defer_mode      =
*    .
**  catch /iwbep/cx_mgw_busi_exception.
**  catch /iwbep/cx_mgw_tech_exception.
**endtry.
    cv_defer_mode = 'X'.

  endmethod.


  method /IWBEP/IF_MGW_CORE_SRV_RUNTIME~CHANGESET_END.
*** inactive new ***

  ENDMETHOD.


  method /IWBEP/IF_MGW_CORE_SRV_RUNTIME~CHANGESET_PROCESS.
**try.
*CALL METHOD SUPER->/IWBEP/IF_MGW_CORE_SRV_RUNTIME~CHANGESET_PROCESS
*  CHANGING
*    CT_CHANGESET_DATA =
*    .
**  catch /iwbep/cx_mgw_busi_exception.
**  catch /iwbep/cx_mgw_tech_exception.
**endtry.


    DATA:
        lv_operation_counter TYPE i VALUE 0,
        lr_context           TYPE REF TO /iwbep/cl_mgw_request,
        lr_entry_provider    TYPE REF TO /iwbep/if_mgw_entry_provider,
        lr_message_container TYPE REF TO /iwbep/if_message_container,
        lr_entity_data       TYPE REF TO data,
        ls_context_details   TYPE /iwbep/if_mgw_core_srv_runtime=>ty_s_mgw_request_context,
        ls_changeset_response LIKE LINE OF ct_changeset_data.

    FIELD-SYMBOLS:
        <fs_ls_changeset_request>  LIKE LINE OF ct_changeset_data.

*    LOOP AT ct_changeset_data ASSIGNING <fs_ls_changeset_request>.
*        lr_context          ?= <fs_ls_changeset_request>-request_context.
*        lr_entry_provider    = <fs_ls_changeset_request>-entry_provider.
*        lr_message_container = <fs_ls_changeset_request>-msg_container.
*        ls_context_details   = lr_context->get_request_details( ).
*        CASE ls_context_details-target_entity.
*          WHEN 'SomeEntity'.
*            "Do the processing here
*          WHEN OTHERS.
*        ENDCASE.
*    ENDLOOP.
  endmethod.


  method ADDREQUESTSET_GET_ENTITYSET.
**try.
*CALL METHOD SUPER->ADDREQUESTSET_GET_ENTITYSET
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
  endmethod.


  method AUTHSTRUCSET_GET_ENTITY.
 data lt_message type bapiret2_t.


*    try.

    data: lv_dpo_request type zhr_dpo_request.
    data: lv_uname       type sy-uname.
    data: ls_authority_struc type zhr_dpo_prava_s.

     DATA(lv_adm_name) = zcl_pe_all_change_user=>get_uname( iv_appl_id = 'ZHR_DPO_REQUEST' ).

    loop at it_key_tab assigning field-symbol(<fs_key>).
*      if <fs_key>-name = 'DpoRequest'.
*        lv_dpo_request = |{ <fs_key>-value alpha = in }|..
*      endif.
      if <fs_key>-name = 'Uname'.
        lv_uname = |{ <fs_key>-value alpha = in }|..
      endif.
    endloop.

    IF lv_uname IS INITIAL.
      lv_uname = lv_adm_name.
    ENDIF.

* je to zástupce, zjisti jeho oprávňení
    IF lv_uname NE sy-uname.
      SELECT SINGLE * FROM zhr_dpo_zastup
                      INTO @DATA(ls_zastup)
                      WHERE creator = @lv_uname
                        AND deputy  = @lv_adm_name.
*                        AND deputy_status = @abap_true.
    ENDIF.


    if lv_uname is initial.
      lv_uname = sy-uname.
    endif.



    data(lo_request) = new zcl_hr_dpo_request( ).
    ls_authority_struc = lo_request->get_authorization_structure( exporting
                                               iv_uname      =  lv_uname
                                               iv_dpo_process = 'P-CENTR'
                                               importing et_message = lt_message ).

     CASE ls_zastup-activity."opravnení zástupce
      WHEN 'C'. "jenom zadavani
        CLEAR:
        ls_authority_struc-request_deputy,
        ls_authority_struc-request_next_step,
        ls_authority_struc-request_text_edit.
      WHEN 'A'."jenom schvalování
        CLEAR:
         ls_authority_struc-request_deputy,
         ls_authority_struc-request_create,
         ls_authority_struc-request_delete,
         ls_authority_struc-request_text_edit,
         ls_authority_struc-term_create.
      WHEN 'F' . "vše
        CLEAR: ls_authority_struc-request_deputy.
      WHEN OTHERS.
    ENDCASE.


    er_entity = corresponding #( ls_authority_struc ).

    if lt_message[] is not initial.
      data(lo_message) = mo_context->get_message_container( ).
      lo_message->add_messages_from_bapi( it_bapi_messages = lt_message iv_add_to_response_header = abap_true ).
      raise exception type /iwbep/cx_mgw_busi_exception
        exporting
          message_container = lo_message.
    endif.




*      catch /iwbep/cx_mgw_busi_exception.
*      catch /iwbep/cx_mgw_tech_exception.

*    endtry.
  endmethod.


  method DPONOTIFICATIONS_GET_ENTITY.
**try.
*CALL METHOD SUPER->DPONOTIFICATIONS_GET_ENTITY
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
     data: lv_dpo_request type zhr_dpo_request,
        lv_dpo_term    type zhr_dpo_id_term.

      READ TABLE it_key_tab ASSIGNING FIELD-SYMBOL(<fs_key>)
                          WITH KEY name = 'Request'.
    IF sy-subrc EQ 0.
       lv_dpo_request = <fs_key>-value.
        call function 'CONVERSION_EXIT_ALPHA_INPUT'
          exporting
            input         = lv_dpo_request
          IMPORTING
           OUTPUT        = lv_dpo_request
                  .
    ENDIF.
    READ TABLE it_key_tab ASSIGNING <fs_key>
                          WITH KEY name = 'TermId'.
    IF sy-subrc EQ 0.
      lv_dpo_term =  <fs_key>-value..
    ENDIF.
    DATA(lo_notif) = NEW zcl_hr_dpo_notif( ).
    er_entity = lo_notif->read_notif(
      exporting
        iv_dpo_request = lv_dpo_request                " ID žádosti
        iv_dpo_term    = lv_dpo_term ).

  endmethod.


  method NOTIFATTCHDIRSET_DELETE_ENTITY.

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
    lo_request->delete_attachment(
      exporting
        is_attch   = ls_attch
*      importing
*        et_message =                  " Návratová tabulka
      receiving
         rs_return  = DATA(ls_return)               " Dpo Žádost
    ).


  endmethod.


  method NOTIFATTCHDIRSET_GET_ENTITYSET.

  data: lv_dpo_request type zhr_dpo_request,
        lv_dpo_term    type zhr_dpo_id_term.

      READ TABLE it_key_tab ASSIGNING FIELD-SYMBOL(<fs_key>)
                          WITH KEY name = 'Request'.
    IF sy-subrc EQ 0.
       lv_dpo_request = <fs_key>-value.
        call function 'CONVERSION_EXIT_ALPHA_INPUT'
          exporting
            input         = lv_dpo_request
          IMPORTING
           OUTPUT        = lv_dpo_request
                  .
    ENDIF.
    lv_dpo_term = '9999999999'.

    data(lo_request) = new zcl_hr_dpo_request( ).

    et_entityset = corresponding #( lo_request->read_attachment_tab( iv_dpo_request = lv_dpo_request
                                                                     iv_dpo_term = lv_dpo_term ) ).

  endmethod.


  METHOD requestforkset_get_entityset.

    IF line_exists( it_filter_select_options[ property = 'DpoRequest' ] ).
      DATA(so) =  it_filter_select_options[ property = 'DpoRequest' ]-select_options  .
      DATA(lv_dpo_request) = CONV zhr_dpo_request( so[ 1 ]-low ).
      lv_dpo_request =  |{ lv_dpo_request ALPHA = IN }|.

      et_entityset = zcl_hr_dpo_request=>show_approval_fork( iv_dpo_request =  lv_dpo_request iv_role = 'HRBP'   ).

      SORT et_entityset BY ordernr.
    ENDIF.

  ENDMETHOD.


  METHOD statusnotifset_get_entityset.
    TRY.
        CALL METHOD super->statusnotifset_get_entityset
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
    SORT  et_entityset BY status_num.

  ENDMETHOD.


  method STATUSREQUESTSET_GET_ENTITYSET.
*try.
CALL METHOD SUPER->STATUSREQUESTSET_GET_ENTITYSET
  EXPORTING
    IV_ENTITY_NAME           = iv_entity_name
    IV_ENTITY_SET_NAME       = iv_entity_set_name
    IV_SOURCE_NAME           = iv_source_name
    IT_FILTER_SELECT_OPTIONS = it_filter_select_options
    IS_PAGING                = is_paging
    IT_KEY_TAB               = it_key_tab
    IT_NAVIGATION_PATH       = it_navigation_path
    IT_ORDER                 = it_order
    IV_FILTER_STRING         = iv_filter_string
    IV_SEARCH_STRING         = iv_search_string
    io_tech_request_context  = io_tech_request_context
   importing
     et_entityset             = et_entityset
     es_response_context      = es_response_context
    .
  if et_entityset[] IS NOT INITIAL.
   SELECT * FROM ZHR_DPO_CSTAT INTO TABLE @data(lt_status_tab)
                 FOR ALL ENTRIES IN @et_entityset
                 WHERE status EQ @et_entityset-status.
   IF sy-subrc EQ 0.
     SORT lt_status_tab BY status_num ASCENDING.
     DATA(lt_entityset) = et_entityset.
     REFRESH et_entityset.
     LOOP AT lt_status_tab ASSIGNING FIELD-SYMBOL(<fs_status>).
       READ TABLE lt_entityset  ASSIGNING FIELD-SYMBOL(<fs_entityset>)
                                WITH KEY status = <fs_status>-status.
       IF sy-subrc EQ 0.
         IF <fs_status>-status_num BETWEEN '11' AND '16'
         AND <fs_status>-status NE 'NAA'.
           APPEND <fs_entityset> TO et_entityset.
         ENDIF.
       ENDIF.
     ENDLOOP.
   ENDIF.
  endif.
*  catch /iwbep/cx_mgw_busi_exception.
*  catch /iwbep/cx_mgw_tech_exception.
*endtry.
  endmethod.


  METHOD statustaskset_get_entityset.

    et_entityset = zcl_hr_dpo_task=>get_task_status_list( ).

  ENDMETHOD.


  METHOD taskset_create_entity.

    DATA:
      lt_message TYPE bapirettab,
      ls_result  TYPE zhr_dpo_task_return_s,
      lv_dpo_request TYPE zhr_dpo_request.

*    DATA(lv_dpo_request) = CONV zhr_dpo_request( it_key_tab[ name = 'DpoRequest' ]-value  ).
*   lv_dpo_request = | { lv_dpo_request ALPHA = IN } |.
    DATA(lo_task) = NEW zcl_hr_dpo_task( ).

    TRY.
        io_data_provider->read_entry_data( IMPORTING es_data = er_entity ).
      CATCH cx_static_check INTO DATA(lo_exc).
        DATA(lv_text) = lo_exc->get_text( ).
    ENDTRY.


    er_entity = lo_task->save( EXPORTING is_task = CONV #( er_entity )
                   IMPORTING  et_message           = lt_message                 " Table with BAPI Return Information
                              ev_result            = ls_result   ).

    IF ls_result-return_code = 'FAIL'.
      DATA(lo_message) = mo_context->get_message_container( ).
      lo_message->add_messages_from_bapi( it_bapi_messages = lt_message iv_add_to_response_header = abap_true ).
      RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
        EXPORTING
          message_container = lo_message.
    ENDIF.

  ENDMETHOD.


  method TASKSET_DELETE_ENTITY.

    DATA:
      lt_message TYPE bapirettab,
      ls_result  TYPE zhr_dpo_task_return_s.

    DATA(lv_dpo_task) = CONV zhr_dpo_request( it_key_tab[ name = 'DpoTask' ]-value  ).
    lv_dpo_task = |{ lv_dpo_task ALPHA = IN }|.
    DATA(lo_task) = NEW zcl_hr_dpo_task( ).

    ls_result = lo_task->delete_task( EXPORTING  iv_dpo_task = lv_dpo_task
                                      IMPORTING  et_message  = lt_message                 " Table with BAPI Return Information
                                       ).
    IF ls_result-return_code = 'FAIL'.
      DATA(lo_message) = mo_context->get_message_container( ).
      lo_message->add_messages_from_bapi( it_bapi_messages = lt_message iv_add_to_response_header = abap_true ).
*      RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
*        EXPORTING
*          message_container = lo_message.
    ENDIF.


  endmethod.


  method TASKSET_GET_ENTITY.

   IF line_exists( it_key_tab[ name =  'DpoTask' ] ).
      DATA(lv_dpo_task) =  CONV zhr_dpo_task(  it_key_tab[ name =  'DpoTask' ]-value  ).
      lv_dpo_task  = |{ lv_dpo_task ALPHA = IN }|.
    ENDIF.

    DATA(lo_task) = NEW zcl_hr_dpo_task( ).

    DATA(so_dpo_task) = VALUE /IWBEP/T_COD_SELECT_OPTIONS( ( sign = 'I' option = 'EQ' low = lv_dpo_task )  ).
    DATA(lt_tasks_tab) = lo_task->get_task_list( so_dpo_task = so_dpo_task  ).
    IF line_exists( lt_tasks_tab[ 1 ] ).
        er_entity = CORRESPONDING #( lt_tasks_tab[ 1 ] ).
    ENDIF.

  endmethod.


  method TASKSET_GET_ENTITYSET.

  DATA lv_req TYPE zhr_dpo_request.

  FIELD-SYMBOLS:
      <fs_so> TYPE /iwbep/s_cod_select_option.

    LOOP AT it_filter_select_options[] ASSIGNING FIELD-SYMBOL(<fso>).
      CASE <fso>-property.
        WHEN 'OrigUser'.
           DATA(lr_orig_user) = <fso>-select_options[].
        WHEN 'DpoReqFull'.
           DATA(lr_req_full) = <fso>-select_options[].
        WHEN 'TaskText'.
           DATA(lr_tasktext) = <fso>-select_options[].
        WHEN 'FullName'.
          DATA(lr_requestorname) = <fso>-select_options[].
        WHEN 'DpoTask'.
           DATA(lr_dpo_task) = <fso>-select_options[].
        WHEN 'Pernr'.
           DATA(lr_pernr) = <fso>-select_options[].
         WHEN 'Uname'.
          DATA(lr_uname) = <fso>-select_options[].
        WHEN 'FinishDate'.
          DATA(lr_finish_date) = <fso>-select_options[].
        WHEN 'Status'.
          DATA(lr_status) = <fso>-select_options[].
        WHEN 'DpoRequest'.
          DATA(lr_request) = <fso>-select_options[].
          "conver to leading zeroes
          LOOP AT lr_request ASSIGNING FIELD-SYMBOL(<fs_req>).
            lv_req = <fs_req>-low.
            CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT' EXPORTING input = lv_req IMPORTING output = lv_req.
            <fs_req>-low = lv_req.
          ENDLOOP.
        WHEN OTHERS.
      ENDCASE.
    ENDLOOP.

    DATA(lo_task) = NEW zcl_hr_dpo_task( ).

    DATA(lt_tasks_tab) = lo_task->get_task_list( EXPORTING so_pernr = lr_pernr
                                                           so_uname = lr_uname
                                                           so_status =  lr_status
                                                           so_finish_date = lr_finish_date
                                                           so_dpo_task = lr_dpo_task
                                                           so_dpo_request = lr_request
                                                           so_fullname = lr_requestorname
                                                           so_dpo_req_full = lr_req_full
                                                           so_text = lr_tasktext
                                                           so_hrbp_user = lr_orig_user
                                                            ).

        et_entityset[] = CORRESPONDING #( lt_tasks_tab[] ).
  endmethod.


  METHOD taskset_update_entity.

    DATA:
      lt_message TYPE bapirettab,
      et_message TYPE bapirettab,
      ls_result  TYPE zhr_dpo_task_return_s.

    TRY.
        io_data_provider->read_entry_data( IMPORTING es_data = er_entity ).
      CATCH cx_static_check INTO DATA(lo_exc).
        DATA(lv_text) = lo_exc->get_text( ).
        MESSAGE e000(zhr_dpo_en) WITH lv_text INTO DATA(lv_dummy).
        zcl_hr_dpo_message=>append_syst( CHANGING ct_message = et_message ).
    ENDTRY.

    er_entity-dpo_task = |{ er_entity-dpo_task ALPHA = IN }|.
    DATA(lo_task) = NEW zcl_hr_dpo_task( ).
    er_entity = lo_task->save(
      EXPORTING
        is_task    =   er_entity
       IMPORTING
         et_message = lt_message                 " Tabulka s návratovými informacemi BAPI
         ev_result  = ls_result                  " Návratová struktura
    ).

    IF ls_result-return_code = 'FAIL'.
      DATA(lo_message) = mo_context->get_message_container( ).
      lo_message->add_messages_from_bapi( it_bapi_messages = lt_message iv_add_to_response_header = abap_true ).
      RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
        EXPORTING
          message_container = lo_message.
    ENDIF.

  ENDMETHOD.


  method TERMREQUESTCOPYS_GET_ENTITY.
 data: lv_dpo_term    type zhr_dpo_id_term,
          lv_dpo_request type ZHR_DPO_REQUEST.

    loop at it_key_tab[] assigning field-symbol(<fs_key>) .
      case <fs_key>-name.
        when 'TermId'.
          lv_dpo_term = <fs_key>-value.
        when 'DpoRequest'.
          lv_dpo_request = <fs_key>-value.
      endcase.

    endloop.



    data(lo_term) = new zcl_hr_dpo_term( ).
    data(ls_termrequest) = lo_term->get_request(
                       iv_dpo_term    = lv_dpo_term
                       iv_dpo_request = lv_dpo_request
                     ).

    er_entity = ls_termrequest.
  endmethod.


  METHOD termrequestcopys_get_entityset.
    DATA: lv_termid  TYPE zhr_dpo_id_term,
          lt_message TYPE bapiret2_t.


    READ TABLE it_order ASSIGNING FIELD-SYMBOL(<fs_order>) WITH KEY property = 'Ordernr'.
    IF sy-subrc EQ 0.
      DATA(lv_sort) = <fs_order>-order.
    ENDIF.

    LOOP AT it_key_tab[] ASSIGNING FIELD-SYMBOL(<fs_key>) WHERE name = 'TermId'.
      CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'
        EXPORTING
          input  = <fs_key>-value
        IMPORTING
          output = lv_termid.


    ENDLOOP.

    LOOP AT it_filter_select_options[] ASSIGNING FIELD-SYMBOL(<fso>).
      CASE <fso>-property.
        WHEN 'TermId'.
          READ TABLE <fso>-select_options[] ASSIGNING FIELD-SYMBOL(<fs_so>) INDEX 1.
          IF sy-subrc EQ 0.
            lv_termid = <fs_so>-low.
          ENDIF.
        WHEN 'Ordernr'.
          READ TABLE <fso>-select_options[] ASSIGNING <fs_so> INDEX 1.
          IF sy-subrc EQ 0.
            IF <fs_so>-low = '999'.
              DATA(lv_exclude999) = abap_true.
            ENDIF.
          ENDIF.
        WHEN OTHERS.
      ENDCASE.
    ENDLOOP.


    DATA(lo_term) = NEW zcl_hr_dpo_term( ).

    et_entityset = CORRESPONDING #( lo_term->get_requests_table(
                                   EXPORTING
                                     iv_term    = lv_termid                 " ID DPO termínu
                                      iv_only_non_electronic = lv_exclude999
                                    IMPORTING
                                      et_message = lt_message                 " Návratová tabulka
                                 ) ).

    IF lv_sort IS NOT INITIAL.
      IF lv_sort EQ 'asc'.
        SORT et_entityset BY ordernr ASCENDING.
      ENDIF.
    ENDIF.
  ENDMETHOD.


  METHOD termrequestcopys_update_entity.
    TRY.
        io_data_provider->read_entry_data( IMPORTING es_data = er_entity ).
      CATCH cx_static_check.
    ENDTRY.

    DATA: lv_dpo_term    TYPE zhr_dpo_id_term,
          lv_dpo_request TYPE zhr_dpo_request.




    DATA(lo_term) = NEW zcl_hr_dpo_term( ).
    DATA(ls_termrequest) = lo_term->update_order_nr(
                       iv_dpo_term     = er_entity-term_id
                       iv_time         = er_entity-req_time
                       iv_dpo_duration = er_entity-duration
                       iv_dpo_request  = er_entity-dpo_request
                       iv_ordernr      = er_entity-ordernr
                     ).
  ENDMETHOD.


  method termrequestset_get_entity.


    data: lv_dpo_term    type zhr_dpo_id_term,
          lv_dpo_request type ZHR_DPO_REQUEST.

    loop at it_key_tab[] assigning field-symbol(<fs_key>) .
      case <fs_key>-name.
        when 'TermId'.
          lv_dpo_term = <fs_key>-value.
        when 'DpoRequest'.
          lv_dpo_request = <fs_key>-value.
      endcase.

    endloop.



    data(lo_term) = new zcl_hr_dpo_term( ).
    data(ls_termrequest) = lo_term->get_request(
                       iv_dpo_term    = lv_dpo_term
                       iv_dpo_request = lv_dpo_request
                     ).

    er_entity = ls_termrequest.
  endmethod.


  METHOD termrequestset_get_entityset.

    DATA: lv_termid  TYPE zhr_dpo_id_term,
          lt_message TYPE bapiret2_t.


    READ TABLE it_order ASSIGNING FIELD-SYMBOL(<fs_order>) WITH KEY property = 'Ordernr'.
    IF sy-subrc EQ 0.
      DATA(lv_sort) = <fs_order>-order.
    ENDIF.

    LOOP AT it_key_tab[] ASSIGNING FIELD-SYMBOL(<fs_key>) WHERE name = 'TermId'.
      CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'
        EXPORTING
          input  = <fs_key>-value
        IMPORTING
          output = lv_termid.


    ENDLOOP.

    LOOP AT it_filter_select_options[] ASSIGNING FIELD-SYMBOL(<fso>).
      CASE <fso>-property.
        WHEN 'TermId'.
          READ TABLE <fso>-select_options[] ASSIGNING FIELD-SYMBOL(<fs_so>) INDEX 1.
          IF sy-subrc EQ 0.
            lv_termid = <fs_so>-low.
          ENDIF.
        WHEN 'Ordernr'.
          READ TABLE <fso>-select_options[] ASSIGNING <fs_so> INDEX 1.
          IF sy-subrc EQ 0.
            IF <fs_so>-low = '999'.
             DATA(lv_exclude999) = abap_true.
            ENDIF.
          ENDIF.
        WHEN OTHERS.
      ENDCASE.
    ENDLOOP.


    DATA(lo_term) = NEW zcl_hr_dpo_term( ).

    et_entityset = CORRESPONDING #( lo_term->get_requests_table(
                                   EXPORTING
                                     iv_term    = lv_termid                 " ID DPO termínu
                                     iv_only_non_electronic = lv_exclude999
                                    IMPORTING
                                      et_message = lt_message                 " Návratová tabulka
                                 ) ).

    IF lv_sort IS NOT INITIAL.
      IF lv_sort EQ 'asc'.
        SORT et_entityset BY ordernr ASCENDING.
      ENDIF.
    ENDIF.

  ENDMETHOD.


  method TERMREQUESTSET_UPDATE_ENTITY.

     try.
        io_data_provider->read_entry_data( importing es_data = er_entity ).
      catch cx_static_check.
    endtry.

    data: lv_dpo_term    type zhr_dpo_id_term,
          lv_dpo_request type ZHR_DPO_REQUEST.




    data(lo_term) = new zcl_hr_dpo_term( ).
    data(ls_termrequest) = lo_term->update_order_nr(
                       iv_dpo_term     = er_entity-term_id
                       iv_time         = er_entity-req_time
                       iv_dpo_duration = er_entity-duration
                       iv_dpo_request  = er_entity-dpo_request
                       iv_ordernr      = er_entity-ordernr
                     ).

  endmethod.


  method TERMSET_CREATE_ENTITY.


  endmethod.


  METHOD termset_get_entity.


    DATA: lv_termid TYPE zhr_dpo_id_term..

    LOOP AT it_key_tab[] ASSIGNING FIELD-SYMBOL(<fs_key>) WHERE name = 'TermId'.
      CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'
        EXPORTING
          input  = <fs_key>-value
        IMPORTING
          output = lv_termid.
    ENDLOOP.

    DATA(lo_term) = NEW zcl_hr_dpo_term( ).

    er_entity = CORRESPONDING #(  lo_term->read_term( iv_term = lv_termid ) ).


  ENDMETHOD.


  METHOD termset_get_entityset.

    LOOP AT it_filter_select_options[] ASSIGNING FIELD-SYMBOL(<fso>).
      CASE <fso>-property.
        WHEN 'TermId'.
          DATA(lr_term_id) = <fso>-select_options[].
        WHEN 'Location'.
          DATA(lr_location) = <fso>-select_options[].
        WHEN 'TermDate'.
          DATA(lr_term_date) = <fso>-select_options[].
        WHEN 'Status'.
          DATA(lr_status) = <fso>-select_options[].
        WHEN 'TermSp'.
          DATA(lr_termsp) = <fso>-select_options[].
        WHEN 'TermOdbory'   .
          DATA(lr_termodb) = <fso>-select_options[].
        WHEN 'TermZarad'   .
          DATA(lr_termzarad) = <fso>-select_options[].
        WHEN OTHERS.
      ENDCASE.
    ENDLOOP.

    IF iv_filter_string IS NOT INITIAL AND lr_term_id IS INITIAL AND lr_location IS INITIAL
    AND lr_status IS INITIAL AND lr_term_date IS INITIAL AND lr_termsp IS INITIAL AND lr_termodb IS INITIAL.
      DATA: lt_parts TYPE STANDARD TABLE OF string,
            lv_date  TYPE d.





      DATA lv_date_string TYPE string.
      FIND FIRST OCCURRENCE OF REGEX `\d{1,2}\.\d{1,2}\.\d{4}`
        IN iv_filter_string
        SUBMATCHES lv_date
         MATCH OFFSET DATA(lv_offset)
    MATCH LENGTH DATA(lv_length).

      IF lv_offset IS NOT INITIAL.

        IF sy-subrc = 0.
          lv_date_string = iv_filter_string+lv_offset(lv_length).

          SPLIT lv_date_string AT '.' INTO TABLE lt_parts.

          lv_date+0(4) = lt_parts[ 3 ].  " rok
          lv_date+4(2) = lt_parts[ 2 ].  " mesiac
          lv_date+6(2) = lt_parts[ 1 ].



          DATA(lt_term_date) = VALUE rsdsselopt_t(

             ( sign   = if_fsbp_const_range=>sign_include
               option = if_fsbp_const_range=>option_equal
               low    = lv_date ) ).
          lr_term_date = CORRESPONDING #( lt_term_date ).

            DATA(lv_proposed) = 'E'.
        ENDIF.

      ENDIF.

      IF lr_term_date IS INITIAL.
        lv_proposed = abap_true.

        DATA(lt_sp) = VALUE rsdsselopt_t(

            ( sign   = if_fsbp_const_range=>sign_include
              option = if_fsbp_const_range=>option_equal
              low    = sy-datum ) ).
        lr_termsp = CORRESPONDING #( lt_sp ).

      ENDIF.

    ENDIF.

    DATA(lo_term) = NEW zcl_hr_dpo_term( ).

*lo_request->read_customizing( ).

    DATA(lt_output) = lo_term->get_term_list(
          term_range = lr_term_id
          location_range = lr_location
          status_range = lr_status
          term_date_range = lr_term_date
          term_sp_range = lr_termsp
          term_odb_range = lr_termodb
          term_zarad_range = lr_termzarad
          with_proposed_term  = lv_proposed ).




    et_entityset[] = CORRESPONDING #( lt_output ).


  ENDMETHOD.


  method termset_update_entity.

    try.
        io_data_provider->read_entry_data( importing es_data = er_entity ).
      catch cx_static_check.
    endtry.

    DATA(lo_term) = NEW zcl_hr_dpo_term( ).
    lo_term->read_term( iv_term = er_entity-term_id ).
    lo_term->set_term( is_term = er_entity ).
    DATA(ls_response) = lo_term->save_term( ).


  endmethod.


  METHOD wordtemplatelink_get_entity.

    DATA: lv_dpo_request TYPE zhr_dpo_request.
    READ TABLE it_key_tab ASSIGNING FIELD-SYMBOL(<fs_key>) WITH KEY name = 'DpoRequest'.
    IF sy-subrc EQ 0.
      CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'
        EXPORTING
          input  = <fs_key>-value
        IMPORTING
          output = lv_dpo_request.
      .
    ENDIF.
    CONSTANTS: c_quot TYPE c VALUE `'`.
    DATA: lv_link TYPE zsd_sdp_url,
          lv_base TYPE string VALUE  '/sap/opu/odata/sap/ZHR_DPO_REQUEST01_SRV/WordTemplateSet'.

    CONCATENATE lv_base '(' INTO  lv_link.
    CONCATENATE lv_link 'DpoRequest=' c_quot lv_dpo_request c_quot
     INTO  lv_link.
    CONCATENATE lv_link ')/$value'                               INTO  lv_link.



    er_entity-link = lv_link.


  ENDMETHOD.
ENDCLASS.
