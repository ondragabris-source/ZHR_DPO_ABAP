class ZCL_ZHR_DPO_REQUEST_01_DPC_EXT definition
  public
  inheriting from ZCL_ZHR_DPO_REQUEST_01_DPC
  create public .

public section.
protected section.

  methods REQUESTDATASET_GET_ENTITYSET
    redefinition .
private section.
ENDCLASS.



CLASS ZCL_ZHR_DPO_REQUEST_01_DPC_EXT IMPLEMENTATION.


  METHOD requestdataset_get_entityset.



LOOP AT it_filter_select_options[] ASSIGNING FIELD-SYMBOL(<fso>).
      CASE <fso>-property.
        WHEN 'RequestDate'.
            DATA(lr_request_date) = <fso>-select_options[].
         WHEN 'DpoYear'.
            DATA(lr_request_year) = <fso>-select_options[].
         WHEN 'DpoRequest'.
            DATA(lr_request) = <fso>-select_options[].
         WHEN 'DpoType'.
            DATA(lr_request_type) = <fso>-select_options[].
        WHEN OTHERS.
      ENDCASE.
ENDLOOP.


DATA(lo_request) = NEW zcl_hr_dpo_request( ).

*lo_request->read_customizing( ).

DATA(lt_output) = lo_request->get_request_list(
      request_range = lr_request
      request_type_range = lr_request_type
      request_year_range = lr_request_year
      request_date_range = lr_request_date  ).

et_entityset[] = CORRESPONDING #( lt_output ).





  ENDMETHOD.
ENDCLASS.
