class ZCL_HR_DPO_AGREEMENT definition
  public
  final
  create public .

public section.

  constants GC_REQUEST type ZHR_DPO_OBJECT value 'D' ##NO_TEXT.
  constants GC_INITIAL_STATUS type ZHR_DPO_STATUS_REQ value 'ND1' ##NO_TEXT.

  methods CHECK_IF_CAN_SEE_AGR
    importing
      !IV_AGR type ZHR_DPO_AGREEMENT
    returning
      value(RV_CAN_SEE_AGR) type WDY_BOOLEAN .
  methods CONSTRUCTOR
    importing
      !IV_UNAME type SY-UNAME .
  class-methods GET
    importing
      !IV_UNAME type SY-UNAME
    returning
      value(RO_AGREEMENT) type ref to ZCL_HR_DPO_AGREEMENT .
  methods CREATE_AND_SAVE
    importing
      !IV_REQUEST type ZHR_DPO_REQUEST
      !IV_AGREEMENT_DATE_TO type DATUM
      !IV_AGREEMENT_DATE type DATUM
      !IV_NAME type ZHR_DPO_DOH_NAME
      !IV_STATUS type ZHR_DPO_STATUS_REQ
      !IV_EFF_FOR_DEP type ZHR_DPO_DOH-EFF_FOR_DEP
    exporting
      !ET_MESSAGE type BAPIRETTAB
      !EV_RESULT type WDY_BOOLEAN
    returning
      value(RS_AGREEMENT) type ZHR_DPO_DOH .
  methods UPDATE
    importing
      !IV_AGREEMENT type ZHR_DPO_AGREEMENT
      !IV_AGREEMENT_DATE_TO type DATUM
      !IV_AGREEMENT_DATE type DATUM
      !IV_NAME type ZHR_DPO_DOH_NAME
      !IV_EFF_FOR_DEP type ZHR_DPO_DOH-EFF_FOR_DEP
    exporting
      !ET_MESSAGE type BAPIRETTAB
      !EV_RESULT type WDY_BOOLEAN
    returning
      value(RS_AGREEMENT) type ZHR_DPO_DOH .
  methods GET_AGREEMENT
    importing
      !IV_AGREEMENT type ZHR_DPO_AGREEMENT
    returning
      value(RS_AGREEMENT) type ZHR_DPO_DOH_S .
  methods GET_AGREEMENT_LIST
    importing
      !IT_AGREEMENT_DATE_TO_RANGE type /IWBEP/T_COD_SELECT_OPTIONS optional
      !IT_AGREEMENT_DATE_RANGE type /IWBEP/T_COD_SELECT_OPTIONS optional
      !IT_AGREEMENT_RANGE type /IWBEP/T_COD_SELECT_OPTIONS optional
      !IT_STATUS_RANGE type /IWBEP/T_COD_SELECT_OPTIONS optional
      !IT_REQUEST_RANGE type /IWBEP/T_COD_SELECT_OPTIONS optional
      !IT_TEMPL_CODE_RANGE type /IWBEP/T_COD_SELECT_OPTIONS optional
      !IV_NAME_FILTER type ZHR_DPO_DOH_NAME optional
      !IV_EFF_FOR_DEP_FILTER type ZRH_DPO_EFF_FOR_DEP optional
      !IV_REQUEST_FULL_FILTER type ZHR_DPO_REQUEST_FULL optional
      !IV_LOAD_ONLY_NON_EMPTY_STATUS type WDY_BOOLEAN default ABAP_FALSE
    returning
      value(RT_AGREEMENTS) type ZHR_DPO_DOH_T .
  methods READ_ATTACHMENT_TAB
    importing
      !IV_DPO_REQUEST type ZHR_DPO_REQUEST
      !IV_DPO_AGREEMENT type ZHR_DPO_AGREEMENT
    returning
      value(RT_ATTACHMENT_TAB) type ZHR_DPO_ATT_T .
  methods GET_HISTORY
    importing
      !IV_DPO_AGREEMENT type ZHR_DPO_AGREEMENT
    exporting
      !ET_MESSAGE type BAPIRETTAB
      !EV_RESULT type WDY_BOOLEAN
    returning
      value(RT_HISTORY_TAB) type ZHR_DPO_HISTDOH_T .
  methods SET_NEXT_STATUS
    importing
      !IV_NEXT_STATUS type ZHR_DPO_STATUS_REQ_NEXT
      !IV_CLARIFICATION type ZHR_DPO_CLARIFICATION
      !IV_ORIGIN_USER type UNAME
    returning
      value(RS_RETURN) type ZHR_DPO_AGR_RETURN_S .
  methods DELETE_AGREEMENT
    importing
      !IV_DPO_AGREEMENT type ZHR_DPO_AGREEMENT
    returning
      value(RS_RETURN) type ZHR_DPO_AGR_RETURN_S .
