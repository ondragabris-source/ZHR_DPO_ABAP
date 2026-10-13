class ZCL_HR_DPO_A004 definition
  public
  create public .

public section.

  methods GET_UNAME
    returning
      value(RV_UNAME) type SY-UNAME .
  class-methods GET_EMP_SENIOR
    importing
      !IV_DATE type DATE
      !IV_PERNR type PERSNO
    returning
      value(RV_SENIOR) type ZHR_DPO_SENIOR .
  methods GET_COMPLETE
    returning
      value(RV_COMPLETED) type ZHR_DPO_A004_VALID .
  methods GET_EXT_EDIT
    returning
      value(RV_EXT_EDIT) type ZHR_DPO_A004_EXT_EDIT .
  methods DELETE_ITEM
    importing
      !IV_ATTACH_ITEM_TYPE type ZHR_DPO_A004IT
      !IV_ATTACHEMENT_ITEM type ZHR_DPO_ATTACHEMENT_ITEM
      !IV_PERNR type PERNR_D optional
      !IV_VERSION type VERSION
    exporting
      !ET_MESSAGE type BAPIRETTAB .
  methods GET_ITEM
    importing
      !IV_ATTACH_ITEM_TYPE type ZHR_DPO_A004IT
      !IV_ATTACHEMENT_ITEM type ZHR_DPO_ATTACHEMENT_ITEM
      !IV_UNAME type SY-UNAME
      !IV_PERNR type PERNR_D
      !IV_VERSION type VERSION
    exporting
      !ET_MESSAGE type BAPIRETTAB
    returning
      value(RS_ITEM) type ZHR_DPO_A004_I_EXT_GW_S .
  methods GET_ITEMS
    importing
      !IV_ATTACH_ITEM_TYPE type ZHR_DPO_A004IT optional
      !IV_DPO_ATTACHEMENT_ITEM type ZHR_DPO_ATTACHEMENT_ITEM optional
      !IV_UNAME type SY-UNAME
      !IV_VSECHNY_ZASTUPY type FLAG default ABAP_FALSE
      !IV_PDF_STREAM type XFELD optional
      !IV_PERNR type PERNR_D optional
      !IV_VERSION type VERSION
    exporting
      !ET_MESSAGE type BAPIRETTAB
    returning
      value(RT_ITEMS) type ZHR_DPO_A004_I_EXT_GW_T .
  methods GET_EMP_DETAIL
    importing
      !IV_PERNR type ZHR_DPO_PERNR
      !IV_LANGU type SY-LANGU default SY-LANGU
    returning
      value(RS_EMP_DETAIL) type ZHR_DPO_A004_FM_EXT_S .
  methods ADD_UPDATE_ITEM
    importing
      !IV_ITEM_TYPE type ZHR_DPO_A004IT
      !IV_ATTACHEMENT_ITEM type ZHR_DPO_ATTACHEMENT_ITEM optional
      !IS_A004_I_ITEM type ZHR_DPO_A004_I_ITEM_S
      !IV_PERNR type PERNR_D optional
    exporting
      !ET_MESSAGE type BAPIRETTAB
      !EV_RESULT type BOOLEAN
    returning
      value(RS_A004_I) type ZHR_DPO_A004_I .
  methods GET_DATA
    exporting
      !ET_MESSAGE type BAPIRETTAB
    returning
      value(RS_A004) type ZHR_DPO_A004 .
  methods GET_PDF
    importing
      !IV_UNAME type SY-UNAME
      !IV_VSECHNY_ZASTUPY type FLAG default ABAP_FALSE
    exporting
      !ET_MESSAGE type BAPIRETTAB
    returning
      value(RX_CONTENT) type XSTRING .
  class-methods ADD_OR_GET
    importing
      !IV_REQUEST type ZHR_DPO_REQUEST
      !IV_UNAME type SY-UNAME optional
    returning
      value(RO_ME) type ref to ZCL_HR_DPO_A004 .
  methods CONSTRUCTOR
    importing
      !IV_REQUEST type ZHR_DPO_REQUEST
      !IV_UNAME type SY-UNAME optional .
protected section.

  data GS_ZAD type ZHR_DPO_ZAD .
  data GS_A004 type ZHR_DPO_A004 .
  data GT_MESSAGE type BAPIRETTAB .
  data GV_RESULT type BOOLEAN .
  data GV_UNAME type SY-UNAME .

  methods GENERATE_A004_I_ID
    importing
      !IV_ITEM_TYPE type ZHR_DPO_A004IT
    returning
      value(RV_ATTACHEMENT_ITEM) type ZHR_DPO_ATTACHEMENT_ITEM .
private section.
ENDCLASS.



