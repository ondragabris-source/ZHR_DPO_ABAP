class ZCL_HR_DPO_A004_BL definition
  public
  create public .

public section.

  methods GET_COMPLETE
    importing
      !IV_REQUEST type ZHR_DPO_REQUEST
    returning
      value(RV_COMPLETED) type ZHR_DPO_A004_VALID .
  class-methods ADD_UPDATE_ITEM
    importing
      !IV_REQUEST type ZHR_DPO_REQUEST
      !IV_ITEM_TYPE type ZHR_DPO_A004IT
      !IV_ATTACHEMENT_ITEM type ZHR_DPO_ATTACHEMENT_ITEM optional
      !IS_A004_I_ITEM type ZHR_DPO_A004_I_ITEM_S
    exporting
      !ET_MESSAGE type BAPIRETTAB
      !EV_RESULT type BOOLEAN
    returning
      value(RS_A004_I) type ZHR_DPO_A004_I .
  class-methods CREATE_OR_GET
    importing
      !IV_REQUEST type ZHR_DPO_REQUEST
      !IV_UNAME type SY-UNAME optional
    exporting
      !ET_MESSAGE type BAPIRETTAB
    returning
      value(RS_A004) type ZHR_DPO_A004_GW_S .
  class-methods DELETE_ITEM
    importing
      !IV_REQUEST type ZHR_DPO_REQUEST
      !IV_ATTACH_ITEM_TYPE type ZHR_DPO_A004IT
      !IV_ATTACHEMENT_ITEM type ZHR_DPO_ATTACHEMENT_ITEM
      !IV_PERNR type PERNR_D
      !IV_VERSION type VERSION
    exporting
      !ET_MESSAGE type BAPIRETTAB .
  class-methods GET_EMP_DETAIL
    importing
      !IV_REQUEST type ZHR_DPO_REQUEST
      !IV_PERNR type ZHR_DPO_PERNR
    exporting
      !ET_MESSAGE type BAPIRETTAB
    returning
      value(RS_A004_FM) type ZHR_DPO_A004_FM_EXT_S .
  class-methods GET_ITEM
    importing
      !IV_REQUEST type ZHR_DPO_REQUEST
      !IV_ATTACH_ITEM_TYPE type ZHR_DPO_A004IT
      !IV_ATTACHEMENT_ITEM type ZHR_DPO_ATTACHEMENT_ITEM
      !IV_UNAME type SY-UNAME
      !IV_PERNR type PERNR_D
      !IV_VERSION type VERSION
    exporting
      !ET_MESSAGE type BAPIRETTAB
    returning
      value(RS_ITEM) type ZHR_DPO_A004_I_EXT_GW_S .
  class-methods GET_ITEMS
    importing
      !IV_REQUEST type ZHR_DPO_REQUEST
      !IV_UNAME type SY-UNAME
      !IV_VERSION type VERSION optional
    exporting
      !ET_MESSAGE type BAPIRETTAB
    returning
      value(RT_ITEMS) type ZHR_DPO_A004_I_GW_T .
  class-methods GET_PDF_STREAM
    importing
      !IV_REQUEST type ZHR_DPO_REQUEST
      !IV_UNAME type SY-UNAME
      !IV_NACTI_VSECHNY_ZASTUPY type FLAG default ABAP_FALSE
    exporting
      !ET_MESSAGE type BAPIRETTAB
    returning
      value(RT_STREAM) type XSTRING .
protected section.
private section.
ENDCLASS.



