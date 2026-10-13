class ZCL_ZHR_DPO_AGR_DPC_EXT definition
  public
  inheriting from ZCL_ZHR_DPO_AGR_DPC
  create public .

public section.

  class-methods GET_UNAME
    returning
      value(RV_UNAME) type SY-UNAME .

  methods /IWBEP/IF_MGW_APPL_SRV_RUNTIME~CREATE_STREAM
    redefinition .
  methods /IWBEP/IF_MGW_APPL_SRV_RUNTIME~EXECUTE_ACTION
    redefinition .
  methods /IWBEP/IF_MGW_APPL_SRV_RUNTIME~GET_STREAM
    redefinition .
protected section.

  methods DISABLE_CACHE .

  methods AGREEMENTATTCH01_DELETE_ENTITY
    redefinition .
  methods AGREEMENTATTCH01_GET_ENTITY
    redefinition .
  methods AGREEMENTATTCH01_GET_ENTITYSET
    redefinition .
  methods AGREEMENTDATASET_CREATE_ENTITY
    redefinition .
  methods AGREEMENTDATASET_DELETE_ENTITY
    redefinition .
  methods AGREEMENTDATASET_GET_ENTITY
    redefinition .
  methods AGREEMENTDATASET_GET_ENTITYSET
    redefinition .
  methods AGREEMENTDATASET_UPDATE_ENTITY
    redefinition .
  methods AGREEMENTHISTORY_GET_ENTITYSET
    redefinition .
  methods AUTHSTRUCSET_GET_ENTITY
    redefinition .
  methods STATUSSET_GET_ENTITYSET
    redefinition .
  methods WORDTEMPLATELINK_GET_ENTITY
    redefinition .
  methods AGREEMENTATTCH01_UPDATE_ENTITY
    redefinition .
private section.
ENDCLASS.



CLASS ZCL_ZHR_DPO_AGR_DPC_EXT IMPLEMENTATION.


  METHOD /iwbep/if_mgw_appl_srv_runtime~create_stream.

    DATA: lf_result          TYPE            flag,
          lt_message         TYPE            bapirettab,
          lo_message         TYPE REF TO     /iwbep/if_message_container,

          lo_facade          TYPE REF TO /iwbep/if_mgw_dp_int_facade,
          lt_request_headers TYPE tihttpnvp.

    CASE iv_entity_name.

      WHEN 'AgreementAttch'.

        DATA: ls_att  TYPE zhr_dpo_att_s.

