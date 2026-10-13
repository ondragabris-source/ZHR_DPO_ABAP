class ZCL_ZHR_DPO_A004_DPC_EXT definition
  public
  inheriting from ZCL_ZHR_DPO_A004_DPC
  create public .

public section.

  methods /IWBEP/IF_MGW_APPL_SRV_RUNTIME~EXECUTE_ACTION
    redefinition .
  methods /IWBEP/IF_MGW_APPL_SRV_RUNTIME~GET_STREAM
    redefinition .
protected section.

  methods SEND_MESSAGES
    importing
      !IT_MESSAGE type BAPIRETTAB
      !IV_MESSAGE_TARGET type STRING
    raising
      /IWBEP/CX_MGW_BUSI_EXCEPTION .
  methods GET_UNAME
    importing
      !IV_REQUEST_URI type IHTTPVAL
    returning
      value(RV_UNAME) type SY-UNAME .
  methods NO_CACHE .

  methods EMPLOYEESET_GET_ENTITYSET
    redefinition .
  methods ITEMSET_CREATE_ENTITY
    redefinition .
  methods ITEMSET_DELETE_ENTITY
    redefinition .
  methods ITEMSET_GET_ENTITY
    redefinition .
  methods ITEMSET_GET_ENTITYSET
    redefinition .
  methods ITEMSET_UPDATE_ENTITY
    redefinition .
  methods ITEMTYPESET_GET_ENTITYSET
    redefinition .
  methods A004SET_GET_ENTITYSET
    redefinition .
private section.
ENDCLASS.



CLASS ZCL_ZHR_DPO_A004_DPC_EXT IMPLEMENTATION.


  METHOD /iwbep/if_mgw_appl_srv_runtime~execute_action.
    DATA: et_message        TYPE bapirettab,
          lv_message_target TYPE string VALUE 'DpoRequest',
          lt_message        TYPE bapirettab,
          lv_uname          TYPE sy-uname.
    me->no_cache( ).
    IF line_exists( it_parameter[ name = 'Uname' ] ).
      lv_uname = it_parameter[ name = 'Uname' ]-value.
    ENDIF.
    IF iv_action_name = 'CreateOrGet'
*      OR iv_action_name = 'RequestItems'
      OR iv_action_name = 'GetFmByPernr'
      OR iv_action_name = 'GetFmByFm'.
      DATA(lv_request) = CONV zhr_dpo_request( it_parameter[ name = 'Request' ]-value ).
    ENDIF.
    CASE iv_action_name.
      WHEN 'ChooseVersion'.


      WHEN 'GetFmByPernr'.
        DATA(ls_a004_fm) = zcl_hr_dpo_a004_bl=>get_emp_detail(
          EXPORTING
            iv_request = lv_request
            iv_pernr   = CONV zhr_dpo_pernr( it_parameter[ name = 'Pernr' ]-value )
          IMPORTING
            et_message = lt_message
        ).
        APPEND LINES OF lt_message TO et_message.
        copy_data_to_ref(
          EXPORTING is_data = ls_a004_fm
          CHANGING  cr_data = er_data
        ).
      WHEN 'CreateOrGet'.
        DATA(ls_a004) = zcl_hr_dpo_a004_bl=>create_or_get(
          EXPORTING
            iv_request = lv_request
            iv_uname   = lv_uname
          IMPORTING
            et_message = lt_message
        ).
        APPEND LINES OF lt_message TO et_message.
        copy_data_to_ref(
          EXPORTING is_data = ls_a004
          CHANGING  cr_data = er_data
        ).
*      WHEN 'RequestItems'.
*        DATA(lt_items) = zcl_hr_dpo_a004_bl=>get_items(
*          EXPORTING
*            iv_request = lv_request        " ID žádosti
*          IMPORTING
*            et_message = lt_message        " Tabulka s návratovými informacemi BAPI
*        ).
*        APPEND LINES OF lt_message TO et_message.
*        lv_message_target = 'DpoRequest'.
*        copy_data_to_ref(
*          EXPORTING is_data = lt_items
*          CHANGING  cr_data = er_data
*        ).
    ENDCASE.
    me->send_messages(
      EXPORTING
        it_message        = et_message                 " Tabulka s návratovými informacemi BAPI
        iv_message_target = lv_message_target
    ).
