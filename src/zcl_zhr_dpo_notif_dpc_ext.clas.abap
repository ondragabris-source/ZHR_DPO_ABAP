class ZCL_ZHR_DPO_NOTIF_DPC_EXT definition
  public
  inheriting from ZCL_ZHR_DPO_NOTIF_DPC
  create public .

public section.
protected section.

  methods NOTIFICATIONSET_GET_ENTITY
    redefinition .
  methods NOTIFICATIONSET_GET_ENTITYSET
    redefinition .
  methods NOTIFICATIONSET_UPDATE_ENTITY
    redefinition .
private section.
ENDCLASS.



CLASS ZCL_ZHR_DPO_NOTIF_DPC_EXT IMPLEMENTATION.


  method NOTIFICATIONSET_GET_ENTITY.

 DATA: lv_termid      TYPE zhr_dpo_id_term,
       lv_dpo_request TYPE zhr_dpo_request,
       lt_message     TYPE bapiret2_t.

 loop at it_key_tab[] assigning field-symbol(<fs_key>).
     CASE <fs_key>-name.
       WHEN 'TermId'.
          lv_termid = <fs_key>-value.
       WHEN 'DpoRequest'.
         lv_dpo_request = <fs_key>-value.
       WHEN OTHERS.
     ENDCASE.

    endloop.


    data(lo_notif) = new zcl_hr_dpo_notif( ).

    er_entity = CORRESPONDING #( lo_notif->get_notification(
                                      exporting
                                        iv_term        = lv_termid               " DPO Termín
                                        iv_dpo_request = lv_dpo_request                 " ID žádosti
                                       importing
                                         et_message     = lt_message               " Návratová tabulka
                                    ) ).
  endmethod.


  method NOTIFICATIONSET_GET_ENTITYSET.



 DATA: lv_termid      TYPE zhr_dpo_id_term,
       lv_dpo_request TYPE zhr_dpo_request,
       lt_message     TYPE bapiret2_t.

 loop at it_key_tab[] assigning field-symbol(<fs_key>).
     CASE <fs_key>-name.
       WHEN 'TermId'.
          lv_termid = <fs_key>-value.
       WHEN 'DpoRequest'.
         lv_dpo_request = <fs_key>-value.
       WHEN OTHERS.
     ENDCASE.

    endloop.


    data(lo_notif) = new zcl_hr_dpo_notif( ).

    et_entityset = CORRESPONDING #( lo_notif->GET_NOTIF_HISTORY(
                                      exporting
                                        iv_term        = lv_termid               " DPO Termín
                                        iv_dpo_request = lv_dpo_request                 " ID žádosti
                                       importing
                                         et_message     = lt_message               " Návratová tabulka
                                    ) ).
  endmethod.


  method NOTIFICATIONSET_UPDATE_ENTITY.



  endmethod.
ENDCLASS.
