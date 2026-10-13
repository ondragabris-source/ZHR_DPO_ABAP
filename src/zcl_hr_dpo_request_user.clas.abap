class ZCL_HR_DPO_REQUEST_USER definition
  public
  create public .

public section.

  methods CHECK_IF_CAN_SEE_REQ
    importing
      !IV_REQ type ZHR_DPO_REQUEST
    returning
      value(RV_CAN_SEE_REQ) type WDY_BOOLEAN .
  methods GET_REQUESTS
    returning
      value(RT_REQUESTS) type ZHR_DPO_ZAD_T .
  class-methods GET
    importing
      !IV_UNAME type SY-UNAME optional
    returning
      value(RO_ZCL_HR_DPO_REQUEST_USER) type ref to ZCL_HR_DPO_REQUEST_USER .
  methods CONSTRUCTOR
    importing
      !IV_UNAME type SY-UNAME .
protected section.

  data GV_UNAME type SY-UNAME .
  data GT_REQUESTS type ZHR_DPO_ZAD_T .
private section.
ENDCLASS.



CLASS ZCL_HR_DPO_REQUEST_USER IMPLEMENTATION.


  METHOD check_if_can_see_req.
    rv_can_see_req = abap_false.
    READ TABLE me->gt_requests TRANSPORTING NO FIELDS WITH KEY dpo_request = iv_req.
    IF sy-subrc = 0.
      rv_can_see_req = abap_true.
    ENDIF.
  ENDMETHOD.


  METHOD constructor.
    DATA:
      lt_creator_range TYPE /iwbep/t_cod_select_options,
      lr_process_range TYPE /iwbep/t_cod_select_options
    .
    lr_process_range = VALUE #( sign = 'I' option = 'EQ'  ( low = zcl_hr_dpo_const=>dpo_dohoda ) ).
    me->gv_uname = iv_uname.
    "Load all requests user has rights to view it
    lt_creator_range = VALUE #( sign = 'I' option = 'EQ' ( low = me->gv_uname ) ).
    DATA(lo_request) = NEW zcl_hr_dpo_request( ).
    me->gt_requests = lo_request->get_request_list(
      EXPORTING
*        request_range       = it_request_range
*        request_type_range  =
*        request_date_range  =
*        request_year_range  =
*        request_full_range  =
        creator_range       = lt_creator_range
*        senddate_range      =
*        name_range          =
*        status_range        =
         process_range       = lr_process_range
        iv_process          = zcl_hr_dpo_const=>dpo_dohoda
*        iv_from_term_string =
*        orgeh               =
*        requestor_full_name =
    ).
  ENDMETHOD.


  METHOD get.
    ro_zcl_hr_dpo_request_user = NEW zcl_hr_dpo_request_user( iv_uname = iv_uname ).
  ENDMETHOD.


  METHOD get_requests.
    REFRESH rt_requests.
    APPEND LINES OF me->gt_requests TO rt_requests.
  ENDMETHOD.
ENDCLASS.
