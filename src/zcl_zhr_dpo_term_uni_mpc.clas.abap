class ZCL_ZHR_DPO_TERM_UNI_MPC definition
  public
  inheriting from /IWBEP/CL_MGW_PUSH_ABS_MODEL
  create public .

public section.

  types:
     TS_CONTROLDATA type ZCA_UF_GW_CONTROL_DATA .
  types:
TT_CONTROLDATA type standard table of TS_CONTROLDATA .
  types:
   begin of ts_text_element,
      artifact_name  type c length 40,       " technical name
      artifact_type  type c length 4,
      parent_artifact_name type c length 40, " technical name
      parent_artifact_type type c length 4,
      text_symbol    type textpoolky,
   end of ts_text_element .
  types:
         tt_text_elements type standard table of ts_text_element with key text_symbol .
  types:
     TS_CONTROLPROPERTY type ZCA_UF_GW_PROPERTY .
  types:
TT_CONTROLPROPERTY type standard table of TS_CONTROLPROPERTY .
  types:
     TS_FORMAPPROVERS type ZCA_UF_GW_APPROVERS .
  types:
TT_FORMAPPROVERS type standard table of TS_FORMAPPROVERS .
  types:
     TS_FORMATTACHMENTS type ZCA_UF_GW_ATTACH .
  types:
TT_FORMATTACHMENTS type standard table of TS_FORMATTACHMENTS .
  types:
     TS_FORMATTACHMENTSDATA type ZCA_UF_GW_ATTACH .
  types:
TT_FORMATTACHMENTSDATA type standard table of TS_FORMATTACHMENTSDATA .
  types:
     TS_FORMHEADER type ZCA_UF_GW_FORM_HEADER .
  types:
TT_FORMHEADER type standard table of TS_FORMHEADER .
  types:
     TS_FORMNOTES type ZCA_UF_GW_NOTES .
  types:
TT_FORMNOTES type standard table of TS_FORMNOTES .

  constants GC_CONTROLDATA type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'ControlData' ##NO_TEXT.
  constants GC_CONTROLPROPERTY type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'ControlProperty' ##NO_TEXT.
  constants GC_FORMAPPROVERS type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'FormApprovers' ##NO_TEXT.
  constants GC_FORMATTACHMENTS type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'FormAttachments' ##NO_TEXT.
  constants GC_FORMATTACHMENTSDATA type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'FormAttachmentsData' ##NO_TEXT.
  constants GC_FORMHEADER type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'FormHeader' ##NO_TEXT.
  constants GC_FORMNOTES type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'FormNotes' ##NO_TEXT.

  methods GET_EXTENDED_MODEL
  final
    exporting
      !EV_EXTENDED_SERVICE type /IWBEP/MED_GRP_TECHNICAL_NAME
      !EV_EXT_SERVICE_VERSION type /IWBEP/MED_GRP_VERSION
      !EV_EXTENDED_MODEL type /IWBEP/MED_MDL_TECHNICAL_NAME
      !EV_EXT_MODEL_VERSION type /IWBEP/MED_MDL_VERSION
    raising
      /IWBEP/CX_MGW_MED_EXCEPTION .
  methods LOAD_TEXT_ELEMENTS
  final
    returning
      value(RT_TEXT_ELEMENTS) type TT_TEXT_ELEMENTS
    raising
      /IWBEP/CX_MGW_MED_EXCEPTION .

  methods DEFINE
    redefinition .
  methods GET_LAST_MODIFIED
    redefinition .
protected section.
private section.
ENDCLASS.



CLASS ZCL_ZHR_DPO_TERM_UNI_MPC IMPLEMENTATION.


  method DEFINE.
*&---------------------------------------------------------------------*
*&           Generated code for the MODEL PROVIDER BASE CLASS          &*
*&                                                                     &*
*&  !!!NEVER MODIFY THIS CLASS. IN CASE YOU WANT TO CHANGE THE MODEL   &*
*&        DO THIS IN THE MODEL PROVIDER SUBCLASS!!!                    &*
*&                                                                     &*
*&---------------------------------------------------------------------*


