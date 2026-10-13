class ZCL_ZHR_DPO_REQUEST_UN_DPC_EXT definition
  public
  inheriting from ZCL_ZHR_DPO_REQUEST_UN_DPC
  create public .

public section.

  methods /IWBEP/IF_MGW_APPL_SRV_RUNTIME~CREATE_ENTITY
    redefinition .
  methods /IWBEP/IF_MGW_APPL_SRV_RUNTIME~GET_ENTITY
    redefinition .
  methods /IWBEP/IF_MGW_APPL_SRV_RUNTIME~GET_ENTITYSET
    redefinition .
  methods /IWBEP/IF_MGW_APPL_SRV_RUNTIME~GET_STREAM
    redefinition .
protected section.

  methods REQUESTDATASET_GET_ENTITYSET
    importing
      !IV_ENTITY_NAME type STRING
      !IV_ENTITY_SET_NAME type STRING
      !IV_SOURCE_NAME type STRING
      !IT_FILTER_SELECT_OPTIONS type /IWBEP/T_MGW_SELECT_OPTION
      !IS_PAGING type /IWBEP/S_MGW_PAGING
      !IT_KEY_TAB type /IWBEP/T_MGW_NAME_VALUE_PAIR
      !IT_NAVIGATION_PATH type /IWBEP/T_MGW_NAVIGATION_PATH
      !IT_ORDER type /IWBEP/T_MGW_SORTING_ORDER
      !IV_FILTER_STRING type STRING
      !IV_SEARCH_STRING type STRING
      !IO_TECH_REQUEST_CONTEXT type ref to /IWBEP/IF_MGW_REQ_ENTITYSET
    exporting
      !ET_ENTITYSET type ZCL_ZHR_DPO_REQUEST01_MPC=>TT_REQUESTDATA
      !ES_RESPONSE_CONTEXT type /IWBEP/IF_MGW_APPL_SRV_RUNTIME=>TY_S_MGW_RESPONSE_CONTEXT .
  methods THEMESET_GET_ENTITYSET
    importing
      !IV_ENTITY_NAME type STRING
      !IV_ENTITY_SET_NAME type STRING
      !IV_SOURCE_NAME type STRING
      !IT_FILTER_SELECT_OPTIONS type /IWBEP/T_MGW_SELECT_OPTION
      !IS_PAGING type /IWBEP/S_MGW_PAGING
      !IT_KEY_TAB type /IWBEP/T_MGW_NAME_VALUE_PAIR
      !IT_NAVIGATION_PATH type /IWBEP/T_MGW_NAVIGATION_PATH
      !IT_ORDER type /IWBEP/T_MGW_SORTING_ORDER
      !IV_FILTER_STRING type STRING
      !IV_SEARCH_STRING type STRING
      !IO_TECH_REQUEST_CONTEXT type ref to /IWBEP/IF_MGW_REQ_ENTITYSET
    exporting
      !ET_ENTITYSET type ZCL_ZHR_DPO_REQUEST01_MPC=>TT_THEME
      !ES_RESPONSE_CONTEXT type /IWBEP/IF_MGW_APPL_SRV_RUNTIME=>TY_S_MGW_RESPONSE_CONTEXT .
  methods TEMPLATESET_GET_ENTITYSET
    importing
      !IV_ENTITY_NAME type STRING
      !IV_ENTITY_SET_NAME type STRING
      !IV_SOURCE_NAME type STRING
      !IT_FILTER_SELECT_OPTIONS type /IWBEP/T_MGW_SELECT_OPTION
      !IS_PAGING type /IWBEP/S_MGW_PAGING
      !IT_KEY_TAB type /IWBEP/T_MGW_NAME_VALUE_PAIR
      !IT_NAVIGATION_PATH type /IWBEP/T_MGW_NAVIGATION_PATH
      !IT_ORDER type /IWBEP/T_MGW_SORTING_ORDER
      !IV_FILTER_STRING type STRING
      !IV_SEARCH_STRING type STRING
      !IO_TECH_REQUEST_CONTEXT type ref to /IWBEP/IF_MGW_REQ_ENTITYSET optional
    exporting
      !ET_ENTITYSET type ZCL_ZHR_DPO_REQUEST01_MPC=>TT_TEMPLATE
      !ES_RESPONSE_CONTEXT type /IWBEP/IF_MGW_APPL_SRV_RUNTIME=>TY_S_MGW_RESPONSE_CONTEXT .
  methods REQUESTDATASET_GET_ENTITY
    importing
      !IV_ENTITY_NAME type STRING
      !IV_ENTITY_SET_NAME type STRING
      !IV_SOURCE_NAME type STRING
      !IT_KEY_TAB type /IWBEP/T_MGW_NAME_VALUE_PAIR
      !IO_REQUEST_OBJECT type ref to /IWBEP/IF_MGW_REQ_ENTITY optional
      !IO_TECH_REQUEST_CONTEXT type ref to /IWBEP/IF_MGW_REQ_ENTITY optional
      !IT_NAVIGATION_PATH type /IWBEP/T_MGW_NAVIGATION_PATH
    exporting
      !ER_ENTITY type ZCL_ZHR_DPO_REQUEST01_MPC=>TS_REQUESTDATA
      !ES_RESPONSE_CONTEXT type /IWBEP/IF_MGW_APPL_SRV_RUNTIME=>TY_S_MGW_RESPONSE_ENTITY_CNTXT .
  methods DEPUTYSET_GET_ENTITYSET
    importing
      !IV_ENTITY_NAME type STRING
      !IV_ENTITY_SET_NAME type STRING
      !IV_SOURCE_NAME type STRING
      !IT_FILTER_SELECT_OPTIONS type /IWBEP/T_MGW_SELECT_OPTION
      !IS_PAGING type /IWBEP/S_MGW_PAGING
      !IT_KEY_TAB type /IWBEP/T_MGW_NAME_VALUE_PAIR
      !IT_NAVIGATION_PATH type /IWBEP/T_MGW_NAVIGATION_PATH
      !IT_ORDER type /IWBEP/T_MGW_SORTING_ORDER
      !IV_FILTER_STRING type STRING
      !IV_SEARCH_STRING type STRING
      !IO_TECH_REQUEST_CONTEXT type ref to /IWBEP/IF_MGW_REQ_ENTITYSET optional
    exporting
      !ET_ENTITYSET type ZCL_ZHR_DPO_REQUEST01_MPC=>TT_DEPUTY
      !ES_RESPONSE_CONTEXT type /IWBEP/IF_MGW_APPL_SRV_RUNTIME=>TY_S_MGW_RESPONSE_CONTEXT .
  methods REQUESTDATASET_CREATE_ENTITY
    importing
      !IV_ENTITY_NAME type STRING
      !IV_ENTITY_SET_NAME type STRING
      !IV_SOURCE_NAME type STRING
      !IT_KEY_TAB type /IWBEP/T_MGW_NAME_VALUE_PAIR
      !IO_TECH_REQUEST_CONTEXT type ref to /IWBEP/IF_MGW_REQ_ENTITY_C
      !IT_NAVIGATION_PATH type /IWBEP/T_MGW_NAVIGATION_PATH
      !IO_DATA_PROVIDER type ref to /IWBEP/IF_MGW_ENTRY_PROVIDER optional
    exporting
      !ER_ENTITY type ZCL_ZHR_DPO_REQUEST01_MPC=>TS_REQUESTDATA .
  methods REQUESTATTCHDIRS_GET_ENTITYSET
    importing
      !IV_ENTITY_NAME type STRING
      !IV_ENTITY_SET_NAME type STRING
      !IV_SOURCE_NAME type STRING
      !IT_FILTER_SELECT_OPTIONS type /IWBEP/T_MGW_SELECT_OPTION
      !IS_PAGING type /IWBEP/S_MGW_PAGING
      !IT_KEY_TAB type /IWBEP/T_MGW_NAME_VALUE_PAIR
      !IT_NAVIGATION_PATH type /IWBEP/T_MGW_NAVIGATION_PATH
      !IT_ORDER type /IWBEP/T_MGW_SORTING_ORDER
      !IV_FILTER_STRING type STRING
      !IV_SEARCH_STRING type STRING
      !IO_TECH_REQUEST_CONTEXT type ref to /IWBEP/IF_MGW_REQ_ENTITYSET
    exporting
      !ET_ENTITYSET type ZCL_ZHR_DPO_REQUEST01_MPC=>TT_REQUESTATTCHDIR
      !ES_RESPONSE_CONTEXT type /IWBEP/IF_MGW_APPL_SRV_RUNTIME=>TY_S_MGW_RESPONSE_CONTEXT .
  methods REQHISTORYSET_GET_ENTITYSET
    importing
      !IV_ENTITY_NAME type STRING
      !IV_ENTITY_SET_NAME type STRING
      !IV_SOURCE_NAME type STRING
      !IT_FILTER_SELECT_OPTIONS type /IWBEP/T_MGW_SELECT_OPTION
      !IS_PAGING type /IWBEP/S_MGW_PAGING
      !IT_KEY_TAB type /IWBEP/T_MGW_NAME_VALUE_PAIR
      !IT_NAVIGATION_PATH type /IWBEP/T_MGW_NAVIGATION_PATH
      !IT_ORDER type /IWBEP/T_MGW_SORTING_ORDER
      !IV_FILTER_STRING type STRING
      !IV_SEARCH_STRING type STRING
      !IO_TECH_REQUEST_CONTEXT type ref to /IWBEP/IF_MGW_REQ_ENTITYSET
    exporting
      !ET_ENTITYSET type ZCL_ZHR_DPO_REQUEST01_MPC=>TT_REQHISTORY
      !ES_RESPONSE_CONTEXT type /IWBEP/IF_MGW_APPL_SRV_RUNTIME=>TY_S_MGW_RESPONSE_CONTEXT .
  methods AUTHSTRUCSET_GET_ENTITY
    importing
      !IV_ENTITY_NAME type STRING
      !IV_ENTITY_SET_NAME type STRING
      !IV_SOURCE_NAME type STRING
      !IT_KEY_TAB type /IWBEP/T_MGW_NAME_VALUE_PAIR
      !IO_REQUEST_OBJECT type ref to /IWBEP/IF_MGW_REQ_ENTITY optional
      !IO_TECH_REQUEST_CONTEXT type ref to /IWBEP/IF_MGW_REQ_ENTITY
      !IT_NAVIGATION_PATH type /IWBEP/T_MGW_NAVIGATION_PATH
    exporting
      !ER_ENTITY type ZCL_ZHR_DPO_REQUEST_UN_MPC=>TS_AUTHSTRUC
      !ES_RESPONSE_CONTEXT type /IWBEP/IF_MGW_APPL_SRV_RUNTIME=>TY_S_MGW_RESPONSE_ENTITY_CNTXT .
  methods AGREEMENTDATASET_GET_ENTITYSET
    importing
      !IV_ENTITY_NAME type STRING
      !IV_ENTITY_SET_NAME type STRING
      !IV_SOURCE_NAME type STRING
      !IT_FILTER_SELECT_OPTIONS type /IWBEP/T_MGW_SELECT_OPTION
      !IS_PAGING type /IWBEP/S_MGW_PAGING
      !IT_KEY_TAB type /IWBEP/T_MGW_NAME_VALUE_PAIR
      !IT_NAVIGATION_PATH type /IWBEP/T_MGW_NAVIGATION_PATH
      !IT_ORDER type /IWBEP/T_MGW_SORTING_ORDER
      !IV_FILTER_STRING type STRING
      !IV_SEARCH_STRING type STRING
      !IO_TECH_REQUEST_CONTEXT type ref to /IWBEP/IF_MGW_REQ_ENTITYSET
    exporting
      !ET_ENTITYSET type ZCL_ZHR_DPO_REQUEST_UN_MPC=>TT_AGREEMENT
      !ES_RESPONSE_CONTEXT type /IWBEP/IF_MGW_APPL_SRV_RUNTIME=>TY_S_MGW_RESPONSE_CONTEXT .
  methods AGREEMENTDATASET_GET_ENTITY
    importing
      !IV_ENTITY_NAME type STRING
      !IV_ENTITY_SET_NAME type STRING
      !IV_SOURCE_NAME type STRING
      !IT_FILTER_SELECT_OPTIONS type /IWBEP/T_MGW_SELECT_OPTION
      !IS_PAGING type /IWBEP/S_MGW_PAGING
      !IT_KEY_TAB type /IWBEP/T_MGW_NAME_VALUE_PAIR
      !IT_NAVIGATION_PATH type /IWBEP/T_MGW_NAVIGATION_PATH
      !IT_ORDER type /IWBEP/T_MGW_SORTING_ORDER
      !IV_FILTER_STRING type STRING
      !IV_SEARCH_STRING type STRING
      !IO_TECH_REQUEST_CONTEXT type ref to /IWBEP/IF_MGW_REQ_ENTITYSET
    exporting
      !ET_ENTITYSET type ZCL_ZHR_DPO_REQUEST_UN_MPC=>TT_AGREEMENT
      !ES_RESPONSE_CONTEXT type /IWBEP/IF_MGW_APPL_SRV_RUNTIME=>TY_S_MGW_RESPONSE_CONTEXT .
  methods OTHERAPPROVERSSE_GET_ENTITYSET
    importing
      !IV_ENTITY_NAME type STRING
      !IV_ENTITY_SET_NAME type STRING
      !IV_SOURCE_NAME type STRING
      !IT_FILTER_SELECT_OPTIONS type /IWBEP/T_MGW_SELECT_OPTION
      !IS_PAGING type /IWBEP/S_MGW_PAGING
      !IT_KEY_TAB type /IWBEP/T_MGW_NAME_VALUE_PAIR
      !IT_NAVIGATION_PATH type /IWBEP/T_MGW_NAVIGATION_PATH
      !IT_ORDER type /IWBEP/T_MGW_SORTING_ORDER
      !IV_FILTER_STRING type STRING
      !IV_SEARCH_STRING type STRING
      !IO_TECH_REQUEST_CONTEXT type ref to /IWBEP/IF_MGW_REQ_ENTITYSET optional
    exporting
      !ET_ENTITYSET type ZCL_ZHR_DPO_REQUEST01_MPC=>TT_OTHERAPPROVERS
      !ES_RESPONSE_CONTEXT type /IWBEP/IF_MGW_APPL_SRV_RUNTIME=>TY_S_MGW_RESPONSE_CONTEXT .