protected section.

  data GV_UNAME type SY-UNAME .
  data GS_DATA_DB type ZHR_DPO_DOH_S .
private section.
ENDCLASS.



CLASS ZCL_HR_DPO_AGREEMENT IMPLEMENTATION.


  METHOD check_if_can_see_agr.
    rv_can_see_agr = abap_false.
    DATA(ls_agreement) = me->get_agreement( iv_agreement = iv_agr ).
    IF ls_agreement IS NOT INITIAL AND ls_agreement-dpo_agreement = iv_agr.
      rv_can_see_agr = abap_true.
    ENDIF.
  ENDMETHOD.


  method CONSTRUCTOR.
    me->gv_uname = iv_uname.
  endmethod.


  METHOD create_and_save.
    DATA:
      lv_agr_id   TYPE zhr_dpo_agreement,
      lv_dummy    TYPE string,
      ls_agr_hist TYPE zhr_dpo_histdoh.

    IF me->gv_uname IS INITIAL.
      me->gv_uname  = zcl_pe_all_change_user=>get_uname( iv_appl_id = 'ZHR_DPO_REQUEST' ).
    ENDIF.

    CLEAR rs_agreement.
    REFRESH et_message.
    DATA(lv_req) = iv_request.
    CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT' EXPORTING input = lv_req IMPORTING output = lv_req.
*    DATA(lv_can_see_req) = zcl_hr_dpo_request_user=>get( iv_uname = me->gv_uname )->check_if_can_see_req( iv_req = lv_req ).
*    IF lv_can_see_req = abap_true.
    CALL FUNCTION 'NUMBER_GET_NEXT'
      EXPORTING
        nr_range_nr             = '01'
        object                  = 'ZHR_DPO_A'
*       QUANTITY                = '1'
*       SUBOBJECT               = ' '
*       TOYEAR                  = '0000'
*       IGNORE_BUFFER           = ' '
      IMPORTING
        number                  = lv_agr_id
*       QUANTITY                =
*       RETURNCODE              =
      EXCEPTIONS
        interval_not_found      = 1
        number_range_not_intern = 2
        object_not_found        = 3
        quantity_is_0           = 4
        quantity_is_not_1       = 5
        interval_overflow       = 6
        buffer_overflow         = 7
        OTHERS                  = 8.
    rs_agreement-dpo_agreement = lv_agr_id.
    rs_agreement-agreement_date = iv_agreement_date.
    rs_agreement-agreement_date_to = iv_agreement_date_to.
    rs_agreement-dpo_request = iv_request.
*      rs_agreement-dpo_type = zcl_hr_dpo_agreement=>gc_request.
    rs_agreement-name = iv_name.
    rs_agreement-status = gc_initial_status.
*    rs_agreement-status = iv_status.
    rs_agreement-eff_for_dep = iv_eff_for_dep.
    MOVE-CORRESPONDING rs_agreement TO gs_data_db.
    INSERT zhr_dpo_doh FROM rs_agreement.

    ls_agr_hist-dpo_agreement = lv_agr_id.
    ls_agr_hist-dpo_step = '01'.
    ls_agr_hist-datum = sy-datum.
    ls_agr_hist-time = sy-uzeit.
    ls_agr_hist-uname = sy-uname.

    ls_agr_hist-next_status = gc_initial_status..
    ls_agr_hist-role          = zcl_hr_dpo_roles=>identify_my_role(  iv_name = me->gv_uname  ).
    ls_agr_hist-orig_user = me->gv_uname.
    INSERT zhr_dpo_histdoh FROM  ls_agr_hist.
    IF sy-subrc EQ 0.
      COMMIT WORK.
    ENDIF.
*    ELSE.
    "User &1 cannot see request no &2