CLASS ZCL_HR_DPO_A004_BL IMPLEMENTATION.


  METHOD add_update_item.
    CLEAR rs_a004_i.
    rs_a004_i = zcl_hr_dpo_a004=>add_or_get( iv_request = iv_request )->add_update_item(
      EXPORTING
        iv_item_type        = iv_item_type
        iv_attachement_item = iv_attachement_item
        is_a004_i_item      = is_a004_i_item
      IMPORTING
        et_message          = et_message
        ev_result           = ev_result
    ).
    ev_result = zcl_hr_dpo_message=>no_contain_error( it_message = et_message ).
  ENDMETHOD.


  METHOD create_or_get.
    DATA: lv_result TYPE flag.
    REFRESH et_message.
    CLEAR rs_a004.
    DATA(lo_a004) = zcl_hr_dpo_a004=>add_or_get( iv_request = iv_request iv_uname = iv_uname ).
    DATA(lo_auth) = zcl_hr_dpo_auth=>get(
      EXPORTING
        iv_uname   = lo_a004->get_uname( )                 " Uname
      IMPORTING
        et_message = et_message                 " Tabulka s návratovými informacemi BAPI
        ev_result  = lv_result                 " Všeobecný příznak
    ).
    IF lv_result = abap_true.
      DATA(ls_a004) = lo_a004->get_data( IMPORTING et_message = et_message ).
      MOVE-CORRESPONDING ls_a004 TO rs_a004.
      rs_a004-ext_edit_fl = lo_a004->get_ext_edit( ).
      rs_a004-show_a004_pdf_fl = lo_auth->get_req_a004_pdf_show( ).
    ENDIF.
  ENDMETHOD.


  METHOD delete_item.
    REFRESH: et_message.
    zcl_hr_dpo_a004=>add_or_get( iv_request = iv_request )->delete_item(
      EXPORTING
        iv_attach_item_type = iv_attach_item_type                 " Žádost - příloha č. 4 - typ řádku - klíč
        iv_attachement_item = iv_attachement_item
        iv_version          = iv_version                " ID položky přílohy
      IMPORTING
        et_message          = et_message                 " Tabulka s návratovými informacemi BAPI
    ).
  ENDMETHOD.


  METHOD get_complete.
    rv_completed = zcl_hr_dpo_a004=>add_or_get( iv_request = iv_request )->get_complete( ).
  ENDMETHOD.


  METHOD get_emp_detail.
    CLEAR: rs_a004_fm.
    REFRESH: et_message.
    rs_a004_fm = zcl_hr_dpo_a004=>add_or_get( iv_request = iv_request )->get_emp_detail( iv_pernr = iv_pernr ).
  ENDMETHOD.


  METHOD get_item.
    CLEAR: rs_item.
    REFRESH: et_message.
    rs_item = zcl_hr_dpo_a004=>add_or_get( iv_request = iv_request )->get_item(
      EXPORTING
        iv_uname            = iv_uname
        iv_attach_item_type = iv_attach_item_type                 " Žádost - příloha č. 4 - typ řádku - klíč
        iv_attachement_item = iv_attachement_item                 " ID položky přílohy
        iv_pernr            = iv_pernr
        iv_version          = iv_version
      IMPORTING
        et_message          = et_message                 " Tabulka s návratovými informacemi BAPI
    ).
  ENDMETHOD.


  METHOD get_items.
    REFRESH: rt_items, et_message.
    DATA(lt_items) = zcl_hr_dpo_a004=>add_or_get( iv_request = iv_request )->get_items( EXPORTING iv_uname = iv_uname iv_version = iv_version  IMPORTING et_message = et_message ).
    rt_items = CORRESPONDING #( lt_items ).
  ENDMETHOD.


  METHOD get_pdf_stream.
    DATA: lv_result  TYPE flag,
          lt_message TYPE bapirettab.
    CLEAR: rt_stream.
    REFRESH: et_message.
    DATA(lo_a004) = NEW zcl_hr_dpo_a004( iv_request = iv_request iv_uname = iv_uname ).
    DATA(lo_auth) = zcl_hr_dpo_auth=>get(
      EXPORTING
        iv_uname   = lo_a004->get_uname( )                 " Uname
        iv_nacti_vsechny_zastupy = iv_nacti_vsechny_zastupy
      IMPORTING
        et_message = et_message                 " Tabulka s návratovými informacemi BAPI
        ev_result  = lv_result                 " Všeobecný příznak
    ).
    IF lv_result = abap_true.
      IF lo_auth->get_req_a004_pdf_show(
           IMPORTING
             et_message = lt_message                 " Tabulka s návratovými informacemi BAPI
         ) = abap_true.
        rt_stream = lo_a004->get_pdf(
          EXPORTING
            iv_uname           = iv_uname
            iv_vsechny_zastupy = iv_nacti_vsechny_zastupy

        ).
      ELSE.
        APPEND LINES OF lt_message TO et_message.
      ENDIF.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