CLASS ZCL_HR_DPO_A004 IMPLEMENTATION.


  METHOD add_or_get.
    ro_me = NEW #( iv_request = iv_request iv_uname = iv_uname ).
  ENDMETHOD.


  METHOD add_update_item.
    DATA: lv_dummy TYPE string.
    CLEAR: rs_a004_i.
    DATA(lv_attachement_item) = iv_attachement_item.
    SELECT SINGLE * FROM zhr_dpo_ca004it INTO @DATA(ls_zhr_dpo_ca004it) WHERE a004it = @iv_item_type.
    IF ls_zhr_dpo_ca004it IS INITIAL.
      "Nenalezen typ polozky &1 pro prilohu A004
      MESSAGE e022(zhr_dpo) WITH iv_item_type INTO lv_dummy.
      zcl_hr_dpo_message=>append_syst( CHANGING ct_message = et_message ).
    ENDIF.
    IF me->gv_result <> abap_true.
      APPEND LINES OF me->gt_message TO et_message.
    ELSE.
      IF lv_attachement_item IS NOT INITIAL.
        SELECT SINGLE * INTO CORRESPONDING FIELDS OF @rs_a004_i FROM zhr_dpo_a004_i
          WHERE dpo_request = @me->gs_a004-dpo_request
            AND dpo_attachement_item = @lv_attachement_item
            AND attach_item_type = @iv_item_type
            AND pernr            = @is_a004_i_item-pernr.
        IF sy-subrc NE 0.
          SELECT SINGLE * INTO CORRESPONDING FIELDS OF @rs_a004_i FROM zhr_dpo_a004_i
          WHERE dpo_request = @me->gs_a004-dpo_request
*            AND dpo_attachement_item = @lv_attachement_item
            AND pernr = @is_a004_i_item-pernr.
*            AND attach_item_type = @iv_item_type.


          IF sy-subrc NE 0.
            SELECT SINGLE * INTO CORRESPONDING FIELDS OF @rs_a004_i FROM zhr_dpo_a004_i
              WHERE dpo_request = @me->gs_a004-dpo_request
                AND dpo_attachement_item = @lv_attachement_item
                AND attach_item_type = @iv_item_type.
*            AND pernr            = @is_a004_i_item-pernr.
          ENDIF.
        ENDIF.
        .
        DATA(ls_a004_i_orig) = rs_a004_i.
        IF rs_a004_i IS INITIAL.
          "Nelze načíst A004 položka id &1, attachment &2, type &3
          MESSAGE e019(zhr_dpo) WITH lv_attachement_item me->gs_a004-dpo_request iv_item_type INTO lv_dummy.
          zcl_hr_dpo_message=>append_syst( CHANGING ct_message = et_message ).
        ENDIF.
      ELSE.
        rs_a004_i-dpo_request = me->gs_a004-dpo_request.
        rs_a004_i-dpo_attachement_item = me->generate_a004_i_id( iv_item_type = iv_item_type ).
        rs_a004_i-attach_item_type = iv_item_type.
      ENDIF.
      IF rs_a004_i IS NOT INITIAL.
        MOVE-CORRESPONDING is_a004_i_item TO rs_a004_i.
        "Docasne zrusena podminka, musi byt lepe definovano
        IF ( 1 = 2 ) AND ( me->get_ext_edit( ) = abap_false
            AND ( rs_a004_i-termin_zruseni <> ls_a004_i_orig-termin_zruseni
              OR rs_a004_i-reseni_navrh <> ls_a004_i_orig-reseni_navrh
              OR rs_a004_i-cinnosti <> ls_a004_i_orig-cinnosti
              OR rs_a004_i-procent <> ls_a004_i_orig-procent
              OR rs_a004_i-opatreni <> ls_a004_i_orig-opatreni
              OR rs_a004_i-opatreni_detail <> ls_a004_i_orig-opatreni_detail
            ) ).
          "Stav žádosti č.&1 jiný, než: ROJ, RDO, RAOJ neumožňuje editaci rozš. polí
          MESSAGE e027(zhr_dpo) WITH me->gs_a004-dpo_request INTO lv_dummy.
          zcl_hr_dpo_message=>append_syst( CHANGING ct_message = et_message ).
        ELSE.
          IF iv_item_type NE rs_a004_i-attach_item_type.
            rs_a004_i-attach_item_type =  iv_item_type.
            rs_a004_i-dpo_attachement_item = me->generate_a004_i_id( iv_item_type = iv_item_type ).
            DELETE FROM zhr_dpo_a004_i WHERE dpo_request = ls_a004_i_orig-dpo_request
                                       AND dpo_attachement_item = ls_a004_i_orig-dpo_attachement_item
                                       AND attach_item_type = ls_a004_i_orig-attach_item_type.
          ENDIF.


          IF NEW zcl_hr_dpo_request( )->status_exists_in_history( iv_dpo_request  =  rs_a004_i-dpo_request
                                                                  iv_status       = 'ZHP' ).

            DATA(lv_not_yet_approved) = abap_true.

            SELECT MAX( version )   FROM  zhr_dpo_a004
                                    WHERE dpo_request      = @rs_a004_i-dpo_request
                                      AND not_yet_approved = @abap_false
                                      INTO @DATA(lv_version_appr).
            IF sy-subrc EQ 0.
              DATA(lv_version) = lv_version_appr + 1.
              rs_a004_i-version = lv_version.

              SELECT COUNT( * ) FROM zhr_dpo_a004_i
                            WHERE
                              dpo_request      = @rs_a004_i-dpo_request AND
                              version          = @lv_version.
              IF sy-subrc NE 0. "nova verze ešte neni v DB, založ ji

                SELECT * FROM zhr_dpo_a004_i
                              WHERE
                                dpo_request      = @rs_a004_i-dpo_request AND
                                version          = @lv_version_appr
                         INTO TABLE @DATA(lt_a004_i).
                IF sy-subrc EQ 0.

                  LOOP AT lt_a004_i INTO DATA(ls_a004_i).
                    ls_a004_i-version = lv_version.
                    INSERT zhr_dpo_a004_i FROM ls_a004_i.
                    IF sy-subrc EQ 0.
                      NEW zcl_hr_dpo_request( )->set_request( rs_a004_i-dpo_request )->update_change_sign( abap_true ).
