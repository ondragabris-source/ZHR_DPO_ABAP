class ZCL_HR_DPO_PDF definition
  public
  create public .

public section.

  class-methods GET_YES_NO
    importing
      !IV_BOOLEAN type BOOLEAN
    returning
      value(RV_YES_NO) type ZHR_DPO_YES_NO .
protected section.
private section.
ENDCLASS.



CLASS ZCL_HR_DPO_PDF IMPLEMENTATION.


  METHOD get_yes_no.
    rv_yes_no = 'Ne'.
    IF iv_boolean = abap_true.
      rv_yes_no = 'Ano'.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
