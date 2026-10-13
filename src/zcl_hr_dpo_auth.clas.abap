class ZCL_HR_DPO_AUTH definition
  public
  create public .

public section.

  constants GC_A004_SHOW_EMPS_GROUP_ORG_JE type ZHR_DPO_A004_SHOW_EMPS_GROUP value '3' ##NO_TEXT.
  constants GC_A004_SHOW_EMPS_GROUP_TAB_BP type ZHR_DPO_A004_SHOW_EMPS_GROUP value '2' ##NO_TEXT.
  constants GC_A004_SHOW_EMPS_GROUP_ALL type ZHR_DPO_A004_SHOW_EMPS_GROUP value '1' ##NO_TEXT.
  constants TYP_ZASTUPU_VSE type ZHR_DPO_DEPUTY_ACTIVITY value 'F' ##NO_TEXT.
  constants TYP_ZASTUPU_SCHVALOVANI type ZHR_DPO_DEPUTY_ACTIVITY value 'A' ##NO_TEXT.
  constants PROCESS_P_CENTR type ZHR_DPO_PROCESS value 'P-CENTR' ##NO_TEXT.
  constants PROCESS_P_DOHODA type ZHR_DPO_PROCESS value 'P-DOHODA' ##NO_TEXT.
  constants RIGHTS_X type ZHR_DPO_RIGHTS value 'X' ##NO_TEXT.

  methods GET_REQ_A004_STRUC_BY_ROLE
    importing
      !IV_REQUEST type ZHR_DPO_REQUEST
      !IV_CREATE_DATE type DATE optional
    exporting
      !EV_SHOW_ALL type FLAG
      !ET_SHOW_ONLY_PERNR type ZHR_DPO_PERSNO_T
      !ET_MESSAGE type BAPIRETTAB
      !ET_OBJEC type ZHR_DPO_OBJEC_T .
  methods GET_REQ_A004_PDF_SHOW
    exporting
      !ET_MESSAGE type BAPIRETTAB
    returning
      value(RV_VALID) type FLAG .
  class-methods GET
    importing
      !IV_UNAME type UNAME
      !IV_NACTI_VSECHNY_ZASTUPY type FLAG default ABAP_FALSE
    exporting
      !ET_MESSAGE type BAPIRETTAB
      !EV_RESULT type FLAG
    returning
      value(RO_ME) type ref to ZCL_HR_DPO_AUTH .
  methods CONSTRUCTOR
    importing
      !IV_UNAME type UNAME optional
      !IV_NACTI_VSECHNY_ZASTUPY type FLAG default ABAP_FALSE
    raising
      ZCX_HR_DPO_AUTH .
protected section.

  data GS_PRAVA type ZHR_DPO_ZASTUP .
  data GT_PRAVA_ZASTUP type ZHR_DPO_PRAVA_ZASTUP_T .
  data GT_ZASTUP type ZHR_DPO_ZASTUP_T .
  data GV_SYUNAME type UNAME .
  data GV_UNAME type UNAME .
  data GV_ZASTUP_VSE type FLAG .
  data GV_ZASTUP_JEDEN type FLAG .

  methods GET_REQ_A004_SHOW_EMPS_GROUP
    importing
      !IV_UNAME type UNAME
      !IV_REQUEST type ZHR_DPO_REQUEST
    exporting
      !ET_MESSAGE type BAPIRETTAB
    returning
      value(RV_SHOW_EMPS_GROUP) type ZHR_DPO_A004_SHOW_EMPS_GROUP .
  methods GET_AUTH_STR_CENTR .
private section.
ENDCLASS.



CLASS ZCL_HR_DPO_AUTH IMPLEMENTATION.


  METHOD constructor.
