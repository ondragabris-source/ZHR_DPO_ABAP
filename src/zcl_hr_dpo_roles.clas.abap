class ZCL_HR_DPO_ROLES definition
  public
  final
  create public .

public section.

  types:
    BEGIN OF TY_S_USER_PERIOD,
      username  TYPE syuname,
      date_from TYPE datum,
      date_to   TYPE datum,
    END OF ty_s_user_period .
  types:
    TY_T_user_period TYPE TABLE OF ty_s_user_period WITH NON-UNIQUE KEY username .
  types:
    TT_DEPUTY_TAB TYPE STANDARD TABLE OF ZHR_DPO_DEPUTY_s .

  constants CO_IDVESP type ZHR_DPO_PARAMETER value 'VED_SP' ##NO_TEXT.
  constants CO_REQUESTOR type ZHR_DPO_ROLE value 'ZAD' ##NO_TEXT.
  constants CO_ADMIN type ZHR_DPO_ROLE value 'ADMIN' ##NO_TEXT.
  constants CO_HRBP type ZHR_DPO_ROLE value 'HRBP' ##NO_TEXT.
  constants CO_SP type ZHR_DPO_ROLE value 'SP' ##NO_TEXT.
  constants CO_UNION type ZHR_DPO_ROLE value 'ODBOR' ##NO_TEXT.
  constants CO_VED_SP type ZHR_DPO_ROLE value 'VED_SP' ##NO_TEXT.
  constants CO_CONSULT type ZHR_DPO_ROLE value 'KONZUL' ##NO_TEXT.
  constants CO_ZAD_NEXT type ZHR_DPO_ROLE value 'ZAD_NEXT' ##NO_TEXT.

  class-methods GET_PERSNO
    importing
      !IV_UNAME type UNAME
      !IV_DATUM type SY-DATUM default SY-DATUM
    returning
      value(RV_PERSNO) type PERSNO .
  class-methods CHECK_ADMIN
    importing
      !IV_UNAME type UNAME optional
    returning
      value(RV_RESULT) type XFELD .
  class-methods CHECK_CONSULTANT
    importing
      !IV_UNAME type UNAME
      !IV_PERNR type PERNR_D optional
    returning
      value(RV_IS_CONSULT) type XFELD .
  class-methods CHECK_HRBP
    importing
      !IV_PERNR type PERNR_D optional
      !IV_UNAME type UNAME optional
    returning
      value(RV_IS_HRBP) type XFELD .
  class-methods CHECK_MANAGER_OJ
    importing
      !IV_UNAME type UNAME optional
      !IV_PERNR type PERNR_D optional
    exporting
      !EV_ORGEH type ORGEH
    returning
      value(RV_IS_MANAGER) type XFELD .
  class-methods CHECK_MANAGER_SP
    importing
      !IV_UNAME type UNAME
    exporting
      !ET_MESSAGE type BAPIRET2_T
    returning
      value(RV_IS_SP_MANAG) type XFELD .
  class-methods CHECK_SP
    importing
      !IV_PERNR type PERNR_D optional
      !IV_UNAME type UNAME
    exporting
      !ET_MESSAGE type BAPIRET2_T
    returning
      value(RV_IS_SP) type XFELD .
  class-methods CHECK_UNIONS
    importing
      !IV_PERNR type PERNR_D optional
      !IV_UNAME type UNAME
    returning
      value(RV_IS_UNION) type XFELD .
  class-methods CREATE_DEPUTY
    importing
      !IS_ENTRY type ZHR_DPO_ZASTUP
    exporting
      !ET_MESSAGE type BAPIRET2_T
    returning
      value(RETURN_CODE) type ZHR_RETURN_OK_CODE .
  class-methods DELETE_DEPUTY
    importing
      !IV_CREATOR type UNAME
      !IV_DEPUTY type UNAME
    exporting
      !ET_MESSAGE type BAPIRET2_T
    returning
      value(RETURN_CODE) type ZHR_RETURN_OK_CODE .
  class-methods GET_CREATOR_LIST
    returning
      value(RT_DEPUTY_TAB) type ZHR_DPO_DEPUTY_T .
  class-methods GET_DEPUTY_ACTIVITY
    returning
      value(RT_ACTIVITY) type ZHR_DPO_ACTIVITY_T .
  class-methods GET_DEPUTY_LIST
    returning
      value(RT_DEPUTY_TAB) type ZHR_DPO_DEPUTY_T .
  class-methods GET_HRBP
    importing
      !IV_ORGEH type ORGEH
    returning
      value(RT_HRBP) type ZHR_DPO_ROLES_RETURN_T .
  class-methods GET_MANAGER_SP
    exporting
      !ET_MESSAGE type BAPIRET2_T
    returning
      value(RS_MANAG_SP) type ZHR_DPO_ROLES_RETURN .
  class-methods GET_ROLE_NEXT
    returning
      value(RT_NEXT_ROLES) type ZHR_DPO_ROLE_NEXT_T .
  class-methods GET_SP
    exporting
      !ET_MESSAGE type BAPIRET2_T
    returning
      value(RT_SP) type ZHR_DPO_ROLES_RETURN_T .
  class-methods GET_UNIONS
    exporting
      !ET_MESSAGE type BAPIRET2_T
    returning
      value(RT_UNIONS) type ZHR_DPO_ROLES_RETURN_T .
  class-methods IDENTIFY_MY_ROLE
    importing
      !IV_DPO_REQUEST type ZHR_DPO_REQUEST optional
      !IV_NAME type UNAME
      !IV_UNI_PROCESS type XFELD optional
    exporting
      !ET_MESSAGE type BAPIRETTAB
    returning
      value(RV_ROLE) type ZHR_DPO_ROLE .
  class-methods SEARCH_EMPLOYEE
    importing
      !IV_PERNR type PERSNO
      !IV_NAME type PAD_VORNA
      !IV_SURNAME type PAD_NACHN
      !IV_FOR_UNAME type SYUNAME
      !IV_ROLE type ZHR_DPO_ROLE
      !IV_FM_SEARCH type STRING optional
    returning
      value(RT_EMPLOYEE_RESULT) type ZPA_VS_T_GW_EMPLOYEE_RESULT .
  class-methods GET_PERNR_DETAILS
    importing
      !IV_PERNR type PERNR_D
    returning
      value(RS_CONTACT_DATA) type ZHR_DPO_PERNR_DETAIL_S .
  class-methods GET_HRBP_USERS
    importing
      !IV_USERNAME type SYUNAME
    returning
      value(RT_USER_PERIOD) type TY_T_USER_PERIOD .
  class-methods GET_UNITS_FOR_HRBP
    importing
      !IV_USERNAME type SYUNAME
    returning
      value(RT_UNIT_ID) type ZPE_ALL_TT_OBJID .