* Read the HTTP Request headers.
        lo_facade ?= /iwbep/if_mgw_conv_srv_runtime~get_dp_facade( ).
        lt_request_headers = lo_facade->get_request_header( ).

        CALL METHOD zcl_hr_dpo_service=>stream_update_attach_agreement
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
      RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
        EXPORTING
          message_container = lo_message.

    ENDIF.


  ENDMETHOD.


  METHOD /iwbep/if_mgw_appl_srv_runtime~execute_action.

    DATA: ls_response  TYPE zhr_dpo_agr_return_s,
          lv_agreement TYPE zhr_dpo_agreement.

    READ TABLE it_parameter ASSIGNING FIELD-SYMBOL(<fs_param>) WITH KEY name = 'DpoAgreement'.
    IF sy-subrc EQ 0.
      CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'
        EXPORTING
          input  = <fs_param>-value
        IMPORTING
          output = lv_agreement.
    ENDIF.

    CASE iv_action_name.

      WHEN 'Delete'.
        DATA(lo_agr) = NEW zcl_hr_dpo_agreement( sy-uname ).
        ls_response =  lo_agr->delete_agreement( lv_agreement ).
        copy_data_to_ref( EXPORTING is_data = ls_response
                    CHANGING  cr_data = er_data ).
      WHEN 'NextStep'.

        READ TABLE it_parameter ASSIGNING <fs_param> WITH KEY name = 'StatusAgreementNext'.
        IF sy-subrc EQ 0.
          DATA(lv_next_status) =  <fs_param>-value.
        ENDIF.
        READ TABLE it_parameter ASSIGNING <fs_param> WITH KEY name = 'actual_user'.
        IF sy-subrc EQ 0.
          DATA(lv_uname) =  <fs_param>-value.
        ENDIF.
        READ TABLE it_parameter ASSIGNING <fs_param> WITH KEY name = 'Clarification'.
        IF sy-subrc EQ 0.
          DATA(lv_clarification) =  <fs_param>-value.
        ENDIF.

        lo_agr = NEW zcl_hr_dpo_agreement( CONV #( lv_uname ) ).
        DATA(ls_agr) =  lo_agr->get_agreement( iv_agreement =  lv_agreement  ).
        ls_response =  lo_agr->set_next_status(
          EXPORTING
            iv_origin_user   = CONV #( lv_uname )
            iv_next_status   = CONV #( lv_next_status )
            iv_clarification = CONV #( lv_clarification ) )
            .
        copy_data_to_ref( EXPORTING is_data = ls_response
                      CHANGING  cr_data = er_data ).
    ENDCASE.

  ENDMETHOD.


  method /IWBEP/IF_MGW_APPL_SRV_RUNTIME~GET_STREAM.

     case iv_entity_name.

       when 'WordTemplate'.

         call method zcl_hr_dpo_service=>stream_word_template
          exporting
            iv_entity_set_name      = iv_entity_set_name
            iv_source_name          = iv_source_name
            it_key_tab              = it_key_tab
            it_navigation_path      = it_navigation_path
            io_tech_request_context = io_tech_request_context
            iv_agreement            = abap_true
            ir_dpc_agreement_ext    = me
          importing
            er_stream               = er_stream.


      when 'AgreementAttchPreview'.
*
        call method zcl_hr_dpo_service=>stream_get_attachment_preview
          exporting
            iv_entity_set_name      = iv_entity_set_name
            iv_source_name          = iv_source_name
            it_key_tab              = it_key_tab
            it_navigation_path      = it_navigation_path
            io_tech_request_context = io_tech_request_context
            iv_agreement            = abap_true
            ir_dpc_agreement_ext    = me
          importing
            er_stream               = er_stream.

      when others.

    endcase.

  endmethod.


  METHOD agreementattch01_delete_entity.


    DATA: lv_guid(40) TYPE c.
    DATA: lv_dpo_request TYPE zhr_dpo_request.
    DATA: ls_attch TYPE zhr_dpo_att_s.

    READ TABLE it_key_tab ASSIGNING FIELD-SYMBOL(<fs_key>) WITH KEY name = 'Guid'.
    IF sy-subrc EQ 0.
      ls_attch-guid = <fs_key>-value.
    ENDIF.
    READ TABLE it_key_tab ASSIGNING <fs_key> WITH KEY name = 'DpoRequest'.
    IF sy-subrc EQ 0.
      CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'
        EXPORTING
          input  = <fs_key>-value
        IMPORTING
          output = ls_attch-dpo_request.


    ENDIF.


    DATA(lo_request) = NEW zcl_hr_dpo_request( ).
    lo_request->delete_attachment(
      EXPORTING
        is_attch   = ls_attch
*      importing
*        et_message =                  " Návratová tabulka
      RECEIVING
         rs_return  = DATA(ls_return)               " Dpo Žádost
    ).


  ENDMETHOD.


  method AGREEMENTATTCH01_GET_ENTITY.


  endmethod.


  METHOD agreementattch01_get_entityset.


    DATA: lv_dpo_request   TYPE zhr_dpo_request,
          lv_dpo_agreement TYPE zhr_dpo_agreement.




    READ TABLE it_key_tab ASSIGNING FIELD-SYMBOL(<fs_key>)
                        WITH KEY name = 'Request'.
    IF sy-subrc EQ 0.
      lv_dpo_request = <fs_key>-value.
      CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'
        EXPORTING
          input  = lv_dpo_request
        IMPORTING
          output = lv_dpo_request.
    ENDIF.
    READ TABLE it_key_tab ASSIGNING <fs_key>
                        WITH KEY name = 'DpoAgreement'.
    IF sy-subrc EQ 0.
     CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'
        EXPORTING
          input  = <fs_key>-value
        IMPORTING
          output = lv_dpo_agreement.
    ENDIF.

    DATA(lo_agr) = NEW zcl_hr_dpo_agreement( sy-uname ).

    et_entityset = CORRESPONDING #( lo_agr->read_attachment_tab( iv_dpo_request = lv_dpo_request
                                                                     iv_dpo_agreement = lv_dpo_agreement ) ).

  ENDMETHOD.


  method AGREEMENTATTCH01_UPDATE_ENTITY.