*    me->gv_syuname = sy-uname.
     me->gv_syuname = zcl_pe_all_change_user=>get_uname( iv_appl_id = 'ZHR_DPO_REQUEST' ).
    IF iv_nacti_vsechny_zastupy = abap_true.
      me->gv_uname = me->gv_syuname.
      "Nacitam vsechny zastupy
      SELECT * INTO CORRESPONDING FIELDS OF TABLE @me->gt_zastup FROM zhr_dpo_zastup
        WHERE deputy = @me->gv_syuname.
      INSERT VALUE #( deputy = me->gv_syuname creator = me->gv_syuname ) INTO TABLE me->gt_zastup.
      me->gv_zastup_vse = abap_true.
    ELSEIF me->gv_syuname <> iv_uname.
      "Zastup - kontrola, zda uzivatel ma pravo na zastup a nacteni daneho zastupu
      SELECT * INTO CORRESPONDING FIELDS OF TABLE @me->gt_zastup FROM zhr_dpo_zastup
        WHERE creator = @iv_uname
          AND deputy = @me->gv_syuname.
      IF me->gt_zastup IS INITIAL.
        "Uživatel &1 nemůže zast.už. &2
        MESSAGE e030(zhr_dpo) WITH me->gv_syuname iv_uname INTO DATA(lv_dummy).
        RAISE EXCEPTION TYPE zcx_hr_dpo_auth USING MESSAGE.
      ELSE.
        me->gv_zastup_jeden = abap_true.
        me->gv_uname = iv_uname.
      ENDIF.
    ELSE.
      INSERT VALUE #( deputy = me->gv_syuname creator = me->gv_syuname ) INTO TABLE me->gt_zastup.
      me->gv_uname = me->gv_syuname.
    ENDIF.
    me->get_auth_str_centr( ).
  ENDMETHOD.


  METHOD get.
    REFRESH et_message.
    CLEAR: ro_me, ev_result.
    TRY.
        ro_me = NEW #( iv_uname = iv_uname iv_nacti_vsechny_zastupy = iv_nacti_vsechny_zastupy ).
      CATCH zcx_hr_dpo_auth INTO DATA(lx_auth).
        "Chyba práv: &1
        MESSAGE e031(zhr_dpo) WITH lx_auth->get_text( ) INTO DATA(lv_dummy).
        zcl_hr_dpo_message=>append_syst( CHANGING ct_message = et_message ).
    ENDTRY.
    ev_result = zcl_hr_dpo_message=>no_contain_error( it_message = et_message ).
  ENDMETHOD.


  METHOD get_auth_str_centr.
    DATA: ls_prava_zastup LIKE LINE OF me->gt_prava_zastup.
    REFRESH me->gt_prava_zastup.
    LOOP AT me->gt_zastup INTO DATA(ls_zastup).
      CLEAR ls_prava_zastup.
      DATA(ls_auth) = NEW zcl_hr_dpo_request( )->get_authorization_structure(
        EXPORTING
*          iv_dpo_request      =                                 " ID žádosti
          iv_uname            = ls_zastup-creator                " Uname
          iv_dpo_process      = zcl_hr_dpo_auth=>process_p_centr " Proces
*        IMPORTING
*          et_message          =                  " Návratová tabulka
*        RECEIVING
*          rs_authority_struct =                  " Struktura oprávnení
      ).
      MOVE-CORRESPONDING ls_auth TO ls_prava_zastup.
      MOVE-CORRESPONDING ls_zastup TO ls_prava_zastup.
      INSERT ls_prava_zastup INTO TABLE me->gt_prava_zastup.
    ENDLOOP.
  ENDMETHOD.


  METHOD get_req_a004_pdf_show.
    REFRESH et_message.
    CLEAR rv_valid.
    LOOP AT me->gt_prava_zastup ASSIGNING FIELD-SYMBOL(<fs_prava_zastup>) WHERE
      ( ( activity = zcl_hr_dpo_auth=>typ_zastupu_schvalovani OR activity = zcl_hr_dpo_auth=>typ_zastupu_vse )
        OR ( deputy = me->gv_syuname AND creator = me->gv_syuname )
      )
      AND pdf4 = zcl_hr_dpo_auth=>rights_x
    .
      rv_valid = abap_true.
      EXIT.
    ENDLOOP.
    IF rv_valid = abap_false.
      IF me->gv_zastup_vse = abap_true.
        "Ani uzivatel &1 ani zastupujici uzivatele nemaji pravo videt PDF
        MESSAGE e033(zhr_dpo) WITH me->gv_syuname INTO DATA(lv_dummy).
        zcl_hr_dpo_message=>append_syst( CHANGING ct_message = et_message ).
      ELSEIF me->gv_zastup_jeden = abap_true.
        DATA(ls_zastup) = me->gt_zastup[ creator = me->gv_uname deputy = me->gv_syuname ].
        "Uživatel &1 zastupujici &2 typu &3 nemá právo videt PDF
        MESSAGE e032(zhr_dpo) WITH me->gv_syuname me->gv_uname ls_zastup-activity INTO lv_dummy.
        zcl_hr_dpo_message=>append_syst( CHANGING ct_message = et_message ).
      ELSE.
        "Uživatel &1 nemá právo videt PDF
        MESSAGE e028(zhr_dpo) WITH me->gv_syuname INTO lv_dummy.
        zcl_hr_dpo_message=>append_syst( CHANGING ct_message = et_message ).
      ENDIF.
    ENDIF.
  ENDMETHOD.


  METHOD get_req_a004_show_emps_group.
    REFRESH et_message.
    rv_show_emps_group = zcl_hr_dpo_auth=>gc_a004_show_emps_group_org_je.
    IF zcl_hr_dpo_roles=>check_admin( iv_uname = iv_uname ) = abap_true
      OR zcl_hr_dpo_roles=>check_sp( iv_uname = iv_uname ) = abap_true
      OR zcl_hr_dpo_roles=>check_manager_sp( iv_uname = iv_uname ) = abap_true
      OR zcl_hr_dpo_roles=>check_unions( iv_uname = iv_uname ) = abap_true
    .
      rv_show_emps_group = zcl_hr_dpo_auth=>gc_a004_show_emps_group_all.
    ELSEIF zcl_hr_dpo_roles=>check_hrbp( iv_uname = iv_uname ) = abap_true
      AND rv_show_emps_group >= zcl_hr_dpo_auth=>gc_a004_show_emps_group_tab_bp.
      rv_show_emps_group = zcl_hr_dpo_auth=>gc_a004_show_emps_group_tab_bp.
    ENDIF.
  ENDMETHOD.


  METHOD get_req_a004_struc_by_role.
    DATA: lt_message         TYPE bapirettab,
          lv_orgeh           TYPE orgeh,
          lt_objec           TYPE zhr_dpo_objec_t,
          lt_show_only_pernr TYPE TABLE OF persno.
    DATA(lv_datum) = sy-datum.
    IF iv_create_date IS NOT INITIAL.
      lv_datum = iv_create_date.
    ENDIF.
    ev_show_all = abap_false.
    REFRESH: et_show_only_pernr,
             et_objec,
             et_message.
    LOOP AT me->gt_zastup INTO DATA(ls_zastup).
      CLEAR lv_orgeh.
      DATA(lv_uname) = ls_zastup-creator.
      "Kontrola konzultanta
      DATA ls_zhr_dpo_rozdel TYPE zhr_dpo_rozdel.
      SELECT SINGLE *
        INTO CORRESPONDING FIELDS OF @ls_zhr_dpo_rozdel
        FROM zhr_dpo_rozdel
        WHERE dpo_request = @iv_request
          AND role = @zcl_hr_dpo_roles=>co_consult
          AND uname = @lv_uname
      .
      IF ls_zhr_dpo_rozdel-zad_uname_for_zad_next IS NOT INITIAL.
        lv_uname = ls_zhr_dpo_rozdel-zad_uname_for_zad_next.
      ENDIF.
      DATA(lv_group) = me->get_req_a004_show_emps_group(
                         EXPORTING
                           iv_uname   = lv_uname
                           iv_request = iv_request
                         IMPORTING
                           et_message = lt_message
                       ).
      APPEND LINES OF lt_message TO et_message.
      IF lv_group = me->gc_a004_show_emps_group_all.
        ev_show_all = abap_true.
      ELSEIF lv_group = me->gc_a004_show_emps_group_tab_bp.
        SELECT orgeh INTO TABLE @DATA(lt_orgeh) FROM zhr_dpo_bp WHERE hrbp = @lv_uname.
      ELSEIF lv_group = me->gc_a004_show_emps_group_org_je.
        lv_orgeh = zcl_hr_dpo_roles=>get_pernr_details(
          iv_pernr = zcl_hr_dpo_roles=>get_persno( iv_uname = lv_uname iv_datum = lv_datum )
        )-orgeh.
      ENDIF.
      IF lv_orgeh IS NOT INITIAL.
        DATA: lt_result_tab   TYPE TABLE OF swhactor,
              lt_result_objec TYPE TABLE OF objec,
              lt_result_struc TYPE TABLE OF struc.
        CALL FUNCTION 'RH_STRUC_GET'
          EXPORTING
            act_otype       = 'O'
            act_objid       = lv_orgeh
            act_wegid       = 'O-O-S-P'