*      MESSAGE e001(zhr_dpo_en) WITH me->gv_uname lv_req INTO lv_dummy.
*      zcl_hr_dpo_message=>append_syst( CHANGING ct_message = et_message ).
*    ENDIF.
    ev_result = zcl_hr_dpo_message=>no_contain_error( it_message = et_message ).
  ENDMETHOD.


  METHOD delete_agreement.

    rs_return-dpo_agreement = iv_dpo_agreement.
    rs_return-return_code = 'OK'.

    DELETE FROM zhr_dpo_doh WHERE dpo_agreement = iv_dpo_agreement.
    IF sy-subrc EQ 0.
      DELETE FROM zhr_dpo_histdoh WHERE dpo_agreement = iv_dpo_agreement.
      IF sy-subrc NE 0.
        rs_return-return_code = 'FAIL'.

      ENDIF.
    ELSE.
      rs_return-return_code = 'FAIL'.
    ENDIF.

    COMMIT WORK.

  ENDMETHOD.


  method GET.
    ro_agreement = new zcl_hr_dpo_agreement( iv_uname = iv_uname ).
  endmethod.


  METHOD get_agreement.
    DATA:
      lt_agreement_range TYPE /iwbep/t_cod_select_options
    .
    CLEAR rs_agreement.
    lt_agreement_range = VALUE #( sign = 'I' option = 'EQ' ( low = iv_agreement ) ).
    DATA(lt_agreements) = me->get_agreement_list(
*      it_agreement_date_range =
      it_agreement_range      = lt_agreement_range
*      it_status_range         =
*      it_request_range        =
    ).
    READ TABLE lt_agreements INTO rs_agreement INDEX 1.
    IF sy-subrc EQ 0.
      MOVE-CORRESPONDING rs_agreement TO gs_data_db.
    ENDIF.
  ENDMETHOD.


  METHOD get_agreement_list.
    DATA:
      ls_zhr_dpo_doh TYPE zhr_dpo_doh_s,
      lv_where       TYPE string,
      lt_req_range   LIKE it_request_range,
      ls_req_range   LIKE LINE OF lt_req_range,
      lv_addwhere    TYPE string,
      r_date_from    TYPE RANGE OF sy-datum,
      r_date_to      TYPE RANGE OF sy-datum,
      lv_datum       TYPE sy-datum,
      rs_date        LIKE LINE OF r_date_from.
    .
    DATA: rs_compare_ag TYPE RANGE OF zhr_dpo_cpravast-status_num_ag,
          rs_compare_rq TYPE RANGE OF zhr_dpo_cpravast-status_num_rq.
    FIELD-SYMBOLS:
      <fs_agreement> LIKE LINE OF rt_agreements,
      <ls_req>       TYPE zhr_dpo_zad_struct
      .

    DATA(lo_request) = NEW zcl_hr_dpo_request( ).
    DATA(ls_auth_struc) = lo_request->get_authorization_structure(
      EXPORTING
        iv_uname            = gv_uname
        iv_dpo_process      = 'D-DOHODA'

    ).

    DATA(lv_role) = zcl_hr_dpo_roles=>identify_my_role(  iv_name = gv_uname  ).

    IF ls_auth_struc-agreement_disp = 'S'.
      DATA(ls_auth_field_stat) =   lo_request->check_field_stat_auth(
        EXPORTING
          iv_process = 'D-DOHODA'
          iv_role    =  lv_role
          iv_field   = 'AGREEMENT_DISP'

      ).
      rs_compare_ag = VALUE #( sign = 'I' option = ls_auth_field_stat-option_f ( low = ls_auth_field_stat-status_num_ag  ) ).
      rs_compare_rq = VALUE #( sign = 'I' option = ls_auth_field_stat-option_f ( low = ls_auth_field_stat-status_num_rq  ) ).
      DATA(lv_s_case) = abap_true.

    ENDIF.

    REFRESH rt_agreements.
    lv_addwhere = `zdd~dpo_request <> ''`.
    IF iv_load_only_non_empty_status = abap_true.
      lv_addwhere = `zdd~status <> ''`.
    ENDIF.


    IF it_agreement_date_range[] IS NOT INITIAL.
      rs_date-sign = 'I'.
      rs_date-option = 'BT'.
      LOOP AT it_agreement_date_range ASSIGNING FIELD-SYMBOL(<fs_date>).
        IF rs_date-low IS INITIAL.
          lv_datum = <fs_date>-low.
          ADD 1 TO lv_datum.
          rs_date-low  = lv_datum.
        ELSE.
          rs_date-high  = <fs_date>-low.
        ENDIF.
      ENDLOOP.
      APPEND rs_date TO r_date_from.
    ENDIF.

    IF it_agreement_date_to_range[] IS NOT INITIAL.
      rs_date-sign = 'I'.
      rs_date-option = 'BT'.
      LOOP AT it_agreement_date_to_range ASSIGNING <fs_date>.
        IF rs_date-low IS INITIAL.
          lv_datum = <fs_date>-low.
          ADD 1 TO lv_datum.
          rs_date-low  = lv_datum.
        ELSE.
          rs_date-high  = <fs_date>-low.
        ENDIF.
      ENDLOOP.
      APPEND rs_date TO r_date_to.
    ENDIF.

    "Due to rights implementation in REQUESTS - load all requests

    DATA(lt_req) = zcl_hr_dpo_request_user=>get( iv_uname = me->gv_uname )->get_requests( ).
    LOOP AT lt_req ASSIGNING <ls_req>.
      IF iv_request_full_filter IS INITIAL
        OR <ls_req>-dpo_req_full CS iv_request_full_filter
      .
        ls_req_range = VALUE #( sign = 'I' option = 'EQ' low = <ls_req>-dpo_request ).
        APPEND ls_req_range TO lt_req_range.
      ENDIF.
    ENDLOOP.


    IF lv_s_case = abap_true.
      SELECT object, status, status_num FROM zhr_dpo_cstat
                             INTO TABLE @DATA(lt_status)
                             WHERE object NE ''.


    ENDIF.
    "Load all agreements