* error
                    ENDIF.
                  ENDLOOP.


                  DATA(ls_a004) = VALUE zhr_dpo_a004(  dpo_request      = rs_a004_i-dpo_request
                                                       version          = lv_version
                                                       before_save      = abap_true
                                                       created_at       = sy-datum
                                                       not_yet_approved = abap_true  ).


                  MODIFY zhr_dpo_a004 FROM ls_a004.
                  IF sy-subrc EQ 0.
                    NEW zcl_hr_dpo_request( )->set_request( rs_a004_i-dpo_request )->update_change_sign( abap_true ).
                    COMMIT WORK AND WAIT.
                  ENDIF.
                ENDIF.
              ENDIF.
            ENDIF.
          ELSE.
            SELECT MAX( version )   FROM  zhr_dpo_a004
                                   WHERE dpo_request      = @rs_a004_i-dpo_request
                                     AND not_yet_approved = @abap_false
                                     INTO @DATA(lv_vers).
            IF sy-subrc EQ 0.
              rs_a004_i-version = lv_vers.
            ELSE.
              rs_a004_i-version = 1.
            ENDIF.
          ENDIF.

          rs_a004_i-not_yet_approved = lv_not_yet_approved.

          MODIFY zhr_dpo_a004_i FROM rs_a004_i.

          IF sy-subrc <> 0.
            "Nelze ulozit do ZHR_DPO_A004_I, chyba &1
            MESSAGE e021(zhr_dpo) WITH sy-subrc INTO lv_dummy.
            zcl_hr_dpo_message=>append_syst( CHANGING ct_message = et_message ).
          ELSE.
            NEW zcl_hr_dpo_request( )->set_request( rs_a004_i-dpo_request )->update_change_sign( abap_true ).
            COMMIT WORK AND WAIT.
          ENDIF.
        ENDIF.
      ENDIF.
    ENDIF.
    ev_result = zcl_hr_dpo_message=>no_contain_error( it_message = et_message ).
  ENDMETHOD.


  METHOD constructor.
    DATA: lv_dummy       TYPE string,
          lv_dpo_request TYPE zhr_dpo_zad-dpo_request.
    IF iv_uname IS INITIAL.
      me->gv_uname = zcl_pe_all_change_user=>get_uname( iv_appl_id = 'ZHR_DPO_REQUEST' )..

    ELSE.
      me->gv_uname = iv_uname.
    ENDIF.
    lv_dpo_request = |{ iv_request ALPHA = IN }|.
    SELECT SINGLE * FROM zhr_dpo_zad INTO @DATA(ls_zhr_dpo_zad) WHERE dpo_request = @lv_dpo_request.
    IF ls_zhr_dpo_zad IS INITIAL.
      "Nenalezena zadost &1
      MESSAGE e023(zhr_dpo) WITH iv_request INTO lv_dummy.
      zcl_hr_dpo_message=>append_syst( CHANGING ct_message = me->gt_message ).
    ELSE.
      MOVE-CORRESPONDING ls_zhr_dpo_zad TO me->gs_zad.
      SELECT SINGLE * FROM zhr_dpo_a004 INTO @DATA(ls_a004) WHERE dpo_request = @lv_dpo_request.
      IF ls_a004 IS INITIAL.
        ls_a004-dpo_request = lv_dpo_request.
        ls_a004-created_at = sy-datum.
        ls_a004-before_save = abap_true.
        ls_a004-version = 1.
        INSERT zhr_dpo_a004 FROM ls_a004.
      ENDIF.
      me->gs_a004 = ls_a004.
    ENDIF.
    me->gv_result = zcl_hr_dpo_message=>no_contain_error( it_message = me->gt_message ).
  ENDMETHOD.


  METHOD delete_item.
    REFRESH: et_message.
    IF me->gv_result <> abap_true.
      APPEND LINES OF me->gt_message TO et_message.
    ELSE.
      DELETE FROM zhr_dpo_a004_i WHERE dpo_request = @me->gs_a004-dpo_request
        AND dpo_attachement_item = @iv_attachement_item
        AND attach_item_type = @iv_attach_item_type
        AND version = @iv_version.
    ENDIF.
  ENDMETHOD.


  METHOD generate_a004_i_id.
    CLEAR: rv_attachement_item.
    SELECT SINGLE MAX( dpo_attachement_item ) INTO @rv_attachement_item
      FROM zhr_dpo_a004_i
      WHERE dpo_request = @me->gs_a004-dpo_request
        AND attach_item_type = @iv_item_type.
    IF rv_attachement_item IS INITIAL.
      rv_attachement_item = 1.
    ELSE.
      rv_attachement_item = rv_attachement_item + 1.
    ENDIF.
  ENDMETHOD.


  METHOD get_complete.
    rv_completed = abap_false.
    SELECT COUNT( * ) INTO @DATA(lv_lines) FROM zhr_dpo_a004_i
      WHERE dpo_request = @me->gs_zad-dpo_request.
    IF lv_lines >= 1.
      rv_completed = abap_true.
    ENDIF.
  ENDMETHOD.


  METHOD get_data.
    CLEAR rs_a004.
    IF me->gv_result <> abap_true.
      APPEND LINES OF me->gt_message TO et_message.
    ELSE.
      rs_a004 = me->gs_a004.
    ENDIF.
  ENDMETHOD.


  METHOD get_emp_detail.
    CLEAR: rs_emp_detail.
    DATA(lv_date) = me->gs_a004-created_at.
    DATA(lv_pernr) = iv_pernr.
    DATA(lv_langu) = 'C'.
    SELECT p1~plans,
        p1~kostl,
        p1~stell,
        p1~pernr,
        p1~persk,
        p22~slart,
        h1000~short AS utvar,
        h1000_2~stext AS nazev_pozice,
        h1000_3~short AS profese_short,
        h1000_3~stext AS profese_stext
      FROM pa0001 AS p1
      LEFT JOIN pa0022 AS p22 ON p22~pernr = p1~pernr AND p22~begda <= @lv_date AND p22~endda >= @lv_date