*    CATCH /iwbep/cx_mgw_busi_exception. " Business Exception
  ENDMETHOD.


  METHOD /iwbep/if_mgw_appl_srv_runtime~get_stream.
    DATA: et_message TYPE bapirettab,
          lt_message TYPE bapirettab.
    DATA(lv_message_target) = CONV string( 'DpoRequest' ).
    me->no_cache( ).
    CASE iv_entity_set_name.
      WHEN 'PdfSet'.
        DATA(lv_request) = CONV zhr_dpo_request( it_key_tab[ name = 'DpoRequest' ]-value ).

        DATA: ls_stream  TYPE /iwbep/cl_mgw_abs_data=>ty_s_media_resource,
              ls_lheader TYPE ihttpnvp,
              lv_uname   TYPE sy-uname.
        DATA(lt_request_headers) = io_tech_request_context->get_request_headers( ).
        IF line_exists( lt_request_headers[ name = '~request_uri' ] ).
          DATA(lv_request_uri) = lt_request_headers[ name = '~request_uri' ]-value.
          lv_uname = me->get_uname( lv_request_uri ).
          IF lv_uname IS INITIAL.
            lv_uname = sy-uname.
            lv_uname =     zcl_pe_all_change_user=>get_uname( iv_appl_id = 'ZHR_DPO_REQUEST' ).
          ENDIF.
          DATA(lv_nacti_vsechny_zastupy) = abap_false.
          SEARCH lv_request_uri FOR 'NactiVsechnyZastupy'.
          IF sy-subrc EQ 0.
            lv_nacti_vsechny_zastupy = abap_true.
          ENDIF.
        ENDIF.
        ls_stream = VALUE #(
          value = zcl_hr_dpo_a004_bl=>get_pdf_stream(
            EXPORTING
              iv_request = lv_request
              iv_uname = lv_uname
              iv_nacti_vsechny_zastupy = lv_nacti_vsechny_zastupy
*              iv_version = lv_version
            IMPORTING
              et_message = lt_message
          )
          mime_type = |application/pdf|
        ).
        APPEND LINES OF lt_message TO et_message.
        DATA(lv_filename) = |zadost-{ lv_request }-priloha-c-4-{ sy-datum DATE = ISO }.pdf|.
        ls_lheader = VALUE #(
          name = |Content-Disposition| ##NO_TEXT
          value = |attachment; name="{ lv_filename }"; filename="{ lv_filename }"|
        ).
        me->set_header( is_header = ls_lheader ).
        me->copy_data_to_ref( EXPORTING is_data = ls_stream CHANGING cr_data = er_stream ).
    ENDCASE.
    me->send_messages(
      EXPORTING
        it_message        = et_message                 " Tabulka s návratovými informacemi BAPI
        iv_message_target = lv_message_target
    ).
  ENDMETHOD.


  METHOD a004set_get_entityset.



    TRY.
        CALL METHOD super->a004set_get_entityset
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




    DATA(lv_uname) = CONV sy-uname( zcl_pa_vs_utils=>get_param_from_filter(
                                      iv_name = 'JmenoPrijmeni03'
                                      it_filter_select_options = it_filter_select_options )
                                      ).
    DATA(lv_request) = CONV zhr_dpo_zad-dpo_request( zcl_pa_vs_utils=>get_param_from_filter(
                                      iv_name = 'DpoRequest'
                                      it_filter_select_options = it_filter_select_options )
                                      ).

    IF lv_uname IS INITIAL.
      lv_uname =       zcl_pe_all_change_user=>get_uname( iv_appl_id = 'ZHR_DPO_REQUEST' ).

    ENDIF.

    DATA(lv_role)  = zcl_hr_dpo_roles=>identify_my_role(  iv_name = lv_uname iv_dpo_request = |{ lv_request ALPHA = IN }|   ).
    DATA(lv_status) = NEW zcl_hr_dpo_request( )->read_request( iv_dpo_request = |{ lv_request ALPHA = IN }| iv_read_tmp_request = abap_true )-status.


    lv_request = |{ lv_request ALPHA = IN }|.
    IF lv_role = 'HRBP'.
      SELECT COUNT( * ) FROM zhr_dpo_rozdel as rozdel
                            WHERE  dpo_request = @lv_request
                               AND role  = 'ZAD'
                               AND pernr = ( SELECT pernr FROM zhr_dpo_rozdel WHERE dpo_request = @lv_request
                                                                                AND role = 'HRBP'
                                                                                AND pernr = rozdel~pernr   )  .
      IF sy-subrc EQ 0.
        lv_role = 'ZAD'.
      ENDIF.
    ENDIF.

    IF lv_role <> 'ZAD' AND lv_role <> 'SP' AND lv_role <> 'ADMIN'.
      DELETE et_entityset WHERE not_yet_approved = abap_true.
    ELSE.
      IF lv_role = 'SP'  AND lv_status NE 'NAA'.
        DELETE et_entityset WHERE not_yet_approved = abap_true.
      ENDIF.
    ENDIF .



    SORT et_entityset BY version DESCENDING.
    IF lv_role = 'ZAD' AND  NEW zcl_hr_dpo_request( )->status_exists_in_history( iv_dpo_request  =  |{ lv_request ALPHA = IN }|
                                                                  iv_status       = 'ZHP' ).
      DATA(ls_entity_set) =  et_entityset[ 1 ].
      REFRESH  et_entityset.
      APPEND ls_entity_set TO et_entityset.

    ENDIF.

  ENDMETHOD.


  METHOD employeeset_get_entityset.
    DATA: lv_pernr       TYPE persno,
          lv_pernr_c(8)  TYPE c,
          lv_name        TYPE pad_vorna,
          lv_surname     TYPE pad_nachn,
          lv_uname       TYPE syuname,
          lv_role        TYPE zhr_dpo_role,
          lv_dpo_request TYPE zhr_dpo_request,
          lv_plans       TYPE string,
          et_message     TYPE bapirettab.

    CLEAR: et_entityset.