*    IF lt_req_range IS NOT INITIAL.
      SELECT
          zdd~dpo_request,
          zdd~dpo_agreement,
          zdd~agreement_date,
          zdd~agreement_date_to,
          zdd~name,
          zdd~status,
          zdc~description AS status_descr,
          zdd~eff_for_dep
        FROM zhr_dpo_doh AS zdd
        LEFT JOIN zhr_dpo_cstatt AS zdc ON zdc~status = zdd~status
          AND zdc~object = @zcl_hr_dpo_agreement=>gc_request
          AND zdc~spras = @sy-langu
        INTO CORRESPONDING FIELDS OF TABLE @rt_agreements
        WHERE
          "requests from odata filter
          zdd~dpo_request IN @it_request_range
          "requests where user has rights to them
          AND zdd~dpo_request IN @lt_req_range
          AND zdd~dpo_agreement IN @it_agreement_range
          AND zdd~agreement_date IN @r_date_from
          AND zdd~agreement_date_to IN @r_date_to
          AND zdd~status IN @it_status_range
          AND (lv_addwhere)
      .
*    ENDIF.

    "Add Theme
    LOOP AT rt_agreements ASSIGNING <fs_agreement>.
      DATA(lv_tabix) = sy-tabix.
      IF ( iv_name_filter IS NOT INITIAL AND NOT <fs_agreement>-name CS iv_name_filter )
        OR ( iv_eff_for_dep_filter IS NOT INITIAL AND NOT <fs_agreement>-eff_for_dep CS iv_eff_for_dep_filter )
      .
        "filter by name of agreement or by eff for dep
        DELETE TABLE rt_agreements FROM <fs_agreement>.
      ELSE.
        IF lv_s_case = abap_true.
          READ TABLE lt_status ASSIGNING FIELD-SYMBOL(<fs_status>)
                           WITH KEY status = <fs_agreement>-status
                                    object = 'D'.
          IF sy-subrc EQ 0.
          IF <fs_status>-status_num NOT IN rs_compare_ag.
            DELETE rt_agreements INDEX lv_tabix.
            CONTINUE.
          ENDIF.
          ENDIF.
          READ TABLE lt_req ASSIGNING <ls_req> WITH KEY dpo_request = <fs_agreement>-dpo_request.
          IF sy-subrc EQ 0.
            READ TABLE lt_status ASSIGNING <fs_status>
                             WITH KEY status = <ls_req>-status
                                      object = 'R'.
            IF sy-subrc EQ 0.
            IF <fs_status>-status_num NOT IN rs_compare_rq.
              DELETE rt_agreements INDEX lv_tabix.
              CONTINUE.
            ENDIF.
            ENDIF.
          ENDIF.

        ENDIF.
        READ TABLE lt_req ASSIGNING <ls_req> WITH KEY dpo_request = <fs_agreement>-dpo_request.
        IF sy-subrc = 0.
          <fs_agreement>-dpo_request_full = <ls_req>-dpo_req_full.
          <fs_agreement>-theme = <ls_req>-theme.
          <fs_agreement>-theme_long = <ls_req>-theme_long.
          <fs_agreement>-template_code = <ls_req>-template_code.
          <fs_agreement>-template_desc = <ls_req>-template_desc.
          IF <fs_agreement>-status IS INITIAL.
