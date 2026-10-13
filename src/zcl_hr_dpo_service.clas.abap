class ZCL_HR_DPO_SERVICE definition
  public
  final
  create public .

public section.

  class-methods GET_DOMAIN_VALUES
    importing
      !IV_NAME type DDOBJNAME
    returning
      value(RT_DD07V) type DD07V_TAB .
  class-methods STREAM_UPDATE_ATTACH_NOTIF
    importing
      !IV_ENTITY_SET_NAME type STRING optional
      !IV_SOURCE_NAME type STRING optional
      !IS_MEDIA_RESOURCE type /IWBEP/CL_MGW_ABS_DATA=>TY_S_MEDIA_RESOURCE optional
      !IT_KEY_TAB type /IWBEP/T_MGW_NAME_VALUE_PAIR optional
      !IT_NAVIGATION_PATH type /IWBEP/T_MGW_NAVIGATION_PATH optional
      !IO_TECH_REQUEST_CONTEXT type ref to /IWBEP/IF_MGW_REQ_ENTITY_C optional
      !IT_REQUEST_HEADERS type TIHTTPNVP optional
      !IR_DPC_EXT type ref to ZCL_ZHR_DPO_TERM_DPC_EXT optional
      !IV_SLUG type STRING
    exporting
      !ES_ATT type ZHR_DPO_ATT_S
      !ET_MESSAGE type BAPIRETTAB
      !EF_VALID type FLAG
      !EF_RESULT type FLAG .
  class-methods STREAM_UPDATE_ATTACH
    importing
      !IV_ENTITY_SET_NAME type STRING optional
      !IV_SOURCE_NAME type STRING optional
      !IS_MEDIA_RESOURCE type /IWBEP/CL_MGW_ABS_DATA=>TY_S_MEDIA_RESOURCE
      !IT_KEY_TAB type /IWBEP/T_MGW_NAME_VALUE_PAIR optional
      !IT_NAVIGATION_PATH type /IWBEP/T_MGW_NAVIGATION_PATH optional
      !IO_TECH_REQUEST_CONTEXT type ref to /IWBEP/IF_MGW_REQ_ENTITY_C optional
      !IT_REQUEST_HEADERS type TIHTTPNVP
      !IR_DPC_EXT type ref to ZCL_ZHR_DPO_REQUEST01_DPC_EXT
      !IV_SLUG type STRING
    exporting
      !ES_ATT type ZHR_DPO_ATT_S
      !ET_MESSAGE type BAPIRETTAB
      !EF_VALID type FLAG
      !EF_RESULT type FLAG .
  class-methods STREAM_UPDATE_ATTACH_AGREEMENT
    importing
      !IV_ENTITY_SET_NAME type STRING optional
      !IV_SOURCE_NAME type STRING optional
      !IS_MEDIA_RESOURCE type /IWBEP/CL_MGW_ABS_DATA=>TY_S_MEDIA_RESOURCE optional
      !IT_KEY_TAB type /IWBEP/T_MGW_NAME_VALUE_PAIR optional
      !IT_NAVIGATION_PATH type /IWBEP/T_MGW_NAVIGATION_PATH optional
      !IO_TECH_REQUEST_CONTEXT type ref to /IWBEP/IF_MGW_REQ_ENTITY_C optional
      !IT_REQUEST_HEADERS type TIHTTPNVP optional
      !IR_DPC_EXT type ref to ZCL_ZHR_DPO_AGR_DPC_EXT optional
      !IV_SLUG type STRING
    exporting
      !ES_ATT type ZHR_DPO_ATT_S
      !ET_MESSAGE type BAPIRETTAB
      !EF_VALID type FLAG
      !EF_RESULT type FLAG .
  class-methods GET_ATTACHMENT_AGREEMENT_LINK
    importing
      !IV_DPO_REQUEST type ZHR_DPO_REQUEST
      !IV_GUID type CHAR40
    returning
      value(RV_LINK) type STRING .
  class-methods GET_ATTACHMENT_LINK
    importing
      !IV_DPO_REQUEST type ZHR_DPO_REQUEST
      !IV_UNAME type UNAME
      !IV_GUID type CHAR40
    returning
      value(RV_LINK) type STRING .
  class-methods STREAM_GET_ATTACHMENT_PREVIEW
    importing
      !IV_ENTITY_SET_NAME type STRING
      !IV_SOURCE_NAME type STRING
      !IT_KEY_TAB type /IWBEP/T_MGW_NAME_VALUE_PAIR
      !IT_NAVIGATION_PATH type /IWBEP/T_MGW_NAVIGATION_PATH
      !IO_TECH_REQUEST_CONTEXT type ref to /IWBEP/IF_MGW_REQ_ENTITY
      !IR_DPC_EXT type ref to ZCL_ZHR_DPO_REQUEST01_DPC_EXT optional
      !IR_DPC_NOTIF_EXT type ref to ZCL_ZHR_DPO_TERM_DPC_EXT optional
      !IR_DPC_AGREEMENT_EXT type ref to ZCL_ZHR_DPO_AGR_DPC_EXT optional
      !IV_NOTIF type XFELD optional
      !IV_AGREEMENT type XFELD optional
    exporting
      !ER_STREAM type ref to DATA
      !ES_RESPONSE_CONTEXT type /IWBEP/IF_MGW_APPL_SRV_RUNTIME=>TY_S_MGW_RESPONSE_ENTITY_CNTXT .
  class-methods SEND_EMAIL
    importing
      !IV_SUBJECT type SO_OBJ_DES
      !IV_TEXT type SOLI_TAB
    returning
      value(RV_RETURN) type FLAG .
  class-methods STREAM_GET_ATTACHMENT_PREV_UN
    importing
      !IV_ENTITY_SET_NAME type STRING
      !IV_SOURCE_NAME type STRING
      !IT_KEY_TAB type /IWBEP/T_MGW_NAME_VALUE_PAIR
      !IT_NAVIGATION_PATH type /IWBEP/T_MGW_NAVIGATION_PATH
      !IO_TECH_REQUEST_CONTEXT type ref to /IWBEP/IF_MGW_REQ_ENTITY
      !IR_DPC_EXT type ref to ZCL_ZHR_DPO_REQUEST_UN_DPC_EXT
    exporting
      !ER_STREAM type ref to DATA
      !ES_RESPONSE_CONTEXT type /IWBEP/IF_MGW_APPL_SRV_RUNTIME=>TY_S_MGW_RESPONSE_ENTITY_CNTXT .
  class-methods STREAM_GET_DOC_PDF_SHOW
    importing
      !IV_ENTITY_SET_NAME type STRING
      !IV_SOURCE_NAME type STRING
      !IT_KEY_TAB type /IWBEP/T_MGW_NAME_VALUE_PAIR
      !IT_NAVIGATION_PATH type /IWBEP/T_MGW_NAVIGATION_PATH
      !IO_TECH_REQUEST_CONTEXT type ref to /IWBEP/IF_MGW_REQ_ENTITY
      !IR_DPC_EXT type ref to ZCL_ZHR_DPO_REQUEST01_DPC_EXT
    exporting
      !ER_STREAM type ref to DATA
      !ES_RESPONSE_CONTEXT type /IWBEP/IF_MGW_APPL_SRV_RUNTIME=>TY_S_MGW_RESPONSE_ENTITY_CNTXT .
  class-methods GET_DISTRIBUTION_LIST_MAILS
    importing
      !IV_DISTRIBUTION_LIST type SOOBJINFI1-OBJ_NAME
    returning
      value(RS_ADDRESS_STRING) type STRINGVAL .
  class-methods GET_USER_DETAILS
    importing
      !IV_UNAME type UNAME
    returning
      value(RS_CONTACT_DATA) type ZHR_DPO_USER_DATA .
  class-methods STREAM_WORD_TEMPLATE
    importing
      !IV_ENTITY_SET_NAME type STRING
      !IV_SOURCE_NAME type STRING
      !IT_KEY_TAB type /IWBEP/T_MGW_NAME_VALUE_PAIR
      !IT_NAVIGATION_PATH type /IWBEP/T_MGW_NAVIGATION_PATH
      !IO_TECH_REQUEST_CONTEXT type ref to /IWBEP/IF_MGW_REQ_ENTITY
      !IR_DPC_EXT type ref to ZCL_ZHR_DPO_REQUEST01_DPC_EXT optional
      !IR_DPC_NOTIF_EXT type ref to ZCL_ZHR_DPO_TERM_DPC_EXT optional
      !IR_DPC_AGREEMENT_EXT type ref to ZCL_ZHR_DPO_AGR_DPC_EXT optional
      !IV_NOTIF type XFELD optional
      !IV_AGREEMENT type XFELD optional
    exporting
      !ER_STREAM type ref to DATA
      !ES_RESPONSE_CONTEXT type /IWBEP/IF_MGW_APPL_SRV_RUNTIME=>TY_S_MGW_RESPONSE_ENTITY_CNTXT .
  class-methods CREATE_PDF_LINK
    importing
      !IV_DPO_REQUEST type ZHR_DPO_REQUEST
    returning
      value(RV_PDF_LINK) type STRINGVAL .
  class-methods GET_MANUAL_LINK
    importing
      !IV_BUTTON_PRESS type ZHR_DPO_BUTTON
    returning
      value(R_LINK) type STRING .