*        AND p22~begda IN ( SELECT MIN(p22_2~begda) FROM pa0022 AS p22_2 WHERE p22_2~begda <= @lv_date AND p22_2~endda >= @lv_date AND p22_2~pernr = p1~pernr )
      LEFT JOIN hrp1000 AS h1000 ON h1000~otype = 'O' AND h1000~objid = p1~orgeh AND h1000~begda <= @lv_date AND h1000~endda >= @lv_date AND h1000~istat = '1'
      LEFT JOIN hrp1000 AS h1000_2 ON h1000_2~objid = p1~plans AND h1000_2~plvar = '01' AND h1000_2~otype = 'S' AND h1000_2~istat = '1'
                       AND h1000_2~begda <= @lv_date AND h1000_2~endda >= @lv_date AND h1000_2~langu = @lv_langu
      LEFT JOIN hrp1000 AS h1000_3 ON h1000_3~objid = p1~stell AND h1000_3~plvar = '01' AND h1000_3~otype = 'C' AND h1000_3~istat = '1'
                       AND h1000_3~begda <= @lv_date AND h1000_3~endda >= @lv_date AND h1000_3~langu = @lv_langu
      WHERE p1~pernr = @iv_pernr
        AND p1~begda <= @lv_date
        AND p1~endda >= @lv_date
      ORDER BY p22~begda DESCENDING
      INTO @DATA(ls_it)
      UP TO 1 ROWS
      .
*    SELECT SINGLE objid, short, stext INTO @DATA(ls_HRP1000) FROM hrp1000 WHERE objid = @ls_it-plans
*      AND plvar = '01'
*      AND otype = 'S'
*      AND begda <= @lv_date
*      AND endda >= @lv_date.
      rs_emp_detail-datum = lv_date.
      rs_emp_detail-pernr = ls_it-pernr.
      rs_emp_detail-fm = ls_it-plans.
      CASE ls_it-persk.
        WHEN '11' OR '12'.
          rs_emp_detail-km = 'VD'.
        WHEN '15' OR '16'.
          rs_emp_detail-km = 'RD'.
        WHEN '20' OR '24' OR '25' OR '26' OR '27' OR '28'.
          rs_emp_detail-km = 'THZ'.
      ENDCASE.
      rs_emp_detail-nazev_pozice = ls_it-nazev_pozice.
      rs_emp_detail-utvar = ls_it-utvar.
      rs_emp_detail-stredisko = ls_it-kostl.
      rs_emp_detail-jmeno_prijmeni = zcl_hr_dpo_roles=>get_pernr_details( iv_pernr = ls_it-pernr )-full_name_s.
      "Vzdělání
      IF ls_it-slart IS NOT INITIAL.
        SELECT SINGLE text1 INTO @rs_emp_detail-vzdelani
          FROM t5tpsckk3
          WHERE kateg = @ls_it-slart+1(1)
            AND begda <= @lv_date
            AND endda >= @lv_date
            AND langu = @lv_langu
        .
      ENDIF.
      "ext
      "Profese