private section.
ENDCLASS.



CLASS ZCL_ZHR_DPO_REQUEST_UN_DPC_EXT IMPLEMENTATION.


  method /IWBEP/IF_MGW_APPL_SRV_RUNTIME~CREATE_ENTITY.
**try.
*CALL METHOD SUPER->/IWBEP/IF_MGW_APPL_SRV_RUNTIME~CREATE_ENTITY
*  EXPORTING
**    iv_entity_name          =
**    iv_entity_set_name      =
**    iv_source_name          =
*    IO_DATA_PROVIDER        =
**    it_key_tab              =
**    it_navigation_path      =
**    io_tech_request_context =
**  importing
**    er_entity               =
*    .
**  catch /iwbep/cx_mgw_busi_exception.
**  catch /iwbep/cx_mgw_tech_exception.
**endtry.

*&----------------------------------------------------------------------------------------------*
*&  Include           /IWBEP/DPC_TEMP_CRT_ENTITY_BASE
*&* This class has been generated on 12.07.2016 14:45:09 in client 010
*&*
*&*       WARNING--> NEVER MODIFY THIS CLASS <--WARNING
*&*   If you want to change the DPC implementation, use the
*&*   generated methods inside the DPC provider subclass - ZCL_CA_UF_DPC_EXT
*&-----------------------------------------------------------------------------------------------*

 DATA controlpropertys_create_entity TYPE zcl_ca_uf_mpc=>ts_controlproperty.
 DATA approversset_create_entity TYPE zcl_ca_uf_mpc=>ts_formapprovers.
 DATA controldataset_create_entity TYPE zcl_ca_uf_mpc=>ts_controldata.
 DATA formheaderset_create_entity TYPE zcl_ca_uf_mpc=>ts_formheader.
 DATA formattachment01_create_entity TYPE zcl_ca_uf_mpc=>ts_formattachmentsdata.
 DATA notesset_create_entity TYPE zcl_ca_uf_mpc=>ts_formnotes.
 DATA attachmentsset_create_entity TYPE zcl_ca_uf_mpc=>ts_formattachments.
 DATA lv_entityset_name TYPE string.
 DATA requestdataset_create_entity TYPE ZCL_ZHR_DPO_REQUEST01_MPC=>TS_REQUESTDATA.

lv_entityset_name = io_tech_request_context->get_entity_set_name( ).

CASE lv_entityset_name.
*-------------------------------------------------------------------------*
*             EntitySet -  ControlPropertySet
*-------------------------------------------------------------------------*
     WHEN 'RequestDataSet'.
*     Call the entity set generated method
    requestdataset_create_entity(
         EXPORTING iv_entity_name     = iv_entity_name
                   iv_entity_set_name = iv_entity_set_name
                   iv_source_name     = iv_source_name
                   io_data_provider   = io_data_provider
                   it_key_tab         = it_key_tab
                   it_navigation_path = it_navigation_path
                   io_tech_request_context = io_tech_request_context
       	 IMPORTING er_entity          = requestdataset_create_entity
    ).
*     Send specific entity data to the caller interfaces
    copy_data_to_ref(
      EXPORTING
        is_data = requestdataset_create_entity
      CHANGING
        cr_data = er_entity
   ).


     WHEN 'ControlPropertySet'.
