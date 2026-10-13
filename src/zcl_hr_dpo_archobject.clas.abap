class ZCL_HR_DPO_ARCHOBJECT definition
  public
  final
  create public .

*"* public components of class ZCL_HR_DPO_ARCHOBJECT
*"* do not include other source files here!!!
public section.

  methods CREATE_DOC
    importing
      !IV_DOC_TYPE type SAEDOKTYP
      !IV_DATA type XSTRING
    exporting
      !EV_DOC_ID type SAEARDOID
    raising
      ZCX_SD_SDP_ARCHOBJECT .
  methods DELETE_DOC
    importing
      !IS_ARCHOBJECT type ZSD_SDP_ARCHOBJECT_S
    raising
      ZCX_SD_SDP_ARCHOBJECT .
  methods GET_DOC
    importing
      !IS_ARCHOBJECT type ZSD_SDP_ARCHOBJECT_S
      !IV_ARCHIVE_ID type SAEARCHIVI optional
    exporting
      !EV_DATA type XSTRING
    raising
      ZCX_SD_SDP_ARCHOBJECT .
  methods CONSTRUCTOR
    importing
      !IV_SAP_OBJECT type SAEANWDID .
  methods VALIDATE_DOC_TYPE
    importing
      value(IV_DOC_TYPE) type SAEDOKTYP
    exporting
      !EF_VALID type FLAG .
  class-methods GET_HANDLER
    importing
      !IV_SAP_OBJECT type SAEANWDID
    returning
      value(RO_HANDLER) type ref to ZCL_HR_DPO_ARCHOBJECT .
  PROTECTED SECTION.
*"* protected components of class ZCL_HR_DPO_ARCHOBJECT
*"* do not include other source files here!!!

    METHODS check_connection
      RAISING
        zcx_sd_sdp_archobject .
private section.

*"* private components of class ZCL_HR_DPO_ARCHOBJECT
*"* do not include other source files here!!!
  data GV_SAP_OBJECT type SAEANWDID .
  data GT_TOAOM type ZPE_PDS_TOAOM_T .
  class-data GT_HANDLER_DIR type TT_DIR .
  data GV_ARCHIV_ID_PROD type TOAOM-ARCHIV_ID .

  class-methods RAWTAB_2_XSTRING_CONVERT
    importing
      !IT_RAW type RMPS_T_1024
      !IV_LENGTH type INT4 optional
    exporting
      !EV_XSTRING type XSTRING
      !EV_XSTRLEN type INT4 .
  methods XSTRING_2_RAWTAB_CONVERT
    importing
      !IV_XSTRING type XSTRINGVAL
    exporting
      !ET_TABLE type RMPS_T_1024
      !EV_TOTALLEN type SAPB-LENGTH .
  methods ADJUST_DOC_TYPE
    importing
      !IV_DOC_TYPE type SAEDOKTYP
    returning
      value(RV_DOC_TYPE) type SAEDOKTYP .
ENDCLASS.



CLASS ZCL_HR_DPO_ARCHOBJECT IMPLEMENTATION.


  METHOD ADJUST_DOC_TYPE.

    rv_doc_type = iv_doc_type.

    TRANSLATE rv_doc_type TO UPPER CASE.

  ENDMETHOD.


  METHOD CHECK_CONNECTION.

    "Check connection to IXOS
    DATA: lt_bapiret TYPE bapirettab,
          ls_bapiret LIKE LINE OF lt_bapiret,
          lv_subrc   TYPE sy-subrc,
          ls_toaom   LIKE LINE OF me->gt_toaom,
          lv_text    TYPE string.

    READ TABLE me->gt_toaom INDEX 1 INTO ls_toaom.

* Z duvodu nove functionsality v FM, neprobiha kontrola