**TRY.
*CALL METHOD SUPER->AGREEMENTATTCH01_UPDATE_ENTITY
*  EXPORTING
*    IV_ENTITY_NAME          =
*    IV_ENTITY_SET_NAME      =
*    IV_SOURCE_NAME          =
*    IT_KEY_TAB              =
**    io_tech_request_context =
*    IT_NAVIGATION_PATH      =
**    io_data_provider        =
**  IMPORTING
**    er_entity               =
*    .
**  CATCH /iwbep/cx_mgw_busi_exception.
**  CATCH /iwbep/cx_mgw_tech_exception.
**ENDTRY.
    break dzc26y2.

  endmethod.


  METHOD agreementdataset_create_entity.
    me->disable_cache( ).
    DATA:
      lt_message TYPE bapirettab,
      lv_result  TYPE wdy_boolean
      .
    TRY.
        io_data_provider->read_entry_data( IMPORTING es_data = er_entity ).
      CATCH cx_static_check INTO DATA(lo_exc).
        DATA(lv_text) = lo_exc->get_text( ).
    ENDTRY.
    CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT' EXPORTING input = er_entity-dpo_request IMPORTING output = er_entity-dpo_request.
    DATA(lv_uname) =  er_entity-uname.
    IF lv_uname IS INITIAL.
      lv_uname = zcl_zhr_dpo_agr_dpc_ext=>get_uname( ).
    ENDIF.
    DATA(lo_agreement) = zcl_hr_dpo_agreement=>get( iv_uname = lv_uname ).
    DATA(ls_agreement) = lo_agreement->create_and_save(
      EXPORTING
        iv_request           = er_entity-dpo_request
        iv_agreement_date_to = er_entity-agreement_date_to                 " Date
        iv_agreement_date    = er_entity-agreement_date                 " Date
        iv_name              = er_entity-name
        iv_status            = er_entity-status
        iv_eff_for_dep       = er_entity-eff_for_dep                 " Effectiveness for a department
      IMPORTING
        et_message           = lt_message                 " Table with BAPI Return Information
        ev_result            = lv_result                 " Replacement for Real Boolean Type: 'X' == True '' == False
    ).
    IF lv_result = abap_true.
      CLEAR er_entity.
      DATA(ls_agreement_gw) = lo_agreement->get_agreement( iv_agreement = ls_agreement-dpo_agreement ).
      MOVE-CORRESPONDING ls_agreement_gw TO er_entity.
    ELSE.
      CLEAR er_entity.
      ls_agreement_gw = lo_agreement->get_agreement( iv_agreement = ls_agreement-dpo_agreement ).
      MOVE-CORRESPONDING ls_agreement_gw TO er_entity.

      DATA(lo_message) = mo_context->get_message_container( ).
      lo_message->add_messages_from_bapi( it_bapi_messages = lt_message iv_add_to_response_header = abap_true ).
      RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
        EXPORTING
          message_container = lo_message.
    ENDIF.
  ENDMETHOD.


  METHOD agreementdataset_delete_entity.

*    DATA: lv_guid(40) TYPE c.
*    DATA: lv_dpo_request TYPE zhr_dpo_request.
*    DATA: ls_attch TYPE zhr_dpo_att_s.
*
*    READ TABLE it_key_tab ASSIGNING FIELD-SYMBOL(<fs_key>) WITH KEY name = 'Guid'.
*    IF sy-subrc EQ 0.
*      ls_attch-guid = <fs_key>-value.
*    ENDIF.
*    READ TABLE it_key_tab ASSIGNING <fs_key> WITH KEY name = 'DpoRequest'.
*    IF sy-subrc EQ 0.
*      CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'
*        EXPORTING
*          input  = <fs_key>-value
*        IMPORTING
*          output = ls_attch-dpo_request.
*
*
*    ENDIF.
*
*
*    DATA(lo_request) = NEW zcl_hr_dpo_request( ).
*    lo_request->delete_attachment(
*      EXPORTING
*        is_attch   = ls_attch
*
*      RECEIVING
*         rs_return  = DATA(ls_return)               " Dpo Žádost
*    ).

  ENDMETHOD.


  METHOD agreementdataset_get_entity.
    me->disable_cache( ).
    DATA lv_dpo_agreement TYPE zhr_dpo_agreement.
    LOOP AT it_key_tab[] ASSIGNING FIELD-SYMBOL(<fs_key>) WHERE name = 'DpoAgreement'.
      lv_dpo_agreement = <fs_key>-value.
    ENDLOOP.
    CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT' EXPORTING input = lv_dpo_agreement IMPORTING output = lv_dpo_agreement.
    SELECT SINGLE orig_user FROM zhr_dpo_histdoh INTO @DATA(lv_uname) WHERE dpo_agreement = @lv_dpo_agreement.

