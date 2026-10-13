class ZCL_HR_DPO_LNK_GENERATOR definition
  public
  inheriting from ZCL_PE_LNK_GENERATOR
  final
  create public .

public section.

  class-methods GENERATE_LINK
    importing
      !IV_ID_APPLICATION type ZPE_ALL_ID_APPLICATION
      !IV_SYSID type SYSYSID optional
      !IT_PARAMETERS type ZPE_ALL_TT_LNK_PARAMS
    returning
      value(RV_LINK) type STRINGVAL .
protected section.

  methods GET_LINK
    redefinition .
private section.
ENDCLASS.



CLASS ZCL_HR_DPO_LNK_GENERATOR IMPLEMENTATION.


  method GENERATE_LINK.
     DATA:
    lr_lnk_gen  TYPE REF TO zcl_hr_dpo_lnk_generator,
    ls_app_cust TYPE zpe_all_clnkapp.

  CLEAR rv_link.

*-- nacteni tridy, kterou se ma generovani linku zpracovavat
  SELECT SINGLE *
    FROM zpe_all_clnkapp
    INTO ls_app_cust
    WHERE id_application = iv_id_application.

* pokud zaznam pro aplikaci neexistuje nebo neni definovana trida,
* pokusime se nacist defaultni nastaveni
  IF sy-subrc <> 0 OR ls_app_cust-link_clsname IS INITIAL.
    SELECT SINGLE *
      FROM zpe_all_clnkapp
      INTO ls_app_cust
      WHERE id_application = ''.
  ENDIF.

  CHECK ls_app_cust-link_clsname IS NOT INITIAL.

*-- pokusime se vytvorit objekt daneho typu
  TRY.
      CREATE OBJECT lr_lnk_gen TYPE (ls_app_cust-link_clsname).
    CATCH cx_sy_create_object_error .
      RETURN.
  ENDTRY.

* generovani linku
  rv_link = lr_lnk_gen->get_link(
    iv_id_application = iv_id_application
    iv_sysid          = iv_sysid
    it_parameters     = it_parameters  ).




  endmethod.


  method GET_LINK.
*CALL METHOD SUPER->GET_LINK
*  EXPORTING
*    IV_ID_APPLICATION =
**    iv_sysid          = SY-SYSID
*    IT_PARAMETERS     =
*  RECEIVING
*    RV_LINK           =
*    .
 DATA:
    lv_param_separator_a TYPE string VALUE '?',
    lv_param_separator_b TYPE string VALUE '&',
    lv_found             TYPE xfeld,
    lv_name              TYPE string,
    lv_service           TYPE string,
    lv_s                 TYPE string.

  FIELD-SYMBOLS:
    <fs_param> LIKE LINE OF it_parameters.

  CLEAR rv_link.

* nacteni customizace
  me->read_customization(
    iv_id_application = iv_id_application
    iv_sysid          = iv_sysid ).

*-- slozeni linku
* sso prefix
  rv_link = me->get_sso_prefix( ).

* protokol
  lv_s = me->get_protocol( ).
  CONCATENATE rv_link lv_s '://' INTO rv_link.

* host
  lv_s = me->get_host( ).
  CONCATENATE rv_link lv_s INTO rv_link.

* port
  lv_s = me->get_port( ).
  IF lv_s IS NOT INITIAL.
    CONCATENATE rv_link ':' lv_s INTO rv_link.
  ENDIF.

* service
  lv_service = lv_s = me->get_service( ).
  CONCATENATE rv_link lv_s INTO rv_link.

*-- parametry
* oddelovac parametru - lisi se pokud je SSO prefix nebo ne
  IF gs_cust_prms_merged-sso_prefix = 'X' AND gs_cust_prms_merged-sso_link IS NOT INITIAL.
    lv_param_separator_a = '%3F'.
    lv_param_separator_b = '%26'.
  ELSE.
    lv_param_separator_a = '?'.
    lv_param_separator_b = '&'.
  ENDIF.

  lv_s = lv_param_separator_a.

  FIND REGEX '%3F' IN lv_service IGNORING CASE.
  IF sy-subrc = 0.
    lv_s = lv_param_separator_b.
  ENDIF.

*-- pripojeni parametru sap-client, pokud neni v predanych parametrech
  CLEAR lv_found.
*  LOOP AT it_parameters ASSIGNING <fs_param>.
*    lv_name = <fs_param>-name.
*    TRANSLATE lv_name TO UPPER CASE.
*    IF lv_name = 'SAP-CLIENT'.
*      lv_found = 'X'.
*      EXIT.
*    ENDIF.
*  ENDLOOP.
*  IF lv_found <> 'X'.
*    CONCATENATE rv_link lv_s 'sap-client' '=' sy-mandt INTO rv_link.
*    lv_s = lv_param_separator_b.
*  ENDIF.

  LOOP AT it_parameters ASSIGNING <fs_param>.

    CONCATENATE rv_link  <fs_param>-value INTO rv_link.

    lv_s = lv_param_separator_b.

  ENDLOOP.

  endmethod.
ENDCLASS.