*     Call the entity set generated method
    controlpropertys_create_entity(
         EXPORTING iv_entity_name     = iv_entity_name
                   iv_entity_set_name = iv_entity_set_name
                   iv_source_name     = iv_source_name
                   io_data_provider   = io_data_provider
                   it_key_tab         = it_key_tab
                   it_navigation_path = it_navigation_path
                   io_tech_request_context = io_tech_request_context
       	 IMPORTING er_entity          = controlpropertys_create_entity
    ).
*     Send specific entity data to the caller interfaces
    copy_data_to_ref(
      EXPORTING
        is_data = controlpropertys_create_entity
      CHANGING
        cr_data = er_entity
   ).

*-------------------------------------------------------------------------*
*             EntitySet -  FormApproversSet
*-------------------------------------------------------------------------*
     WHEN 'FormApproversSet'.
*     Call the entity set generated method
    approversset_create_entity(
         EXPORTING iv_entity_name     = iv_entity_name
                   iv_entity_set_name = iv_entity_set_name
                   iv_source_name     = iv_source_name
                   io_data_provider   = io_data_provider
                   it_key_tab         = it_key_tab
                   it_navigation_path = it_navigation_path
                   io_tech_request_context = io_tech_request_context
       	 IMPORTING er_entity          = approversset_create_entity
    ).
*     Send specific entity data to the caller interfaces
    copy_data_to_ref(
      EXPORTING
        is_data = approversset_create_entity
      CHANGING
        cr_data = er_entity
   ).

*-------------------------------------------------------------------------*
*             EntitySet -  ControlDataSet
*-------------------------------------------------------------------------*
     WHEN 'ControlDataSet'.
*     Call the entity set generated method
    controldataset_create_entity(
         EXPORTING iv_entity_name     = iv_entity_name
                   iv_entity_set_name = iv_entity_set_name
                   iv_source_name     = iv_source_name
                   io_data_provider   = io_data_provider
                   it_key_tab         = it_key_tab
                   it_navigation_path = it_navigation_path
                   io_tech_request_context = io_tech_request_context
       	 IMPORTING er_entity          = controldataset_create_entity
    ).
*     Send specific entity data to the caller interfaces
    copy_data_to_ref(
      EXPORTING
        is_data = controldataset_create_entity
      CHANGING
        cr_data = er_entity
   ).

*-------------------------------------------------------------------------*
*             EntitySet -  FormHeaderSet
*-------------------------------------------------------------------------*
     WHEN 'FormHeaderSet'.
*     Call the entity set generated method
    formheaderset_create_entity(
         EXPORTING iv_entity_name     = iv_entity_name
                   iv_entity_set_name = iv_entity_set_name
                   iv_source_name     = iv_source_name
                   io_data_provider   = io_data_provider
                   it_key_tab         = it_key_tab
                   it_navigation_path = it_navigation_path
                   io_tech_request_context = io_tech_request_context
       	 IMPORTING er_entity          = formheaderset_create_entity
    ).
*     Send specific entity data to the caller interfaces
    copy_data_to_ref(
      EXPORTING
        is_data = formheaderset_create_entity
      CHANGING
        cr_data = er_entity
   ).

*-------------------------------------------------------------------------*
*             EntitySet -  FormAttachmentsDataSet
*-------------------------------------------------------------------------*
     WHEN 'FormAttachmentsDataSet'.
*     Call the entity set generated method
    formattachment01_create_entity(
         EXPORTING iv_entity_name     = iv_entity_name
                   iv_entity_set_name = iv_entity_set_name
                   iv_source_name     = iv_source_name
                   io_data_provider   = io_data_provider
                   it_key_tab         = it_key_tab
                   it_navigation_path = it_navigation_path
                   io_tech_request_context = io_tech_request_context
       	 IMPORTING er_entity          = formattachment01_create_entity
    ).
*     Send specific entity data to the caller interfaces
    copy_data_to_ref(
      EXPORTING
        is_data = formattachment01_create_entity
      CHANGING
        cr_data = er_entity
   ).

*-------------------------------------------------------------------------*
*             EntitySet -  FormNotesSet
*-------------------------------------------------------------------------*
     WHEN 'FormNotesSet'.
*     Call the entity set generated method
    notesset_create_entity(
         EXPORTING iv_entity_name     = iv_entity_name
                   iv_entity_set_name = iv_entity_set_name
                   iv_source_name     = iv_source_name
                   io_data_provider   = io_data_provider
                   it_key_tab         = it_key_tab
                   it_navigation_path = it_navigation_path
                   io_tech_request_context = io_tech_request_context
       	 IMPORTING er_entity          = notesset_create_entity
    ).
*     Send specific entity data to the caller interfaces
    copy_data_to_ref(
      EXPORTING
        is_data = notesset_create_entity
      CHANGING
        cr_data = er_entity
   ).

*-------------------------------------------------------------------------*
*             EntitySet -  FormAttachmentsSet
*-------------------------------------------------------------------------*
     WHEN 'FormAttachmentsSet'.
*     Call the entity set generated method
    attachmentsset_create_entity(
         EXPORTING iv_entity_name     = iv_entity_name
                   iv_entity_set_name = iv_entity_set_name
                   iv_source_name     = iv_source_name
                   io_data_provider   = io_data_provider
                   it_key_tab         = it_key_tab
                   it_navigation_path = it_navigation_path
                   io_tech_request_context = io_tech_request_context
       	 IMPORTING er_entity          = attachmentsset_create_entity
    ).
*     Send specific entity data to the caller interfaces
    copy_data_to_ref(
      EXPORTING
        is_data = attachmentsset_create_entity
      CHANGING
        cr_data = er_entity
   ).

  when others.
    super->/iwbep/if_mgw_appl_srv_runtime~create_entity(
       EXPORTING
         iv_entity_name = iv_entity_name
         iv_entity_set_name = iv_entity_set_name
         iv_source_name = iv_source_name
         io_data_provider   = io_data_provider
         it_key_tab = it_key_tab
         it_navigation_path = it_navigation_path
      IMPORTING
        er_entity = er_entity
  ).
ENDCASE.


  endmethod.


  method /IWBEP/IF_MGW_APPL_SRV_RUNTIME~GET_ENTITY.
**try.
*CALL METHOD SUPER->/IWBEP/IF_MGW_APPL_SRV_RUNTIME~GET_ENTITY
**  exporting
**    iv_entity_name          =
**    iv_entity_set_name      =
**    iv_source_name          =
**    it_key_tab              =
**    it_navigation_path      =
**    io_tech_request_context =
**  importing
**    er_entity               =
**    es_response_context     =
*    .
**  catch /iwbep/cx_mgw_busi_exception.
**  catch /iwbep/cx_mgw_tech_exception.
**endtry.

DATA attachmentsset_get_entity TYPE zcl_ca_uf_mpc=>ts_formattachments.
 DATA formheaderset_get_entity TYPE zcl_ca_uf_mpc=>ts_formheader.
 DATA formattachment01_get_entity TYPE zcl_ca_uf_mpc=>ts_formattachmentsdata.
 DATA notesset_get_entity TYPE zcl_ca_uf_mpc=>ts_formnotes.
 DATA controldataset_get_entity TYPE zcl_ca_uf_mpc=>ts_controldata.
 DATA controlpropertys_get_entity TYPE zcl_ca_uf_mpc=>ts_controlproperty.
 DATA approversset_get_entity TYPE zcl_ca_uf_mpc=>ts_formapprovers.
 DATA lv_entityset_name TYPE string.
 DATA lr_entity TYPE REF TO data.
 DATA  authstrucset_get_entity TYPE zcl_zhr_dpo_request_un_mpc=>ts_authstruc.
 DATA: requestdataset_get_entity TYPE zcl_zhr_dpo_request_un_mpc=>ts_requestdata.
 DATA: requestattchdirset_get_entity TYPE zcl_zhr_dpo_request_un_mpc=>ts_requestattchdir.

lv_entityset_name = io_tech_request_context->get_entity_set_name( ).

CASE lv_entityset_name.
*-------------------------------------------------------------------------*
*             EntitySet -  FormAttachmentsSet
*-------------------------------------------------------------------------*
      WHEN 'AuthStrucSet'.
         AuthStrucSet_get_entity(
               EXPORTING iv_entity_name     = iv_entity_name
                         iv_entity_set_name = iv_entity_set_name
                         iv_source_name     = iv_source_name
                         it_key_tab         = it_key_tab
                         it_navigation_path = it_navigation_path
                         io_tech_request_context = io_tech_request_context
             	 IMPORTING er_entity          = authstrucset_get_entity
                         es_response_context = es_response_context
          ).

        IF authstrucset_get_entity IS NOT INITIAL.
*     Send specific entity data to the caller interface
          copy_data_to_ref(
            EXPORTING
              is_data = authstrucset_get_entity
            CHANGING
              cr_data = er_entity ).

       ENDIF.
      WHEN 'RequestAttchDirSet'.