protected section.
private section.
ENDCLASS.



CLASS ZCL_HR_DPO_SERVICE IMPLEMENTATION.


  method create_pdf_link.

    constants: c_quot type c value `'`.

    data: lv_base type string value  '/sap/opu/odata/sap/ZHR_DPO_REQUEST01_SRV/ShowPdfSet'.

    concatenate lv_base '(' into  rv_pdf_link.
    concatenate rv_pdf_link 'DpoRequest=' c_quot iv_dpo_request c_quot
    into  rv_pdf_link.
    concatenate rv_pdf_link ')/$value'   into rv_pdf_link.


  endmethod.


  method GET_ATTACHMENT_AGREEMENT_LINK.

    CONSTANTS: c_quot TYPE c VALUE `'`.

    DATA: lv_link TYPE zsd_sdp_url,
          lv_base TYPE string VALUE  '/sap/opu/odata/sap/ZHR_DPO_AGR_SRV/AgreementAttchPreviewSet'.

    CONCATENATE lv_base '(' INTO  lv_link.
    CONCATENATE lv_link 'DpoRequest=' c_quot iv_dpo_request c_quot ','
     'Guid=' c_quot iv_guid  c_quot
     INTO  lv_link.
    CONCATENATE lv_link ')/$value'                               INTO  lv_link.

    rv_link  = lv_link.



  endmethod.


  method GET_ATTACHMENT_LINK.


    CONSTANTS: c_quot TYPE c VALUE `'`.

    DATA: lv_link TYPE zsd_sdp_url,
          lv_base TYPE string VALUE  '/sap/opu/odata/sap/ZHR_DPO_REQUEST01_SRV/ReqAttchPreviewSet'.

    CONCATENATE lv_base '(' INTO  lv_link.
    CONCATENATE lv_link 'DpoRequest=' c_quot iv_dpo_request c_quot ','
     'Uname=' c_quot iv_uname  c_quot ','
     'Guid=' c_quot iv_guid  c_quot
     INTO  lv_link.
    CONCATENATE lv_link ')/$value'                               INTO  lv_link.

    rv_link  = lv_link.


  endmethod.


  method GET_DISTRIBUTION_LIST_MAILS.

    DATA: lt_entries TYPE STANDARD TABLE OF  SODLIENTI1 .

    call function 'SO_DLI_READ_API1'
     EXPORTING
        DLI_NAME                         = iv_distribution_list
