*----------------------------------------------------------------------*
***INCLUDE LZHR_DPO_BPF06.
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form ZHR_UPDATE_FIELD
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM zhr_update_field .

  DATA: lv_uname   TYPE  bapibname-bapibname,
        lt_return  TYPE STANDARD TABLE OF bapiret2,
        ls_address TYPE bapiaddr3.

  DATA(lv_pernr) = zcl_pa_vs_utils=>get_pernr_by_uname( iv_uname = zhr_dpo_bp-hrbp ).
  DATA(ls_user_data) = zcl_hr_dpo_roles=>get_pernr_details( iv_pernr = lv_pernr  ).

  zhr_dpo_bp-hrbp_name = ls_user_data-full_name.

  CLEAR ls_user_data.
  lv_pernr = zcl_pa_vs_utils=>get_pernr_by_uname( iv_uname = zhr_dpo_bp-hrbp_junior ).
  ls_user_data = zcl_hr_dpo_roles=>get_pernr_details( iv_pernr = lv_pernr  ).

  zhr_dpo_bp-hrbp_junior_name = ls_user_data-full_name.


  CLEAR ls_user_data.
  lv_pernr = zcl_pa_vs_utils=>get_pernr_by_uname( iv_uname = zhr_dpo_bp-hrbp_junior_tplus ).
  ls_user_data = zcl_hr_dpo_roles=>get_pernr_details( iv_pernr = lv_pernr  ).

  zhr_dpo_bp-hrbp_junior_name_tplus = ls_user_data-full_name.

*  select single sachn from t526 into zhr_dpo_bp-hrbp_name
*             where usrid = zhr_dpo_bp-hrbp.

*  select single sachn from t526 into zhr_dpo_bp-hrbp_junior_name
*               where usrid = zhr_dpo_bp-hrbp_junior.


ENDFORM.
