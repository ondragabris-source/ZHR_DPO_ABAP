*&---------------------------------------------------------------------*
*& Report ZPE_DPO_CHANGE_PERSON
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpe_dpo_change_person.
TABLES: zhr_dpo_rozdel.
TABLES: zhr_dpo_zad.

DATA ls_rozdel_del TYPE zhr_dpo_rozdel.
DATA ls_rozdel_ins TYPE zhr_dpo_rozdel.
DATA lt_rozdel_del TYPE STANDARD TABLE OF zhr_dpo_rozdel.
DATA lt_rozdel_ins TYPE STANDARD TABLE OF zhr_dpo_rozdel.
DATA  lt_message TYPE bapiret2_t.

SELECT-OPTIONS: s_req FOR zhr_dpo_zad-dpo_req_full OBLIGATORY.
SELECT-OPTIONS: s_rol FOR zhr_dpo_rozdel-role NO INTERVALS.
PARAMETERS:     p_test AS CHECKBOX DEFAULT 'X'.

INITIALIZATION.

  s_rol-sign = 'I'.
  s_rol-option = 'EQ'.
  s_rol-low = zcl_hr_dpo_roles=>co_ved_sp.
  APPEND s_rol.




START-OF-SELECTION.

*  AUTHORITY-CHECK OBJECT 'S_TCODE'
*       ID 'TCD' FIELD 'ZHRPA_DPO_SHIFT_TERM'.
*  IF sy-subrc <> 0.
** Implement a suitable exception handling here
*    MESSAGE e024(zhr_dpo) INTO DATA(lv_text).
** Nemáte autorizaci na spuštění programu.
*
*  ENDIF.

  SELECT rozdel~*, zad~dpo_req_full FROM zhr_dpo_rozdel AS rozdel INNER JOIN zhr_dpo_zad AS zad
                               ON rozdel~dpo_request = zad~dpo_request
                               INTO TABLE @DATA(lt_rozdel)
                               WHERE dpo_req_full IN @s_req
                                 AND role IN @s_rol
                                 AND approved = ''
                                 .
  IF sy-subrc EQ 0.
    LOOP AT lt_rozdel ASSIGNING FIELD-SYMBOL(<fs_rozdel>).
      CLEAR ls_rozdel_del.
      CLEAR ls_rozdel_ins.
      DATA(ls_sp)               = zcl_hr_dpo_roles=>get_manager_sp( IMPORTING et_message = lt_message ).
      IF ls_sp-pernr IS NOT INITIAL AND <fs_rozdel>-rozdel-pernr NE ls_sp-pernr.

        ls_rozdel_del = CORRESPONDING #( <fs_rozdel>-rozdel ).
        APPEND ls_rozdel_del TO lt_rozdel_del.
        ls_rozdel_ins = CORRESPONDING #( <fs_rozdel>-rozdel ).
        ls_rozdel_ins-uname =   ls_sp-uname.
        ls_rozdel_ins-pernr =   ls_sp-pernr.
        APPEND ls_rozdel_ins TO lt_rozdel_ins.
        WRITE:/ 'U žádosti ', <fs_rozdel>-dpo_req_full, 'Ved_SP: ', ls_rozdel_del-uname, 'nahrazen VED_SP:', ls_rozdel_ins-uname.
      ENDIF.

    ENDLOOP.

    IF p_test IS INITIAL.
      INSERT zhr_dpo_rozdel FROM TABLE lt_rozdel_ins.
      IF sy-subrc EQ 0.
        DELETE zhr_dpo_rozdel FROM TABLE lt_rozdel_del.
      ENDIF.
    ENDIF.
  ENDIF.
