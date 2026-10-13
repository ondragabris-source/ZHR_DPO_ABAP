class ZCL_ZHR_DPO_REQUEST_MPC definition
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
  types:
     TS_REQUESTDATA type ZHR_DPO_CZAD_STRUCT .
  types:
TT_REQUESTDATA type standard table of TS_REQUESTDATA .

  constants GC_CONTROLDATA type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'ControlData' ##NO_TEXT.
  constants GC_CONTROLPROPERTY type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'ControlProperty' ##NO_TEXT.
  constants GC_FORMAPPROVERS type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'FormApprovers' ##NO_TEXT.
  constants GC_FORMATTACHMENTS type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'FormAttachments' ##NO_TEXT.
  constants GC_FORMATTACHMENTSDATA type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'FormAttachmentsData' ##NO_TEXT.
  constants GC_FORMHEADER type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'FormHeader' ##NO_TEXT.
  constants GC_FORMNOTES type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'FormNotes' ##NO_TEXT.
  constants GC_REQUESTDATA type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'RequestData' ##NO_TEXT.

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

  methods CREATE_NEW_ARTIFACTS
    raising
      /IWBEP/CX_MGW_MED_EXCEPTION .
ENDCLASS.



CLASS ZCL_ZHR_DPO_REQUEST_MPC IMPLEMENTATION.


  method CREATE_NEW_ARTIFACTS.
*&---------------------------------------------------------------------*
*&           Generated code for the MODEL PROVIDER BASE CLASS          &*
*&                                                                     &*
*&  !!!NEVER MODIFY THIS CLASS. IN CASE YOU WANT TO CHANGE THE MODEL   &*
*&        DO THIS IN THE MODEL PROVIDER SUBCLASS!!!                    &*
*&                                                                     &*
*&---------------------------------------------------------------------*


DATA:
  lo_entity_type    TYPE REF TO /iwbep/if_mgw_odata_entity_typ,                      "#EC NEEDED
  lo_complex_type   TYPE REF TO /iwbep/if_mgw_odata_cmplx_type,                      "#EC NEEDED
  lo_property       TYPE REF TO /iwbep/if_mgw_odata_property,                        "#EC NEEDED
  lo_association    TYPE REF TO /iwbep/if_mgw_odata_assoc,                           "#EC NEEDED
  lo_assoc_set      TYPE REF TO /iwbep/if_mgw_odata_assoc_set,                       "#EC NEEDED
  lo_ref_constraint TYPE REF TO /iwbep/if_mgw_odata_ref_constr,                      "#EC NEEDED
  lo_nav_property   TYPE REF TO /iwbep/if_mgw_odata_nav_prop,                        "#EC NEEDED
  lo_action         TYPE REF TO /iwbep/if_mgw_odata_action,                          "#EC NEEDED
  lo_parameter      TYPE REF TO /iwbep/if_mgw_odata_property,                        "#EC NEEDED
  lo_entity_set     TYPE REF TO /iwbep/if_mgw_odata_entity_set.                      "#EC NEEDED


***********************************************************************************************************************************
*   ENTITY - RequestData
***********************************************************************************************************************************
lo_entity_type = model->create_entity_type( iv_entity_type_name = 'RequestData' iv_def_entity_set = abap_false ). "#EC NOTEXT

***********************************************************************************************************************************
*Properties
***********************************************************************************************************************************