*       DLI_ID                           = ' '
        SHARED_DLI                       = 'X'
*     IMPORTING
*       DLI_DATA                         =
      TABLES
        DLI_ENTRIES                      = lt_entries
      EXCEPTIONS
        DLI_NOT_EXIST                    = 1
        OPERATION_NO_AUTHORIZATION       = 2
        PARAMETER_ERROR                  = 3
        X_ERROR                          = 4
        OTHERS                           = 5
              .
    if sy-subrc <> 0.
* Implement suitable error handling here
    endif.

   LOOP AT lt_entries ASSIGNING FIELD-SYMBOL(<fs_entries>).
     IF sy-tabix = 1.
       rs_address_string = <fs_entries>-member_adr.
     ELSE.
     rs_address_string = rs_address_string && ';' && <fs_entries>-member_adr.
     ENDIF.
   ENDLOOP.


  endmethod.


  method GET_DOMAIN_VALUES.
    CALL FUNCTION 'DDIF_DOMA_GET'
      EXPORTING
        name                = iv_name
*       STATE               = 'A'
        LANGU               = sy-langu
*     IMPORTING
*       GOTSTATE            =
*       DD01V_WA            =
      TABLES
        DD07V_TAB           = rt_dd07v[]
     EXCEPTIONS
       ILLEGAL_INPUT       = 1
       OTHERS              = 2
              .
    IF sy-subrc <> 0.
* Implement suitable error handling here
    ENDIF.


  endmethod.


  method GET_MANUAL_LINK.

    SELECT SINGLE * FROM ZHR_DPO_CPARAM INTO @data(ls_param)
                                        WHERE PARAMETER_DPO = @iv_button_press.

    IF sy-subrc EQ 0.
      r_link = ls_param-value.
    ENDIF.

  endmethod.


  method get_user_details.

    select single bname, name_text from user_addrs into @data(ls_user_name)
                            where bname eq @iv_uname
                            and date_from le @sy-datum.

    if sy-subrc eq 0.
      rs_contact_data-uname = ls_user_name-bname.
      rs_contact_data-user_name_full = ls_user_name-name_text.
    endif.



  endmethod.


  method SEND_EMAIL.