protected section.
private section.
ENDCLASS.



CLASS ZCL_HR_DPO_ROLES IMPLEMENTATION.


  method CHECK_ADMIN.

    DATA lv_name TYPE uname.
    DATA lv_usrid TYPE pa0105-usrid.
    DATA lv_pernr TYPE pernr_d.

    IF iv_uname IS NOT INITIAL.
      lv_name = iv_uname.
    ELSE.
      lv_name = sy-uname.
    ENDIF.

    SELECT COUNT(*) FROM zhr_dpo_cauth
                    WHERE uname EQ lv_name
                      AND role EQ zcl_hr_dpo_roles=>co_admin.
     IF sy-subrc EQ 0.
       rv_result = abap_true.
       RETURN.
     ENDIF.


       lv_usrid = lv_name.
        call function 'RP_GET_PERNR_FROM_USERID'
          exporting
            begda     = sy-datum
            endda     = sy-datum
            usrid     = lv_usrid
            usrty     = '0001'
          importing
            usr_pernr = lv_pernr
          exceptions
            retcd     = 1
            others    = 2.
*                .

*
        select single plans from pa0001 into @data(lv_plans)
                                       where pernr eq @lv_pernr
                                         and begda le @sy-datum
                                         and endda ge @sy-datum.

        if sy-subrc eq 0 AND lv_plans IS NOT INITIAL.
          select count( * ) from  zhr_dpo_cauth
                     where role = 'ADMIN'
                       and plans eq lv_plans.

          if sy-subrc eq 0.
            rv_result = abap_true.
          endif.

        endif.





  endmethod.


  method CHECK_CONSULTANT.

*     DATA: lv_pernr TYPE pernr_d,
*           lv_usrid TYPE P0105-USRID.
*
*    IF iv_pernr IS INITIAL.
*
*    IF iv_pernr IS INITIAL AND iv_uname IS INITIAL.
** výnimka
*    ENDIF.
*
*    SELECT COUNT( * ) FROM  ZHR_DPO_CAUTH
*                   WHERE role = 'KONSUL'
*                     AND uname EQ iv_uname.
*
*        IF sy-subrc EQ 0.
*          rv_is_consult = abap_true.
*        ENDIF.
*
*
*
*    IF iv_pernr IS INITIAL AND iv_uname IS NOT INITIAL.
*      lv_usrid = iv_uname.
*      call function 'RP_GET_PERNR_FROM_USERID'
*        exporting
*          begda           = sy-datum
*          endda           = sy-datum
*          usrid           = lv_usrid
*          usrty           = '0001'
*        IMPORTING
*          USR_PERNR       = lv_pernr
*        EXCEPTIONS
*          RETCD           = 1
*          OTHERS          = 2
*                .
*      if sy-subrc <> 0.
** Implement suitable error handling here
*      endif.
*    ELSE.
*      lv_pernr = iv_pernr.
*
*    ENDIF.
*
*      SELECT SINGLE plans FROM pa0001 INTO @DATA(lv_plans)
*                                     WHERE pernr EQ @lv_pernr
*                                       AND begda LE @sy-datum
*                                       AND endda GE @sy-datum.
*      IF sy-subrc EQ 0.
*        SELECT COUNT( * ) FROM  ZHR_DPO_CAUTH
*                   WHERE role = 'KONSUL'
*                     AND plans EQ lv_plans.
*
*        IF sy-subrc EQ 0.
          rv_is_consult = abap_true.
*        ENDIF.
*
*      ENDIF.
*
*    ENDIF.


  endmethod.


  method check_hrbp.

    data: lv_pernr type pernr_d,
          lv_usrid type p0105-usrid.

    if iv_pernr is initial.

      if iv_pernr is initial and iv_uname is initial.
* výnimka
      endif.

      if iv_pernr is initial and iv_uname is not initial.
        lv_usrid = iv_uname.
        call function 'RP_GET_PERNR_FROM_USERID'
          exporting
            begda     = sy-datum
            endda     = sy-datum
            usrid     = lv_usrid
            usrty     = '0001'
          importing
            usr_pernr = lv_pernr
          exceptions
            retcd     = 1
            others    = 2.
        if sy-subrc <> 0.
* Implement suitable error handling here
        endif.
      else.
        lv_pernr = iv_pernr.

      endif.

      select single plans from pa0001 into @data(lv_plans)
                                     where pernr eq @lv_pernr
                                       and begda le @sy-datum
                                       and endda ge @sy-datum.
      if sy-subrc eq 0 and lv_plans IS NOT INITIAL.




        select count( * ) from zhr_dpo_chrbp
                          where plans eq lv_plans.
        if sy-subrc eq 0.
          rv_is_hrbp = abap_true.
        endif.

      endif.


    endif.

  endmethod.


  METHOD check_manager_oj.

    DATA: lv_pernr TYPE pernr_d,
          lv_usrid TYPE p0105-usrid.

*    IF iv_pernr IS INITIAL.

    IF iv_pernr IS INITIAL AND iv_uname IS INITIAL.
* výnimka
    ENDIF.

    IF iv_pernr IS INITIAL AND iv_uname IS NOT INITIAL.
      lv_usrid = iv_uname.
      CALL FUNCTION 'RP_GET_PERNR_FROM_USERID'
        EXPORTING
          begda     = sy-datum
          endda     = sy-datum
          usrid     = lv_usrid
          usrty     = '0001'
        IMPORTING
          usr_pernr = lv_pernr
        EXCEPTIONS
          retcd     = 1
          OTHERS    = 2.
      .
    ELSE.
      lv_pernr = iv_pernr.

    ENDIF.

    SELECT SINGLE plans, orgeh FROM pa0001 INTO @DATA(ls_info)
                                   WHERE pernr EQ @lv_pernr
                                     AND begda LE @sy-datum
                                     AND endda GE @sy-datum.
    CONCATENATE 'S' ls_info-plans INTO DATA(lv_otjid) SEPARATED BY space.
    SELECT SINGLE sobid  FROM hrp1001 INTO @DATA(lv_sobid)
                       WHERE subty EQ 'B007'
                         AND sclas EQ 'C'
                         AND otjid EQ @lv_otjid
                         AND begda LE @sy-datum
                         AND endda GE @sy-datum
                         AND plvar = '01'
                         AND istat = '1'.
    IF sy-subrc EQ 0.
      SELECT COUNT( * ) FROM zhr_dpo_cved
                        WHERE stell EQ lv_sobid.
      IF sy-subrc EQ 0.
        rv_is_manager = abap_true.
        ev_orgeh = ls_info-orgeh.
      ENDIF.

    ENDIF.