*    DATA(lv_uname) = zcl_zhr_dpo_agr_dpc_ext=>get_uname( ).
    er_entity = CORRESPONDING #( zcl_hr_dpo_agreement=>get( iv_uname = lv_uname )->get_agreement( iv_agreement = lv_dpo_agreement ) ).
  ENDMETHOD.


  METHOD agreementdataset_get_entityset.
    me->disable_cache( ).
    DATA:
      lv_name_filter  TYPE zhr_dpo_doh_name,
      lv_req          TYPE zhr_dpo_request,
      lv_agr          TYPE zhr_dpo_agreement,
      lr_so           TYPE /iwbep/t_cod_select_options,
      lv_eff_for_dep  TYPE zrh_dpo_eff_for_dep,
      lv_REQUEST_FULL TYPE zhr_dpo_request_full,
      r_uname TYPE RANGE OF sy-uname.

    FIELD-SYMBOLS:
      <fs_so> TYPE /iwbep/s_cod_select_option.

    DATA(lv_uname) = zcl_pe_all_change_user=>get_uname( iv_appl_id = 'ZHR_DPO_REQUEST' ).
    LOOP AT it_filter_select_options[] ASSIGNING FIELD-SYMBOL(<fso>).
      CASE <fso>-property.

        WHEN 'ThemeLong'.
           DATA(lr_templ_code) = <fso>-select_options[].
         WHEN 'Uname'.
           LOOP AT <fso>-select_options ASSIGNING FIELD-SYMBOL(<fs_uname>).
             lv_uname = <fs_uname>-low.
           ENDLOOP.
          DATA(lr_uname) = <fso>-select_options[].
        WHEN 'AgreementDate'.
          DATA(lr_agreement_date) = <fso>-select_options[].
        WHEN 'AgreementDateTo'.
          DATA(lr_agreement_date_to) = <fso>-select_options[].
        WHEN 'StatusDescr'.
          DATA(lr_status) = <fso>-select_options[].
        WHEN 'DpoRequest'.
          DATA(lr_request) = <fso>-select_options[].
          "conver to leading zeroes
          LOOP AT lr_request ASSIGNING FIELD-SYMBOL(<fs_req>).
            lv_req = <fs_req>-low.
            CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT' EXPORTING input = lv_req IMPORTING output = lv_req.
            <fs_req>-low = lv_req.
            lv_req = <fs_req>-high.
            CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT' EXPORTING input = lv_req IMPORTING output = lv_req.
            <fs_req>-high = lv_req.
          ENDLOOP.
        WHEN 'DpoAgreement'.
          DATA(lr_agreement) = <fso>-select_options[].
          "conver to leading zeroes
          LOOP AT lr_agreement ASSIGNING FIELD-SYMBOL(<fs_agr>).
            lv_agr = <fs_agr>-low.
            CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT' EXPORTING input = lv_agr IMPORTING output = lv_agr.
            <fs_agr>-low = lv_agr.
            lv_agr = <fs_agr>-high.
            CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT' EXPORTING input = lv_agr IMPORTING output = lv_agr.
            <fs_agr>-high = lv_agr.
          ENDLOOP.
        WHEN 'Name'.
          DATA(lr_name) = <fso>-select_options[].
          LOOP AT lr_name ASSIGNING FIELD-SYMBOL(<fs_name>).
            lv_name_filter = <fs_name>-low.
          ENDLOOP.
        WHEN 'EffForDep'.
          lr_so = <fso>-select_options[].
          LOOP AT lr_so ASSIGNING <fs_so>.
            lv_eff_for_dep = <fs_so>-low.
          ENDLOOP.
        WHEN 'DpoRequestFull'.
          lr_so = <fso>-select_options[].
          LOOP AT lr_so ASSIGNING <fs_so>.
            lv_request_full = <fs_so>-low.
          ENDLOOP.
        WHEN OTHERS.
      ENDCASE.
    ENDLOOP.