*  DATA: lc_separator TYPE c VALUE ';'.
*
*  DATA: lo_employee TYPE REF TO zcl_pe_all_employee.
*
*  DATA: lv_subject type so_obj_des,
*        lv_sender  type xubname,
*        lt_email_body type soli_tab,
*        lv_userid type uname,
*        lv_email type soos1-recextnam.
*
*  DATA:
*        lt_list_email TYPE STANDARD TABLE OF ZIBWA_SMTP,
*        ls_admin_list_email TYPE ZIBWA_SMTP.
*
** Pripravime telo notifikacni zpravy
*  IF ( ( sy-sysid EQ 'SK2' ) OR ( sy-sysid EQ 'SK4' ) ).
*    CONCATENATE SY-SYSID 'TEST:' iv_subject INTO lv_subject SEPARATED BY space.
*  ELSE.
*    lv_subject = iv_subject.
*  ENDIF.
*
*  lv_sender = text-t01.
*
*  lt_email_body = iv_text.
*
*  .
*  IF sy-subrc IS NOT INITIAL.
*    EXIT. " Seznam spravcu neni zadan, nic nebudeme odesilat
*  ENDIF.
*
** Samotne odeslani notifikacni zpravy
*  IF lt_list_email IS NOT INITIAL.
*    CALL FUNCTION 'ZP_ED_MAIL'
*      EXPORTING
*        I_SUBJECT       = lv_subject
*        X_COMMIT        = 'X'
*        i_sender        = lv_sender
*      TABLES
*        T_EMAIL         = lt_list_email
*        T_CONTENT       = lt_email_body
*      EXCEPTIONS
*        ERROR           = 1
**       OTHERS          = 2
*    .
*    IF sy-subrc IS INITIAL.
*      rv_return = abap_true.
*    ENDIF.
*  ENDIF.


  endmethod.


  METHOD stream_get_attachment_preview.
    DATA: lt_keys TYPE /iwbep/t_mgw_tech_pairs,
          ls_key  TYPE /iwbep/s_mgw_tech_pair.

    DATA: ls_lheader TYPE ihttpnvp,

          ls_stream  TYPE            ir_dpc_ext->ty_s_media_resource,
          lf_result  TYPE            flag,
          lt_message TYPE            bapirettab,
          lo_message TYPE REF TO     /iwbep/if_message_container.


    "PrintPreview
    DATA: lo_instance     TYPE REF TO     zcl_hr_dpo_request,

          lv_dpo_request  TYPE zhr_dpo_request,
          ls_attchm       TYPE            zhr_dpo_att_s,
          lv_filename     TYPE            skwf_filnm,   "char255
          lv_stream       TYPE            xstring,
          lv_header_value TYPE            string,
          lv_guid         TYPE             guid,
          lv_mimetype     TYPE            skwf_mime. "sdok_cntty.


    lt_keys = io_tech_request_context->get_keys( ).


    READ TABLE lt_keys WITH KEY name = 'DPO_REQUEST' INTO ls_key.
    IF sy-subrc EQ 0.
      CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'
        EXPORTING
          input  = ls_key-value
        IMPORTING
          output = lv_dpo_request.

    ENDIF.
    READ TABLE lt_keys WITH KEY name = 'GUID' INTO ls_key.
    IF sy-subrc EQ 0.
      lv_guid = ls_key-value.
    ENDIF.




    SELECT SINGLE * FROM zhr_dpo_req_att INTO @DATA(ls_att)
                            WHERE dpo_request = @lv_dpo_request
                              AND guid = @lv_guid.

    MOVE-CORRESPONDING ls_att TO  ls_attchm.

    CREATE OBJECT lo_instance.

    CALL METHOD lo_instance->attach_preview
      EXPORTING
        is_attchm   = ls_attchm
      IMPORTING
        ev_stream   = lv_stream
        ev_filename = lv_filename
        ef_result   = lf_result
        et_message  = lt_message.

    CALL FUNCTION 'SKWF_MIMETYPE_OF_FILE_GET'
      EXPORTING
        filename = lv_filename
      IMPORTING
        mimetype = lv_mimetype.


    lv_filename = escape( val = lv_filename format = cl_abap_format=>e_url ).


    ls_stream-value = lv_stream.
    ls_stream-mime_type = lv_mimetype.

    ls_lheader-name = 'Content-Disposition' ##NO_TEXT.
    CONCATENATE 'attachment; filename="' lv_filename '"'  INTO lv_header_value ##NO_TEXT.
    ls_lheader-value = lv_header_value.

    IF iv_notif IS INITIAL AND iv_agreement IS INITIAL..

      ir_dpc_ext->set_header( is_header = ls_lheader ).


      ir_dpc_ext->copy_data_to_ref( EXPORTING is_data = ls_stream
                                    CHANGING cr_data = er_stream ).
    ENDIF.
    IF iv_agreement = abap_true.
      ir_dpc_agreement_ext->set_header( is_header = ls_lheader ).
      ir_dpc_agreement_ext->copy_data_to_ref( EXPORTING is_data = ls_stream
                                    CHANGING cr_data = er_stream ).
    ENDIF.
    IF iv_notif = abap_true.
      ir_dpc_notif_ext->set_header( is_header = ls_lheader ).
      ir_dpc_notif_ext->copy_data_to_ref( EXPORTING is_data = ls_stream
                                    CHANGING cr_data = er_stream ).
    ENDIF.


  ENDMETHOD.


  method STREAM_GET_ATTACHMENT_PREV_UN.
     DATA: lt_keys TYPE /iwbep/t_mgw_tech_pairs,
          ls_key  TYPE /iwbep/s_mgw_tech_pair.

    DATA: ls_lheader TYPE ihttpnvp,

          ls_stream  TYPE            ir_dpc_ext->ty_s_media_resource,
          lf_result  TYPE            flag,
          lt_message TYPE            bapirettab,
          lo_message TYPE REF TO     /iwbep/if_message_container.


    "PrintPreview
    DATA: lo_instance     TYPE REF TO     zcl_hr_dpo_request,

          lv_dpo_request  TYPE zhr_dpo_request,


          ls_attchm       TYPE            ZHR_DPO_ATT_S,
          ls_a_db         TYPE            zsd_sdp_tmp_ca,