*    ENDIF.

  ENDMETHOD.


  method check_manager_sp.


    data: lv_pernr type pernr_d,
          lv_usrid type  p0105-usrid.

    rv_is_sp_manag = abap_false.

    lv_usrid = iv_uname.
    call function 'RP_GET_PERNR_FROM_USERID'
      exporting
        begda     = sy-datum
        endda     = sy-datum
        usrid     = lv_usrid
        usrty     = '0001'
      importing
        usr_pernr = lv_pernr
      exceptions
        retcd     = 1
        others    = 2.


    select single plans, uname   from  zhr_dpo_cauth
                                 into @data(ls_auth)
                                 where role eq @co_idvesp.
    if sy-subrc eq 0.
      if ls_auth-uname eq iv_uname.
        rv_is_sp_manag = abap_true.
        return.
      endif.
      if ls_auth-plans is not initial.
        select count( * ) from pa0001
                               where plans eq ls_auth-plans
                                 and pernr eq lv_pernr
                                 and begda le sy-datum
                                 and endda ge sy-datum.
        if sy-subrc eq 0.
          rv_is_sp_manag = abap_true.
        endif.
      endif.
    endif.


  endmethod.


  method check_sp.


    data: lv_pernr type pernr_d,
          lv_usrid type p0105-usrid.

    if iv_pernr is initial.

      if iv_pernr is initial and iv_uname is initial.
* výnimka
      endif.

      select count( * ) from zhr_dpo_cauth
                        where role = 'SP'
                          and uname eq iv_uname.
      if sy-subrc eq 0.
        rv_is_sp = abap_true.
      endif.

*    SELECT COUNT( * ) FROM agr_users
*                       WHERE agr_name EQ 'Z:HRPAP_PPL_TABU_0001'
*                         AND uname = iv_uname
*                         AND from_dat LE sy-datum
*                         AND to_dat GE sy-datum.


      if iv_pernr is initial and iv_uname is not initial.
        lv_usrid = iv_uname.
        call function 'RP_GET_PERNR_FROM_USERID'
          exporting
            begda     = sy-datum
            endda     = sy-datum
            usrid     = lv_usrid
            usrty     = '0001'
          importing
            usr_pernr = lv_pernr
          exceptions
            retcd     = 1
            others    = 2.
*                .
*      if sy-subrc <> 0.
** Implement suitable error handling here
*      endif.
*    ELSE.
*      lv_pernr = iv_pernr.
*
*    ENDIF.
*
        select single plans from pa0001 into @data(lv_plans)
                                       where pernr eq @lv_pernr
                                         and begda le @sy-datum
                                         and endda ge @sy-datum.
        if sy-subrc eq 0 AND lv_plans IS NOT INITIAL.
          select count( * ) from  zhr_dpo_cauth
                     where role = 'SP'
                       and plans eq lv_plans.

          if sy-subrc eq 0.
            rv_is_sp = abap_true.
          endif.

        endif.

      endif.

    endif.
  endmethod.


  method check_unions.

    data: lv_pernr type pernr_d,
          lv_usrid type p0105-usrid.



    if iv_pernr is initial and iv_uname is initial.
* výnimka
    endif.

    if iv_pernr is initial and iv_uname is not initial.
      lv_usrid = iv_uname.
      call function 'RP_GET_PERNR_FROM_USERID'
        exporting
          begda     = sy-datum
          endda     = sy-datum
          usrid     = lv_usrid
          usrty     = '0001'
        importing
          usr_pernr = lv_pernr
        exceptions
          retcd     = 1
          others    = 2.
      if sy-subrc <> 0.
* Implement suitable error handling here
      endif.
    else.
      lv_pernr = iv_pernr.

    endif.

    select single plans from pa0001 into @data(lv_plans)
                                   where pernr eq @lv_pernr
                                     and begda le @sy-datum
                                     and endda ge @sy-datum.

    if sy-subrc eq 0 and lv_plans is not initial.
      select count( * ) from  zhr_dpo_cauth
                 where role = 'ODBOR'
                   and plans eq lv_plans.

      if sy-subrc eq 0.
        rv_is_union = abap_true.
        return.
      endif.

    endif.


    select count( * ) from  zhr_dpo_cauth
              where role = 'ODBOR'
                and uname eq iv_uname.

    if sy-subrc eq 0.
      rv_is_union = abap_true.
    endif.



  endmethod.


  method create_deputy.

    data: lv_par1    type sy-msgv1,
          ls_return  type bapiret2,
          ls_zastup  type zhr_dpo_zastup,
          lv_pernr   type pernr_d,
          lt_return  type bapiret2_t,
          ls_address type bapiaddr3,
          lv_uname   type  bapibname-bapibname.


    data(lv_adm_name) = zcl_pe_all_change_user=>get_uname( iv_appl_id = 'ZHR_DPO_REQUEST' ).


    if is_entry-activity is initial.
      call function 'BALW_BAPIRETURN_GET2'
        exporting
          type   = 'E'
          cl     = 'ZHR_DPO'
          number = '011'
*         par1   = lv_par1
        importing
          return = ls_return.

      append ls_return to et_message.
      return_code = 'FAIL'.
      return.
    endif.

    call function 'CONVERSION_EXIT_ALPHA_INPUT'
      exporting
        input  = is_entry-deputy
      importing
        output = lv_pernr.


    ls_zastup-creator = lv_adm_name.
    ls_zastup-activity = is_entry-activity.

    select single usrid from pa0105
                            into ls_zastup-deputy
                            where pernr = lv_pernr
                              and endda eq '99991231'
                              and usrty = '0001'.
    if ls_zastup-deputy is initial.

      lv_par1 = is_entry-deputy.
      call function 'BALW_BAPIRETURN_GET2'
        exporting
          type   = 'E'
          cl     = 'ZHR_DPO'
          number = '010'
          par1   = lv_par1
        importing
          return = ls_return.

      append ls_return to et_message.
      return_code = 'FAIL'.
      return.
* Pro Osobní číslo &1 nebyl nalezen uživatel

    endif.

    select count( * ) from zhr_dpo_zastup
                       where creator = ls_zastup-creator
                         and deputy  = ls_zastup-deputy.
    if sy-subrc eq 0.
      lv_uname = ls_zastup-deputy.

      lv_pernr = zcl_pa_vs_utils=>get_pernr_by_uname( iv_uname = lv_uname  ).
      if lv_pernr is not initial.
        data(ls_user_data) = zcl_hr_dpo_roles=>get_pernr_details( iv_pernr = lv_pernr  ).
        lv_par1 = ls_user_data-full_name.
        call function 'BALW_BAPIRETURN_GET2'
          exporting
            type   = 'E'
            cl     = 'ZHR_DPO'
            number = '012'
            par1   = lv_par1
          importing
            return = ls_return.

      append ls_return to et_message.
      return_code = 'FAIL'.
      return.
      ENDIF.
    endif.

    insert zhr_dpo_zastup from ls_zastup.

    if sy-subrc eq 0.
      return_code = 'OK'.
    else.
      return_code = 'FAIL'.
    endif.
  endmethod.


  method DELETE_DEPUTY.

    DATA ls_return TYPE bapiret2.

    DELETE FROM zhr_dpo_zastup WHERE creator = iv_creator
                                AND deputy  = iv_deputy.
    IF sy-subrc EQ 0.
      call function 'BALW_BAPIRETURN_GET2'
          exporting
            type   = 'S'
            cl     = 'ZHR_DPO'
            number = '013'