*      SELECT SINGLE stltx INTO @DATA(lv_stltx) FROM t513s WHERE stell = @ls_it-stell
*        AND begda <= @lv_date
*        AND endda >= @lv_date.
      REPLACE 'SMT' WITH '' INTO ls_it-profese_stext.
      rs_emp_detail-profese = ls_it-profese_stext.
      IF ls_it-profese_short+0(3) EQ ls_it-profese_stext+0(3).
        rs_emp_detail-profese = ls_it-profese_stext+3.
        SHIFT rs_emp_detail-profese LEFT DELETING LEADING space.
      ENDIF.
      "
      SELECT SINGLE gbdat INTO @DATA(lv_gbdat) FROM pa0002 WHERE pernr = @ls_it-pernr
        AND begda <= @lv_date
        AND endda >= @lv_date.
      rs_emp_detail-narozeni = lv_gbdat.
      CALL FUNCTION 'HR_ENTRY_DATE'
        EXPORTING
          persnr               = ls_it-pernr
*         RCLAS                =
*         BEGDA                = '18000101'
*         ENDDA                = '99991231'
*         VARKY                =
*         INITIALIZE_PS_BUFFER = 'X'
        IMPORTING
          entrydate            = rs_emp_detail-nastup
*       TABLES
*         ENTRY_DATES          =
        EXCEPTIONS
          entry_date_not_found = 1
          pernr_not_assigned   = 2
          OTHERS               = 3.
      IF sy-subrc <> 0.
*       Implement suitable error handling here
      ENDIF.
      "<Seniorita => prevzato z ZHRPA_ZPBOSV02>
      rs_emp_detail-senior = zcl_hr_dpo_a004=>get_emp_senior( iv_date = lv_date iv_pernr = iv_pernr ).
      "</Seniorita => prevzato z ZHRPA_ZPBOSV02>
      SELECT SINGLE * INTO @DATA(ls_620_5) FROM pa0620 WHERE pernr = @ls_it-pernr
        AND begda <= @lv_date
        AND endda >= @lv_date
        AND subty = '5'.
      rs_emp_detail-zp = abap_false.
      IF ls_620_5 IS NOT INITIAL.
        rs_emp_detail-zp = abap_true.
      ENDIF.
      "<Narok na duchod => prevzato z ZCL_PA_PERSTA->GET_SENIORITY_AGE>
      DATA: lt_par01    TYPE RANGE OF famsa,
            lv_sen_date LIKE sy-datum,
            lv_date2    LIKE sy-datum,
            ls_p0002    TYPE p0002,
            lt_p0021    TYPE p0021_tab,
            lt_p0041    TYPE p0041_tab.
      lv_date2 = lv_date.
      lt_par01 = VALUE #( sign = 'I' option = 'EQ' ( low = '2' ) ).
      SELECT SINGLE pernr, anzkd, gbdat, gesch, vorna, nachn, natio, sprsl, titel, namzu
        INTO CORRESPONDING FIELDS OF @ls_p0002
        FROM pa0002
        WHERE pernr = @ls_it-pernr AND begda <= @lv_date AND endda >= @lv_date.
      SELECT * INTO CORRESPONDING FIELDS OF TABLE @lt_p0021 FROM pa0021 WHERE pernr = @ls_it-pernr ORDER BY begda ASCENDING.
      SELECT * INTO CORRESPONDING FIELDS OF TABLE @lt_p0041 FROM pa0041 WHERE pernr = @ls_it-pernr ORDER BY begda ASCENDING.
      CALL FUNCTION 'HR_CZ_SENIORITY_AGE_DECO'
        EXPORTING
          kids_it2 = 'X' "prednost IT 2 pred 21
          date     = lv_date2
          p0002    = ls_p0002
        IMPORTING
          sen_date = lv_sen_date
*         SEN_STAT =
*         CHILDREN =
*         CH_STAT  =
        TABLES
          p0021    = lt_p0021
          p0041    = lt_p0041
          21sub    = lt_par01.
      rs_emp_detail-narok_na_duchod = lv_sen_date.
      "</Narok na duchod => prevzato z ZCL_PA_PERSTA->GET_SENIORITY_AGE>
    ENDSELECT.
  ENDMETHOD.


  METHOD get_emp_senior.
    DATA: lv_hire_date TYPE hiredate,
          lt_p0000     TYPE p0000_tab,
          lt_p0001     TYPE p0001_tab,
          lv_vek       TYPE p,
          lv_pomdate   TYPE dardt,
          lv_zapvy     TYPE dardt,
          lt_phifi     TYPE pco_phifi_tab,
          ls_p0041_var TYPE pa0041,
          ls_p0041     TYPE pa0041,
          lv_valid     TYPE flag
          .
    DATA(lv_date) = iv_date.
    DATA(lv_date_dats8) = CONV begda( lv_date ).
    SELECT * INTO CORRESPONDING FIELDS OF TABLE @lt_p0000 FROM pa0000 WHERE pernr = @iv_pernr ORDER BY begda ASCENDING.
    SELECT * INTO CORRESPONDING FIELDS OF TABLE @lt_p0001 FROM pa0001 WHERE pernr = @iv_pernr ORDER BY begda ASCENDING.
    CALL FUNCTION 'RP_HIRE_FIRE'
      EXPORTING
        beg       = lv_date_dats8
        end       = lv_date_dats8
      IMPORTING