*         requestattchdirs_get_entityset(
*               EXPORTING iv_entity_name     = iv_entity_name
*                         iv_entity_set_name = iv_entity_set_name
*                         iv_source_name     = iv_source_name
*                         it_key_tab         = it_key_tab
*                         it_navigation_path = it_navigation_path
*                         io_tech_request_context = io_tech_request_context
*                IMPORTING er_entity          = requestdataset_get_entity
*                         es_response_context = es_response_context
*          ).
*
*        IF requestdataset_get_entity IS NOT INITIAL.
**     Send specific entity data to the caller interface
*          copy_data_to_ref(
*            EXPORTING
*              is_data = requestattchdirset_get_entity
*            CHANGING
*              cr_data = er_entity
*          ).

      WHEN 'RequestDataSet'.
*     Call the entity set generated method
          requestdataset_get_entity(
               EXPORTING iv_entity_name     = iv_entity_name
                         iv_entity_set_name = iv_entity_set_name
                         iv_source_name     = iv_source_name
                         it_key_tab         = it_key_tab
                         it_navigation_path = it_navigation_path
                         io_tech_request_context = io_tech_request_context
             	 IMPORTING er_entity          = requestdataset_get_entity
                         es_response_context = es_response_context
          ).

        IF requestdataset_get_entity IS NOT INITIAL.
*     Send specific entity data to the caller interface
          copy_data_to_ref(
            EXPORTING
              is_data = requestdataset_get_entity
            CHANGING
              cr_data = er_entity
          ).
        ELSE.
*         In case of initial values - unbind the entity reference
          er_entity = lr_entity.
        ENDIF.
      WHEN 'FormAttachmentsSet'.
*     Call the entity set generated method
          attachmentsset_get_entity(
               EXPORTING iv_entity_name     = iv_entity_name
                         iv_entity_set_name = iv_entity_set_name
                         iv_source_name     = iv_source_name
                         it_key_tab         = it_key_tab
                         it_navigation_path = it_navigation_path
                         io_tech_request_context = io_tech_request_context
             	 IMPORTING er_entity          = attachmentsset_get_entity
                         es_response_context = es_response_context
          ).

        IF attachmentsset_get_entity IS NOT INITIAL.
*     Send specific entity data to the caller interface
          copy_data_to_ref(
            EXPORTING
              is_data = attachmentsset_get_entity
            CHANGING
              cr_data = er_entity
          ).
        ELSE.
*         In case of initial values - unbind the entity reference
          er_entity = lr_entity.
        ENDIF.
*-------------------------------------------------------------------------*
*             EntitySet -  FormHeaderSet
*-------------------------------------------------------------------------*
      WHEN 'FormHeaderSet'.
*     Call the entity set generated method
          formheaderset_get_entity(
               EXPORTING iv_entity_name     = iv_entity_name
                         iv_entity_set_name = iv_entity_set_name
                         iv_source_name     = iv_source_name
                         it_key_tab         = it_key_tab
                         it_navigation_path = it_navigation_path
                         io_tech_request_context = io_tech_request_context
             	 IMPORTING er_entity          = formheaderset_get_entity
                         es_response_context = es_response_context
          ).

        IF formheaderset_get_entity IS NOT INITIAL.
*     Send specific entity data to the caller interface
          copy_data_to_ref(
            EXPORTING
              is_data = formheaderset_get_entity
            CHANGING
              cr_data = er_entity
          ).
        ELSE.
*         In case of initial values - unbind the entity reference
          er_entity = lr_entity.
        ENDIF.
*-------------------------------------------------------------------------*
*             EntitySet -  FormAttachmentsDataSet
*-------------------------------------------------------------------------*
      WHEN 'FormAttachmentsDataSet'.
*     Call the entity set generated method
          formattachment01_get_entity(
               EXPORTING iv_entity_name     = iv_entity_name
                         iv_entity_set_name = iv_entity_set_name
                         iv_source_name     = iv_source_name
                         it_key_tab         = it_key_tab
                         it_navigation_path = it_navigation_path
                         io_tech_request_context = io_tech_request_context
             	 IMPORTING er_entity          = formattachment01_get_entity
                         es_response_context = es_response_context
          ).

        IF formattachment01_get_entity IS NOT INITIAL.
*     Send specific entity data to the caller interface
          copy_data_to_ref(
            EXPORTING
              is_data = formattachment01_get_entity
            CHANGING
              cr_data = er_entity
          ).
        ELSE.
*         In case of initial values - unbind the entity reference
          er_entity = lr_entity.
        ENDIF.
*-------------------------------------------------------------------------*
*             EntitySet -  FormNotesSet
*-------------------------------------------------------------------------*
      WHEN 'FormNotesSet'.
*     Call the entity set generated method
          notesset_get_entity(
               EXPORTING iv_entity_name     = iv_entity_name
                         iv_entity_set_name = iv_entity_set_name
                         iv_source_name     = iv_source_name
                         it_key_tab         = it_key_tab
                         it_navigation_path = it_navigation_path
                         io_tech_request_context = io_tech_request_context
             	 IMPORTING er_entity          = notesset_get_entity
                         es_response_context = es_response_context
          ).

        IF notesset_get_entity IS NOT INITIAL.
*     Send specific entity data to the caller interface
          copy_data_to_ref(
            EXPORTING
              is_data = notesset_get_entity
            CHANGING
              cr_data = er_entity
          ).
        ELSE.
*         In case of initial values - unbind the entity reference
          er_entity = lr_entity.
        ENDIF.
*-------------------------------------------------------------------------*
*             EntitySet -  ControlDataSet
*-------------------------------------------------------------------------*
      WHEN 'ControlDataSet'.
*     Call the entity set generated method
          controldataset_get_entity(
               EXPORTING iv_entity_name     = iv_entity_name
                         iv_entity_set_name = iv_entity_set_name
                         iv_source_name     = iv_source_name
                         it_key_tab         = it_key_tab
                         it_navigation_path = it_navigation_path
                         io_tech_request_context = io_tech_request_context
             	 IMPORTING er_entity          = controldataset_get_entity
                         es_response_context = es_response_context
          ).

        IF controldataset_get_entity IS NOT INITIAL.
*     Send specific entity data to the caller interface
          copy_data_to_ref(
            EXPORTING
              is_data = controldataset_get_entity
            CHANGING
              cr_data = er_entity
          ).
        ELSE.
*         In case of initial values - unbind the entity reference
          er_entity = lr_entity.
        ENDIF.
*-------------------------------------------------------------------------*
*             EntitySet -  ControlPropertySet
*-------------------------------------------------------------------------*
      WHEN 'ControlPropertySet'.
*     Call the entity set generated method
          controlpropertys_get_entity(
               EXPORTING iv_entity_name     = iv_entity_name
                         iv_entity_set_name = iv_entity_set_name
                         iv_source_name     = iv_source_name
                         it_key_tab         = it_key_tab
                         it_navigation_path = it_navigation_path
                         io_tech_request_context = io_tech_request_context
             	 IMPORTING er_entity          = controlpropertys_get_entity
                         es_response_context = es_response_context
          ).

        IF controlpropertys_get_entity IS NOT INITIAL.
*     Send specific entity data to the caller interface
          copy_data_to_ref(
            EXPORTING
              is_data = controlpropertys_get_entity
            CHANGING
              cr_data = er_entity
          ).
        ELSE.
*         In case of initial values - unbind the entity reference
          er_entity = lr_entity.
        ENDIF.
*-------------------------------------------------------------------------*
*             EntitySet -  FormApproversSet
*-------------------------------------------------------------------------*
      WHEN 'FormApproversSet'.
*     Call the entity set generated method
          approversset_get_entity(
               EXPORTING iv_entity_name     = iv_entity_name
                         iv_entity_set_name = iv_entity_set_name
                         iv_source_name     = iv_source_name
                         it_key_tab         = it_key_tab
                         it_navigation_path = it_navigation_path
                         io_tech_request_context = io_tech_request_context
             	 IMPORTING er_entity          = approversset_get_entity
                         es_response_context = es_response_context
          ).

        IF approversset_get_entity IS NOT INITIAL.
*     Send specific entity data to the caller interface
          copy_data_to_ref(
            EXPORTING
              is_data = approversset_get_entity
            CHANGING
              cr_data = er_entity
          ).
        ELSE.