*    DATA(lv_uname) = zcl_zhr_dpo_agr_dpc_ext=>get_uname( ).
    DATA(lt_output) = zcl_hr_dpo_agreement=>get( iv_uname = lv_uname )->get_agreement_list(
      it_agreement_date_range       = lr_agreement_date
      it_agreement_date_to_range    = lr_agreement_date_to
      it_agreement_range            = lr_agreement
      it_status_range               = lr_status
      it_request_range              = lr_request
      iv_name_filter                = lv_name_filter
      iv_eff_for_dep_filter         = lv_eff_for_dep
      iv_request_full_filter        = lv_request_full
      it_templ_code_range           = lr_templ_code
      iv_load_only_non_empty_status = abap_true
    ).
    et_entityset[] = CORRESPONDING #( lt_output ).
  ENDMETHOD.


  METHOD agreementdataset_update_entity.
    me->disable_cache( ).
    DATA:
      lt_message TYPE bapirettab,
      et_message TYPE bapirettab,
      lv_result  TYPE wdy_boolean,
      lv_dummy   TYPE string
      .
    TRY.
        io_data_provider->read_entry_data( IMPORTING es_data = er_entity ).
      CATCH cx_static_check INTO DATA(lo_exc).
        DATA(lv_text) = lo_exc->get_text( ).
        MESSAGE e000(zhr_dpo_en) WITH lv_text INTO lv_dummy.
        zcl_hr_dpo_message=>append_syst( CHANGING ct_message = et_message ).
    ENDTRY.
    CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT' EXPORTING input = er_entity-dpo_agreement IMPORTING output = er_entity-dpo_agreement.
    SELECT SINGLE orig_user FROM zhr_dpo_histdoh INTO @DATA(lv_uname) WHERE dpo_agreement = @er_entity-dpo_agreement.
*    DATA(lv_uname) = zcl_zhr_dpo_agr_dpc_ext=>get_uname( ).
    DATA(lo_agreement) = zcl_hr_dpo_agreement=>get( iv_uname = lv_uname ).
    DATA(ls_agreement) = lo_agreement->update(
      EXPORTING
        iv_agreement         = er_entity-dpo_agreement
        iv_agreement_date_to = er_entity-agreement_date_to
        iv_agreement_date    = er_entity-agreement_date
        iv_name              = er_entity-name
        iv_eff_for_dep       = er_entity-eff_for_dep
      IMPORTING
        et_message           = lt_message
        ev_result            = lv_result
    ).
    APPEND LINES OF lt_message TO et_message.
    lv_result = zcl_hr_dpo_message=>no_contain_error( it_message = et_message ).
    IF lv_result = abap_true.
      CLEAR er_entity.
      DATA(ls_agreement_gw) = lo_agreement->get_agreement( iv_agreement = ls_agreement-dpo_agreement ).
      MOVE-CORRESPONDING ls_agreement_gw TO er_entity.
    ELSE.
      DATA(lo_message) = mo_context->get_message_container( ).
      lo_message->add_messages_from_bapi( it_bapi_messages = et_message iv_add_to_response_header = abap_true ).
      RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
        EXPORTING
          message_container = lo_message.
    ENDIF.
  ENDMETHOD.


  METHOD agreementhistory_get_entityset.
    me->disable_cache( ).
    DATA:
      lt_message TYPE bapirettab,
      et_message TYPE bapirettab,
      lv_result  TYPE wdy_boolean,
      lv_dummy   TYPE string,
      lv_agr     TYPE zhr_dpo_agreement
      .
    READ TABLE it_key_tab[] ASSIGNING FIELD-SYMBOL(<fso>) WITH KEY name =  'DpoAgreement'.
    IF sy-subrc EQ 0.

      CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'
        EXPORTING
          input  = <fso>-value
        IMPORTING
          output = lv_agr.
    ENDIF.
    IF lv_agr IS INITIAL.
      "Only specific agreement history is possible. Use $filter=(DpoAgreement eq 'NUM')
      MESSAGE e004(zhr_dpo_en) INTO lv_dummy.
      zcl_hr_dpo_message=>append_syst( CHANGING ct_message = et_message ).
    ELSE.
