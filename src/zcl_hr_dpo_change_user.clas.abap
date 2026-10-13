class ZCL_HR_DPO_CHANGE_USER definition
  public
  inheriting from ZCL_PE_ALL_CHANGE_USER_APPL
  final
  create public .

public section.

  methods ZIF_PE_ALL_CHANGE_USER~IS_ALLOWED
    redefinition .
protected section.
private section.
ENDCLASS.



CLASS ZCL_HR_DPO_CHANGE_USER IMPLEMENTATION.


  method ZIF_PE_ALL_CHANGE_USER~IS_ALLOWED.

    IF ZCL_HR_DPO_ROLES=>check_admin( ) = abap_true.
      rv_allowed = abap_true.
    ENDIF.

  endmethod.
ENDCLASS.