*         In case of initial values - unbind the entity reference
          er_entity = lr_entity.
        ENDIF.

      WHEN OTHERS.
        super->/iwbep/if_mgw_appl_srv_runtime~get_entity(
           EXPORTING
             iv_entity_name = iv_entity_name
             iv_entity_set_name = iv_entity_set_name
             iv_source_name = iv_source_name
             it_key_tab = it_key_tab
             it_navigation_path = it_navigation_path
          IMPORTING
            er_entity = er_entity
    ).
 ENDCASE.
  endmethod.


  METHOD /iwbep/if_mgw_appl_srv_runtime~get_entityset.


    DATA attachmentsset_get_entityset TYPE zcl_ca_uf_mpc=>tt_formattachments.
    DATA formheaderset_get_entityset TYPE zcl_ca_uf_mpc=>tt_formheader.
    DATA notesset_get_entityset TYPE zcl_ca_uf_mpc=>tt_formnotes.
    DATA controldataset_get_entityset TYPE zcl_ca_uf_mpc=>tt_controldata.
    DATA formattachment01_get_entityset TYPE zcl_ca_uf_mpc=>tt_formattachmentsdata.
    DATA controlpropertys_get_entityset TYPE zcl_ca_uf_mpc=>tt_controlproperty.
    DATA approversset_get_entityset TYPE zcl_ca_uf_mpc=>tt_formapprovers.
    DATA requestdataset_get_entityset TYPE zcl_zhr_dpo_request_un_mpc=>tt_requestdata.
    DATA themeset_get_entityset TYPE zcl_zhr_dpo_request_un_mpc=>tt_theme.
    DATA templateset_get_entityset TYPE zcl_zhr_dpo_request_un_mpc=>tt_template.
    DATA deputyset_get_entityset TYPE zcl_zhr_dpo_request_un_mpc=>tt_deputy.
    DATA requestattchdirs_get_entityset TYPE zcl_zhr_dpo_request_un_mpc=>tt_requestattchdir.
    DATA reqhistory_get_entityset TYPE zcl_zhr_dpo_request_un_mpc=>tt_reqhistory.
    DATA agreement_get_entityset TYPE zcl_zhr_dpo_request_un_mpc=>tt_agreement.
    DATA otherapprovers_get_entityset TYPE zcl_zhr_dpo_request01_mpc=>tt_otherapprovers.
    DATA lv_entityset_name TYPE string.

    lv_entityset_name = io_tech_request_context->get_entity_set_name( ).

    CASE lv_entityset_name.

*-------------------------------------------------------------------------*
*             EntitySet -  FormAttachmentsSet
*-------------------------------------------------------------------------*
      WHEN 'OtherApproversSet'.
        otherapproversse_get_entityset(
           EXPORTING
            iv_entity_name = iv_entity_name
            iv_entity_set_name = iv_entity_set_name
            iv_source_name = iv_source_name
            it_filter_select_options = it_filter_select_options
            it_order = it_order
            is_paging = is_paging
            it_navigation_path = it_navigation_path
            it_key_tab = it_key_tab
            iv_filter_string = iv_filter_string
            iv_search_string = iv_search_string
            io_tech_request_context = io_tech_request_context
          IMPORTING
            et_entityset = otherapprovers_get_entityset
            es_response_context = es_response_context
          ).
*     Send specific entity data to the caller interface
        copy_data_to_ref(
          EXPORTING
            is_data = otherapprovers_get_entityset
          CHANGING
            cr_data = er_entityset
        ).



      WHEN 'AgreementSet'.
        agreementdataset_get_entityset(
            EXPORTING
             iv_entity_name = iv_entity_name
             iv_entity_set_name = iv_entity_set_name
             iv_source_name = iv_source_name
             it_filter_select_options = it_filter_select_options
             it_order = it_order
             is_paging = is_paging
             it_navigation_path = it_navigation_path
             it_key_tab = it_key_tab
             iv_filter_string = iv_filter_string
             iv_search_string = iv_search_string
             io_tech_request_context = io_tech_request_context
           IMPORTING
             et_entityset = agreement_get_entityset
             es_response_context = es_response_context
           ).
*     Send specific entity data to the caller interface
        copy_data_to_ref(
          EXPORTING
            is_data = agreement_get_entityset
          CHANGING
            cr_data = er_entityset
        ).

      WHEN 'ReqHistorySet'.
        reqhistoryset_get_entityset(
            EXPORTING
             iv_entity_name = iv_entity_name
             iv_entity_set_name = iv_entity_set_name
             iv_source_name = iv_source_name
             it_filter_select_options = it_filter_select_options
             it_order = it_order
             is_paging = is_paging
             it_navigation_path = it_navigation_path
             it_key_tab = it_key_tab
             iv_filter_string = iv_filter_string
             iv_search_string = iv_search_string
             io_tech_request_context = io_tech_request_context
           IMPORTING
             et_entityset = reqhistory_get_entityset
             es_response_context = es_response_context
           ).
*     Send specific entity data to the caller interface
        copy_data_to_ref(
          EXPORTING
            is_data = reqhistory_get_entityset
          CHANGING
            cr_data = er_entityset
        ).
      WHEN 'RequestAttchDirSet'.
        requestattchdirs_get_entityset(
            EXPORTING
             iv_entity_name = iv_entity_name
             iv_entity_set_name = iv_entity_set_name
             iv_source_name = iv_source_name
             it_filter_select_options = it_filter_select_options
             it_order = it_order
             is_paging = is_paging
             it_navigation_path = it_navigation_path
             it_key_tab = it_key_tab
             iv_filter_string = iv_filter_string
             iv_search_string = iv_search_string
             io_tech_request_context = io_tech_request_context
           IMPORTING
             et_entityset = requestattchdirs_get_entityset
             es_response_context = es_response_context
           ).
*     Send specific entity data to the caller interface
        copy_data_to_ref(
          EXPORTING
            is_data = requestattchdirs_get_entityset
          CHANGING
            cr_data = er_entityset
        ).

      WHEN 'StatusSet'.
      WHEN 'DeputySet'.
*     Call the entity set generated method
        deputyset_get_entityset(
          EXPORTING
           iv_entity_name = iv_entity_name
           iv_entity_set_name = iv_entity_set_name
           iv_source_name = iv_source_name
           it_filter_select_options = it_filter_select_options
           it_order = it_order
           is_paging = is_paging
           it_navigation_path = it_navigation_path
           it_key_tab = it_key_tab
           iv_filter_string = iv_filter_string
           iv_search_string = iv_search_string
           io_tech_request_context = io_tech_request_context
         IMPORTING
           et_entityset = deputyset_get_entityset
           es_response_context = es_response_context
         ).
*     Send specific entity data to the caller interface
        copy_data_to_ref(
          EXPORTING
            is_data = deputyset_get_entityset
          CHANGING
            cr_data = er_entityset
        ).



      WHEN 'TemplateSet'.
*     Call the entity set generated method
        templateset_get_entityset(
          EXPORTING
           iv_entity_name = iv_entity_name
           iv_entity_set_name = iv_entity_set_name
           iv_source_name = iv_source_name
           it_filter_select_options = it_filter_select_options
           it_order = it_order
           is_paging = is_paging
           it_navigation_path = it_navigation_path
           it_key_tab = it_key_tab
           iv_filter_string = iv_filter_string
           iv_search_string = iv_search_string
           io_tech_request_context = io_tech_request_context
         IMPORTING
           et_entityset = templateset_get_entityset
           es_response_context = es_response_context
         ).
*     Send specific entity data to the caller interface
        copy_data_to_ref(
          EXPORTING
            is_data = templateset_get_entityset
          CHANGING
            cr_data = er_entityset
        ).

      WHEN 'ThemeSet'.
*     Call the entity set generated method
        themeset_get_entityset(
          EXPORTING
           iv_entity_name = iv_entity_name
           iv_entity_set_name = iv_entity_set_name
           iv_source_name = iv_source_name
           it_filter_select_options = it_filter_select_options
           it_order = it_order
           is_paging = is_paging
           it_navigation_path = it_navigation_path
           it_key_tab = it_key_tab
           iv_filter_string = iv_filter_string
           iv_search_string = iv_search_string
           io_tech_request_context = io_tech_request_context
         IMPORTING
           et_entityset = themeset_get_entityset
           es_response_context = es_response_context
         ).
*     Send specific entity data to the caller interface
        copy_data_to_ref(
          EXPORTING
            is_data = themeset_get_entityset
          CHANGING
            cr_data = er_entityset
        ).

      WHEN 'FormAttachmentsSet'.
*     Call the entity set generated method
        attachmentsset_get_entityset(
          EXPORTING
           iv_entity_name = iv_entity_name
           iv_entity_set_name = iv_entity_set_name
           iv_source_name = iv_source_name
           it_filter_select_options = it_filter_select_options
           it_order = it_order
           is_paging = is_paging
           it_navigation_path = it_navigation_path
           it_key_tab = it_key_tab
           iv_filter_string = iv_filter_string
           iv_search_string = iv_search_string
           io_tech_request_context = io_tech_request_context
         IMPORTING
           et_entityset = attachmentsset_get_entityset
           es_response_context = es_response_context
         ).
*     Send specific entity data to the caller interface
        copy_data_to_ref(
          EXPORTING
            is_data = attachmentsset_get_entityset
          CHANGING
            cr_data = er_entityset
        ).

*-------------------------------------------------------------------------*
*             EntitySet -  FormHeaderSet
*-------------------------------------------------------------------------*
      WHEN 'FormHeaderSet'.