lo_property = lo_entity_type->create_property( iv_property_name = 'FormId' iv_abap_fieldname = 'FORM_ID' ). "#EC NOTEXT
lo_property->set_is_key( ).
lo_property->set_type_edm_guid( ).
lo_property->set_creatable( abap_false ).
lo_property->set_updatable( abap_false ).
lo_property->set_sortable( abap_false ).
lo_property->set_nullable( abap_false ).
lo_property->set_filterable( abap_false ).
lo_property = lo_entity_type->create_property( iv_property_name = 'DpoRequest' iv_abap_fieldname = 'DPO_REQUEST' ). "#EC NOTEXT
lo_property->set_is_key( ).
lo_property->set_type_edm_string( ).
lo_property->set_maxlength( iv_max_length = 10 ).
lo_property->set_creatable( abap_false ).
lo_property->set_updatable( abap_false ).
lo_property->set_sortable( abap_false ).
lo_property->set_nullable( abap_false ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'DpoYear' iv_abap_fieldname = 'DPO_YEAR' ). "#EC NOTEXT
lo_property->set_is_key( ).
lo_property->set_type_edm_string( ).
lo_property->set_maxlength( iv_max_length = 4 ).
lo_property->set_conversion_exit( 'GJAHR' ). "#EC NOTEXT
lo_property->set_creatable( abap_false ).
lo_property->set_updatable( abap_false ).
lo_property->set_sortable( abap_false ).
lo_property->set_nullable( abap_false ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'Type' iv_abap_fieldname = 'TYPE' ). "#EC NOTEXT
lo_property->set_is_key( ).
lo_property->set_type_edm_string( ).
lo_property->set_maxlength( iv_max_length = 2 ).
lo_property->set_creatable( abap_false ).
lo_property->set_updatable( abap_false ).
lo_property->set_sortable( abap_false ).
lo_property->set_nullable( abap_false ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'Theme' iv_abap_fieldname = 'THEME' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_maxlength( iv_max_length = 2 ).
lo_property->set_creatable( abap_false ).
lo_property->set_updatable( abap_false ).
lo_property->set_sortable( abap_false ).
lo_property->set_nullable( abap_false ).
lo_property->set_filterable( abap_false ).
lo_property = lo_entity_type->create_property( iv_property_name = 'DpoTemplate' iv_abap_fieldname = 'DPO_TEMPLATE' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_maxlength( iv_max_length = 10 ).
lo_property->set_creatable( abap_false ).
lo_property->set_updatable( abap_false ).
lo_property->set_sortable( abap_false ).
lo_property->set_nullable( abap_false ).
lo_property->set_filterable( abap_false ).
lo_property = lo_entity_type->create_property( iv_property_name = 'RequestDate' iv_abap_fieldname = 'REQUEST_DATE' ). "#EC NOTEXT
lo_property->set_type_edm_datetime( ).
lo_property->set_precison( iv_precision = 7 ).
lo_property->set_creatable( abap_false ).
lo_property->set_updatable( abap_false ).
lo_property->set_sortable( abap_false ).
lo_property->set_nullable( abap_false ).
lo_property->set_filterable( abap_false ).
lo_property = lo_entity_type->create_property( iv_property_name = 'Status' iv_abap_fieldname = 'STATUS' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_maxlength( iv_max_length = 10 ).
lo_property->set_creatable( abap_false ).
lo_property->set_updatable( abap_false ).
lo_property->set_sortable( abap_false ).
lo_property->set_nullable( abap_false ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'NextStatus' iv_abap_fieldname = 'NEXT_STATUS' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_maxlength( iv_max_length = 10 ).
lo_property->set_creatable( abap_false ).
lo_property->set_updatable( abap_false ).
lo_property->set_sortable( abap_false ).
lo_property->set_nullable( abap_false ).
lo_property->set_filterable( abap_false ).
lo_property = lo_entity_type->create_property( iv_property_name = 'Name' iv_abap_fieldname = 'NAME' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_maxlength( iv_max_length = 60 ).
lo_property->set_creatable( abap_false ).
lo_property->set_updatable( abap_false ).
lo_property->set_sortable( abap_false ).
lo_property->set_nullable( abap_false ).
lo_property->set_filterable( abap_false ).
lo_property = lo_entity_type->create_property( iv_property_name = 'SendDate' iv_abap_fieldname = 'SEND_DATE' ). "#EC NOTEXT
lo_property->set_type_edm_datetime( ).
lo_property->set_precison( iv_precision = 7 ).
lo_property->set_creatable( abap_false ).
lo_property->set_updatable( abap_false ).
lo_property->set_sortable( abap_false ).
lo_property->set_nullable( abap_false ).
lo_property->set_filterable( abap_false ).
lo_property = lo_entity_type->create_property( iv_property_name = 'TermId' iv_abap_fieldname = 'TERM_ID' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_maxlength( iv_max_length = 10 ).
lo_property->set_creatable( abap_false ).
lo_property->set_updatable( abap_false ).
lo_property->set_sortable( abap_false ).
lo_property->set_nullable( abap_false ).
lo_property->set_filterable( abap_false ).
lo_property = lo_entity_type->create_property( iv_property_name = 'Text' iv_abap_fieldname = 'TEXT' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_false ).
lo_property->set_updatable( abap_false ).
lo_property->set_sortable( abap_false ).
lo_property->set_nullable( abap_false ).
lo_property->set_filterable( abap_false ).
lo_property = lo_entity_type->create_property( iv_property_name = 'Uname' iv_abap_fieldname = 'UNAME' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_maxlength( iv_max_length = 12 ).
lo_property->set_creatable( abap_false ).
lo_property->set_updatable( abap_false ).
lo_property->set_sortable( abap_false ).
lo_property->set_nullable( abap_false ).
lo_property->set_filterable( abap_false ).
lo_property = lo_entity_type->create_property( iv_property_name = 'TemplateCode' iv_abap_fieldname = 'TEMPLATE_CODE' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_maxlength( iv_max_length = 4 ).
lo_property->set_creatable( abap_false ).
lo_property->set_updatable( abap_false ).
lo_property->set_sortable( abap_false ).
lo_property->set_nullable( abap_false ).
lo_property->set_filterable( abap_false ).
lo_property = lo_entity_type->create_property( iv_property_name = 'Role' iv_abap_fieldname = 'ROLE' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_maxlength( iv_max_length = 20 ).
lo_property->set_creatable( abap_false ).
lo_property->set_updatable( abap_false ).
lo_property->set_sortable( abap_false ).
lo_property->set_nullable( abap_false ).
lo_property->set_filterable( abap_true ).

lo_entity_type->bind_structure( iv_structure_name   = 'ZHR_DPO_CZAD_STRUCT'
                                iv_bind_conversions = 'X' ). "#EC NOTEXT


***********************************************************************************************************************************
*   ENTITY SETS
***********************************************************************************************************************************
lo_entity_type = model->get_entity_type( iv_entity_name = 'RequestData' ). "#EC NOTEXT
lo_entity_set = lo_entity_type->create_entity_set( 'RequestDataSet' ). "#EC NOTEXT

lo_entity_set->set_creatable( abap_false ).
lo_entity_set->set_updatable( abap_false ).
lo_entity_set->set_deletable( abap_false ).

lo_entity_set->set_pageable( abap_false ).
lo_entity_set->set_addressable( abap_false ).
lo_entity_set->set_has_ftxt_search( abap_false ).
lo_entity_set->set_subscribable( abap_false ).
lo_entity_set->set_filter_required( abap_false ).
  endmethod.


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
* New artifacts have been created in the service builder after the redefinition of service
create_new_artifacts( ).
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


  constants: lc_gen_date_time type timestamp value '20210409102922'. "#EC NOTEXT
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