*          lv_doc_id       TYPE            zsd_sdp_tmp_oa-doc_id,
*          lv_object_id    TYPE            zsd_sdp_tmp_oa-object_id,

          lv_filename     TYPE            skwf_filnm,   "char255
          lv_stream       TYPE            xstring,
          lv_header_value TYPE            string,
          lv_guid         TYPE             guid,
          lv_mimetype     TYPE            skwf_mime. "sdok_cntty.


    lt_keys = io_tech_request_context->get_keys( ).


    READ TABLE lt_keys WITH KEY name = 'DPO_REQUEST' INTO ls_key.
    IF sy-subrc EQ 0.
    call function 'CONVERSION_EXIT_ALPHA_INPUT'
      exporting
        input         = ls_key-value
      IMPORTING
        OUTPUT        = lv_dpo_request
              .

   ENDIF.
   READ TABLE lt_keys WITH KEY name = 'GUID' INTO ls_key.
   IF sy-subrc EQ 0.
     lv_guid = ls_key-value.
   ENDIF.




    SELECT SINGLE * FROM ZHR_DPO_REQ_ATT INTO @DATA(ls_att)
                            WHERE dpo_request = @lv_dpo_request
                              AND guid = @lv_guid.

    MOVE-CORRESPONDING ls_att TO  ls_attchm.

   CREATE OBJECT lo_instance.

    CALL METHOD lo_instance->attach_preview
      EXPORTING
        is_attchm   = ls_attchm
      IMPORTING
        ev_stream   = lv_stream
        ev_filename = lv_filename
        ef_result   = lf_result
        et_message  = lt_message.

    CALL FUNCTION 'SKWF_MIMETYPE_OF_FILE_GET'
      EXPORTING
        filename = lv_filename
      IMPORTING
        mimetype = lv_mimetype.


    lv_filename = escape( val = lv_filename format = cl_abap_format=>e_url ).


    ls_stream-value = lv_stream.
    ls_stream-mime_type = lv_mimetype.

    ls_lheader-name = 'Content-Disposition' ##NO_TEXT.
    CONCATENATE 'attachment; filename="' lv_filename '"'  INTO lv_header_value ##NO_TEXT.
    ls_lheader-value = lv_header_value.


    ir_dpc_ext->set_header( is_header = ls_lheader ).

    ir_dpc_ext->copy_data_to_ref( EXPORTING is_data = ls_stream
                                  CHANGING cr_data = er_stream ).
  endmethod.


  method STREAM_GET_DOC_PDF_SHOW.

     DATA: lt_keys TYPE /iwbep/t_mgw_tech_pairs,
          ls_key  TYPE /iwbep/s_mgw_tech_pair.
    DATA: ls_lheader TYPE ihttpnvp.

    DATA: ls_stream  TYPE            ir_dpc_ext->ty_s_media_resource,
          lf_result  TYPE            flag,
          lt_message TYPE            bapirettab,
          lv_form_type TYPE zhr_dpo_pdf_form_type,
          lo_message TYPE REF TO     /iwbep/if_message_container.


    "PrintPreview
    DATA: lo_instance   TYPE REF TO     zcl_hr_dpo_request,

          lv_dpo_request TYPE           zhr_dpo_request,
          lv_vtweg      TYPE            vtweg,
          lv_erdat      TYPE            erdat,
          lv_kunwe      TYPE kunwe,

          lf_valid      TYPE flag,
          lv_pdf_stream TYPE            xstring.


    lt_keys = io_tech_request_context->get_keys( ).


    READ TABLE lt_keys WITH KEY name = 'OBJECTID' INTO ls_key.
    call function 'CONVERSION_EXIT_ALPHA_INPUT'
      exporting
        input         = ls_key-value
     IMPORTING
       OUTPUT        = lv_dpo_request
              .

     READ TABLE lt_keys WITH KEY name = 'ZHR_DPO_PDF_FORM_TYPE' INTO ls_key.
     IF sy-subrc EQ 0.
       lv_form_type = ls_key-value.
     ENDIF.



     lo_instance = NEW zcl_hr_dpo_request( ).

      CALL METHOD lo_instance->display_pdf
        EXPORTING
          iv_dpo_request = lv_dpo_request
          iv_form_type = lv_form_type
        IMPORTING
          ev_pdf_stream = lv_pdf_stream
          ef_result     = lf_result
          et_message    = lt_message.
*    ENDIF.

    IF lf_result = abap_true.

      lv_form_type = SWITCH #( lv_form_type WHEN 'INT' THEN 'Int'
                                            WHEN 'EXT' THEN 'Ext').

      SELECT SINGLE dpo_req_full FROM ZHR_DPO_ZAD into @DATA(lv_dpo_full)
                                      WHERE dpo_request = @lv_dpo_request.
      IF sy-subrc EQ 0.
        REPLACE ALL OCCURRENCES OF '/' IN lv_dpo_full WITH '-'.
        DATA(lv_formname) = |inline; filename="{ lv_form_type }-{ lv_dpo_full }.pdf" |.
      ENDIF.

      ls_stream-value = lv_pdf_stream.
      ls_stream-mime_type = 'application/pdf' ##NO_TEXT.


      ls_lheader-name = 'Content-Disposition' ##NO_TEXT.
      ls_lheader-value = lv_formname ##NO_TEXT.
      ir_dpc_ext->set_header( is_header = ls_lheader ).


      ir_dpc_ext->copy_data_to_ref( EXPORTING is_data = ls_stream
                         CHANGING cr_data = er_stream ).

    ENDIF.



  endmethod.


  METHOD stream_update_attach.

    DATA: lf_result  TYPE            flag,
          lt_message TYPE            bapirettab,
          lo_message TYPE REF TO     /iwbep/if_message_container.


    DATA: ls_key_tab TYPE /iwbep/s_mgw_name_value_pair,
          lt_key_tab TYPE /iwbep/t_mgw_name_value_pair.


    DATA: lo_instance       TYPE REF TO zcl_hr_dpo_request,
          ls_media_resource TYPE /iwbep/cl_mgw_abs_data=>ty_s_media_resource,
          lv_minetype       TYPE /iwbep/cl_mgw_abs_data=>ty_s_media_resource-mime_type,
          lv_xstring        TYPE xstring.

    DATA: ls_keys            TYPE       zsd_sdp_supcpl_gw_itm_att_s,
          lv_filename        TYPE       zsd_sdp_supcpl_gw_itm_att_s-filename,
          ls_return          TYPE     bapiret2,
          lv_par1            TYPE sy-msgv1,