*     Call the entity set generated method
        formheaderset_get_entityset(
          EXPORTING
           iv_entity_name = iv_entity_name
           iv_entity_set_name = iv_entity_set_name
           iv_source_name = iv_source_name
           it_filter_select_options = it_filter_select_options
           it_order = it_order
           is_paging = is_paging
           it_navigation_path = it_navigation_path
           it_key_tab = it_key_tab
           iv_filter_string = iv_filter_string
           iv_search_string = iv_search_string
           io_tech_request_context = io_tech_request_context
         IMPORTING
           et_entityset = formheaderset_get_entityset
           es_response_context = es_response_context
         ).
*     Send specific entity data to the caller interface
        copy_data_to_ref(
          EXPORTING
            is_data = formheaderset_get_entityset
          CHANGING
            cr_data = er_entityset
        ).

*-------------------------------------------------------------------------*
*             EntitySet -  FormNotesSet
*-------------------------------------------------------------------------*
      WHEN 'FormNotesSet'.
*     Call the entity set generated method
        notesset_get_entityset(
          EXPORTING
           iv_entity_name = iv_entity_name
           iv_entity_set_name = iv_entity_set_name
           iv_source_name = iv_source_name
           it_filter_select_options = it_filter_select_options
           it_order = it_order
           is_paging = is_paging
           it_navigation_path = it_navigation_path
           it_key_tab = it_key_tab
           iv_filter_string = iv_filter_string
           iv_search_string = iv_search_string
           io_tech_request_context = io_tech_request_context
         IMPORTING
           et_entityset = notesset_get_entityset
           es_response_context = es_response_context
         ).
*     Send specific entity data to the caller interface
        copy_data_to_ref(
          EXPORTING
            is_data = notesset_get_entityset
          CHANGING
            cr_data = er_entityset
        ).

*-------------------------------------------------------------------------*
*             EntitySet -  ControlDataSet
*-------------------------------------------------------------------------*
      WHEN 'ControlDataSet'.
*     Call the entity set generated method
        controldataset_get_entityset(
          EXPORTING
           iv_entity_name = iv_entity_name
           iv_entity_set_name = iv_entity_set_name
           iv_source_name = iv_source_name
           it_filter_select_options = it_filter_select_options
           it_order = it_order
           is_paging = is_paging
           it_navigation_path = it_navigation_path
           it_key_tab = it_key_tab
           iv_filter_string = iv_filter_string
           iv_search_string = iv_search_string
           io_tech_request_context = io_tech_request_context
         IMPORTING
           et_entityset = controldataset_get_entityset
           es_response_context = es_response_context
         ).
*     Send specific entity data to the caller interface
        copy_data_to_ref(
          EXPORTING
            is_data = controldataset_get_entityset
          CHANGING
            cr_data = er_entityset
        ).

*-------------------------------------------------------------------------*
*             EntitySet -  FormAttachmentsDataSet
*-------------------------------------------------------------------------*
      WHEN 'FormAttachmentsDataSet'.
*     Call the entity set generated method
        formattachment01_get_entityset(
          EXPORTING
           iv_entity_name = iv_entity_name
           iv_entity_set_name = iv_entity_set_name
           iv_source_name = iv_source_name
           it_filter_select_options = it_filter_select_options
           it_order = it_order
           is_paging = is_paging
           it_navigation_path = it_navigation_path
           it_key_tab = it_key_tab
           iv_filter_string = iv_filter_string
           iv_search_string = iv_search_string
           io_tech_request_context = io_tech_request_context
         IMPORTING
           et_entityset = formattachment01_get_entityset
           es_response_context = es_response_context
         ).
*     Send specific entity data to the caller interface
        copy_data_to_ref(
          EXPORTING
            is_data = formattachment01_get_entityset
          CHANGING
            cr_data = er_entityset
        ).

*-------------------------------------------------------------------------*
*             EntitySet -  ControlPropertySet
*-------------------------------------------------------------------------*
      WHEN 'ControlPropertySet'.
*     Call the entity set generated method
        controlpropertys_get_entityset(
          EXPORTING
           iv_entity_name = iv_entity_name
           iv_entity_set_name = iv_entity_set_name
           iv_source_name = iv_source_name
           it_filter_select_options = it_filter_select_options
           it_order = it_order
           is_paging = is_paging
           it_navigation_path = it_navigation_path
           it_key_tab = it_key_tab
           iv_filter_string = iv_filter_string
           iv_search_string = iv_search_string
           io_tech_request_context = io_tech_request_context
         IMPORTING
           et_entityset = controlpropertys_get_entityset
           es_response_context = es_response_context
         ).
*     Send specific entity data to the caller interface
        copy_data_to_ref(
          EXPORTING
            is_data = controlpropertys_get_entityset
          CHANGING
            cr_data = er_entityset
        ).

*-------------------------------------------------------------------------*
*             EntitySet -  FormApproversSet
*-------------------------------------------------------------------------*
      WHEN 'FormApproversSet'.
*     Call the entity set generated method
        approversset_get_entityset(
          EXPORTING
           iv_entity_name = iv_entity_name
           iv_entity_set_name = iv_entity_set_name
           iv_source_name = iv_source_name
           it_filter_select_options = it_filter_select_options
           it_order = it_order
           is_paging = is_paging
           it_navigation_path = it_navigation_path
           it_key_tab = it_key_tab
           iv_filter_string = iv_filter_string
           iv_search_string = iv_search_string
           io_tech_request_context = io_tech_request_context
         IMPORTING
           et_entityset = approversset_get_entityset
           es_response_context = es_response_context
         ).
*     Send specific entity data to the caller interface
        copy_data_to_ref(
          EXPORTING
            is_data = approversset_get_entityset
          CHANGING
            cr_data = er_entityset
        ).


      WHEN 'RequestDataSet'.
        requestdataset_get_entityset(
         EXPORTING
           iv_entity_name = iv_entity_name
           iv_entity_set_name = iv_entity_set_name
           iv_source_name = iv_source_name
           it_filter_select_options = it_filter_select_options
           it_order = it_order
           is_paging = is_paging
           it_navigation_path = it_navigation_path
           it_key_tab = it_key_tab
           iv_filter_string = iv_filter_string
           iv_search_string = iv_search_string
           io_tech_request_context = io_tech_request_context
         IMPORTING
           et_entityset = requestdataset_get_entityset
           es_response_context = es_response_context
         ).
*     Send specific entity data to the caller interface
        copy_data_to_ref(
          EXPORTING
            is_data = requestdataset_get_entityset
          CHANGING
            cr_data = er_entityset
        ).

      WHEN OTHERS.
        super->/iwbep/if_mgw_appl_srv_runtime~get_entityset(
          EXPORTING
            iv_entity_name = iv_entity_name
            iv_entity_set_name = iv_entity_set_name
            iv_source_name = iv_source_name
            it_filter_select_options = it_filter_select_options
            it_order = it_order
            is_paging = is_paging
            it_navigation_path = it_navigation_path
            it_key_tab = it_key_tab
            iv_filter_string = iv_filter_string
            iv_search_string = iv_search_string
            io_tech_request_context = io_tech_request_context
         IMPORTING
           er_entityset = er_entityset ).
    ENDCASE.



  ENDMETHOD.


  method /iwbep/if_mgw_appl_srv_runtime~get_stream.
**try.
*CALL METHOD SUPER->/IWBEP/IF_MGW_APPL_SRV_RUNTIME~GET_STREAM
**  exporting
**    iv_entity_name          =
**    iv_entity_set_name      =
**    iv_source_name          =
**    it_key_tab              =
**    it_navigation_path      =
**    io_tech_request_context =
**  importing
**    er_stream               =
**    es_response_context     =
*    .
**  catch /iwbep/cx_mgw_busi_exception.
**  catch /iwbep/cx_mgw_tech_exception.
**endtry.
    case iv_entity_name.

      when 'ReqAttchPreview'.
*
        call method zcl_hr_dpo_service=>stream_get_attachment_prev_un
          exporting
            iv_entity_set_name      = iv_entity_set_name
            iv_source_name          = iv_source_name
            it_key_tab              = it_key_tab
            it_navigation_path      = it_navigation_path
            io_tech_request_context = io_tech_request_context
            ir_dpc_ext              = me
          importing
            er_stream               = er_stream.

      when others.

    endcase.

    data:
      ls_header    type ihttpnvp,
      lv_attach_id type zca_uf_attach_id,
      ls_resource  type ty_s_media_resource,
      lv_mime_type type zca_uf_mime_type,
      lv_file_name type zca_uf_file_name,
      lv_data      type xstring.

    check iv_entity_set_name = 'FormAttachmentsDataSet'.

    lv_attach_id = zcl_ca_uniframe_utils=>get_odata_param(
        it_key_tab = it_key_tab
        iv_name    = 'AttachId' ).

    zcl_ca_uniframe=>get_attachment_data_only(
      exporting
        iv_attach_id   = lv_attach_id
      importing
        ev_file_name   = lv_file_name
        ev_mime_type   = lv_mime_type
        ev_attach_data = ls_resource-value ).

    ls_resource-mime_type = lv_mime_type.

    "escape file name
    lv_file_name = escape( val = lv_file_name format = cl_abap_format=>e_uri_full ).

    me->copy_data_to_ref(
      exporting
        is_data = ls_resource
      changing
        cr_data = er_stream ).