*  CALL FUNCTION 'SCMS_HTTP_SERVER_INFO'
*    EXPORTING
*      crep_id               = ls_toaom-archiv_id
*    EXCEPTIONS
*      bad_request           = 1
*      internal_server_error = 2
*      error_http            = 3
*      error_url             = 4
*      error_signature       = 5
*      contrep_not_found     = 6
*      OTHERS                = 7.
*
*  IF sy-subrc <> 0 AND sy-subrc <> 6.
*    CLEAR: lt_bapiret.
*    zcl_pe_all_utils=>append_message_from_syst( CHANGING ct_bapiret = lt_bapiret ).
*    MESSAGE e080(zpe_all) INTO lv_text.
*    zcl_pe_all_utils=>append_message_from_syst( CHANGING ct_bapiret = lt_bapiret ).
*    RAISE EXCEPTION TYPE ZCX_PE_ALL_ARCHOBJECT
*      EXPORTING
*        at_bapiret = lt_bapiret.
*  ENDIF.

  ENDMETHOD.


  METHOD constructor.

    DATA ls_toaom TYPE toaom.

    "Initialize atributes
    me->gv_sap_object = iv_sap_object.

    "Initialize customizing data
    SELECT * FROM toaom INTO TABLE me->gt_toaom WHERE sap_object = me->gv_sap_object.

    IF sy-sysid EQ 'SK2'
    OR sy-sysid EQ 'SK3'
    OR sy-sysid EQ 'SK4'.
      ls_toaom-archiv_id = 'TN'.
      IF me->gt_toaom IS NOT INITIAL.
        gv_archiv_id_prod = me->gt_toaom[ 1 ]-archiv_id.
      ENDIF.
      MODIFY me->gt_toaom FROM ls_toaom TRANSPORTING archiv_id WHERE archiv_id NE 'TN'.
    ENDIF.



  ENDMETHOD.


  METHOD create_doc.

    DATA: lv_ar_object TYPE toaom-ar_object,
          lt_data      TYPE rmps_t_1024,
          lv_archiv_id TYPE saearchivi,
          ls_toaom     LIKE LINE OF me->gt_toaom,
          lv_length    TYPE sapb-length,
          lv_text      TYPE string,
          lt_bapiret   TYPE bapirettab,
          lv_doc_type  LIKE iv_doc_type.

    "Check IXOS connection
    me->check_connection( ).

    lv_doc_type = me->adjust_doc_type( iv_doc_type = iv_doc_type ).
    READ TABLE me->gt_toaom WITH KEY doc_type = lv_doc_type INTO ls_toaom.



    me->xstring_2_rawtab_convert(
        EXPORTING
          iv_xstring = iv_data
        IMPORTING
          et_table   = lt_data
          ev_totallen = lv_length ).





    CALL FUNCTION 'ARCHIVOBJECT_CREATE_TABLE'
      EXPORTING
        archiv_id                = ls_toaom-archiv_id
*       ARC_DOC_ID               =
        document_type            = lv_doc_type ""ls_toaom-doc_type .. repair PaM
        length                   = lv_length
*       COMPID                   = 'data'
*       SIGNATURE                = 'X'
      IMPORTING
        archiv_doc_id            = ev_doc_id
      TABLES
*       ARCHIVOBJECT             =
*       COMPONENTS               =
        binarchivobject          = lt_data
      EXCEPTIONS
        error_archiv             = 1
        error_communicationtable = 2
        error_kernel             = 3
        OTHERS                   = 4.

    IF sy-subrc <> 0.
      CLEAR: lt_bapiret.
      zcl_pe_all_utils=>append_message_from_syst( CHANGING ct_bapiret = lt_bapiret ).
      MESSAGE e080(zpe_all) INTO lv_text.
      zcl_pe_all_utils=>append_message_from_syst( CHANGING ct_bapiret = lt_bapiret ).
      RAISE EXCEPTION TYPE zcx_sd_sdp_archobject
        EXPORTING
          bapirettab = lt_bapiret.
    ENDIF.

  ENDMETHOD.


  METHOD DELETE_DOC.

    DATA: ls_toaom    LIKE LINE OF me->gt_toaom,
          lv_text     TYPE string,
          lt_bapiret  TYPE bapirettab,
          lv_doc_type TYPE saedoktyp.

    "Check IXOS connection
    me->check_connection( ).

    READ TABLE me->gt_toaom INDEX 1 INTO ls_toaom.
    lv_doc_type = me->adjust_doc_type( iv_doc_type = is_archobject-doc_type ).

    CALL FUNCTION 'ARCHIVOBJECT_DELETE'
      EXPORTING
        archiv_doc_id            = is_archobject-doc_id
        archiv_id                = ls_toaom-archiv_id
        doc_type                 = lv_doc_type
      EXCEPTIONS
        error_archiv             = 1
        error_communicationtable = 2
        error_kernel             = 3
        OTHERS                   = 4.

    IF sy-subrc <> 0.
      CLEAR: lt_bapiret.
      zcl_sd_sdp_helper=>append_message_from_syst( CHANGING ct_message = lt_bapiret ).
      MESSAGE e300(zsd_sdp) INTO lv_text.
      zcl_sd_sdp_helper=>append_message_from_syst( CHANGING ct_message = lt_bapiret ).
      RAISE EXCEPTION TYPE zcx_sd_sdp_archobject
        EXPORTING
          bapirettab = lt_bapiret.
    ENDIF.

  ENDMETHOD.


  METHOD get_doc.

    DATA: ls_toaom    LIKE LINE OF me->gt_toaom,
          lv_text     TYPE string,
          lv_length   TYPE sapb-length,
          lt_data     TYPE rmps_t_1024,
          lt_bapiret  TYPE bapirettab,
          lv_doc_type TYPE saedoktyp.

    "Check IXOS connection
    me->check_connection( ).

    lv_doc_type = me->adjust_doc_type( iv_doc_type = is_archobject-doc_type ).
    READ TABLE me->gt_toaom WITH KEY doc_type = is_archobject-doc_type INTO ls_toaom.

    IF iv_archive_id IS NOT INITIAL.
      ls_toaom-archiv_id = iv_archive_id.
    ENDIF.

    CALL FUNCTION 'ARCHIVOBJECT_GET_TABLE'
      EXPORTING
        archiv_id                = ls_toaom-archiv_id
        document_type            = lv_doc_type
        archiv_doc_id            = is_archobject-doc_id