*            par1   = lv_par1
          importing
            return = ls_return.

        APPEND ls_return TO et_message.
       COMMIT WORK.
       return_code = 'OK'.
    ELSE.
      return_code = 'FAIL'.
    ENDIF.

  endmethod.


  method GET_CREATOR_LIST.
    data: ls_deputy type zhr_dpo_deputy_s,
          lv_name TYPE sy-uname.

    data(lt_activity) = zcl_hr_dpo_request=>get_domain_values( 'ZHR_DPO_DEPUTY_ACTIVITY'  ).

    DATA(lv_name_from_admin) = zcl_pe_all_change_user=>get_uname( iv_appl_id = 'ZHR_DPO_REQUEST' ).

    IF lv_name_from_admin IS NOT INITIAL AND lv_name_from_admin NE sy-uname.
      lv_name = lv_name_from_admin.
    ELSE.
      lv_name = sy-uname.
    ENDIF.


    select * from zhr_dpo_zastup into table @data(lt_deputy_tab)
                                 where deputy eq @lv_name.
    if sy-subrc eq 0.


      select bname, name_text from user_addrs into table @data(lt_user_name)
                              for all entries in @lt_deputy_tab
                              where bname eq @lt_deputy_tab-creator
                              and date_from LE @sy-datum.

      loop at lt_deputy_tab assigning field-symbol(<fs_deputy>).

        move-corresponding <fs_deputy> to ls_deputy.

        read table lt_activity assigning field-symbol(<fs_activity>)
                               with key domvalue_l = <fs_deputy>-activity.
        if sy-subrc eq 0.
          ls_deputy-activity_desc = <fs_activity>-ddtext.
        endif.

        read table lt_user_name assigning field-symbol(<fs_user_name>)
                                with key bname = ls_deputy-creator.

        if sy-subrc eq 0.

          ls_deputy-creator_full_name = <fs_user_name>-name_text.
        endif.

        append ls_deputy to rt_deputy_tab.

      endloop.

    endif.
  endmethod.


  method GET_DEPUTY_ACTIVITY.

    DATA: ls_activity TYPE zhr_dpo_activity_s.

    DATA(lt_values) = ZCL_HR_DPO_SERVICE=>get_domain_values( iv_name = 'ZHR_DPO_DEPUTY_ACTIVITY' ).

    LOOP AT lt_values ASSIGNING FIELD-SYMBOL(<fs_values>).
      ls_activity-activity = <fs_values>-domvalue_l.
      ls_activity-activity_desc = <fs_values>-ddtext.
      APPEND ls_activity TO rt_activity.
    ENDLOOP.

  endmethod.


  method get_deputy_list.

    data: ls_deputy type zhr_dpo_deputy_s,
          lv_uname  type sy-uname.

    data(lt_activity) = zcl_hr_dpo_request=>get_domain_values( 'ZHR_DPO_DEPUTY_ACTIVITY'  ).


    data(lv_adm_name) = zcl_pe_all_change_user=>get_uname( iv_appl_id = 'ZHR_DPO_REQUEST' ).
    if lv_adm_name is not initial.
      lv_uname = lv_adm_name.
    else.
      lv_uname = sy-uname.
    endif.

    select * from zhr_dpo_zastup into table @data(lt_deputy_tab)
                                 where creator eq @lv_uname.
    if sy-subrc eq 0.

      loop at lt_deputy_tab assigning field-symbol(<fs_deputy>).

        move-corresponding <fs_deputy> to ls_deputy.

        read table lt_activity assigning field-symbol(<fs_activity>)
                               with key domvalue_l = <fs_deputy>-activity.
        if sy-subrc eq 0.
          ls_deputy-activity_desc = <fs_activity>-ddtext.
        endif.

        data(lv_pernr) = zcl_pa_vs_utils=>get_pernr_by_uname( iv_uname = ls_deputy-deputy ).
        if lv_pernr is not initial.
          data(ls_user_data) = zcl_hr_dpo_roles=>get_pernr_details( iv_pernr = lv_pernr  ).
          ls_deputy-deputy_full_name = ls_user_data-full_name.
          clear: ls_user_data, lv_pernr.
        endif.
        CLEAR: lv_pernr, ls_user_data.
        lv_pernr = zcl_pa_vs_utils=>get_pernr_by_uname( iv_uname = ls_deputy-creator ).
        if lv_pernr is not initial.
          ls_user_data = zcl_hr_dpo_roles=>get_pernr_details( iv_pernr = lv_pernr  ).
          ls_deputy-creator_full_name  = ls_user_data-full_name.
          clear: ls_user_data, lv_pernr.
        endif.



        append ls_deputy to rt_deputy_tab.

      endloop.

    endif.







  endmethod.


  method GET_HRBP.

      TYPES: BEGIN OF t_bp,
             pernr TYPE pernr_d,
             ursid TYPE pa0105-usrid,
             END  OF t_bp.

          DATA: ls_hrbp TYPE ZHR_DPO_ROLES_RETURN.


          SELECT * FROM ZHR_DPO_BP INTO TABLE @data(lt_dpo_bp)
                                   WHERE orgeh EQ @iv_orgeh.
          IF sy-subrc EQ 0.



            LOOP AT lt_dpo_bp ASSIGNING FIELD-SYMBOL(<fs_dpo_bp>).
              ls_hrbp-uname = <fs_dpo_bp>-hrbp.

               APPEND ls_hrbp TO rt_hrbp.
            ENDLOOP.
          ELSE.