*-- nastaveni http hlavicky tak, aby se prenesl nazev souboru (normalne by byl $value)
    ls_header-name = 'Content-Disposition'.
    concatenate 'inline;filename=' lv_file_name into ls_header-value.
    condense ls_header-value no-gaps.


    me->set_header( is_header = ls_header  ).


  endmethod.


  method AGREEMENTDATASET_GET_ENTITY.

     DATA lv_dpo_agreement TYPE zhr_dpo_agreement.
    LOOP AT it_key_tab[] ASSIGNING FIELD-SYMBOL(<fs_key>) WHERE name = 'DpoAgreement'.
      lv_dpo_agreement = <fs_key>-value.
    ENDLOOP.
    CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT' EXPORTING input  = lv_dpo_agreement IMPORTING output = lv_dpo_agreement.
    DATA(lv_uname) = zcl_zhr_dpo_agr_dpc_ext=>get_uname( ).
*    et_entity = CORRESPONDING #( zcl_hr_dpo_agreement=>get( iv_uname = lv_uname )->get_agreement( iv_agreement = lv_dpo_agreement ) ).


  endmethod.


  METHOD agreementdataset_get_entityset.

*     me->disable_cache( ).
    DATA:
      lv_name_filter  TYPE zhr_dpo_doh_name,
      lv_req          TYPE zhr_dpo_request,
      lv_agr          TYPE zhr_dpo_agreement,
      lr_so           TYPE /iwbep/t_cod_select_options,
      lv_eff_for_dep  TYPE zrh_dpo_eff_for_dep,
      lv_request_full TYPE zhr_dpo_request_full,
      r_request       TYPE /iwbep/t_cod_select_options,
      rs_request      LIKE LINE OF r_request,
      r_status        TYPE /iwbep/t_cod_select_options,
      rs_status       LIKE LINE OF r_status.
    .
    FIELD-SYMBOLS:
      <fs_so> TYPE /iwbep/s_cod_select_option
    .
    DATA: lv_dpo_request TYPE zhr_dpo_request.

    READ TABLE it_key_tab ASSIGNING FIELD-SYMBOL(<fs_key>)
                          WITH KEY name = 'FormId'.
    IF sy-subrc EQ 0.
      SELECT SINGLE dpo_request FROM zhr_dpo_hist
                  INTO lv_dpo_request
                  WHERE form_id = <fs_key>-value.

      IF sy-subrc EQ 0.
        rs_request-sign = 'I'.
        rs_request-option = 'EQ'.
        rs_request-low = lv_dpo_request.
        APPEND rs_request TO r_request.
      ENDIF.
    ENDIF.

    rs_status-sign = 'I'.
    rs_status-option = 'EQ'.
    rs_status-low = 'ND2'.
    APPEND rs_status TO r_status.

    SELECT SINGLE uname FROM  zhr_dpo_rozdel INTO @DATA(lv_uname)
                        WHERE role = @zcl_hr_dpo_roles=>co_ved_sp
                          AND dpo_request = @lv_dpo_request.

    DATA(lt_output) = zcl_hr_dpo_agreement=>get( iv_uname = lv_uname )->get_agreement_list(
      it_request_range              = r_request
      it_status_range               = r_status
      iv_load_only_non_empty_status = abap_true
    ).
    et_entityset[] = CORRESPONDING #( lt_output ).


  ENDMETHOD.


  method AUTHSTRUCSET_GET_ENTITY.

     data lt_message type bapiret2_t.
    data: lv_dpo_request type zhr_dpo_request.
    data: lv_uname       type sy-uname.
    data: ls_authority_struc type zhr_dpo_prava_s.

    DATA(lv_adm_name) = zcl_pe_all_change_user=>get_uname( iv_appl_id = 'ZHR_DPO_REQUEST' ).


    loop at it_key_tab assigning field-symbol(<fs_key>).
      if <fs_key>-name = 'DpoRequest'.
        lv_dpo_request = |{ <fs_key>-value alpha = in }|..
      endif.
       if <fs_key>-name = 'FormId'.

         SELECT SINGLE dpo_request FROM zhr_dpo_hist
               INTO lv_dpo_request
               WHERE form_id EQ <fs_key>-value .


      endif.
      if <fs_key>-name = 'Uname'.
        lv_uname = |{ <fs_key>-value alpha = in }|..
        IF lv_uname = 'undefined'.
          CLEAR lv_uname.
        ENDIF.
      endif.
    endloop.

    IF lv_uname IS INITIAL.
      lv_uname = lv_adm_name.
    ENDIF.

* je to zástupce, zjisti jeho oprávňení
    IF lv_uname NE lv_adm_name.
      SELECT SINGLE * FROM zhr_dpo_zastup
                      INTO @DATA(ls_zastup)
                      WHERE creator = @lv_uname
                        AND deputy  = @lv_adm_name.


    ENDIF.


*     IF lv_adm_name IS NOT INITIAL AND lv_adm_name NE sy-uname..
*       CLEAR ls_zastup.
*       lv_uname = lv_adm_name.
*       DATA(lv_no_subst) = abap_true.
*     ENDIF.

    if lv_uname is initial.
      lv_uname = sy-uname.
    endif.

    IF lv_dpo_request IS NOT INITIAL.
      SELECT SINGLE dpo_type FROM zhr_dpo_zad INTO @DATA(lv_process)
                           WHERE dpo_request = @lv_dpo_request.
      IF lv_process IS INITIAL.
         lv_process = 'P-CENTR'.
      ENDIF.
    ENDIF.


    data(lo_request) = new zcl_hr_dpo_request( ).
    ls_authority_struc = lo_request->get_authorization_structure( exporting iv_dpo_request =  lv_dpo_request
                                               iv_uname      =  lv_uname
                                               iv_dpo_process    = lv_process
                                               importing et_message = lt_message ).
*    IF lv_no_subst = abap_true.
*     CLEAR ls_authority_struc-request_deputy_o.
*    ENDIF.

    CASE ls_zastup-activity."opravnení zástupce
      WHEN 'C'. "jenom zadavani
        CLEAR:
        ls_authority_struc-request_deputy_o,
        ls_authority_struc-request_next_step_o,
        ls_authority_struc-request_text_edit_o,
        ls_authority_struc-request_send_o .
      WHEN 'A'."jenom schvalování
        CLEAR:
         ls_authority_struc-request_deputy_o,
         ls_authority_struc-request_create_o,
         ls_authority_struc-request_delete_o,
         ls_authority_struc-request_text_edit_o,
         ls_authority_struc-term_create_o.
      WHEN 'F' . "vše
        CLEAR: ls_authority_struc-request_deputy_o.
      WHEN OTHERS.
    ENDCASE.


    er_entity = corresponding #( ls_authority_struc ).
    er_entity-dpo_request = lv_dpo_request.
    er_entity-uname = lv_uname.
    if lt_message[] is not initial.
      data(lo_message) = mo_context->get_message_container( ).
      lo_message->add_messages_from_bapi( it_bapi_messages = lt_message iv_add_to_response_header = abap_true ).
*      raise exception type /iwbep/cx_mgw_busi_exception
*        exporting
*          message_container = lo_message.
    endif.




*      catch /iwbep/cx_mgw_busi_exception.
*      catch /iwbep/cx_mgw_tech_exception.


  endmethod.


  method DEPUTYSET_GET_ENTITYSET.

    et_entityset =  zcl_hr_dpo_roles=>get_deputy_list( ).

  endmethod.


  method OTHERAPPROVERSSE_GET_ENTITYSET.

     DATA: lv_dpo_request TYPE zhr_dpo_request.

      READ TABLE it_key_tab ASSIGNING FIELD-SYMBOL(<fs_key>)
                             WITH KEY name = 'FormId'.
      IF sy-subrc EQ 0.

         SELECT SINGLE dpo_request FROM zhr_dpo_hist
               INTO lv_dpo_request
               WHERE form_id EQ <fs_key>-value.


        call function 'CONVERSION_EXIT_ALPHA_INPUT'
          exporting
            input         = lv_dpo_request
         IMPORTING
           OUTPUT        = lv_dpo_request
                  .
      ENDIF.

    et_entityset = zcl_hr_dpo_request=>show_approval_fork( iv_dpo_request =  lv_dpo_request iv_only_next_approvers = abap_true   ).
    sort et_entityset BY ordernr.



  endmethod.


  METHOD reqhistoryset_get_entityset.

    DATA: lv_dpo_request TYPE zhr_dpo_request.

    READ TABLE it_key_tab ASSIGNING FIELD-SYMBOL(<fs_key>)
                          WITH KEY name = 'FormId'.
    IF sy-subrc EQ 0.
      SELECT SINGLE dpo_request FROM zhr_dpo_hist
                  INTO lv_dpo_request
                  WHERE form_id = <fs_key>-value.


      DATA(lo_request) = NEW zcl_hr_dpo_request( ).

      DATA(lt_output) = lo_request->get_history( iv_dpo_request = lv_dpo_request  ).

    ENDIF.

    DATA(ls_request) = lo_request->read_request( lv_dpo_request ).
    IF ls_request-button_as_draft NE abap_true
    AND lines( lt_output[] ) GT 1.
      DELETE lt_output INDEX 1.
    ENDIF.


    et_entityset[] = CORRESPONDING #( lt_output ).


  ENDMETHOD.


  method REQUESTATTCHDIRS_GET_ENTITYSET.
    Data: lv_dpo_request type zhr_dpo_request.

      READ TABLE it_key_tab ASSIGNING FIELD-SYMBOL(<fs_key>)
                          WITH KEY name = 'FormId'.
    IF sy-subrc EQ 0.
       SELECT SINGLE dpo_request FROM zhr_dpo_hist
                          INTO lv_dpo_request
                          WHERE form_id = <fs_key>-value.

        call function 'CONVERSION_EXIT_ALPHA_INPUT'
          exporting
            input         = lv_dpo_request
          IMPORTING
           OUTPUT        = lv_dpo_request
                  .
    ENDIF.



    data(lo_request) = new zcl_hr_dpo_request( ).

    et_entityset = corresponding #( lo_request->read_attachment_tab( iv_dpo_request = lv_dpo_request ) ).


  endmethod.


  method REQUESTDATASET_CREATE_ENTITY.

    DATA:
    lr_form_io TYPE REF TO zcl_hr_dpo_request,