*    lv_uname = zcl_pe_all_change_user=>get_uname( iv_appl_id = zcl_pa_vs_all_data=>application_id_common ).
*    lv_uname = zcl_pe_all_change_user=>get_uname( iv_appl_id = 'ZHR_DPO_REQUEST' ).

    lv_plans = zcl_pa_vs_utils=>get_param_from_filter( iv_name = 'Plans' it_filter_select_options = it_filter_select_options ).
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
                                          WITH KEY property = 'DpoRequest'.
      IF sy-subrc EQ 0.
        LOOP AT <fs_name>-select_options ASSIGNING FIELD-SYMBOL(<fs_val>).
          CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'
            EXPORTING
              input  = <fs_val>-low
            IMPORTING
              output = lv_dpo_request.
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
      DATA(lt_emp_search) = zcl_hr_dpo_roles=>search_employee(
              iv_pernr      =     lv_pernr
              iv_name       =     lv_name
              iv_surname    =     lv_surname
              iv_for_uname  =     lv_uname
              iv_role       =     lv_role
              iv_fm_search  =     lv_plans
            ).

      "<Omezeni podle roli>
      DATA: lt_message TYPE bapirettab,
            lv_result  TYPE flag.
      "Využití atributu UnitShort - nepoužívá se pro hledání, použije se pro zástup
      lv_uname = zcl_pa_vs_utils=>get_param_from_filter( iv_name = 'UnitShort' it_filter_select_options = it_filter_select_options ).
      IF lv_uname IS INITIAL.
        lv_uname =     zcl_pe_all_change_user=>get_uname( iv_appl_id = 'ZHR_DPO_REQUEST' ).
      ENDIF.
      DATA(lo_auth) = zcl_hr_dpo_auth=>get(
        EXPORTING
          iv_uname                 = lv_uname
        IMPORTING
          et_message               = lt_message                 " Tabulka s návratovými informacemi BAPI
          ev_result                = lv_result                 " Všeobecný příznak
      ).
      APPEND LINES OF lt_message TO et_message.
      IF lo_auth IS NOT INITIAL.
        lo_auth->get_req_a004_struc_by_role(
          EXPORTING
            iv_request         = lv_dpo_request
          IMPORTING
            ev_show_all        = DATA(lv_show_all)                 " Může vidět všechny zaměstnance
            et_show_only_pernr = DATA(lt_show_only_pernr)                 " Tabulka zaměstnanců
            et_message         = DATA(lt_message3)                 " Tabulka s návratovými informacemi BAPI
            et_objec           = DATA(lt_objec)                 " Tabulka struc
        ).
        APPEND LINES OF lt_message3 TO et_message.
      ENDIF.
      IF lv_show_all <> abap_true.
        lt_emp_search = FILTER #( lt_emp_search IN lt_show_only_pernr WHERE pernr = table_line ).
      ENDIF.
      "</Omezeni podle roli>

      DATA: ls_entityset LIKE LINE OF et_entityset.
      DATA(lv_from) = ( is_paging-top * is_paging-skip ).
      DATA(lv_to) = lv_from + is_paging-top.
      LOOP AT lt_emp_search INTO DATA(ls_emp_search) FROM lv_from TO lv_to.
        MOVE-CORRESPONDING ls_emp_search TO ls_entityset.
        APPEND ls_entityset TO et_entityset.
      ENDLOOP.
    ENDIF.
    zcl_hr_dpo_message=>fill_message_container(
      EXPORTING
        iv_message_target = 'Pernr'
        io_message        = me->/iwbep/if_mgw_conv_srv_runtime~get_message_container( )
        it_message        = et_message
    ).
    IF zcl_hr_dpo_message=>no_contain_error( it_message = et_message ) = abap_false.
      RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
        EXPORTING
          message_container = me->/iwbep/if_mgw_conv_srv_runtime~get_message_container( ).
    ENDIF.
  ENDMETHOD.


  METHOD get_uname.
    CLEAR rv_uname.
    SEARCH iv_request_uri FOR 'Uname='.
    IF sy-subrc EQ 0.
      DATA(lv_pos) = sy-fdpos + 6.
      DATA(lv_uname2) = iv_request_uri+lv_pos.
      rv_uname = lv_uname2.
    ENDIF.
  ENDMETHOD.


  METHOD itemset_create_entity.
    DATA: lv_dummy          TYPE string,
          lt_message        TYPE bapirettab,
          lv_message_target TYPE string VALUE 'DpoRequest',
          ls_a004_i_item    TYPE zhr_dpo_a004_i_item_s,
          et_message        TYPE bapirettab,
          lv_result         TYPE boolean VALUE abap_false
          .
    me->no_cache( ).
    TRY.
        io_data_provider->read_entry_data( IMPORTING es_data = er_entity ).
      CATCH cx_static_check INTO DATA(lo_exc).
        DATA(lv_text) = lo_exc->get_text( ).
        "Nemohu nacist vstupni data: &1
        MESSAGE e020(zhr_dpo) WITH lv_text INTO lv_dummy.
        zcl_hr_dpo_message=>append_syst( CHANGING ct_message = lt_message ).
    ENDTRY.
    IF er_entity IS NOT INITIAL.
      MOVE-CORRESPONDING er_entity TO ls_a004_i_item.
      DATA(ls_a004_i_item_inserted) = zcl_hr_dpo_a004_bl=>add_update_item(
        EXPORTING
          iv_request          = er_entity-dpo_request
          iv_item_type        = er_entity-attach_item_type
*          iv_attachement_item =
          is_a004_i_item      = ls_a004_i_item
        IMPORTING
          et_message          = lt_message
          ev_result           = lv_result
      ).
      zcl_hr_dpo_message=>fill_message_container(
      EXPORTING
        iv_message_target = lv_message_target
        io_message        = me->/iwbep/if_mgw_conv_srv_runtime~get_message_container( )
        it_message        = lt_message
    ).
    ENDIF.
    IF lv_result = abap_true.
      er_entity-dpo_attachement_item = ls_a004_i_item_inserted-dpo_attachement_item.
    ELSE.
      RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
        EXPORTING
          message_container = me->/iwbep/if_mgw_conv_srv_runtime~get_message_container( ).
    ENDIF.
  ENDMETHOD.


  METHOD itemset_delete_entity.
    DATA: lt_message TYPE bapirettab.

    me->no_cache( ).
    DATA(lv_request) = CONV zhr_dpo_request( it_key_tab[ name = 'DpoRequest' ]-value ).
    DATA(lv_attachement_item) = CONV zhr_dpo_attachement_item( it_key_tab[ name = 'DpoAttachementItem' ]-value ).
    DATA(lv_attachement_item_type) = CONV zhr_dpo_a004it( it_key_tab[ name = 'AttachItemType' ]-value ).
    DATA(lv_pernr) = CONV pernr_d( it_key_tab[ name = 'Pernr' ]-value ).
    DATA(lv_version) = CONV version( it_key_tab[ name = 'Version' ]-value ).

    zcl_hr_dpo_a004_bl=>delete_item(
      EXPORTING
        iv_request          = lv_request                 " ID žádosti
        iv_attach_item_type = lv_attachement_item_type                 " Žádost - příloha č. 4 - typ řádku - klíč
        iv_attachement_item = lv_attachement_item                 " ID položky přílohy
        iv_pernr            = lv_pernr
        iv_version          = lv_version
      IMPORTING
        et_message          = lt_message                 " Tabulka s návratovými informacemi BAPI
    ).
    DATA(lo_mess_cont) = me->/iwbep/if_mgw_conv_srv_runtime~get_message_container( ).
    zcl_hr_dpo_message=>fill_message_container(
      EXPORTING
        iv_message_target = 'DPO_REQUEST'
        io_message        = lo_mess_cont
        it_message        = lt_message
    ).
    IF zcl_hr_dpo_message=>no_contain_error( it_message = lt_message ) <> abap_true.
      RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
        EXPORTING
          message_container = lo_mess_cont.
    ENDIF.
  ENDMETHOD.


  METHOD itemset_get_entity.
    DATA: lt_message TYPE bapirettab.
    me->no_cache( ).
    DATA(lv_request) = CONV zhr_dpo_request( it_key_tab[ name = 'DpoRequest' ]-value ).
    DATA(lv_version) = CONV version( it_key_tab[ name = 'Version' ]-value ).
    DATA(lv_attachement_item) = CONV zhr_dpo_attachement_item( it_key_tab[ name = 'DpoAttachementItem' ]-value ).
    DATA(lv_attachement_item_type) = CONV zhr_dpo_a004it( it_key_tab[ name = 'AttachItemType' ]-value ).
    DATA(lv_pernr) = CONV pernr_d( it_key_tab[ name = 'Pernr' ]-value ).
    "Využití atributu JmenoPrijmeni03 - nepoužívá se pro hledání, použije se pro zástup