*            <fs_agreement>-status = 'ND1'.
          ENDIF.
        ENDIF.
        IF it_templ_code_range[] IS NOT INITIAL.
          IF <fs_agreement>-template_code NOT IN it_templ_code_range.
            DELETE rt_agreements INDEX lv_tabix.
            CONTINUE.
          ENDIF.
        ENDIF.

        DATA(lt_agr_att) = me->read_attachment_tab( iv_dpo_request = <fs_agreement>-dpo_request iv_dpo_agreement = <fs_agreement>-dpo_agreement ).
        READ TABLE lt_agr_att INTO DATA(ls_agr_att) INDEX 1.
        IF sy-subrc = 0.
          <fs_agreement>-link = ls_agr_att-link.
        ENDIF.
      ENDIF.
    ENDLOOP.


    SORT rt_agreements BY dpo_request DESCENDING dpo_agreement DESCENDING.
  ENDMETHOD.


  METHOD get_history.
    DATA:
      lv_dummy TYPE string
    .
    REFRESH et_message.
    CLEAR ev_result.
    "Ma user pravo videt dohodu?
    IF me->check_if_can_see_agr( iv_agr = iv_dpo_agreement ) = abap_true.
      SELECT zdh~dpo_agreement,
          zdh~dpo_step,
          zdh~uname,
          zdh~datum,
          zdh~time,
          zdh~role,
          zdrole~description AS role_desc,
          zdh~next_status,
          zdstat~description AS next_status_desc,
          zdh~orig_user,
          zdh~clarification

        FROM zhr_dpo_histdoh AS zdh
          LEFT JOIN zhr_dpo_crolet AS zdrole ON zdrole~spras = @sy-langu AND zdrole~role = zdh~role
          LEFT JOIN zhr_dpo_cstatt AS zdstat ON zdstat~spras = @sy-langu AND zdstat~status = zdh~next_status
        INTO CORRESPONDING FIELDS OF TABLE @rt_history_tab
        WHERE zdh~dpo_agreement = @iv_dpo_agreement
      .

      IF rt_history_tab[] IS NOT INITIAL.
        SELECT role, description FROM zhr_dpo_crolet INTO TABLE @DATA(lt_role_desc)
                            FOR ALL ENTRIES IN @rt_history_tab
                            WHERE role EQ @rt_history_tab-role
                            AND spras EQ @sy-langu.
      ENDIF.

      SORT rt_history_tab BY dpo_agreement dpo_step uname.
      LOOP AT rt_history_tab ASSIGNING FIELD-SYMBOL(<fs_history_tab>).
        DATA(lv_pernr) = zcl_pa_vs_utils=>get_pernr_by_uname( iv_uname = <fs_history_tab>-uname ).
        IF lv_pernr IS NOT INITIAL.
          IF lv_pernr IS NOT INITIAL.
            DATA(ls_user_data) = zcl_hr_dpo_roles=>get_pernr_details( iv_pernr = lv_pernr  ).
            <fs_history_tab>-name_full = ls_user_data-full_name.
            CLEAR: lv_pernr, ls_user_data.
            lv_pernr = zcl_pa_vs_utils=>get_pernr_by_uname( iv_uname = <fs_history_tab>-orig_user ).
            ls_user_data = zcl_hr_dpo_roles=>get_pernr_details( iv_pernr = lv_pernr  ).
            IF ( <fs_history_tab>-name_full NE ls_user_data-full_name ) AND ls_user_data-full_name IS NOT INITIAL..
              <fs_history_tab>-name_full = |vz. { <fs_history_tab>-name_full } ( { ls_user_data-full_name } )|.
            ENDIF.

          ENDIF.
        ENDIF.
        READ TABLE lt_role_desc ASSIGNING FIELD-SYMBOL(<fs_desc>) WITH KEY role = <fs_history_tab>-role.
        IF sy-subrc EQ 0.
          <fs_history_tab>-role_desc = <fs_desc>-description.
        ENDIF.
      ENDLOOP.
    ELSE.
      MESSAGE e003(zhr_dpo_en) WITH me->gv_uname iv_dpo_agreement INTO lv_dummy.
      zcl_hr_dpo_message=>append_syst( CHANGING ct_message = et_message ).
    ENDIF.
    ev_result = zcl_hr_dpo_message=>no_contain_error( it_message = et_message ).
  ENDMETHOD.


  method READ_ATTACHMENT_TAB.

    DATA: ls_attach_line TYPE ZHR_DPO_ATT_S,
        lt_attach_tab  TYPE ZHR_DPO_ATT_T,
        lv_guid(40)        TYPE c.

    SELECT * FROM ZHR_DPO_REQ_ATT
             INTO TABLE @data(lt_attach)
             WHERE