*    lr_form    TYPE REF TO zcl_ca_uniframe,
    lr_data    TYPE REF TO zcl_zhr_dpo_request01_mpc=>ts_requestdata,
    ls_key     TYPE zca_uf_key.

    DATA:
    lt_messages      TYPE bapirettab,
    lr_form          TYPE REF TO zcl_ca_uniframe,
    lr_msg_container TYPE REF TO /iwbep/if_message_container,
    ls_control       TYPE zca_uf_gw_control_data,
    ls_control_be    TYPE zca_uf_control_data,
    ls_buttons       TYPE zca_uf_buttons_visibility_ui,
    lv_name          TYPE string,
*    ls_key           TYPE zca_uf_key,
    lv_result        TYPE sysubrc.

  FIELD-SYMBOLS:
    <fs_key>      LIKE LINE OF it_key_tab.

*  LOOP AT it_key_tab ASSIGNING <fs_key>.
*    lv_name = <fs_key>-name.
*    TRANSLATE lv_name TO UPPER CASE.
*    CASE lv_name.
*      WHEN 'FORMTYPE'.
*        ls_key-form_type = <fs_key>-value.
*      WHEN 'FORMID'.
*        ls_key-form_id = <fs_key>-value.
*      WHEN 'LINEID'.
*        ls_key-line_id = <fs_key>-value.
*      WHEN 'STEPID'.
*        ls_key-step_id = <fs_key>-value.
*      WHEN 'WIID'.
*        ls_key-wi_id = <fs_key>-value.
*      WHEN 'OPERATION'.
*        ls_control-operation = <fs_key>-value.
*      WHEN 'PROCESSMODE'.
*        ls_control-process_mode = <fs_key>-value.
*    ENDCASE.
*  ENDLOOP.

  ls_control-process_mode = 'NEW'.
  ls_control-operation = 'LOAD'.
  ls_key-form_type = 'HR_DPO_REQ'.

  "pokud bude mod NEW, vygeneruje se u instance novy FormID, ktery
  "pouzijeme v UI pro binding hodnot
  zcl_ca_uniframe=>create_instance(
    EXPORTING
      iv_process_mode = ls_control-process_mode
      is_key          = ls_key
    IMPORTING
      ev_result       = lv_result
      et_messages     = lt_messages
      er_form         = lr_form ).



   TRY.
      io_data_provider->read_entry_data( IMPORTING es_data = er_entity ).
    CATCH cx_static_check.
  ENDTRY.

*  DATA(lr_form_io) = NEW zcl_hr_dpo_request( ).

  MOVE-CORRESPONDING er_entity TO ls_key.

  zcl_ca_uniframe=>get_instance(
    IMPORTING
      er_form = lr_form ).

  CHECK lr_form IS BOUND.

  lr_form_io ?= lr_form.
*
  CREATE DATA lr_data.
  ASSIGN lr_data->* TO FIELD-SYMBOL(<fs_data>).
  MOVE-CORRESPONDING er_entity TO <fs_data>.


  lr_form_io->read_customizing( ).

  lr_form_io->set_request_data(
    EXPORTING
      ir_protocol_data = lr_data ).



  lr_form_io->save_as_draft( ).

  endmethod.


  method REQUESTDATASET_GET_ENTITY.


    data lv_dpo_request type zhr_dpo_request.
    data lv_formid(32) TYPE c.


    loop at it_key_tab[] assigning field-symbol(<fs_key>) where name = 'FormId'.

      lv_formid = <fs_key>-value.
    endloop.


   SELECT SINGLE dpo_request FROM zhr_dpo_hist
               INTO lv_dpo_request
               WHERE form_id EQ lv_formid.


    data(lo_request) = new zcl_hr_dpo_request( ).

    if lv_dpo_request is initial.
*      lo_request->init_form_data( ).
*      lo_request->save_as_draft( ).
    else.
     lo_request->read_request( iv_dpo_request =  lv_dpo_request iv_read_tmp_request = abap_true  ).
    endif.

    er_entity = corresponding #( lo_request->get_request( ) ).



  endmethod.


  method REQUESTDATASET_GET_ENTITYSET.





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




  endmethod.


  method TEMPLATESET_GET_ENTITYSET.
   DATA lr_theme TYPE RANGE OF zhr_dpo_csabl-theme.
    DATA lr_template TYPE RANGE OF zhr_dpo_csabl-template_code.
    DATA: ls_entity LIKE LINE OF et_entityset.
    DATA: lv_field TYPE string.
    FIELD-SYMBOLS: <lt_range> TYPE ANY TABLE.

    LOOP AT io_tech_request_context->get_filter( )->get_filter_select_options( ) ASSIGNING FIELD-SYMBOL(<ls_filter_sel_opt>).
      lv_field = 'LR_' && <ls_filter_sel_opt>-property.
      ASSIGN (lv_field) TO <lt_range>.
      CHECK sy-subrc = 0.
      io_tech_request_context->get_filter( )->convert_select_option(
        EXPORTING
          is_select_option = <ls_filter_sel_opt>                 " Key name
        IMPORTING
          et_select_option = <lt_range>                 " Ranges table
      ).
*      CATCH /iwbep/cx_mgw_tech_exception. " Technical Exception
    ENDLOOP.

    SELECT theme, a~template_code, template_text FROM ZHR_DPO_CSABL as a
                          INNER JOIN ZHR_DPO_CSABLT as b
                          ON a~template_code EQ b~template_code
                          INTO TABLE @DATA(lt_template_list)
                          WHERE theme IN @lr_theme
                            AND a~template_code IN @lr_template
                            AND b~spras EQ @sy-langu.

    LOOP AT lt_template_list ASSIGNING FIELD-SYMBOL(<fs_template>).
      MOVE-CORRESPONDING <fs_template> TO ls_entity.
      ls_entity-template_desc = <fs_template>-template_text.
      APPEND ls_entity TO et_entityset.
    ENDLOOP.


  endmethod.


  method THEMESET_GET_ENTITYSET.

    DATA: ls_entity LIKE LINE OF ET_ENTITYSET.
    DATA lr_theme TYPE RANGE OF zhr_dpo_csabl-theme.
    DATA lv_field TYPE string.
    FIELD-SYMBOLS: <lt_range> TYPE ANY TABLE.



    LOOP AT io_tech_request_context->get_filter( )->get_filter_select_options( ) ASSIGNING FIELD-SYMBOL(<ls_filter_sel_opt>).
      lv_field = 'LR_' && <ls_filter_sel_opt>-property.
      ASSIGN (lv_field) TO <lt_range>.
      CHECK sy-subrc = 0.
      io_tech_request_context->get_filter( )->convert_select_option(
        EXPORTING
          is_select_option = <ls_filter_sel_opt>                 " Key name
        IMPORTING
          et_select_option = <lt_range>                 " Ranges table
      ).
*      CATCH /iwbep/cx_mgw_tech_exception. " Technical Exception
    ENDLOOP.

    DATA(lt_theme) = ZCL_HR_DPO_REQUEST=>get_domain_values( 'ZHR_DPO_THEME'  ).

    LOOP AT lt_theme ASSIGNING FIELD-SYMBOL(<fs_theme>).
      ls_entity-theme = <fs_theme>-domvalue_l.
      ls_entity-theme_desc = <fs_theme>-ddtext  .
      APPEND ls_entity TO et_entityset.
    ENDLOOP.


      DELETE et_entityset WHERE theme NOT IN lr_theme.


  endmethod.
ENDCLASS.
