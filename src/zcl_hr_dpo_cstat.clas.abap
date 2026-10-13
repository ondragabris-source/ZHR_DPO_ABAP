class ZCL_HR_DPO_CSTAT definition
  public
  create public .

public section.

  constants STATUS_SENT_TO_THE_UNIONS type ZHR_DPO_RFP_STATUS value 'SUN' ##NO_TEXT.
  constants STATUS_APPROVED_BY_HEAD_OF_SP type ZHR_DPO_RFP_STATUS value 'AVSP' ##NO_TEXT.
  constants STATUS_APPROVING_OJ type ZHR_DPO_RFP_STATUS value 'RAOJ' ##NO_TEXT.
  constants STATUS_TO_COMPLETE_OJ type ZHR_DPO_RFP_STATUS value 'RDO' ##NO_TEXT.
  constants STATUS_IN_DATA_PROCESSING_OJ type ZHR_DPO_RFP_STATUS value 'ROJ' ##NO_TEXT.
protected section.
private section.
ENDCLASS.



CLASS ZCL_HR_DPO_CSTAT IMPLEMENTATION.
ENDCLASS.