*       FIRE_DATE =
        hire_date = lv_hire_date
      TABLES
        pphifi    = lt_phifi
        pp0000    = lt_p0000
        pp0001    = lt_p0001.
    lv_pomdate = lv_hire_date.
    "<zapvy>
    SELECT * INTO @DATA(ls_pa0041) FROM Pa0041 WHERE
      pernr = @iv_pernr
      AND begda <= @lv_date AND endda >= @lv_date.
      DO 12 TIMES VARYING ls_p0041_var-dar01 FROM ls_pa0041-dar01 NEXT ls_pa0041-dar02
                  VARYING ls_p0041_var-dat01 FROM ls_pa0041-dat01 NEXT ls_pa0041-dat02.
        IF ls_p0041_var-dar01 EQ 'VY'.
          lv_pomdate = ls_p0041_var-dat01.
        ENDIF.
      ENDDO.
    ENDSELECT.
*      AND dar01 = 'TY'
*      .
*      IF lv_dat01 <> '00000000'.
*        lv_pomdate = lv_dat01.
*      ENDIF.
*    ENDSELECT.
    "</zapvy>
    lv_vek = lv_date(4) - lv_pomdate(4).
    IF lv_date+4(2) < lv_pomdate+4(2).
      lv_vek = lv_vek - 1.
    ELSEIF lv_date+4(2) = lv_pomdate+4(2) AND lv_date+6(2) < lv_pomdate+6(2).
      lv_vek = lv_vek - 1.
    ENDIF.
    IF lv_vek >= 30.
      rv_senior = abap_true.
    ENDIF.
  ENDMETHOD.


  METHOD get_ext_edit.
    rv_ext_edit = abap_false.
    IF me->gs_zad-status = zcl_hr_dpo_cstat=>status_approving_oj            "RAOJ
      OR me->gs_zad-status = zcl_hr_dpo_cstat=>status_in_data_processing_oj "ROJ
      OR me->gs_zad-status = zcl_hr_dpo_cstat=>status_to_complete_oj        "RDO
      OR NEW zcl_hr_dpo_request( )->status_exists_in_history( iv_dpo_request  =  me->gs_zad-dpo_request
                                                                  iv_status       = 'ZHP' ).
      rv_ext_edit = abap_true.
    ENDIF.
  ENDMETHOD.


  METHOD get_item.
    DATA: lt_message TYPE bapirettab.
    CLEAR rs_item.
    DATA(lt_item) = me->get_items(
      EXPORTING
        iv_uname                = iv_uname
        iv_attach_item_type     = iv_attach_item_type                 " Žádost - příloha č. 4 - typ řádku - klíč
        iv_dpo_attachement_item = iv_attachement_item             " ID položky přílohy
        iv_pernr                = iv_pernr
        iv_version              = iv_version
      IMPORTING
        et_message              = lt_message                 " Tabulka s návratovými informacemi BAPI
    ).
    APPEND LINES OF lt_message TO et_message.
    IF line_exists( lt_item[ 1 ] ).
      MOVE-CORRESPONDING lt_item[ 1 ] TO rs_item.
    ENDIF.
  ENDMETHOD.


  METHOD get_items.
    REFRESH: rt_items, et_message.
    IF me->gv_result <> abap_true.
      APPEND LINES OF me->gt_message TO et_message.
    ELSE.

      DATA(lv_spras) =  COND sy-langu( WHEN iv_pdf_stream IS INITIAL THEN sy-langu
                                       WHEN iv_pdf_stream = abap_true THEN 'C' ).
      DATA(lv_where) = |zda~dpo_request = @me->gs_a004-dpo_request AND zda~version = @iv_version|.

      IF iv_pernr IS NOT INITIAL.
        lv_where = |{ lv_where } AND zda~pernr = @iv_pernr|.
      ENDIF.
      SELECT
          zda~*,
          zdc~serial_number AS serial_number_01,
          zdc~serial_number_roman AS serial_number_roman_01,
          zdc2~description AS description_02
        INTO CORRESPONDING FIELDS OF TABLE @rt_items
        FROM zhr_dpo_a004_i AS zda
        JOIN zhr_dpo_ca004it AS zdc ON zdc~a004it = zda~attach_item_type
        JOIN zhr_dpo_ca004itt AS zdc2 ON zdc~a004it = zdc2~a004it AND zdc2~spras = @lv_spras
        WHERE (lv_where)
        ORDER BY zdc~serial_number ASCENDING, zda~dpo_attachement_item ASCENDING
      .
      IF sy-subrc NE 0.
        CLEAR lv_where.
        lv_where = |zda~dpo_request = @me->gs_a004-dpo_request|.
        IF iv_dpo_attachement_item IS NOT INITIAL
       AND iv_attach_item_type IS NOT INITIAL.
          lv_where = |{ lv_where } AND zda~dpo_attachement_item = @iv_dpo_attachement_item| &&
            | AND zda~attach_item_type = @iv_attach_item_type |.
        ENDIF.
        SELECT
         zda~*,
         zdc~serial_number AS serial_number_01,
         zdc~serial_number_roman AS serial_number_roman_01,
         zdc2~description AS description_02
       INTO CORRESPONDING FIELDS OF TABLE @rt_items
       FROM zhr_dpo_a004_i AS zda
       JOIN zhr_dpo_ca004it AS zdc ON zdc~a004it = zda~attach_item_type
       JOIN zhr_dpo_ca004itt AS zdc2 ON zdc~a004it = zdc2~a004it AND zdc2~spras = @lv_spras
       WHERE (lv_where)
       ORDER BY zdc~serial_number ASCENDING, zda~dpo_attachement_item ASCENDING.
      ENDIF.

      DATA(lv_counter) = 0.
      DATA: lv_type_old TYPE zhr_dpo_a004it,
            lt_message4 TYPE bapirettab,
            lv_result4  TYPE flag.
      DATA(lo_auth) = zcl_hr_dpo_auth=>get(
                        EXPORTING
                          iv_uname                 = iv_uname                 " Uname
                          iv_nacti_vsechny_zastupy = iv_vsechny_zastupy       " Všeobecný příznak
                        IMPORTING
                          et_message               = lt_message4                 " Tabulka s návratovými informacemi BAPI
                          ev_result                = lv_result4                 " Všeobecný příznak
                      ).
      APPEND LINES OF lt_message4 TO et_message.
      IF lo_auth IS NOT INITIAL
        AND lv_result4 = abap_true.
        lo_auth->get_req_a004_struc_by_role(
          EXPORTING
            iv_request         = me->gs_a004-dpo_request
            iv_create_date     = me->gs_a004-created_at
          IMPORTING
            ev_show_all        = DATA(lv_show_all)                 " Může vidět všechny zaměstnance
            et_show_only_pernr = DATA(lt_show_only_pernr)                 " Tabulka zaměstnanců
            et_message         = DATA(lt_message3)                 " Tabulka s návratovými informacemi BAPI
            et_objec           = DATA(lt_objec)                 " Tabulka struc
        ).
        APPEND LINES OF lt_message3 TO et_message.
        LOOP AT rt_items ASSIGNING FIELD-SYMBOL(<ls_item>).
          DATA(lv_index) = sy-index.
          "Kontrola, zda ma uzivatel pravo videt pripadneho zamestnance
          IF ( <ls_item>-pernr IS NOT INITIAL
            AND ( lv_show_all = abap_true OR line_exists( lt_show_only_pernr[ table_line = <ls_item>-pernr ] ) )
            ) OR <ls_item>-pernr IS INITIAL
          .
            IF lv_type_old <> <ls_item>-attach_item_type.
              lv_counter = 0.
              lv_type_old = <ls_item>-attach_item_type.
            ENDIF.
            lv_counter = lv_counter + 1.
            <ls_item>-item_type_index = lv_counter.
            IF <ls_item>-pernr IS NOT INITIAL.
              DATA(ls_fm) = me->get_emp_detail( iv_pernr = <ls_item>-pernr ).
              IF ls_fm IS NOT INITIAL.
                MOVE-CORRESPONDING ls_fm TO <ls_item>-fm.
              ENDIF.
            ENDIF.
          ELSE.
            DELETE TABLE rt_items FROM <ls_item>.
          ENDIF.
        ENDLOOP.
      ELSE.
        REFRESH rt_items.
      ENDIF.
    ENDIF.
  ENDMETHOD.


