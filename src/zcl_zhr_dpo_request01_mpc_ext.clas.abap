class ZCL_ZHR_DPO_REQUEST01_MPC_EXT definition
  public
  inheriting from ZCL_ZHR_DPO_REQUEST01_MPC
  create public .

public section.

  methods DEFINE
    redefinition .
protected section.
private section.
ENDCLASS.



CLASS ZCL_ZHR_DPO_REQUEST01_MPC_EXT IMPLEMENTATION.


  method DEFINE.


    DATA: lo_entity_type TYPE REF TO /iwbep/if_mgw_odata_entity_typ,
          lo_property    TYPE REF TO /iwbep/if_mgw_odata_property.


    DATA: lo_ann_target  TYPE REF TO /iwbep/if_mgw_vocan_ann_target.   " Vocabulary Annotation Target
    DATA: lo_annotation  TYPE REF TO /iwbep/if_mgw_vocan_annotation.   " Vocabulary Annotation
    DATA: lo_simp_value  TYPE REF TO /iwbep/if_mgw_vocan_simple_val.   " Vocabulary Annotation Simple Value
    DATA: lo_reference   TYPE REF TO /iwbep/if_mgw_vocan_reference.    " Vocabulary Annotation



    super->define( ).

*    lo_reference = vocab_anno_model->create_vocabulary_reference( iv_vocab_id = '/IWBEP/VOC_COMMON' iv_vocab_version = '0001').
*    lo_reference->create_include( iv_namespace = 'com.sap.vocabularies.Common.v1' iv_alias = 'Common' ).
*
*    "annotations for entity type "Product" and property "Category"
*
*    lo_ann_target = vocab_anno_model->create_annotations_target( 'Enabled/Disabled' ).
*    lo_ann_target->set_namespace_qualifier( 'SUPP_VAL' ).    "change the namespace to the SRV namespace
*
*    "map medium description to label
*    lo_annotation = lo_ann_target->create_annotation( iv_term = 'Tile.Disabled' ).
*    lo_simp_value = lo_annotation->create_simple_value( ).
*    lo_simp_value->set_boolean( iv_value = abap_true ).


**********************************************************************
    lo_entity_type = model->get_entity_type( 'RequestAttch' ).
    lo_entity_type->set_is_media( abap_true ).

    IF lo_entity_type IS BOUND.
*      lo_property = lo_entity_type->get_property( iv_property_name = 'DpoRequest' ).
*      lo_property->set_as_content_type( ).
*      lo_property = lo_entity_type->get_property( iv_property_name = 'Uname' ).
*      lo_property->set_as_content_type( ).
*      lo_property = lo_entity_type->get_property( iv_property_name = 'DocType' ).
*      lo_property->set_as_content_type( ).
*     lo_property = lo_entity_type->get_property( iv_property_name = 'Guid' ).
*      lo_property->set_as_content_type( ).
*
*      lo_property = lo_entity_type->get_property( iv_property_name = 'DocId' ).
*      lo_property->set_as_content_type( ).
*
*      lo_property = lo_entity_type->get_property( iv_property_name = 'ObjectId' ).
*      lo_property->set_as_content_type( ).
*      lo_property = lo_entity_type->get_property( iv_property_name = 'Filename' ).
*      lo_property->set_as_content_type( ).
      lo_property = lo_entity_type->get_property( iv_property_name = 'Mimetype' ).
      lo_property->set_as_content_type( ).
*       lo_property = lo_entity_type->get_property( iv_property_name = 'Status' ).
**      lo_property->set_as_content_type( ).
*      lo_property->set_as_content_type( ).
*      lo_property = lo_entity_type->get_property( iv_property_name = 'ValidateAc' ).
*      lo_property->set_as_content_type( ).
*      lo_property = lo_entity_type->get_property( iv_property_name = 'Posit' ).
*      lo_property->set_as_content_type( ).
*          lo_property = lo_entity_type->get_property( iv_property_name = 'Link' ).
*      lo_property->set_as_content_type( ).
**
    ENDIF.

*    lo_entity_type = model->get_entity_type( iv_entity_name = 'ClaimItem' ).
*    lo_entity_type->get_property( iv_property_name = 'Matnr' )->set_conversion_exit(
*      EXPORTING
*        iv_conv_exit  = 'MATSD'
**          iv_round_sign = space            " Unit amount only (+ up, - down, X commercial, b no rounding)
*    ).


  endmethod.
ENDCLASS.