* nenašel se HRBP
          ENDIF.

  endmethod.


  method GET_HRBP_USERS.
    " kontrola jestli je uzivatel HR BP
    DATA(lv_date) = sy-datum.
    DATA(lv_pernr) = zcl_hr_dpo_roles=>get_persno( iv_uname = iv_username  iv_datum = lv_date ).
    DATA(lr_o_empl) = zcl_pe_all_md_employee_factory=>create_by_pernr( iv_pernr = lv_pernr ).

    DATA(lv_position) = lr_o_empl->get_pa_pos( ).

    SELECT pa0105~usrid, pa0001~pernr, pa0001~begda, pa0001~endda
      FROM zhr_dpo_chrbp
      INNER JOIN pa0001 ON pa0001~plans = zhr_dpo_chrbp~plans
      INNER JOIN pa0105 ON pa0105~pernr = pa0001~pernr
        AND pa0105~subty = '0001'
        AND pa0105~begda <= @sy-datum
        AND pa0105~endda >= @sy-datum
      INTO TABLE @DATA(lt_hrbp)
      WHERE zhr_dpo_chrbp~plans = @lv_position.

    LOOP AT lt_hrbp REFERENCE INTO dATA(lr_s_hrbp).
      APPEND VALUE #(   username = lr_s_hrbp->usrid
                        date_from = lr_s_hrbp->begda
                        date_to = lr_s_hrbp->endda ) TO rt_user_period.
    ENDLOOP.



  endmethod.


  method get_manager_sp.

    data lv_par1 type sy-msgv1.
    data ls_return type bapiret2.


    select single plans from  zhr_dpo_cauth
                        into @data(lv_plans)
                        where role eq @co_idvesp.
    if sy-subrc ne 0.
* ošetri
    else.
*      lv_plans = lv_value.
      select single pernr from pa0001 into @data(lv_pernr)
                                    where plans eq @lv_plans
                                      and begda le @sy-datum
                                      and endda ge @sy-datum.

        if sy-subrc eq 0.
          select single usrid from pa0105
                              into @data(lv_uname)
                              where pernr = @lv_pernr
                                and endda eq '99991231'
                                and usrty = '0001'.
          if sy-subrc eq 0.
            rs_manag_sp-pernr = lv_pernr.
            rs_manag_sp-uname = lv_uname.
          else.

          endif.
        endif.

    endif.
    if lv_uname is initial.
      lv_par1 = co_idvesp.
      call function 'BALW_BAPIRETURN_GET2'
        exporting
          type   = 'E'
          cl     = 'ZHR_DPO'
          number = '015'
          par1   = lv_par1
        importing
          return = ls_return.

      append ls_return to et_message.
    endif.

  endmethod.


  METHOD get_pernr_details.

    SELECT * FROM pa0105 INTO TABLE @DATA(lt_0105)
                               WHERE pernr = @iv_pernr
                                 AND begda LE @sy-datum
                                 AND endda GE @sy-datum.
    IF sy-subrc EQ 0.
      LOOP AT lt_0105 ASSIGNING FIELD-SYMBOL(<fs_0105>).
        CASE <fs_0105>-usrty.
          WHEN '0010'.
            rs_contact_data-email = <fs_0105>-usrid_long.
          WHEN 'CELL'.
            rs_contact_data-cell_numbr = <fs_0105>-usrid.
          WHEN '9TEL'.
            rs_contact_data-tel1_numbr = <fs_0105>-usrid.
          WHEN '9FXC'.
            rs_contact_data-fax_number = <fs_0105>-usrid.
          WHEN OTHERS.
        ENDCASE.
      ENDLOOP.
      SELECT SINGLE vorna, nachn FROM pa0002 INTO @DATA(ls_full_name)
                         WHERE pernr = @iv_pernr
                           AND begda LE @sy-datum
                           AND endda GE @sy-datum.
      IF sy-subrc EQ 0.
        SELECT SINGLE orgeh FROM pa0001 INTO @DATA(lv_orgeh)
                            WHERE pernr = @iv_pernr
                            AND begda LE @sy-datum
                            AND endda GE @sy-datum.
        IF sy-subrc EQ 0.
          SELECT SINGLE short FROM hrp1000 INTO @DATA(lv_short)
                            WHERE objid EQ @lv_orgeh
                              AND otype EQ 'O'
                              AND plvar EQ '01'
                              AND langu EQ @sy-langu
                              AND begda LE @sy-datum
                              AND endda GE @sy-datum
                              AND istat EQ '1'.



*          SELECT SINGLE short FROM hrp1000 INTO @DATA(lv_short)
*                              WHERE objid = @lv_orgeh
*                                AND otype = 'O '
*                                AND endda GE @sy-datum.
        ENDIF.
        CONCATENATE ls_full_name-vorna ls_full_name-nachn lv_short INTO rs_contact_data-full_name SEPARATED BY space.
        CONCATENATE ls_full_name-vorna ls_full_name-nachn INTO rs_contact_data-full_name_s SEPARATED BY space.
        rs_contact_data-short = lv_short.
        rs_contact_data-orgeh = lv_orgeh.

      ENDIF.
    ENDIF.



  ENDMETHOD.


  METHOD get_persno.
    CLEAR rv_persno.
    DATA: lv_pernr TYPE pernr_d.
    DATA(lv_usrid) = CONV sysid( iv_uname ).
    CALL FUNCTION 'RP_GET_PERNR_FROM_USERID'
      EXPORTING
        begda     = iv_datum
        endda     = iv_datum
        usrid     = lv_usrid
        usrty     = '0001'
      IMPORTING
        usr_pernr = lv_pernr
      EXCEPTIONS
        retcd     = 1
        OTHERS    = 2.
    rv_persno = lv_pernr.
  ENDMETHOD.


  method GET_ROLE_NEXT.

    DATA: ls_next_role TYPE ZHR_DPO_ROLE_NEXT_S.

    ls_next_role-role = 'KONZUL'.
    SELECT SINGLE description FROM ZHR_DPO_CROLET
                          INTO ls_next_role-role_descr
                          WHERE role = ls_next_role-role
                            AND spras = sy-langu.

    APPEND ls_next_role TO rt_next_roles.
    ls_next_role-role = 'ZAD_NEXT'.
    SELECT SINGLE description FROM ZHR_DPO_CROLET
                          INTO ls_next_role-role_descr
                          WHERE role = ls_next_role-role
                            AND spras = sy-langu.
    APPEND ls_next_role TO rt_next_roles.

  endmethod.


  method get_sp.

    data: ls_sp     type zhr_dpo_roles_return,
          lv_par1   type sy-msgv1,
          ls_return type bapiret2,
          lv_usrid  type  P0105-USRID,
          lv_pernr  type pernr_d.

*    SELECT COUNT( * ) FROM AGR_USERS