*       ALL_COMPONENTS           =
*       SIGNATURE                = 'X'
*       COMPID                   = 'data'
      IMPORTING
        length                   = lv_length
*       BINLENGTH                =
      TABLES
*       ARCHIVOBJECT             =
        binarchivobject          = lt_data
      EXCEPTIONS
        error_archiv             = 1
        error_communicationtable = 2
        error_kernel             = 3
        OTHERS                   = 4.


    IF sy-subrc <> 0 AND sy-sysid = 'SK4'.
* zkus načíst produkční archiv kdy probehla kopie z produkce

      CALL FUNCTION 'ARCHIVOBJECT_GET_TABLE'
        EXPORTING
          archiv_id                = gv_archiv_id_prod
          document_type            = lv_doc_type
          archiv_doc_id            = is_archobject-doc_id
*         ALL_COMPONENTS           =
*         SIGNATURE                = 'X'
*         COMPID                   = 'data'
        IMPORTING
          length                   = lv_length
*         BINLENGTH                =
        TABLES
*         ARCHIVOBJECT             =
          binarchivobject          = lt_data
        EXCEPTIONS
          error_archiv             = 1
          error_communicationtable = 2
          error_kernel             = 3
          OTHERS                   = 4.

      IF sy-subrc <> 0.





        CLEAR: lt_bapiret.
        zcl_pe_all_utils=>append_message_from_syst( CHANGING ct_bapiret = lt_bapiret ).
        MESSAGE e080(zpe_all) INTO lv_text.
        zcl_pe_all_utils=>append_message_from_syst( CHANGING ct_bapiret = lt_bapiret ).
        RAISE EXCEPTION TYPE zcx_sd_sdp_archobject
          EXPORTING
            bapirettab = lt_bapiret.
      ENDIF.
    ENDIF.

    CALL METHOD me->rawtab_2_xstring_convert
      EXPORTING
        it_raw     = lt_data
        iv_length  = CONV int4( lv_length )
      IMPORTING
        ev_xstring = ev_data.

  ENDMETHOD.


  METHOD GET_HANDLER.

    DATA: wa_handler_dir LIKE LINE OF gt_handler_dir.

    READ TABLE gt_handler_dir WITH TABLE KEY sap_object = iv_sap_object INTO wa_handler_dir.
    IF sy-subrc = 0.
      ro_handler = wa_handler_dir-handler.
    ELSE.

      CREATE OBJECT ro_handler EXPORTING iv_sap_object = iv_sap_object.

      wa_handler_dir-sap_object = iv_sap_object.
      wa_handler_dir-handler = ro_handler.
      INSERT wa_handler_dir INTO TABLE gt_handler_dir.

    ENDIF.

  ENDMETHOD.


  METHOD RAWTAB_2_XSTRING_CONVERT.

    FIELD-SYMBOLS:
      <fs_raw> TYPE tbl1024.

    LOOP AT it_raw ASSIGNING <fs_raw>.
      CONCATENATE
        ev_xstring
        <fs_raw>-line
        INTO ev_xstring
        IN BYTE MODE.
    ENDLOOP.

    IF iv_length > 0 AND iv_length < xstrlen( ev_xstring ).
      ev_xstring = ev_xstring(iv_length).
    ENDIF.
    ev_xstrlen = xstrlen( ev_xstring ).

  ENDMETHOD.


  METHOD VALIDATE_DOC_TYPE.

    DATA: lv_text     TYPE string,
          lt_bapiret  TYPE bapirettab,
          lv_doc_type LIKE iv_doc_type.

    lv_doc_type = me->adjust_doc_type( iv_doc_type = iv_doc_type ).

    READ TABLE me->gt_toaom WITH KEY doc_type = lv_doc_type TRANSPORTING NO FIELDS.

    IF sy-subrc <> 0.
      ef_valid = abap_false.
    ELSE.
      ef_valid = abap_true.
    ENDIF.

  ENDMETHOD.


  METHOD XSTRING_2_RAWTAB_CONVERT.

    CONSTANTS:
      lc_linesize   TYPE i VALUE 1024.

    DATA:
      lr_data     TYPE REF TO data,
      ls_line     LIKE LINE OF et_table,
      lv_i        TYPE i,
      lv_linesize TYPE i,
      lv_length   TYPE i,
      lv_rest     TYPE i,
      lv_s        TYPE string,
      lv_xstring  TYPE xstring.


    REFRESH et_table.

*-- konverze na string
    lv_xstring = iv_xstring.

    lv_i = 0.
    lv_length = lc_linesize.
    ev_totallen = xstrlen( lv_xstring ).

    lv_rest = ev_totallen.

    WHILE lv_rest > 0.
      IF lv_rest < lc_linesize.
        lv_length = lv_rest.
      ENDIF.

      ls_line-line = lv_xstring+lv_i(lv_length).
      APPEND ls_line TO et_table.

      lv_i = lv_i + lv_length.
      lv_rest = ev_totallen - lv_i.
    ENDWHILE.

  ENDMETHOD.
ENDCLASS.