*           ACT_INT_FLAG    =
            act_plvar       = '01'
            act_begda       = lv_datum
            act_endda       = lv_datum
*           ACT_TDEPTH      = 0
*           ACT_TFLAG       = 'X'
*           ACT_VFLAG       = 'X'
            authority_check = abap_false
*           TEXT_BUFFER_FILL       =
*           BUFFER_MODE     =
*         IMPORTING
*           ACT_PLVAR       =
          TABLES
            result_tab      = lt_result_tab
            result_objec    = lt_objec
            result_struc    = lt_result_struc
          EXCEPTIONS
            no_plvar_found  = 1
            no_entry_found  = 2
            OTHERS          = 3.
        IF sy-subrc <> 0.
* Implement suitable error handling here
        ENDIF.
        APPEND LINES OF lt_objec TO et_objec.
      ENDIF.
      LOOP AT lt_orgeh INTO lv_orgeh.
        CALL FUNCTION 'RH_STRUC_GET'
          EXPORTING
            act_otype       = 'O'
            act_objid       = lv_orgeh
            act_wegid       = 'O-O-S-P'
*           ACT_INT_FLAG    =
            act_plvar       = '01'
            act_begda       = lv_datum
            act_endda       = lv_datum
*           ACT_TDEPTH      = 0
*           ACT_TFLAG       = 'X'
*           ACT_VFLAG       = 'X'
            authority_check = abap_false
*           TEXT_BUFFER_FILL       =
*           BUFFER_MODE     =
*         IMPORTING
*           ACT_PLVAR       =
          TABLES
            result_tab      = lt_result_tab
            result_objec    = lt_objec
            result_struc    = lt_result_struc
          EXCEPTIONS
            no_plvar_found  = 1
            no_entry_found  = 2
            OTHERS          = 3.
        IF sy-subrc <> 0.
* Implement suitable error handling here
        ENDIF.
        APPEND LINES OF lt_objec TO et_objec.

      ENDLOOP.
      IF et_objec IS NOT INITIAL.
        lt_show_only_pernr = VALUE #( FOR ls_objec IN et_objec WHERE ( otype = 'P' ) ( ls_objec-objid ) ).
        LOOP AT lt_show_only_pernr INTO DATA(lv_pernr).
          IF NOT line_exists( et_show_only_pernr[ table_line = lv_pernr ] ).
            INSERT lv_pernr INTO TABLE et_show_only_pernr.
          ENDIF.
        ENDLOOP.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.
ENDCLASS.