*   SELECT  *  FROM agr_users INTO TABLE @DATA(lt_sp)
*                       WHERE agr_name EQ 'Z:HRPAP_PPL_TABU_0001'
*                         AND from_dat LE @sy-datum
*                         AND to_dat GE @sy-datum.

    select * from  zhr_dpo_cauth into table @data(lt_sp)
                   where role = 'SP'.
    if sy-subrc eq 0.
      loop at lt_sp assigning field-symbol(<fs_sp>) where uname is not initial.
        ls_sp-uname = <fs_sp>-uname.
        lv_usrid = ls_sp-uname .

        call function 'RP_GET_PERNR_FROM_USERID'
          exporting
            begda     = sy-datum
            endda     = sy-datum
            usrid     = lv_usrid
            usrty     = '0001'
          importing
            usr_pernr = lv_pernr
          exceptions
            retcd     = 1
            others    = 2.

        ls_sp-pernr =   lv_pernr.

        append ls_sp to rt_sp.
      endloop.
      select * from pa0001 into table @data(lt_pa0001)
                    for all entries in @lt_sp
                    where plans eq @lt_sp-plans
                      and begda le @sy-datum
                      and endda ge @sy-datum
                      and plans NE '00000000'.
      if sy-subrc eq 0.
        select pernr, usrid from pa0105 into table @data(lt_names)
                     for all entries in @lt_pa0001
                     where pernr eq @lt_pa0001-pernr
                       and usrty eq '0001'
                       and begda le @sy-datum
                       and endda ge @sy-datum.
        if sy-subrc eq 0.
          loop at lt_names assigning field-symbol(<fs_names>).
            ls_sp-pernr = <fs_names>-pernr.
            ls_sp-uname = <fs_names>-usrid.
            append ls_sp to rt_sp.
          endloop.
        endif.
      endif.
    endif.
    if rt_sp[] is initial.

      lv_par1 = 'SP'.
      call function 'BALW_BAPIRETURN_GET2'
        exporting
          type   = 'E'
          cl     = 'ZHR_DPO'
          number = '015'
          par1   = lv_par1
        importing
          return = ls_return.

      append ls_return to et_message.

    endif.

  endmethod.


  METHOD get_unions.
    DATA: ls_sp     TYPE zhr_dpo_roles_return,
          lv_par1   TYPE sy-msgv1,
          ls_return TYPE bapiret2,
          lv_pernr  TYPE pernr_d,
          lv_usrid  TYPE pa0105-usrid.



    SELECT * FROM  zhr_dpo_cauth INTO TABLE @DATA(lt_sp)
                   WHERE role = 'ODBOR'.
    IF sy-subrc EQ 0.
      LOOP AT lt_sp ASSIGNING FIELD-SYMBOL(<fs_sp>) WHERE uname IS NOT INITIAL.
        ls_sp-uname = <fs_sp>-uname.
        lv_usrid = ls_sp-uname .

        CALL FUNCTION 'RP_GET_PERNR_FROM_USERID'
          EXPORTING
            begda     = sy-datum
            endda     = sy-datum
            usrid     = lv_usrid
            usrty     = '0001'
          IMPORTING
            usr_pernr = lv_pernr
          EXCEPTIONS
            retcd     = 1
            OTHERS    = 2.

        ls_sp-pernr =   lv_pernr.
        APPEND ls_sp TO rt_unions.
      ENDLOOP.
      DELETE lt_sp WHERE plans IS INITIAL.

      IF lt_sp[] IS NOT INITIAL.
        SELECT * FROM pa0001 INTO TABLE @DATA(lt_pa0001)
                      FOR ALL ENTRIES IN @lt_sp
                      WHERE plans EQ @lt_sp-plans
                        AND begda LE @sy-datum
                        AND endda GE @sy-datum.
        IF sy-subrc EQ 0.
          SELECT pernr, usrid FROM pa0105 INTO TABLE @DATA(lt_names)
                       FOR ALL ENTRIES IN @lt_pa0001
                       WHERE pernr EQ @lt_pa0001-pernr
                         AND usrty EQ '0001'
                         AND begda LE @sy-datum
                         AND endda GE @sy-datum.
          IF sy-subrc EQ 0.
            LOOP AT lt_names ASSIGNING FIELD-SYMBOL(<fs_names>).
              ls_sp-pernr = <fs_names>-pernr.
              ls_sp-uname = <fs_names>-usrid.
              APPEND ls_sp TO rt_unions.
            ENDLOOP.
          ENDIF.
        ENDIF.
      ENDIF.
    ENDIF.
    IF rt_unions[] IS INITIAL.

      lv_par1 = 'SP'.
      CALL FUNCTION 'BALW_BAPIRETURN_GET2'
        EXPORTING
          type   = 'E'
          cl     = 'ZHR_DPO'
          number = '015'
          par1   = lv_par1
        IMPORTING
          return = ls_return.

      APPEND ls_return TO et_message.

    ENDIF.

  ENDMETHOD.


  method GET_UNITS_FOR_HRBP.

    DAta: lt_struc TYPE TABLE OF  STRUC.

    SELECT  *
        INTO TABLE @DATA(lt_bp)
        FROM zhr_dpo_bp
        WHERE HRBP = @iv_username.

    LOOP AT lt_bp REFERENCE INTO DATA(lr_s_bp).
      DATA(lv_objid_o) = lr_s_bp->orgeh.
      dATA(lv_sub) = lr_s_bp->incl_subord.


      IF lv_sub = abap_true.

        CLEAR lt_struc.

        CALL FUNCTION 'RH_STRUC_GET'
          EXPORTING
            act_otype       = 'O'
            act_objid       = lv_objid_o
            act_wegid       = 'O-O_DOWN'
            authority_check = ' '
          TABLES
            result_struc    = lt_struc
          EXCEPTIONS
            no_plvar_found  = 1
            no_entry_found  = 2
            OTHERS          = 3.

        IF lt_struc[] IS NOT INITIAL.

          LOOP AT lt_struc REFERENCE INTO DATA(lr_s_struc).
            APPEND lr_s_struc->objid TO rt_unit_id.
          ENDLOOP.
        ENDIF.
      ELSE.
        APPEND lv_objid_o TO rt_unit_id.
      ENDIF.
    ENDLOOP.

    SORT rt_unit_id.
    DELETE ADJACENT DUPLICATES FROM rt_unit_id.
  endmethod.


  METHOD identify_my_role.

*    if iv_dpo_request is not initial.
*      select count( * ) from zhr_dpo_hist where dpo_request = iv_dpo_request
*                                            and before_save = ''.
*      if sy-subrc eq 0.
*        data(lv_hist) = abap_true.
*      endif.
*    endif.


    IF iv_name IS INITIAL.
      DATA(lv_name) = sy-uname.
    ELSE.
      lv_name = iv_name.
    ENDIF.