*          ls_att_ext  TYPE zsd_sdp_order_att_ext_s,
          ls_att             TYPE zsd_sdp_supcpl_gw_itm_att_s,

          lt_request_headers TYPE tihttpnvp,
          ls_request_headers LIKE LINE OF lt_request_headers,

          l_minetype         TYPE w3conttype,

          lf_valid           TYPE boole_d.


    DATA: lv_dpo_request TYPE zhr_dpo_request.

    CLEAR ls_request_headers.
    READ TABLE it_request_headers WITH KEY name = 'dporequest' INTO ls_request_headers ##NO_TEXT.
    lv_dpo_request = ls_request_headers-value.



    lv_filename = iv_slug.

**********************************************************************
    CALL FUNCTION 'SCP_TRANSLATE_CHARS'
      EXPORTING
        inbuff  = iv_slug
      IMPORTING
        outbuff = lv_filename.
**********************************************************************





    l_minetype = is_media_resource-mime_type.

    lo_instance = NEW zcl_hr_dpo_request( ).
    lo_instance->read_request(
      EXPORTING
        iv_dpo_request      = CONV #( |{  lv_dpo_request ALPHA = IN } | )
    ).

    SELECT filename  FROM zhr_dpo_req_att
                      WHERE dpo_request = @( |{ lv_dpo_request ALPHA = IN }| )
                      INTO TABLE @DATA(lt_files).
    IF line_exists( lt_files[ filename = lv_filename ] ).
      lv_par1 = lv_filename.
      CALL FUNCTION 'BALW_BAPIRETURN_GET2'
        EXPORTING
          type   = 'E'
          cl     = 'ZHR_DPO'
          number = '025'
          par1   = lv_par1
        IMPORTING
          return = ls_return.
      .
      APPEND ls_return TO et_message.
    ELSE.


      CALL METHOD lo_instance->add_attachment
        EXPORTING
          iv_dpo_request = lv_dpo_request
          iv_data        = is_media_resource-value
          iv_filename    = lv_filename
          iv_mimetype    = l_minetype
        IMPORTING
          es_att         = es_att
*         ef_valid       = ef_valid
          ef_result      = ef_result
          et_message     = et_message.


    ENDIF.

  ENDMETHOD.


  METHOD stream_update_attach_agreement.

    DATA: lf_result  TYPE            flag,
          lt_message TYPE            bapirettab,
          lo_message TYPE REF TO     /iwbep/if_message_container.


    DATA: ls_key_tab TYPE /iwbep/s_mgw_name_value_pair,
          lt_key_tab TYPE /iwbep/t_mgw_name_value_pair.


    DATA: lo_instance       TYPE REF TO zcl_hr_dpo_request,
          ls_media_resource TYPE /iwbep/cl_mgw_abs_data=>ty_s_media_resource,
          lv_minetype       TYPE /iwbep/cl_mgw_abs_data=>ty_s_media_resource-mime_type,
          lv_xstring        TYPE xstring.

    DATA: ls_keys            TYPE       zsd_sdp_supcpl_gw_itm_att_s,
          lv_filename        TYPE       zsd_sdp_supcpl_gw_itm_att_s-filename,

*          ls_att_ext  TYPE zsd_sdp_order_att_ext_s,
          ls_att             TYPE zsd_sdp_supcpl_gw_itm_att_s,

          lt_request_headers TYPE tihttpnvp,
          ls_request_headers LIKE LINE OF lt_request_headers,

          l_minetype         TYPE w3conttype,

          lf_valid           TYPE boole_d.


    DATA: lv_dpo_request   TYPE zhr_dpo_request,
          lv_dpo_term      TYPE zhr_dpo_id_term,
          lv_dpo_agreement TYPE zhr_dpo_agreement,
          lv_par1          TYPE sy-msgv1,
          ls_return        TYPE bapiret2.

    CLEAR ls_request_headers.
    READ TABLE it_request_headers WITH KEY name = 'dporequest' INTO ls_request_headers ##NO_TEXT.
    SPLIT ls_request_headers-value AT '-' INTO lv_dpo_request lv_dpo_agreement.
    CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'
      EXPORTING
        input  = lv_dpo_request
      IMPORTING
        output = lv_dpo_request.

    CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'
      EXPORTING
        input  = lv_dpo_agreement
      IMPORTING
        output = lv_dpo_agreement.

      SELECT SINGLE dpo_request FROM zhr_dpo_doh INTO lv_dpo_request
                                WHERE dpo_agreement = lv_dpo_agreement.

