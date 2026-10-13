class ZCL_HR_DPO_MESSAGE definition
  public
  create public .

public section.

  class-methods FILL_MESSAGE_CONTAINER
    importing
      !IV_MESSAGE_TARGET type STRING
      !IO_MESSAGE type ref to /IWBEP/IF_MESSAGE_CONTAINER
      !IT_MESSAGE type BAPIRETTAB .
  class-methods NO_CONTAIN_ERROR
    importing
      !IT_MESSAGE type BAPIRETTAB
    returning
      value(RV_NO_CONTAIN_ERROR) type WDY_BOOLEAN .
  class-methods APPEND_SYST
    changing
      !CT_MESSAGE type BAPIRETTAB .
protected section.
private section.
ENDCLASS.



CLASS ZCL_HR_DPO_MESSAGE IMPLEMENTATION.


  METHOD append_syst.
    DATA:
      ls_message TYPE bapiret2
    .
    CALL FUNCTION 'BALW_BAPIRETURN_GET2'
      EXPORTING
        type   = sy-msgty
        cl     = sy-msgid
        number = sy-msgno
        par1   = sy-msgv1
        par2   = sy-msgv2
        par3   = sy-msgv3
        par4   = sy-msgv4
*       LOG_NO = ' '
*       LOG_MSG_NO       = ' '
*       PARAMETER        = ' '
*       ROW    = 0
*       FIELD  = ' '
      IMPORTING
        return = ls_message.
    IF ls_message IS NOT INITIAL.
      APPEND ls_message TO ct_message.
    ENDIF.
  ENDMETHOD.


  METHOD fill_message_container.
    LOOP AT it_message INTO DATA(ls_message).
      io_message->add_message_from_bapi(
        EXPORTING
          is_bapi_message           = ls_message                 " Return Parameter
*          iv_error_category         =                  " Error Category
*          iv_is_leading_message     = abap_true        " Is leading message?
*          iv_entity_type            =                  " Entity type/name
*          it_key_tab                =                  " Entity key as name-value pair
          iv_add_to_response_header = abap_true       " Flag for adding or not the message to the response header
          iv_message_target         = iv_message_target " Target (reference) (e.g. Property ID) of a message
*          it_message_target         =                  " Table of targets in addition to the message target
*          iv_omit_target            = abap_false       " Set to TRUE if message has no target
*          iv_is_transition_message  = abap_false       " Is transition message?
      ).
    ENDLOOP.
  ENDMETHOD.


  METHOD no_contain_error.
    rv_no_contain_error = abap_true.
    LOOP AT it_message TRANSPORTING NO FIELDS
      WHERE type CA 'AEX'
    .
      rv_no_contain_error = abap_false.
    ENDLOOP.
  ENDMETHOD.
ENDCLASS.