METHOD get_pdf.
  REFRESH et_message.
  CLEAR rx_content.
  DATA:
    lv_funcname        TYPE funcname,
    ls_fp_outputparams TYPE sfpoutputparams,
    ls_docparams       TYPE sfpdocparams,
    ls_formoutput      TYPE fpformoutput,
    lx_root            TYPE REF TO cx_root
    .
  "Parametry výstupu
  ls_fp_outputparams-preview  = 'X'.
  ls_fp_outputparams-nodialog = 'X'.
  ls_fp_outputparams-arcmode  = '1'.
  ls_fp_outputparams-getpdf   = 'X'.
*  ls_fp_outputparams-getpdl   = 'X'.

  TRY.

      CALL FUNCTION 'FP_JOB_OPEN'
        CHANGING
          ie_outputparams = ls_fp_outputparams
        EXCEPTIONS
          cancel          = 1
          usage_error     = 2
          system_error    = 3
          internal_error  = 4
          OTHERS          = 5.

      "Nactení funkčního kódu PDF formuláře
      CALL FUNCTION 'FP_FUNCTION_MODULE_NAME'
        EXPORTING
          i_name     = 'ZHR_DPO_FORM_A004'
        IMPORTING
          e_funcname = lv_funcname.

**********************************************************************
* Doplneni dat
**********************************************************************
      DATA: lt_items_out TYPE zhr_dpo_form_a004_t,
            ls_item_out  TYPE zhr_dpo_form_a004_items_s,
            lt_message   TYPE bapirettab.

      IF gs_a004-dpo_request IS NOT INITIAL.
        SELECT MAX( version ) FROM zhr_dpo_a004
                                   WHERE dpo_request =  @gs_a004-dpo_request
                                     AND not_yet_approved = @abap_false
                                     INTO @DATA(lv_version).
      ENDIF.

      DATA(lt_items) = me->get_items(
        EXPORTING
          iv_uname = iv_uname
          iv_vsechny_zastupy = iv_vsechny_zastupy
          iv_pdf_stream = abap_true
          iv_version  = lv_version
        IMPORTING
          et_message = lt_message
      ).
      SORT lt_items BY serial_number_01 ASCENDING item_type_index ASCENDING.
      APPEND LINES OF lt_message TO et_message.
      LOOP AT lt_items ASSIGNING FIELD-SYMBOL(<fs_item>).
        CLEAR ls_item_out.
        READ TABLE lt_items_out ASSIGNING FIELD-SYMBOL(<fs_item_out>) WITH KEY item_type_index = <fs_item>-serial_number_roman_01.
        IF sy-subrc <> 0.
          APPEND INITIAL LINE TO lt_items_out ASSIGNING <fs_item_out>.
        ENDIF.
        DATA(lv_pernr) = <fs_item>-pernr.
        SHIFT lv_pernr LEFT DELETING LEADING '0'.
        <fs_item_out>-item_type_index = <fs_item>-serial_number_roman_01.
        <fs_item_out>-item_type_text = <fs_item>-description_02.
        ls_item_out = VALUE #(
          pernr            = lv_pernr
          jmeno_prijmeni   = <fs_item>-jmeno_prijmeni_03
          cinnosti         = <fs_item>-cinnosti
          dopln_inf        = <fs_item>-dopln_inf
          fm               = <fs_item>-fm_03
          item_index       = |{ <fs_item>-item_type_index }.|
          km               = <fs_item>-km_03
          narok_na_duchod  = <fs_item>-narok_na_duchod_03
          narozeni         = <fs_item>-narozeni_03
          nastup           = <fs_item>-nastup_03
          navrh_zruseni_fm = <fs_item>-navrh_zruseni_fm
          nazev_pozice     = <fs_item>-nazev_pozice_03
          odsouhl_reseni   = <fs_item>-odsouhl_reseni
          opatreni         = <fs_item>-opatreni
          opatreni_detail  = <fs_item>-opatreni_detail
          procent          = <fs_item>-procent
          profese          = <fs_item>-profese_03
          reseni_navrh     = <fs_item>-reseni_navrh
          senior           = zcl_hr_dpo_pdf=>get_yes_no( iv_boolean = <fs_item>-senior_03 )
          stav_projednani_fm = <fs_item>-stav_projednani_fm
          stredisko        = <fs_item>-stredisko_03
          termin_zruseni   = <fs_item>-termin_zruseni
          ukonceni_proj    = <fs_item>-ukonceni_proj
          utvar            = <fs_item>-utvar_03
          vzdelani         = <fs_item>-vzdelani_03
          zahajeni_projednani = <fs_item>-zahajeni_projednani
          zp               = zcl_hr_dpo_pdf=>get_yes_no( iv_boolean = <fs_item>-zp_03 )
        ).
        APPEND ls_item_out TO <fs_item_out>-items.
      ENDLOOP.
**********************************************************************
*      EXIT.
      "Parametry PDF formuláře
      ls_docparams-fillable = ''.
      ls_docparams-dynamic = ''.
*      ls_docparams-dynamic = 'X'.
      ls_docparams-langu   = 'C'. "sy-langu. PDF jenom česky
      "Generování PDF formuláře
      CALL FUNCTION lv_funcname
        EXPORTING
          /1bcdwb/docparams  = ls_docparams
          it_items           = lt_items_out
        IMPORTING
          /1bcdwb/formoutput = ls_formoutput
        EXCEPTIONS
          usage_error        = 1
          system_error       = 2
          internal_error     = 3
          OTHERS             = 4.
      CALL FUNCTION 'FP_JOB_CLOSE'
        EXCEPTIONS
          usage_error    = 1
          system_error   = 2
          internal_error = 3
          OTHERS         = 4.
    CATCH cx_root INTO lx_root.
  ENDTRY.
  rx_content = ls_formoutput-pdf.
ENDMETHOD.


  METHOD get_uname.
    rv_uname = me->gv_uname.
  ENDMETHOD.
ENDCLASS.