data:
  lo_entity_type    type ref to /iwbep/if_mgw_odata_entity_typ, "#EC NEEDED
  lo_complex_type   type ref to /iwbep/if_mgw_odata_cmplx_type, "#EC NEEDED
  lo_property       type ref to /iwbep/if_mgw_odata_property, "#EC NEEDED
  lo_association    type ref to /iwbep/if_mgw_odata_assoc,  "#EC NEEDED
  lo_assoc_set      type ref to /iwbep/if_mgw_odata_assoc_set, "#EC NEEDED
  lo_ref_constraint type ref to /iwbep/if_mgw_odata_ref_constr, "#EC NEEDED
  lo_nav_property   type ref to /iwbep/if_mgw_odata_nav_prop, "#EC NEEDED
  lo_action         type ref to /iwbep/if_mgw_odata_action, "#EC NEEDED
  lo_parameter      type ref to /iwbep/if_mgw_odata_property, "#EC NEEDED
  lo_entity_set     type ref to /iwbep/if_mgw_odata_entity_set, "#EC NEEDED
  lo_complex_prop   type ref to /iwbep/if_mgw_odata_cmplx_prop. "#EC NEEDED

* Extend the model
model->extend_model( iv_model_name = 'ZCA_UNIFRAME_MDL' iv_model_version = '0001' ). "#EC NOTEXT

model->set_schema_namespace( 'ZCA_UNIFRAME_SRV' ).
  endmethod.


  method GET_EXTENDED_MODEL.
*&---------------------------------------------------------------------*
*&           Generated code for the MODEL PROVIDER BASE CLASS          &*
*&                                                                     &*
*&  !!!NEVER MODIFY THIS CLASS. IN CASE YOU WANT TO CHANGE THE MODEL   &*
*&        DO THIS IN THE MODEL PROVIDER SUBCLASS!!!                    &*
*&                                                                     &*
*&---------------------------------------------------------------------*



ev_extended_service  = 'ZCA_UNIFRAME_SRV'.                "#EC NOTEXT
ev_ext_service_version = '0001'.               "#EC NOTEXT
ev_extended_model    = 'ZCA_UNIFRAME_MDL'.                    "#EC NOTEXT
ev_ext_model_version = '0001'.                   "#EC NOTEXT
  endmethod.


  method GET_LAST_MODIFIED.
*&---------------------------------------------------------------------*
*&           Generated code for the MODEL PROVIDER BASE CLASS          &*
*&                                                                     &*
*&  !!!NEVER MODIFY THIS CLASS. IN CASE YOU WANT TO CHANGE THE MODEL   &*
*&        DO THIS IN THE MODEL PROVIDER SUBCLASS!!!                    &*
*&                                                                     &*
*&---------------------------------------------------------------------*


  constants: lc_gen_date_time type timestamp value '20210505113640'. "#EC NOTEXT
rv_last_modified = super->get_last_modified( ).
IF rv_last_modified LT lc_gen_date_time.
  rv_last_modified = lc_gen_date_time.
ENDIF.
  endmethod.


  method LOAD_TEXT_ELEMENTS.
*&---------------------------------------------------------------------*
*&           Generated code for the MODEL PROVIDER BASE CLASS          &*
*&                                                                     &*
*&  !!!NEVER MODIFY THIS CLASS. IN CASE YOU WANT TO CHANGE THE MODEL   &*
*&        DO THIS IN THE MODEL PROVIDER SUBCLASS!!!                    &*
*&                                                                     &*
*&---------------------------------------------------------------------*


data:
  lo_entity_type    type ref to /iwbep/if_mgw_odata_entity_typ,           "#EC NEEDED
  lo_complex_type   type ref to /iwbep/if_mgw_odata_cmplx_type,           "#EC NEEDED
  lo_property       type ref to /iwbep/if_mgw_odata_property,             "#EC NEEDED
  lo_association    type ref to /iwbep/if_mgw_odata_assoc,                "#EC NEEDED
  lo_assoc_set      type ref to /iwbep/if_mgw_odata_assoc_set,            "#EC NEEDED
  lo_ref_constraint type ref to /iwbep/if_mgw_odata_ref_constr,           "#EC NEEDED
  lo_nav_property   type ref to /iwbep/if_mgw_odata_nav_prop,             "#EC NEEDED
  lo_action         type ref to /iwbep/if_mgw_odata_action,               "#EC NEEDED
  lo_parameter      type ref to /iwbep/if_mgw_odata_property,             "#EC NEEDED
  lo_entity_set     type ref to /iwbep/if_mgw_odata_entity_set.           "#EC NEEDED


DATA:
     ls_text_element TYPE ts_text_element.                   "#EC NEEDED
clear ls_text_element.
  endmethod.
ENDCLASS.