* když žádost neexistuje...
    IF iv_uni_process IS INITIAL AND iv_dpo_request IS INITIAL ."or lv_hist = abap_false.

      IF  zcl_hr_dpo_roles=>check_admin( iv_uname = lv_name ) = abap_true.
        " jsem admin?
        rv_role = zcl_hr_dpo_roles=>co_admin.


      ELSEIF  zcl_hr_dpo_roles=>check_manager_sp( iv_uname = lv_name ) = abap_true.
        "  jsem vedoucí SP?
        rv_role = zcl_hr_dpo_roles=>co_ved_sp.
      ELSEIF  zcl_hr_dpo_roles=>check_sp( iv_uname = lv_name ) = abap_true.
        " jsem SP
        rv_role = zcl_hr_dpo_roles=>co_sp.

      ELSEIF  zcl_hr_dpo_roles=>check_unions( iv_uname = lv_name ) = abap_true.
        " jsem odborář?

        rv_role = zcl_hr_dpo_roles=>co_union.

      ELSEIF  zcl_hr_dpo_roles=>check_hrbp( iv_uname = lv_name ) = abap_true.
        " jsem hrbp?

        rv_role = zcl_hr_dpo_roles=>co_hrbp.

      ELSEIF  zcl_hr_dpo_roles=>check_manager_oj( iv_uname = lv_name ) = abap_true.

        " jsem vedoucí  OJ?

        rv_role = zcl_hr_dpo_roles=>co_requestor.

      ELSEIF  zcl_hr_dpo_roles=>check_consultant( iv_uname = lv_name ) = abap_true.

        " jsem Konzultant
        rv_role = zcl_hr_dpo_roles=>co_consult.
      ENDIF.

    ELSE.
      SELECT * FROM zhr_dpo_hist INTO TABLE @DATA(lt_hist)
                                  WHERE dpo_request = @iv_dpo_request.
      SORT lt_hist BY dpo_request dpo_step DESCENDING.
      READ TABLE lt_hist ASSIGNING FIELD-SYMBOL(<fs_hist>) INDEX 1.

      SELECT  role FROM zhr_dpo_rozdel
                         INTO TABLE @DATA(lt_role)
                         WHERE dpo_request = @iv_dpo_request
                           AND uname = @lv_name.
      IF lt_role[] IS NOT INITIAL.
        IF lines( lt_role ) = 1.
          READ TABLE lt_role INTO rv_role INDEX 1.
        ELSE.

          CASE <fs_hist>-next_status.
            WHEN 'ROJ'.
              READ TABLE  lt_role INTO rv_role WITH KEY role = 'ZAD'.
            WHEN 'RAOJ'.
              READ TABLE  lt_role INTO rv_role WITH KEY role = 'ZAD'.
              IF sy-subrc NE 0.
                READ TABLE  lt_role INTO rv_role WITH KEY role = 'ZAD_NEXT'.
              ENDIF.
            WHEN 'RHRPB'.
              READ TABLE  lt_role INTO rv_role WITH KEY role = 'HRBP'.
              IF sy-subrc NE 0.
                READ TABLE  lt_role INTO rv_role WITH KEY role = 'HRBP_NEXT'.
              ENDIF.
            WHEN 'RSP'.
              READ TABLE  lt_role INTO rv_role WITH KEY role = 'SP'.
            WHEN OTHERS.
              READ TABLE lt_role INTO rv_role INDEX 1.
          ENDCASE.

*          IF  NEW zcl_hr_dpo_request( )->status_exists_in_history( iv_dpo_request  =  iv_dpo_request
*                                                              iv_status       = 'ZHP' ).
*
*          ENDIF.

        ENDIF.

      ENDIF.
      IF rv_role IS INITIAL.
        rv_role = zcl_hr_dpo_roles=>identify_my_role(  iv_name = lv_name   ).
      ENDIF.
    ENDIF.
  ENDMETHOD.


  METHOD search_employee.

    DATA: lv_name_mc       TYPE string,
          lv_surname_mc    TYPE string,
          lv_sql           TYPE stringval,
          lv_date          TYPE datum,
          lv_pernr_objid_o TYPE hrobjid,
          lv_for_pernr     TYPE persno,
          lv_persk         TYPE persk,
          ls_result        TYPE zpa_vs_s_gw_employee_result,
          lt_sql           TYPE TABLE OF stringval,
          lt_pa0002        TYPE TABLE OF pa0002,
          lt_pernr         TYPE TABLE OF persno,
          lt_o_empl        TYPE zpe_all_md_tt_employee_obj,
          lt_rng_persk     TYPE RANGE OF persk.

    FIELD-SYMBOLS: <ls_pa0002>       TYPE pa0002,
                   <ls_result>       TYPE zpa_vs_s_gw_employee_result,
                   <ls_root_objects> TYPE hrrootob,
                   <ls_o_root_units> TYPE zpe_all_md_s_hrobj_o_obj,
                   <ls_o_empl>       TYPE zpe_all_md_s_employee_obj.


*    if iv_role eq 'ZAD_NEXT'.
*    SELECT * FROM zhr_dpo_cved INTO TABLE @DATA(lt_ved)
*                                    WHERE stell NE ''.
*    IF sy-subrc EQ 0.
*       SELECT pernr, stell FROM pa0001 INTO TABLE  @DATA(lt_info)
*                                     FOR ALL ENTRIES IN @lt_ved
*                                     WHERE stell EQ @lt_ved-stell
*                                       AND begda LE @sy-datum
*                                       AND endda GE @sy-datum.
*         IF sy-subrc EQ 0.
*            APPEND 'pernr = lt_info-pernr' TO lt_sql.
*         ENDIF.
*    ENDIF.
*    endif.


    lv_date = zcl_pe_all_settings=>gv_current_date.

    lv_for_pernr = zcl_pa_vs_utils=>get_pernr_by_uname( iv_uname = iv_for_uname ).

    lt_rng_persk = VALUE #( ( sign = 'I' option = 'BT' low = '11' high = '40' ) ).

*  IF lv_for_pernr IS NOT INITIAL.

    IF iv_pernr IS NOT INITIAL.
      APPEND 'pernr = iv_pernr' TO lt_sql.
*    elseif lv_for_pernr is not initial.
*      append 'pernr = lv_for_pernr' to lt_sql.
    ENDIF.


    IF iv_name IS NOT INITIAL.
      CLEAR lv_name_mc.

      lv_name_mc = iv_name.
      REPLACE ALL OCCURRENCES OF '*' IN lv_name_mc WITH '%'.
      REPLACE ALL OCCURRENCES OF '?' IN lv_name_mc WITH '_'.

      TRANSLATE lv_name_mc TO UPPER CASE.
*      APPEND '( vnamc LIKE lv_name_mc or nchmc LIKE lv_surname_mc )' TO lt_sql.
    ENDIF.

    IF iv_surname IS NOT INITIAL.
      CLEAR lv_surname_mc.

      lv_surname_mc = iv_surname.

      REPLACE ALL OCCURRENCES OF '*' IN lv_surname_mc WITH '%'.
      REPLACE ALL OCCURRENCES OF '?' IN lv_surname_mc WITH '_'.



      TRANSLATE lv_surname_mc TO UPPER CASE.
