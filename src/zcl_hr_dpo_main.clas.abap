class ZCL_HR_DPO_MAIN definition
  public
  inheriting from ZCL_CA_UNIFRAME
  abstract
  create public .

public section.

  methods SEND_TO_UNI .
  methods SEND_TO_TASKMANAGER .
  methods SEND_PROPOSAL .
  methods SEND_FINAL .
  methods SEND_MAIL .
  methods GET_CURRENT_PROCOTOL .
  methods SAVE_AS_DRAFT .
  methods INIT_FORM_DATA
  abstract
    importing
      !IV_UNAME type UNAME optional
    exporting
      !ET_MESSAGE type BAPIRET2_T .
protected section.
private section.
ENDCLASS.



CLASS ZCL_HR_DPO_MAIN IMPLEMENTATION.


  method GET_CURRENT_PROCOTOL.

  endmethod.


  method SAVE_AS_DRAFT.

  endmethod.


  method SEND_FINAL.

  endmethod.


  method SEND_MAIL.

  endmethod.


  method SEND_PROPOSAL.

  endmethod.


  method SEND_TO_TASKMANAGER.

  endmethod.


  method SEND_TO_UNI.

  endmethod.
ENDCLASS.