*    data(lv_uname) = zcl_pa_vs_utils=>get_param_from_filter( iv_name = 'JmenoPrijmeni03' it_filter_select_options = it_filter_select_options ).
    DATA(lv_uname) =     zcl_pe_all_change_user=>get_uname( iv_appl_id = 'ZHR_DPO_REQUEST' ).


    DATA(ls_item) = zcl_hr_dpo_a004_bl=>get_item(
      EXPORTING
        iv_uname            = lv_uname
        iv_request          = lv_request                 " ID žádosti
        iv_version          = lv_version
        iv_attach_item_type = lv_attachement_item_type                 " Žádost - příloha č. 4 - typ řádku - klíč
        iv_attachement_item = lv_attachement_item                 " ID položky přílohy
        iv_pernr            = lv_pernr
      IMPORTING
        et_message          = lt_message                 " Tabulka s návratovými informacemi BAPI
    ).
    me->send_messages(
      EXPORTING
        it_message        = lt_message                 " Tabulka s návratovými informacemi BAPI
        iv_message_target = 'DPO_REQUEST'
    ).
*    CATCH /iwbep/cx_mgw_busi_exception. " Business Exception
    MOVE-CORRESPONDING ls_item TO er_entity.
  ENDMETHOD.


  METHOD itemset_get_entityset.
    DATA: lt_message TYPE bapirettab.
    me->no_cache( ).
    IF lines( it_filter_select_options ) > 0
      AND line_exists( it_filter_select_options[ property = 'DpoRequest' ] ).
      DATA(lv_request) = CONV zhr_dpo_request( it_filter_select_options[ property = 'DpoRequest' ]-select_options[ option = 'EQ' sign = 'I' ]-low ).
      "Využití atributu JmenoPrijmeni03 - nepoužívá se pro hledání, použije se pro zástup
      DATA(lv_uname) = CONV sy-uname( zcl_pa_vs_utils=>get_param_from_filter(
                                        iv_name = 'JmenoPrijmeni03'
                                        it_filter_select_options = it_filter_select_options )
                                        ).
       DATA(lv_version) = CONV version( zcl_pa_vs_utils=>get_param_from_filter(
                                        iv_name = 'Version'
                                        it_filter_select_options = it_filter_select_options )
                                        ).
      IF lv_uname IS INITIAL.
           lv_uname =  zcl_pe_all_change_user=>get_uname( iv_appl_id = 'ZHR_DPO_REQUEST' ).
      ENDIF.

      lv_request = |{ lv_request ALPHA = IN  }|.
      DATA(lv_role)  = zcl_hr_dpo_roles=>identify_my_role(  iv_name = lv_uname iv_dpo_request =  lv_request  ).
      data(lv_status) = NEW zcl_hr_dpo_request( )->read_request( iv_dpo_request =  lv_request iv_read_tmp_request = abap_true )-status.

      IF lv_role = 'ZAD' AND NEW zcl_hr_dpo_request( )->status_exists_in_history( iv_dpo_request  =  lv_request
                                                                  iv_status       = 'ZHP' ).
        SELECT MAX( version ) FROM zhr_dpo_a004
                              WHERE dpo_request =  @lv_request
                              INTO @DATA(lv_max_version).
        IF sy-subrc EQ 0.
          lv_version = lv_max_version.
        ENDIF.
      ENDIF.

      DATA(lt_items) = zcl_hr_dpo_a004_bl=>get_items(
        EXPORTING
          iv_uname   = lv_uname
          iv_request = lv_request        " ID žádosti
          iv_version = lv_version
        IMPORTING
          et_message = lt_message        " Tabulka s návratovými informacemi BAPI
      ).
      SORT lt_items BY serial_number_01 ASCENDING item_type_index ASCENDING.
      APPEND LINES OF lt_items TO et_entityset.
    ENDIF.
    me->send_messages(
      EXPORTING
        it_message        = lt_message                 " Tabulka s návratovými informacemi BAPI
        iv_message_target = 'DPO_REQUEST'
    ).