*      APPEND 'nchmc LIKE lv_surname_mc' TO lt_sql.
      DATA: lv_name1 TYPE text50,
            lv_name2 TYPE text50.
      SPLIT lv_name_mc AT ' ' INTO lv_name1 lv_name2.
      IF lv_name2 IS INITIAL.
        APPEND '( vnamc LIKE lv_name_mc or nchmc LIKE lv_surname_mc )' TO lt_sql.
      ELSE.
        lv_name1 = lv_name1 && '%'.
        lv_name2 = '%' && lv_name2.
        APPEND '( vnamc LIKE lv_name1 or nchmc LIKE lv_name1 OR  vnamc LIKE lv_name2 or nchmc LIKE lv_name2 )' TO lt_sql.
      ENDIF.
    ENDIF.

    IF lines( lt_sql ) > 0.

      APPEND 'begda <= lv_date' TO lt_sql.
      APPEND 'endda >= lv_date' TO lt_sql.

      CONCATENATE LINES OF lt_sql INTO lv_sql SEPARATED BY ' AND '.


      SELECT pernr nachn vorna nchmc vnamc
        INTO CORRESPONDING FIELDS OF TABLE lt_pa0002
        FROM pa0002
        WHERE (lv_sql).
    ENDIF.

    DELETE lt_pa0002 WHERE pernr = lv_for_pernr.
    IF lines( lt_pa0002 ) > 0.
      LOOP AT lt_pa0002 ASSIGNING <ls_pa0002>.
        APPEND <ls_pa0002>-pernr TO lt_pernr.
      ENDLOOP.
    ENDIF.

    SORT lt_pernr.
    DELETE ADJACENT DUPLICATES FROM lt_pernr.

    "Hledani podle FM
    IF iv_fm_search IS NOT INITIAL.
      DATA(lv_fm) = iv_fm_search.
      REPLACE ALL OCCURRENCES OF '*' IN lv_fm WITH '%'.
      REPLACE ALL OCCURRENCES OF '?' IN lv_fm WITH '_'.
      SELECT pernr FROM pa0001 INTO @DATA(ls_pernr_by_fm) WHERE
        plans LIKE @lv_fm
        AND begda <= @zcl_pe_all_settings=>gv_current_date
        AND endda >= @zcl_pe_all_settings=>gv_current_date
      .
        APPEND ls_pernr_by_fm TO lt_pernr.
      ENDSELECT.
    ENDIF.

    IF lines( lt_pernr ) > 0.
      lt_o_empl = zcl_pe_all_md_employee_factory=>create_by_pernr_list( it_pernr = lt_pernr ).
    ENDIF.

    IF lines( lt_o_empl ) > 0.
      LOOP AT lt_o_empl ASSIGNING <ls_o_empl>.
        IF <ls_o_empl>-r_o_employee IS BOUND.
          IF <ls_o_empl>-r_o_employee->get_stat1( ) = '0'.

            CLEAR lv_persk.
            lv_persk = <ls_o_empl>-r_o_employee->get_persk( ).

            IF lv_persk IN lt_rng_persk.
              IF   iv_role EQ 'ZAD_NEXT'.
                IF  zcl_hr_dpo_roles=>check_manager_oj( iv_pernr = <ls_o_empl>-r_o_employee->get_pernr( ) ) = abap_true.
                  APPEND INITIAL LINE TO rt_employee_result ASSIGNING <ls_result>.
                  <ls_result>-pernr = <ls_o_empl>-r_o_employee->get_pernr( ).
                  <ls_result>-fullname = zcl_pa_vs_utils=>format_fullname( ir_o_empl = <ls_o_empl>-r_o_employee ).
                  <ls_result>-surname =  <ls_o_empl>-r_o_employee->get_surname( ).
                  <ls_result>-plans =  <ls_o_empl>-r_o_employee->get_plans( ).
                  TRANSLATE <ls_result>-surname TO UPPER CASE.
                  TRANSLATE <ls_result>-name TO UPPER CASE.
                  <ls_result>-name =  <ls_o_empl>-r_o_employee->get_name( ).
                  IF <ls_o_empl>-r_o_employee->get_om_unit( ) IS BOUND.
                    <ls_result>-unit_short = <ls_o_empl>-r_o_employee->get_om_unit( )->get_short( ).
                  ENDIF.
                ENDIF.
              ELSE.
                APPEND INITIAL LINE TO rt_employee_result ASSIGNING <ls_result>.
                <ls_result>-pernr = <ls_o_empl>-r_o_employee->get_pernr( ).
                <ls_result>-fullname = zcl_pa_vs_utils=>format_fullname( ir_o_empl = <ls_o_empl>-r_o_employee ).
                <ls_result>-surname =  <ls_o_empl>-r_o_employee->get_surname( ).
                <ls_result>-name =  <ls_o_empl>-r_o_employee->get_name( ).
                <ls_result>-plans =  <ls_o_empl>-r_o_employee->get_plans( ).
                TRANSLATE <ls_result>-surname TO UPPER CASE.
                TRANSLATE <ls_result>-name TO UPPER CASE..
                IF <ls_o_empl>-r_o_employee->get_om_unit( ) IS BOUND.
                  <ls_result>-unit_short = <ls_o_empl>-r_o_employee->get_om_unit( )->get_short( ).
                ENDIF.
              ENDIF.

            ENDIF.
          ENDIF.
        ENDIF.
      ENDLOOP.
    ENDIF.
    SORT rt_employee_result BY surname name unit_short.
    IF lv_name2 IS NOT INITIAL.
      DATA(lt_result) = rt_employee_result[].
      REPLACE ALL OCCURRENCES OF '%' IN lv_name1 WITH ''.
      REPLACE ALL OCCURRENCES OF '%' IN lv_name2 WITH ''.
      READ TABLE rt_employee_result INTO ls_result WITH KEY surname = lv_name2
                                          name = lv_name1.
      IF sy-subrc EQ 0.
        REFRESH rt_employee_result.
        LOOP AT lt_result INTO ls_result WHERE surname = lv_name2
                                           AND name = lv_name1.
          APPEND ls_result TO rt_employee_result.
        ENDLOOP.
        RETURN.
      ENDIF.
      READ TABLE rt_employee_result INTO ls_result WITH KEY surname = lv_name1
                                          name = lv_name2.
      IF sy-subrc EQ 0.
        REFRESH rt_employee_result.
        LOOP AT lt_result INTO ls_result WHERE surname = lv_name1
                                           AND name = lv_name2.
          APPEND ls_result TO rt_employee_result.
        ENDLOOP.
      ENDIF.

      .


    ENDIF.


  ENDMETHOD.
ENDCLASS.