*       dpo_request = @iv_dpo_request
                dpo_agreement =  @iv_dpo_agreement.

    IF sy-subrc EQ 0.
      LOOP AT lt_attach ASSIGNING FIELD-SYMBOL(<fs_attach>).
          MOVE-CORRESPONDING <fs_attach> TO ls_attach_line.
          lv_guid = ls_attach_line-guid.
          ls_attach_line-link = ZCL_HR_DPO_SERVICE=>get_attachment_agreement_link( iv_dpo_request = ls_attach_line-dpo_request iv_guid = lv_guid  ).
          APPEND ls_attach_line TO lt_attach_tab.
      ENDLOOP.
    ENDIF.

    rt_attachment_tab[] = lt_attach_tab[].

  endmethod.


  METHOD set_next_status.

    DATA: ls_agreement TYPE zhr_dpo_doh,
          ls_agr_hist  TYPE zhr_dpo_histdoh.

    rs_return-dpo_agreement = gs_data_db-dpo_agreement.
    SELECT MAX( dpo_step ) FROM zhr_dpo_histdoh INTO gs_data_db-dpo_step
                    WHERE dpo_agreement = gs_data_db-dpo_agreement.

    gs_data_db-uname          = sy-uname.
    gs_data_db-status         = iv_next_status.
    gs_data_db-clarification  = ls_agr_hist-clarification = iv_clarification.
    gs_data_db-dpo_step       = gs_data_db-dpo_step  + 1.
    ls_agr_hist-datum         = sy-datum.
    ls_agr_hist-time          = sy-uzeit.
    ls_agr_hist-next_status   = iv_next_status.
    ls_agr_hist-dpo_agreement = gs_data_db-dpo_agreement.
    ls_agr_hist-dpo_step      = gs_data_db-dpo_step.
    ls_agr_hist-uname         = sy-uname.
    ls_agr_hist-role          = zcl_hr_dpo_roles=>identify_my_role(  iv_name = iv_origin_user  ).
    ls_agr_hist-orig_user     = iv_origin_user.


    MOVE-CORRESPONDING gs_data_db TO ls_agreement.
    MODIFY zhr_dpo_doh FROM ls_agreement.
    MODIFY zhr_dpo_histdoh FROM ls_agr_hist.
    IF sy-subrc EQ 0.
      rs_return-return_code = 'OK'.
      COMMIT WORK.
    ELSE.
      rs_return-return_code = 'FAIL'.
    ENDIF.

  ENDMETHOD.


  METHOD update.
    DATA:
      lv_dummy  TYPE string
    .
    CLEAR rs_agreement.
    REFRESH et_message.
    DATA(lv_agr) = iv_agreement.
    CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT' EXPORTING input = lv_agr IMPORTING output = lv_agr.
    "Check if user edit agreement to which he has right
    DATA(ls_agreement_gw) = me->get_agreement( iv_agreement = lv_agr ).
    IF ls_agreement_gw IS INITIAL.
      "User &1, agreement no &2 cannot be loaded
      MESSAGE e002(zhr_dpo_en) WITH me->gv_uname lv_agr INTO lv_dummy.
      zcl_hr_dpo_message=>append_syst( CHANGING ct_message = et_message ).
    ELSE.
      SELECT SINGLE * FROM zhr_dpo_doh INTO CORRESPONDING FIELDS OF @rs_agreement WHERE dpo_agreement = @lv_agr.
      rs_agreement-agreement_date = iv_agreement_date.
      rs_agreement-agreement_date_to = iv_agreement_date_to.
      rs_agreement-name = iv_name.
      rs_agreement-eff_for_dep = iv_eff_for_dep.
      IF rs_agreement-status IS INITIAL.
       UPDATE zhr_dpo_histdoh SET next_status = gc_initial_status
                              WHERE dpo_agreement = iv_agreement.
       IF sy-subrc EQ 0.
         rs_agreement-status = gc_initial_status.
       ENDIF.
      ENDIF.
      MODIFY zhr_dpo_doh FROM rs_agreement.
      IF sy-subrc EQ 0.
        COMMIT WORK.
      ENDIF.
    ENDIF.
    ev_result = zcl_hr_dpo_message=>no_contain_error( it_message = et_message ).
  ENDMETHOD.
ENDCLASS.
