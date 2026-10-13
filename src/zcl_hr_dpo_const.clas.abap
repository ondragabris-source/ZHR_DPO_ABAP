class ZCL_HR_DPO_CONST definition
  public
  create public .

public section.

  constants DPO_PROCESS type ZHR_DPO_PROCESS value 'P-CENTR' ##NO_TEXT.
  constants DPO_DOHODA type ZHR_DPO_PROCESS value 'D-DOHODA' ##NO_TEXT.
  constants:
    BEGIN OF CS_ROLE,
      hrbp TYPE ZHR_DPO_ROLE VALUE 'HRBP',
      zadavatel TYPE ZHR_DPO_ROLE VALUE 'ZAD',
    END OF cs_role.
protected section.
private section.
ENDCLASS.



CLASS ZCL_HR_DPO_CONST IMPLEMENTATION.
ENDCLASS.