*      DATA(lv_uname) = zcl_zhr_dpo_agr_dpc_ext=>get_uname( ).
      CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT' EXPORTING input = lv_agr IMPORTING output = lv_agr.
      SELECT SINGLE orig_user FROM zhr_dpo_histdoh INTO @DATA(lv_uname) WHERE dpo_agreement = @lv_agr.
      DATA(lt_agr_hist_gw) = zcl_hr_dpo_agreement=>get( iv_uname = lv_uname )->get_history(
        EXPORTING
          iv_dpo_agreement = lv_agr  " ID žádosti
        IMPORTING
          et_message       = lt_message " Table with BAPI Return Information
          ev_result        = lv_result  " Replacement for Real Boolean Type: 'X' == True '' == False
      ).
      APPEND LINES OF lt_message TO et_message.
    ENDIF.
    lv_result = zcl_hr_dpo_message=>no_contain_error( it_message = et_message ).
    IF lv_result = abap_true.
      et_entityset[] = CORRESPONDING #( lt_agr_hist_gw ).
    ELSE.
      DATA(lo_message) = mo_context->get_message_container( ).
      lo_message->add_messages_from_bapi( it_bapi_messages = et_message iv_add_to_response_header = abap_true ).
      RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
        EXPORTING
          message_container = lo_message.
    ENDIF.
  ENDMETHOD.


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
                                               iv_dpo_process = 'D-DOHODA'
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

  endmethod.


  METHOD disable_cache.
    DATA ls_header TYPE ihttpnvp.
    ls_header-name = 'Cache-Control'.                       "#EC NOTEXT
    ls_header-value = 'no-cache, no-store'.                 "#EC NOTEXT
    me->set_header( EXPORTING is_header = ls_header ).
    ls_header-name = 'X-Content-Type-Options'.              "#EC NOTEXT
    ls_header-value = 'nosniff'.                            "#EC NOTEXT
    me->set_header( EXPORTING is_header = ls_header ).
  ENDMETHOD.


  METHOD get_uname.
    rv_uname = zcl_pe_all_change_user=>get_uname( iv_appl_id = 'ZHR_DPO_REQUEST' ).
  ENDMETHOD.


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


  method WORDTEMPLATELINK_GET_ENTITY.

  DATA: lv_dpo_request TYPE zhr_dpo_request,
        lv_dpo_agreement TYPE zhr_dpo_agreement.

    READ TABLE it_key_tab ASSIGNING FIELD-SYMBOL(<fs_key>) WITH KEY name = 'DpoRequest'.
    IF sy-subrc EQ 0.
      CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'
        EXPORTING
          input  = <fs_key>-value
        IMPORTING
          output = lv_dpo_request.
      .
    ENDIF.
    SELECT SINGLE template_code FROM zhr_dpo_zad INTO @DATA(lv_templ_code)
                                WHERE dpo_request = @lv_dpo_request.

    IF sy-subrc EQ 0.
      lv_dpo_request = '9999999999'.
    ENDIF.



    CONSTANTS: c_quot TYPE c VALUE `'`.
    DATA: lv_link TYPE zsd_sdp_url,
          lv_base TYPE string VALUE  '/sap/opu/odata/sap/ZHR_DPO_AGR_SRV/WordTemplateSet'.

    CONCATENATE lv_base '(' INTO  lv_link.
    CONCATENATE lv_link 'DpoRequest=' c_quot lv_dpo_request c_quot  ','
     'TemplateCode=' c_quot lv_templ_code  c_quot
     INTO  lv_link.
    CONCATENATE lv_link ')/$value'                               INTO  lv_link.
    er_entity-link = lv_link.

  endmethod.
ENDCLASS.