*    CATCH /iwbep/cx_mgw_busi_exception. " Business Exception
  ENDMETHOD.


  METHOD itemset_update_entity.
    DATA: lv_dummy          TYPE string,
          lt_message        TYPE bapirettab,
          lv_message_target TYPE string VALUE 'DpoRequest',
          ls_a004_i_item    TYPE zhr_dpo_a004_i_item_s,
          et_message        TYPE bapirettab,
          lv_result         TYPE boolean VALUE abap_false
          .
    me->no_cache( ).
    TRY.
        io_data_provider->read_entry_data( IMPORTING es_data = er_entity ).
      CATCH cx_static_check INTO DATA(lo_exc).
        DATA(lv_text) = lo_exc->get_text( ).
        "Nemohu nacist vstupni data: &1
        MESSAGE e020(zhr_dpo) WITH lv_text INTO lv_dummy.
        zcl_hr_dpo_message=>append_syst( CHANGING ct_message = lt_message ).
    ENDTRY.
    IF er_entity IS NOT INITIAL.
      MOVE-CORRESPONDING er_entity TO ls_a004_i_item.
      DATA(ls_a004_i_item_updated) = zcl_hr_dpo_a004_bl=>add_update_item(
        EXPORTING
          iv_request          = er_entity-dpo_request
          iv_item_type        = er_entity-attach_item_type
          iv_attachement_item = er_entity-dpo_attachement_item
          is_a004_i_item      = ls_a004_i_item
        IMPORTING
          et_message          = lt_message
          ev_result           = lv_result
      ).
      zcl_hr_dpo_message=>fill_message_container(
      EXPORTING
        iv_message_target = lv_message_target
        io_message        = me->/iwbep/if_mgw_conv_srv_runtime~get_message_container( )
        it_message        = lt_message
    ).
    ENDIF.
    IF lv_result = abap_true.
    ELSE.
      RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
        EXPORTING
          message_container = me->/iwbep/if_mgw_conv_srv_runtime~get_message_container( ).
    ENDIF.
  ENDMETHOD.


  METHOD itemtypeset_get_entityset.