*    lv_dpo_term = '9999999999'.

    lv_filename = iv_slug.

**********************************************************************
    CALL FUNCTION 'SCP_TRANSLATE_CHARS'
      EXPORTING
        inbuff  = iv_slug
      IMPORTING
        outbuff = lv_filename.
**********************************************************************

    l_minetype = is_media_resource-mime_type.

    lo_instance = NEW zcl_hr_dpo_request( ).

    SELECT filename  FROM zhr_dpo_req_att
                     WHERE dpo_request = @( |{ lv_dpo_request ALPHA = IN }| )
                       AND dpo_agreement = @lv_dpo_agreement
                     INTO TABLE @DATA(lt_files).
    IF line_exists( lt_files[ filename = lv_filename ] ).
      lv_par1 = lv_filename.
      CALL FUNCTION 'BALW_BAPIRETURN_GET2'
        EXPORTING
          type   = 'E'
          cl     = 'ZHR_DPO'
          number = '025'
          par1   = lv_par1
        IMPORTING
          return = ls_return.
      .
      APPEND ls_return TO et_message.
    ELSE.

*
    CALL METHOD lo_instance->add_attachment
      EXPORTING
        iv_dpo_request = lv_dpo_request
*        iv_dpo_term    = lv_dpo_term
        iv_dpo_agreement = lv_dpo_agreement
        iv_data        = is_media_resource-value
        iv_filename    = lv_filename
        iv_mimetype    = l_minetype
      IMPORTING
        es_att         = es_att
*       ef_valid       = ef_valid
        ef_result      = ef_result
        et_message     = et_message.

     ENDIF.
  ENDMETHOD.


  METHOD stream_update_attach_notif.

    DATA: lf_result  TYPE            flag,
          lt_message TYPE            bapirettab,
          lo_message TYPE REF TO     /iwbep/if_message_container.


    DATA: ls_key_tab TYPE /iwbep/s_mgw_name_value_pair,
          lt_key_tab TYPE /iwbep/t_mgw_name_value_pair.


    DATA: lo_instance       TYPE REF TO zcl_hr_dpo_request,
          ls_media_resource TYPE /iwbep/cl_mgw_abs_data=>ty_s_media_resource,
          lv_minetype       TYPE /iwbep/cl_mgw_abs_data=>ty_s_media_resource-mime_type,
          lv_xstring        TYPE xstring.

    DATA: ls_keys            TYPE       zsd_sdp_supcpl_gw_itm_att_s,
          lv_filename        TYPE       zsd_sdp_supcpl_gw_itm_att_s-filename,

*          ls_att_ext  TYPE zsd_sdp_order_att_ext_s,
          ls_att             TYPE zsd_sdp_supcpl_gw_itm_att_s,

          lt_request_headers TYPE tihttpnvp,
          ls_request_headers LIKE LINE OF lt_request_headers,

          l_minetype         TYPE w3conttype,

          lf_valid           TYPE boole_d.


    DATA: lv_dpo_request TYPE zhr_dpo_request,
          lv_dpo_term    TYPE zhr_dpo_id_term,
          lv_par1        TYPE sy-msgv1,
          ls_return      TYPE bapiret2.

    CLEAR ls_request_headers.
    READ TABLE it_request_headers WITH KEY name = 'dporequest' INTO ls_request_headers ##NO_TEXT.
    SPLIT ls_request_headers-value AT '-' INTO lv_dpo_request lv_dpo_term.
    CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'
      EXPORTING
        input  = lv_dpo_request
      IMPORTING
        output = lv_dpo_request.

*    call function 'CONVERSION_EXIT_ALPHA_INPUT'
*      exporting
*        input  = lv_dpo_term
*      importing
*        output = lv_dpo_term.
    lv_dpo_term = '9999999999'.

    lv_filename = iv_slug.

**********************************************************************
    CALL FUNCTION 'SCP_TRANSLATE_CHARS'
      EXPORTING
        inbuff  = iv_slug
      IMPORTING
        outbuff = lv_filename.
**********************************************************************

    l_minetype = is_media_resource-mime_type.

    lo_instance = NEW zcl_hr_dpo_request( ).

    SELECT filename  FROM zhr_dpo_req_att
                     WHERE dpo_request = @( |{ lv_dpo_request ALPHA = IN }| )
                       AND term_id = @lv_dpo_term
                     INTO TABLE @DATA(lt_files).
    IF line_exists( lt_files[ filename = lv_filename ] ).
      lv_par1 = lv_filename.
      CALL FUNCTION 'BALW_BAPIRETURN_GET2'
        EXPORTING
          type   = 'E'
          cl     = 'ZHR_DPO'
          number = '025'
          par1   = lv_par1
        IMPORTING
          return = ls_return.
      .
      APPEND ls_return TO et_message.
    ELSE.

*
      CALL METHOD lo_instance->add_attachment
        EXPORTING
          iv_dpo_request = lv_dpo_request
          iv_dpo_term    = lv_dpo_term
          iv_data        = is_media_resource-value
          iv_filename    = lv_filename
          iv_mimetype    = l_minetype
        IMPORTING
          es_att         = es_att
*         ef_valid       = ef_valid
          ef_result      = ef_result
          et_message     = et_message.

    ENDIF.
  ENDMETHOD.


  METHOD stream_word_template.
    DATA: lt_keys    TYPE /iwbep/t_mgw_tech_pairs,
          ls_key     TYPE /iwbep/s_mgw_tech_pair,
          lo_hr_term TYPE REF TO zcl_hr_dpo_term.



    DATA: ls_lheader TYPE ihttpnvp,

          ls_stream  TYPE            ir_dpc_ext->ty_s_media_resource,
          lf_result  TYPE            flag,
          lt_message TYPE            bapirettab,
          lo_message TYPE REF TO     /iwbep/if_message_container.


    "PrintPreview
    DATA: lo_instance     TYPE REF TO     zcl_hr_dpo_request,
          lv_dpo_request  TYPE zhr_dpo_request,
          ls_attchm       TYPE            zhr_dpo_att_s,
          lv_filename     TYPE            skwf_filnm,   "char255
          lv_stream       TYPE            xstring,
          lv_header_value TYPE            string,
          lv_guid         TYPE             guid,
          lv_mimetype     TYPE            skwf_mime,
          lv_temp_code    TYPE            zhr_dpo_templ_code. "sdok_cntty.


    lt_keys = io_tech_request_context->get_keys( ).

    READ TABLE lt_keys ASSIGNING FIELD-SYMBOL(<fs_keys>) WITH KEY name = 'TEMPLATE_CODE'.
    IF sy-subrc EQ 0.
      lv_temp_code = <fs_keys>-value.
    ENDIF.

*    lv_temp_code = 'DX01'.
    lv_dpo_request = '9999999999'.


    SELECT SINGLE * FROM zhr_dpo_req_att INTO @DATA(ls_att)
                            WHERE dpo_request = @lv_dpo_request
                               AND template_code = @lv_temp_code.
*                              AND guid = @lv_guid.

    MOVE-CORRESPONDING ls_att TO  ls_attchm.

    CREATE OBJECT lo_instance.

    CALL METHOD lo_instance->attach_preview
      EXPORTING
        is_attchm   = ls_attchm
      IMPORTING
        ev_stream   = lv_stream
        ev_filename = lv_filename
        ef_result   = lf_result
        et_message  = lt_message.

    CALL FUNCTION 'SKWF_MIMETYPE_OF_FILE_GET'
      EXPORTING
        filename = lv_filename
      IMPORTING
        mimetype = lv_mimetype.


    lv_filename = escape( val = lv_filename format = cl_abap_format=>e_url ).

    READ TABLE it_key_tab ASSIGNING FIELD-SYMBOL(<fs_key>)
                                WITH KEY name = 'DpoRequest'.
    IF sy-subrc EQ 0.
      lv_dpo_request = <fs_key>-value.
    ENDIF.

    IF iv_agreement IS INITIAL.
      CALL METHOD zcl_hr_dpo_term=>prepare_word_template(
        EXPORTING
          iv_dpo_request   = lv_dpo_request
*         iv_dpo_term      = '1'
          iv_xstring       = lv_stream
        IMPORTING
          ev_final_xstring = lv_stream ).

    ENDIF.

    ls_stream-value = lv_stream.
    ls_stream-mime_type = lv_mimetype.

    ls_lheader-name = 'Content-Disposition' ##NO_TEXT.
    IF lv_temp_code  IS INITIAL.
      DATA(lv_length) = strlen( lv_filename ).
      lv_length = lv_length - 5.
      lv_filename = lv_filename+lv_length.
      SELECT SINGLE dpo_req_full FROM zhr_dpo_zad INTO @DATA(lv_req_full) WHERE dpo_request = @lv_dpo_request.
      IF sy-subrc EQ 0.
        lv_filename = |{ TEXT-001 }{ lv_req_full }{ lv_filename }|.
      ENDIF.
    ENDIF.
    CONCATENATE 'attachment; filename="' lv_filename '"'  INTO lv_header_value ##NO_TEXT.
    ls_lheader-value = lv_header_value.

    IF iv_notif IS INITIAL AND iv_agreement IS INITIAL.

      ir_dpc_ext->set_header( is_header = ls_lheader ).


      ir_dpc_ext->copy_data_to_ref( EXPORTING is_data = ls_stream
                                    CHANGING cr_data = er_stream ).

    ELSEIF iv_notif IS NOT INITIAL.
      ir_dpc_notif_ext->set_header( is_header = ls_lheader ).
      ir_dpc_notif_ext->copy_data_to_ref( EXPORTING is_data = ls_stream
                                    CHANGING cr_data = er_stream ).
    ELSE.
      ir_dpc_agreement_ext->set_header( is_header = ls_lheader ).
      ir_dpc_agreement_ext->copy_data_to_ref( EXPORTING is_data = ls_stream
                                    CHANGING cr_data = er_stream ).
    ENDIF.


  ENDMETHOD.
ENDCLASS.