*    TRY.
    CALL METHOD super->itemtypeset_get_entityset
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
*      CATCH /iwbep/cx_mgw_busi_exception.
*      CATCH /iwbep/cx_mgw_tech_exception.
*    ENDTRY.
    SORT et_entityset BY type_order ASCENDING.
  ENDMETHOD.


  METHOD no_cache.
    DATA ls_header TYPE ihttpnvp.
    ls_header-name = 'Cache-Control' ##NO_TEXT.
    ls_header-value = 'no-cache, no-store' ##NO_TEXT.
    me->set_header( EXPORTING is_header = ls_header ).
    ls_header-name = 'X-Content-Type-Options' ##NO_TEXT.
    ls_header-value = 'nosniff' ##NO_TEXT.
    me->set_header( EXPORTING is_header = ls_header ).
  ENDMETHOD.


  METHOD send_messages.
    DATA(lt_message) = it_message.
    DATA(lo_mess_cont) = me->/iwbep/if_mgw_conv_srv_runtime~get_message_container( ).
    zcl_hr_dpo_message=>fill_message_container(
      EXPORTING
        iv_message_target = iv_message_target
        io_message        = lo_mess_cont
        it_message        = lt_message
    ).
    IF zcl_hr_dpo_message=>no_contain_error( it_message = lt_message ) = abap_false.
      RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
        EXPORTING
          message_container = lo_mess_cont.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
