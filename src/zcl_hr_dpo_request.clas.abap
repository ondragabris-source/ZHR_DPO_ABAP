class ZCL_HR_DPO_REQUEST definition
  public
  inheriting from ZCL_HR_DPO_MAIN
  final
  create public .

public section.

  interfaces ZIF_CA_UNIFRAME_ECOCKPIT_DPR .
  interfaces ZIF_PE_ALL_TASK_MNG .

  types:
    TT_STATUS_DESC TYPE STANDARD TABLE OF ZHR_DPO_S_CSTAT .
  types:
    TT_ROZDEL TYPE STANDARD TABLE OF zhr_dpo_rozdel .
  types:
    TT_CUSTOM_REQUEST TYPE STANDARD TABLE OF ZHR_DPO_CZAD .
  types:
    TT_CUSTOM_TEMPLATE TYPE STANDARD TABLE OF ZHR_DPO_CSABL .

  data GS_DATA_DB type ZHR_DPO_ZAD_STRUCT .
  data GS_CUSTOM_REQUEST type ZHR_DPO_CZAD .
  data GT_CUSTOM_REQUEST type TT_CUSTOM_REQUEST .
  data GS_CUSTOM_TEMPLATE type ZHR_DPO_CSABL .
  data GT_CUSTOM_TEMPLATE type TT_CUSTOM_TEMPLATE .
  data GV_PROCESS_TYPE type ZHR_DPO_PROCESS value 'P-CENTR' ##NO_TEXT.
  constants CV_REQUEST type ZHR_DPO_OBJECT value 'R' ##NO_TEXT.
  data GT_ROZDEL type TT_ROZDEL .
  data GT_STATUS_DESC type TT_STATUS_DESC .
  data GT_APPROVERS type ZCA_UF_TT_APPROVER .
  data GT_NEXT_STATUS_TAB type ZHR_DPO_NEXT_STATUS_T .
  constants CO_OK type ZHR_RETURN_OK_CODE value 'OK' ##NO_TEXT.
  constants CO_FAIL type ZHR_RETURN_OK_CODE value 'FAIL' ##NO_TEXT.
  constants CO_UNDEFINED type SY-UNAME value 'undefined' ##NO_TEXT.

  class-methods CONVERT_REQUEST
    changing
      !CHS_REQUEST type ZHR_DPO_ZADCONV .
  class-methods GET_DOMAIN_VALUES
    importing
      !IV_NAME type DDOBJNAME
    returning
      value(RT_DD07V) type DD07V_TAB .
  class-methods GET_NEXT_STEPS
    importing
      !IV_STATUS type ZHR_DPO_STATUS optional
      !IV_ROLE type ZHR_DPO_ROLE optional
      !IV_DPO_REQUEST type ZHR_DPO_REQUEST
    returning
      value(RT_STATUSES) type ZHR_DPO_NEXT_STATUS_T .
  class-methods GET_OTHER_ROLES
    returning
      value(RT_ROLES) type ZHR_DPO_OTHER_ROLES_T .
  class-methods SHOW_APPROVAL_FORK
    importing
      !IV_DPO_REQUEST type ZHR_DPO_REQUEST
      !IV_ONLY_NEXT_APPROVERS type XFLAG optional
      !IV_PERNR type PERNR_D optional
      !IV_ROLE type ZHR_DPO_ROLE optional
    returning
      value(RT_APPROVAL_TAB) type ZHR_DPO_ROZDEL_T .
  methods ADD_ATTACHMENT
    importing
      !IV_DPO_REQUEST type ZHR_DPO_REQUEST optional
      !IV_DPO_TERM type ZHR_DPO_ID_TERM optional
      !IV_DPO_AGREEMENT type ZHR_DPO_AGREEMENT optional
      !IV_TEMPLATE_CODE type ZHR_DPO_TEMPL_CODE optional
      !IV_DATA type XSTRING optional
      !IV_FILENAME type STRING optional
      !IV_MIMETYPE type W3CONTTYPE optional
    exporting
      !ES_ATT type ZHR_DPO_ATT_S
      !EF_VALID type BOOLE_D
      !EF_RESULT type FLAG
      !ET_MESSAGE type BAPIRETTAB .
  methods ADD_NEXT_APPROVER
    importing
      !IS_APPROVER type ZHR_DPO_ROZDEL_S
    exporting
      !ET_MESSAGE type BAPIRET2_T .
  methods ASSIGN_TERM
    importing
      !IV_EXCLUDE_TERM type ZHR_DPO_ID_TERM optional
    returning
      value(RS_RETURN) type ZHR_DPO_TERM_RETURN_S .
  methods ATTACH_PREVIEW
    importing
      !IS_ATTCHM type ZHR_DPO_ATT_S
    exporting
      !EV_STREAM type XSTRING
      !EV_FILENAME type CHAR255
      !EF_RESULT type FLAG
      !ET_MESSAGE type BAPIRETTAB .
  methods BUTTON_PRESS
    importing
      !IV_BUTTON type ZHR_DPO_BUTTON
      !IV_PROCESS type ZHR_DPO_PROCESS
      !IV_UNAME type SY-UNAME optional .
  methods CHANGE_TERM
    importing
      !IV_DPO_REQUEST type ZHR_DPO_REQUEST
      !IV_DPO_TERM type ZHR_DPO_ID_TERM
    returning
      value(RS_RETURN) type ZHR_DPO_REQUEST_S .
  methods CHECK_FIELD_STAT_AUTH
    importing
      !IV_PROCESS type ZHR_DPO_PROCESS
      !IV_ROLE type ZHR_DPO_ROLE
      !IV_FIELD type ZHR_DPO_FIELDNAME optional
    returning
      value(RS_RESULT) type ZHR_DPO_CPRAVAST .
  methods CLEAR_APPROVERS .
  methods CONVERT_STRING_TO_TEXT_TABLE
    importing
      !IV_STRING type STRING
    returning
      value(RT_TEXT_TABLE) type TLINE_T .
  methods CREATE_APPROVAL_FORK
    importing
      !IV_DPO_REQUEST type ZHR_DPO_REQUEST
      !IV_UNAME type UNAME
    exporting
      !ET_MESSAGE type BAPIRET2_T .
  methods DELETE_ATTACHMENT
    importing
      !IS_ATTCH type ZHR_DPO_ATT_S
    exporting
      !ET_MESSAGE type BAPIRET2_T
    returning
      value(RS_RETURN) type ZHR_DPO_REQUEST_S .
  methods DELETE_NEXT_APPROVER
    importing
      !IV_DPO_REQUEST type ZHR_DPO_REQUEST
      !IV_ROLE type ZHR_DPO_ROLE
      !IV_UNAME type UNAME
    exporting
      !ET_MESSAGE type BAPIRET2_T
    returning
      value(RS_RETURN) type ZHR_RETURN_OK_CODE .
  methods DELETE_REQUEST
    importing
      !IV_DPO_REQUEST type ZHR_DPO_REQUEST optional
      !IV_DELETE_STATUS type ZHR_DPO_STATUS_REQ
    exporting
      !ET_MESSAGE type BAPIRET2_T
    returning
      value(RS_RETURN) type ZHR_DPO_REQUEST_S .
  methods DISPLAY_PDF
    importing
      !IV_DPO_REQUEST type ZHR_DPO_REQUEST
      !IV_FORM_TYPE type ZHR_DPO_PDF_FORM_TYPE
    exporting
      !EV_PDF_STREAM type XSTRING
      !EF_RESULT type FLAG
      !ET_MESSAGE type BAPIRETTAB .
  methods DUMMY .
  methods STATUS_EXISTS_IN_HISTORY
    importing
      !IV_DPO_REQUEST type ZHR_DPO_REQUEST
      !IV_STATUS type ZHR_DPO_STATUS_REQ_NEXT
    returning
      value(RETURN) type BOOLEAN .
  methods GET_AUTHORIZATION_STRUCTURE
    importing
      !IV_DPO_REQUEST type ZHR_DPO_REQUEST optional
      !IV_UNAME type UNAME
      !IV_DPO_PROCESS type ZHR_DPO_PROCESS
    exporting
      !ET_MESSAGE type BAPIRET2_T
    returning
      value(RS_AUTHORITY_STRUCT) type ZHR_DPO_PRAVA_S
    raising
      CX_NO_AUTHORIZATION .
  methods GET_HISTORY
    importing
      !IV_DPO_REQUEST type ZHR_DPO_REQUEST optional
      !NO_BEHALFS type XFELD optional
    returning
      value(RT_HISTORY_TAB) type ZHR_DPO_HIST_T .
  methods GET_LONG_TEXT
    importing
      !IV_TEMPLATE_CODE type ZHR_DPO_TEMPL_CODE
    returning
      value(RS_LONG_TEXT) type ZHR_DPO_LONGTEXT .
  methods GET_LONG_TEXTS_ALL
    importing
      !IV_DPO_REQUEST type ZHR_DPO_REQUEST
    exporting
      !ET_MESSAGE type BAPIRET2_T
    returning
      value(RS_LONG_TEXT_ALL) type ZHR_DPO_LONGTEXT_ALL .
  methods GET_NEXT_STATUS_TAB
    importing
      !IV_DPO_REQUEST type ZHR_DPO_REQUEST
      !IV_IGNORE_ACTUAL_STATUS type XFELD optional
      !IV_IGNORE_APPL_STAT type XFELD optional
    exporting
      !ET_MESSAGE type BAPIRET2_T
    returning
      value(RT_NEXT_STATUS_TAB) type ZHR_DPO_NEXT_STATUS_T .
  methods GET_REQUEST
    returning
      value(RS_DPO_REQUEST) type ZHR_DPO_ZAD_STRUCT .
  methods GET_REQUEST_LIST
    importing
      !REQUEST_RANGE type /IWBEP/T_COD_SELECT_OPTIONS optional
      !REQUEST_TYPE_RANGE type /IWBEP/T_COD_SELECT_OPTIONS optional
      !REQUEST_DATE_RANGE type /IWBEP/T_COD_SELECT_OPTIONS optional
      !REQUEST_YEAR_RANGE type /IWBEP/T_COD_SELECT_OPTIONS optional
      !REQUEST_FULL_RANGE type /IWBEP/T_COD_SELECT_OPTIONS optional
      !CREATOR_RANGE type /IWBEP/T_COD_SELECT_OPTIONS optional
      !SENDDATE_RANGE type /IWBEP/T_COD_SELECT_OPTIONS optional
      !NAME_RANGE type /IWBEP/T_COD_SELECT_OPTIONS optional
      !STATUS_RANGE type /IWBEP/T_COD_SELECT_OPTIONS optional
      !PROCESS_RANGE type /IWBEP/T_COD_SELECT_OPTIONS optional
      !IV_PROCESS type ZHR_DPO_PROCESS optional
      !IV_FROM_TERM_STRING type STRING optional
      !ORGEH type /IWBEP/T_COD_SELECT_OPTIONS optional
      !REQUESTOR_FULL_NAME type /IWBEP/T_COD_SELECT_OPTIONS optional
      !TERM_DATE type /IWBEP/T_COD_SELECT_OPTIONS optional
      !TASK_UNFINISHED type /IWBEP/T_COD_SELECT_OPTIONS optional
    returning
      value(RT_REQUEST_LIST) type ZHR_DPO_ZAD_T .
  methods GET_WERKS_UNION_TEXT
    returning
      value(RT_LONGTEXT_UNION) type ZHR_DPO_WERK_TEXT_T .
  methods MOVE_ATTACHMENTS_TO_UNI .
  methods PREPARE_TO_SAVE
    changing
      !CHS_REQUESTDATA type ZHR_DPO_ZAD_STRUCT .
  methods READ_ATTACHMENT_TAB
    importing
      !IV_DPO_REQUEST type ZHR_DPO_REQUEST
      !IV_DPO_TERM type ZHR_DPO_ID_TERM optional
      !IV_WITH_AGREEMENTS type XFELD optional
      !IV_UNAME type UNAME optional
    returning
      value(RT_ATTACHMENT_TAB) type ZHR_DPO_ATT_T .
  methods READ_CUSTOMIZING .
  methods READ_REQUEST
    importing
      !IV_DPO_REQUEST type ZHR_DPO_REQUEST
      !IV_READ_TMP_REQUEST type XFLAG optional
      !IV_UNI_PROCESS type XFLAG optional
    returning
      value(RS_DPO_REQUEST) type ZHR_DPO_ZAD_STRUCT .
  methods READ_TEXT
    importing
      !IS_HEAD type THEAD optional
      !IV_MAIL type XFELD optional
    exporting
      !EV_SUBJECT type ZHR_DPO_NAME
      !EV_SUCCESS type XFELD
    returning
      value(RV_LONGTEXT) type STRING .
  methods SAVE_ALL_LONGTEXTS
    importing
      !IS_LONGTEXT type ZHR_DPO_LONGTEXT_ALL
    exporting
      !ET_MESSAGE type BAPIRET2_T
    returning
      value(IS_RETURN) type ZHR_DPO_REQUEST_S .
  methods SAVE_AS_DRAFT_REQ
    importing
      !BUTTON_AS_DRAFT type XFELD optional .
  methods SAVE_LONG_TEXT
    importing
      !IV_TEXT_TYPE type CHAR2
      !IV_TEXT type STRING .
  methods SAVE_REQ
    importing
      !IV_AS_DRAFT type XFELD optional
      !IV_BUTTON_AS_DRAFT type CHAR1 optional .
  methods SEND_MAIL_TO_ZAD_NEXT
    returning
      value(RV_RETURN) type FLAG .
  methods SEND_MAIL_TO_SP
    returning
      value(RV_RETURN) type FLAG .
  methods SEND_MAIL_TO_CONSULTANT
    importing
      !IV_SO10_TEXT_NAME type TDOBNAME
    returning
      value(RV_RETURN) type FLAG .
  methods SEND_MAIL_SP_RETURNS
    returning
      value(RV_RETURN) type FLAG .
  methods SEND_MAIL_HRBP_RETURNS
    returning
      value(RV_RETURN) type FLAG .
  methods SEND_MAIL_TO_HRBP
    returning
      value(RV_RETURN) type FLAG .
  methods SEND_REQUEST_TO_UNION .
  methods SETUP_CONDITION
    importing
      !IV_PROCESS type ZHR_DPO_PROCESS
      !IV_UNAME type UNAME optional
      !IV_BUTTON type ZHR_DPO_BUTTON
    returning
      value(RV_CONDITION) type ZHR_DPO_CONDITION .
  methods SET_DEPUTY
    returning
      value(RT_DEPUTY_TAB) type ZHR_DPO_DEPUTY_T .
  methods SET_NEXT_STATUS
    importing
      !IV_NEXT_STATUS type ZHR_DPO_STATUS_REQ_NEXT
      !IV_CLARIFICATION type ZHR_DPO_CLARIFICATION optional
      !IV_IGNORE_ACTUAL_STATUS type XFELD optional
      !IV_NOTIF_STATUS type ZHR_DPO_STATUS_REQ_NEXT optional
      !IV_UNAME type SY-UNAME optional
    returning
      value(RS_RETURN) type ZHR_DPO_REQUEST_S .
  methods SET_REQUEST
    importing
      !IV_DPO_REQUEST type ZHR_DPO_REQUEST
    returning
      value(RETURN) type ref to ZCL_HR_DPO_REQUEST .
  methods SET_REQUEST_DATA
    importing
      !IR_PROTOCOL_DATA type ref to DATA
    exporting
      !EV_RESULT type SYSUBRC
      !ET_MESSAGES type BAPIRETTAB .
  methods TASK_COMPLETE .
  methods TASK_MANAG
    importing
      !IV_ROLE type ZHR_DPO_ROLE
      !IV_MESSAGE_TYPE type ZHR_DPO_TM_MESSAGE_TYPE .
  methods TASK_MANAGER_CANCEL
    importing
      !IV_GUID type GUID_32 optional
      !IV_DPO_REQUEST type ZHR_DPO_REQUEST
    exporting
      !EF_RESULT type FLAG
      !ET_MESSAGE type BAPIRETTAB .
  methods TASK_MANAGER_COMPLETE
    importing
      !IV_GUID type GUID_32 optional
      !IV_DPO_REQUEST type ZHR_DPO_REQUEST
      !IV_RESOLVER type UNAME
    exporting
      !EF_RESULT type FLAG
      !ET_MESSAGE type BAPIRETTAB .
  methods TASK_MANAGER_CREATE
    importing
      !IV_DPO_REQUEST_FULL type ZHR_DPO_REQUEST_FULL
      !IV_DPO_REQUEST type ZHR_DPO_REQUEST
      !IV_RESOLVER type UNAME
      !IV_MESSAGE_TYPE type ZHR_DPO_TM_MESSAGE_TYPE
    exporting
      !EF_RESULT type FLAG
      !ET_MESSAGE type BAPIRETTAB .
  methods TASK_OJ .
  methods TASK_OJ_NEXT .
  methods TASK_SP1 .
  methods TASK_SP1_AGR .
  methods TASK_SP2 .
  methods TASK_SP3 .
  methods TEST_METHOD .
  methods UNASSIGN_TERM .
  methods UNI_HRBP .
  methods UNI_HRBP_RETURN .
  methods UNI_VED_SP .
  methods UPDATE_NEXT_APPROVER
    importing
      !IS_APPROVER type ZHR_DPO_ROZDEL_S
    exporting
      !ET_MESSAGE type BAPIRET2_T .
  methods UPDATE_CHANGE_SIGN
    importing
      !IV_CHANGED type XFELD .
  methods GET_MAIL_UNION
    importing
      !IV_DPO_REQUEST type ZHR_DPO_REQUEST
      !IV_BUTTON type ZHR_DPO_BUTTON
    returning
      value(E_SUBJECTBODY) type ZHR_DPO_AGR_EMAIL_S .
  methods COPY_REQUEST
    importing
      value(IV_DPO_REQUEST) type ZHR_DPO_REQUEST
      !IV_ORIGIN_USER type UNAME
    returning
      value(RV_DPO_REQUEST) type ZHR_DPO_REQUEST .
  methods UPDATE_TERM_IN_HISTORY
    importing
      !I_TERM_ID type ZHR_DPO_ID_TERM
      !IV_DPO_REQUEST type ZHR_DPO_REQUEST
      !I_OLD_TERM_ID type ZHR_DPO_ID_TERM optional
      !IS_HIST type ZHR_DPO_HIST optional .
  class-methods GET_INSTANCE_REQUEST
    importing
      !IV_DPO_REQUEST type ZHR_DPO_REQUEST
    returning
      value(RETURN) type ref to ZCL_HR_DPO_REQUEST .

  methods APPL_ACTION_AFTER_LINE_APPR
    redefinition .
  methods APPL_ACTION_AFTER_STEP_APPR
    redefinition .
  methods APPL_ACTION_CANCEL_FORM
    redefinition .
  methods APPL_FILL_INBOX_DESCRIPTION
    redefinition .
  methods APPL_FILL_INBOX_DESCRIPTION_ON
    redefinition .
  methods APPL_GENERATE_APPROVING_FORM
    redefinition .
  methods APPL_SAVE_FORM
    redefinition .
  methods APPL_SET_BUTTONS_VISIBILITY
    redefinition .
  methods INIT_FORM_DATA
    redefinition .
  methods SAVE_AS_DRAFT
    redefinition .
protected section.

  data GS_ACTIVE_ZAD type ZHR_DPO_ZAD_ACT .
  data GT_NOT_APPROVED_ATT type ZHR_DPO_TT_REQ_ATT .
  data GV_NOT_APPROVED_VERS type VERSION .

  methods CHECK_FIELD
    returning
      value(ET_MESSAGE) type BAPIRET2_T .
  methods CLEAR_ROZDEL_SEND_AFTER_REJECT .
  methods FILL_APPROVERS
    importing
      !IV_ROLE type ZHR_DPO_ROLE
    returning
      value(RT_APPROVERS) type ZCA_UF_TT_APPROVER .
  methods READ_NEXT_STEP
    importing
      !IV_STATUS type ZHR_DPO_STATUS_REQ
      !IV_PROCESS type ZHR_DPO_PROCESS
      !IV_ROLE type ZHR_DPO_ROLE .
  methods RUN_UNIPROCESS .
  methods RELOAD_ACTIVE_ZAD
    importing
      !IV_DPO_REQUEST type ZHR_DPO_REQUEST optional
    returning
      value(RETURN) type ZHR_DPO_ZAD_ACT .
  methods CHECK_NOT_YET_APPROVED
    returning
      value(RETURN) type ABAP_BOOLEAN .
  methods ATTACHMENT_TO_HISTORY .
  methods IS_BUTTON_CHECK_RELEVANT
    importing
      !IV_BUTTON type ZHR_DPO_BUTTON
    changing
      !CH_STATUS_TO_CHECK type ZHR_DPO_STATUS_REQ
    returning
      value(RETURN) type ABAP_BOOLEAN .
private section.

  methods UNI_OJ .
  methods GET_FULL_NAME
    returning
      value(RV_NAME_FULL) type ZHR_DPO_HIST_S-NAME_FULL .
ENDCLASS.



CLASS ZCL_HR_DPO_REQUEST IMPLEMENTATION.


  METHOD add_attachment.


    DATA: ls_a_db        TYPE zhr_dpo_req_att, "zsd_sdp_supcpl_att_s,
          lo_val         TYPE REF TO zcl_sd_sdp_supcpl_val_bl,
          lf_valid       TYPE boole_d,
          ls_return      TYPE bapiret2,
          lv_extension   TYPE string,
          lv_par1        TYPE sy-msgv1,
          lx_arch        TYPE REF TO zcx_sd_sdp_archobject,
          lr_arch        TYPE REF TO zcl_hr_dpo_archobject,



          lx_root        TYPE REF TO cx_root,
          lv_dpo_request TYPE zhr_dpo_request..


    ef_result = abap_true.

    CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'
      EXPORTING
        input  = iv_dpo_request
      IMPORTING
        output = lv_dpo_request.


    TRY.

* - Create document in IXos
        lv_extension = zcl_sd_sdp_helper=>get_file_extension( iv_filename = iv_filename ).
        es_att-doc_type = lv_extension.
        lr_arch = zcl_hr_dpo_archobject=>get_handler( iv_sap_object = 'ZHR_DPO' ).

        lr_arch->create_doc(
          EXPORTING
            iv_doc_type = es_att-doc_type
            iv_data     = iv_data
          IMPORTING
            ev_doc_id   = es_att-doc_id
               ).

*internal guid for temp attachement
        es_att-guid  = cl_system_uuid=>create_uuid_c32_static( ).


        es_att-dpo_request    = lv_dpo_request.
        es_att-dpo_agreement  = iv_dpo_agreement.
        es_att-term_id        = iv_dpo_term.
        es_att-template_code  = iv_template_code.
        .

        es_att-filename = iv_filename.
        es_att-mimetype = iv_mimetype.



        MOVE-CORRESPONDING es_att TO ls_a_db.
        ls_a_db-uname = es_att-uname = sy-uname.



*        ls_a_db-not_yet_approved = NEW zcl_hr_dpo_request( )->status_exists_in_history( iv_dpo_request  =   iv_dpo_request
*                                                                  iv_status       = 'ZHP' ).


        INSERT zhr_dpo_req_att FROM ls_a_db.
        IF sy-subrc <> 0.
          MESSAGE e004(zsd_sdp) WITH 'ZHR_DPO_REQ_ATT' .
*   Internal: Update of db table &1 failed.
        ENDIF.



      CATCH cx_uuid_error zcx_sd_sdp_archobject zcx_sd_sdp_user   INTO lx_root.
        lv_par1 = es_att-doc_type.
        CALL FUNCTION 'BALW_BAPIRETURN_GET2'
          EXPORTING
            type   = 'E'
            cl     = 'ZHR_DPO'
            number = '014'
            par1   = lv_par1
          IMPORTING
            return = ls_return.
        .
        APPEND ls_return TO et_message.

    ENDTRY.


   me->update_change_sign( 'X').



  ENDMETHOD.


  METHOD add_next_approver.

    DATA: ls_approver TYPE zhr_dpo_rozdel.
    DATA: ls_return   TYPE bapiret2,
          lv_msg1     TYPE sy-msgv1,
          lv_usrid    TYPE  p0105-usrid,
          lv_pernr    TYPE pernr_d,
          lv_zad_next TYPE uname,
          lt_struc    TYPE TABLE OF struc.

    CHECK is_approver-pernr IS NOT INITIAL.
    MOVE-CORRESPONDING is_approver TO ls_approver.

    CALL FUNCTION 'PTRV_CONVERT_PERNR_TO_USERID'
      EXPORTING
        personnel_number  = ls_approver-pernr
        validity_date     = sy-datum
      IMPORTING
        user_id           = ls_approver-uname
      EXCEPTIONS
        user_id_not_found = 1
        OTHERS            = 2.
    IF sy-subrc <> 0.
* Implement suitable error handling here
      lv_msg1 = ls_approver-pernr.
      CALL FUNCTION 'BALW_BAPIRETURN_GET2'
        EXPORTING
          type   = 'I'
          cl     = 'ZHR_DPO'
          number = '008'
          par1   = lv_msg1
        IMPORTING
          return = ls_return.
      APPEND ls_return TO et_message.
      RETURN.
    ENDIF.
    lv_zad_next = ls_approver-uname.

    zcl_hr_dpo_roles=>check_manager_oj(
          EXPORTING  iv_uname = ls_approver-uname
          IMPORTING  ev_orgeh = DATA(lv_orgeh) ).



    IF   is_approver-role = zcl_hr_dpo_roles=>co_zad_next.
      SELECT MAX( ordernr ) FROM zhr_dpo_rozdel
                  INTO @ls_approver-ordernr
                  WHERE role = @is_approver-role
                    AND dpo_request = @is_approver-dpo_request.
      IF sy-subrc EQ 0.
        ADD 1 TO ls_approver-ordernr.
      ENDIF.

    ENDIF.

    SELECT SINGLE role FROM zhr_dpo_rozdel INTO @DATA(lv_role)
                 WHERE
                   ( role = 'KONZUL' OR role = 'ZAD_NEXT' )
                   AND  uname = @ls_approver-uname
                   AND dpo_request = @is_approver-dpo_request.

    IF sy-subrc EQ 0.
      IF lv_role = is_approver-role.
        CALL FUNCTION 'BALW_BAPIRETURN_GET2'
          EXPORTING
            type   = 'I'
            cl     = 'ZHR_DPO'
            number = '007'
          IMPORTING
            return = ls_return.

      ELSE.
        CALL FUNCTION 'BALW_BAPIRETURN_GET2'
          EXPORTING
            type   = 'I'
            cl     = 'ZHR_DPO'
            number = '034'
          IMPORTING
            return = ls_return.
      ENDIF.

      APPEND ls_return TO et_message.
      RETURN.
* Záznam už existuje
    ELSE.
*      ls_approver-before_save = abap_true.
      INSERT  zhr_dpo_rozdel FROM ls_approver.
      CLEAR ls_approver.
    ENDIF.

    IF is_approver-role NE 'KONZUL'.
* identifikuj BP
      DO 20 TIMES.
        SELECT SINGLE * FROM zhr_dpo_bp INTO  @DATA(ls_bp)
                        WHERE orgeh EQ @lv_orgeh.
        IF sy-subrc EQ 0.
          EXIT.
        ELSE.
          CALL FUNCTION 'RH_STRUC_GET'
            EXPORTING
              act_otype       = 'O'
              act_objid       = lv_orgeh
              act_wegid       = 'O-O'
              authority_check = ' '
            TABLES
              result_struc    = lt_struc
            EXCEPTIONS
              no_plvar_found  = 1
              no_entry_found  = 2
              OTHERS          = 3.
          IF lt_struc[] IS NOT INITIAL .
            READ  TABLE lt_struc ASSIGNING FIELD-SYMBOL(<fs_struc>) WITH KEY objid = lv_orgeh.
            IF sy-subrc EQ 0.
              DATA(lv_level) = <fs_struc>-pdown.

              READ TABLE lt_struc ASSIGNING <fs_struc> WITH KEY level = lv_level.
              IF sy-subrc EQ 0.
                lv_orgeh = <fs_struc>-objid.
              ENDIF.
            ENDIF.

          ELSE.
            lv_msg1 = lv_orgeh.
            CALL FUNCTION 'BALW_BAPIRETURN_GET2'
              EXPORTING
                type   = 'E'
                cl     = 'ZHR_DPO'
                number = '006'
                par1   = lv_msg1
              IMPORTING
                return = ls_return.
            APPEND ls_return TO et_message.
            RETURN.
          ENDIF.
        ENDIF.
      ENDDO.

      ls_approver-dpo_request = is_approver-dpo_request.
      ls_approver-role        = zcl_hr_dpo_roles=>co_hrbp.
      ls_approver-zad_uname_for_hrbp = lv_zad_next.
      ls_approver-uname       = ls_bp-hrbp.
      CLEAR: lv_usrid, lv_pernr.
      lv_usrid = ls_approver-uname   .
      CALL FUNCTION 'RP_GET_PERNR_FROM_USERID'
        EXPORTING
          begda     = sy-datum
          endda     = sy-datum
          usrid     = lv_usrid
          usrty     = '0001'
        IMPORTING
          usr_pernr = lv_pernr
        EXCEPTIONS
          retcd     = 1
          OTHERS    = 2.

      ls_approver-pernr =   lv_pernr.
      SELECT COUNT( * ) FROM zhr_dpo_rozdel
                      WHERE role = ls_approver-role
                        AND uname = ls_approver-uname
                        AND dpo_request = ls_approver-dpo_request.

      IF sy-subrc EQ 0.
*        CALL FUNCTION 'BALW_BAPIRETURN_GET2'
*          EXPORTING
*            type   = 'I'
*            cl     = 'ZHR_DPO'
*            number = '007'
*          IMPORTING
*            return = ls_return.
*        APPEND ls_return TO et_message.
* Záznam už existuje
      ELSE.
*      ls_approver-before_save = abap_true.
        INSERT  zhr_dpo_rozdel FROM ls_approver.
      ENDIF.

    ENDIF.

    me->update_change_sign( iv_changed = 'X' ).

  ENDMETHOD.


  method APPL_ACTION_AFTER_LINE_APPR.
*CALL METHOD SUPER->APPL_ACTION_AFTER_LINE_APPR
**  importing
**    ev_result   =
**    et_messages =

*DATA:  lo_form            TYPE REF TO zcl_ca_uniframe,
*         lo_form_request      TYPE REF TO zcl_hr_dpo_request,
*         ls_key             TYPE zca_uf_key,
*         lv_result          TYPE sysubrc,
*         lv_attach_data     TYPE zca_uf_attach_data,
*         ls_attach_ui       TYPE zca_uf_attachments_ui.
*
*      ls_key-form_type = 'HR_DPO_REQ'.
*
*      ls_key-form_id = me->gs_data_db-form_id.
*
*      zcl_ca_uniframe=>get_instance(
*          EXPORTING
*            is_key = ls_key
*            iv_operation = zif_ca_uniframe_consts=>co_control_operation_start_apr
*            iv_process_mode = zif_ca_uniframe_consts=>co_control_proc_mode_new
*          IMPORTING
*            er_form = lo_form ).
*
*      CHECK lo_form IS BOUND.
*      lo_form_request ?= lo_form.
*
*      lo_form_request->get_header( IMPORTING es_header_ui = DATA(ls_header_ui) ).
*
*      lo_form_request->read_request(
*        exporting
*          iv_dpo_request      =  me->gs_data_db-dpo_request                " ID žádosti
*          iv_read_tmp_request = abap_true                  " Nové vstup.hodnoty
**        receiving
**          rs_dpo_request      =                  " Struktura pro Žádosti
*      )..





*    .
  endmethod.


  METHOD appl_action_after_step_appr.

*    .
    DATA: lo_form         TYPE REF TO zcl_ca_uniframe,
          lo_form_request TYPE REF TO zcl_hr_dpo_request,
          ls_key          TYPE zca_uf_key,
          lv_result       TYPE sysubrc,
          lv_attach_data  TYPE zca_uf_attach_data,
          ls_attach_ui    TYPE zca_uf_attachments_ui,
          lv_uname        TYPE sy-uname.


*-- nacteni vsech vetvi schvalovani
    SELECT line_id, line_status, form_id
      INTO  TABLE @DATA(lt_line)
      FROM zca_uf_line
      WHERE form_id = @gs_control_data-form_id.

    SELECT SINGLE dpo_request FROM zhr_dpo_hist INTO @DATA(lv_dpo_request)
                                   WHERE form_id = @gs_control_data-form_id.
    IF sy-subrc EQ 0.

      DO 5 TIMES.

        CALL FUNCTION 'ENQUEUE_EZHR_DPO_ZAD'
          EXPORTING
            dpo_request    = lv_dpo_request
          EXCEPTIONS
            foreign_lock   = 1
            system_failure = 2
            OTHERS         = 3.
        IF sy-subrc <> 0.

          WAIT UP TO 1 SECONDS .

        ELSE.
          EXIT.
        ENDIF.
      ENDDO.


      me->read_header(

      ).
      me->read_customizing( ).
      me->read_request(
        EXPORTING
          iv_dpo_request      = lv_dpo_request                  " ID žádosti
          iv_read_tmp_request = abap_true
          iv_uni_process      = abap_true
        RECEIVING
          rs_dpo_request      =  DATA(ls_request)                " Struktura pro Žádosti
      ).

    ENDIF.



    CASE gs_control_data-operation.

***************SCHVALENI***********************************
      WHEN zif_ca_uniframe_consts=>co_control_operation_approve.
        gs_data_db-line_id = gs_control_data-line_id.
        SELECT * FROM zca_uf_approver INTO TABLE @DATA(lt_approvers)
                                       WHERE step_id = @gs_control_data-step_id.
        IF sy-subrc EQ 0.
* identifikuj roli
          LOOP AT gt_rozdel ASSIGNING FIELD-SYMBOL(<fs_rozdel>) WHERE send = abap_true
                                                                  AND role NE 'KONZUL'.
            LOOP AT lt_approvers ASSIGNING FIELD-SYMBOL(<fs_approvers>) WHERE approver_pernr = <fs_rozdel>-pernr.
              gs_data_db-rozdel_apr_pernr = <fs_rozdel>-pernr.
              <fs_rozdel>-approved =  gs_data_db-approved = abap_true.
              gs_data_db-orig_user = <fs_rozdel>-uname.
              gs_data_db-role = <fs_rozdel>-role.
              CLEAR <fs_rozdel>-send.
              DATA(lv_appr_found) = abap_true.
              EXIT.
            ENDLOOP.
*            IF sy-subrc NE 0.
*              gs_data_db-rozdel_apr_pernr = <fs_rozdel>-pernr.
*              <fs_rozdel>-approved =  gs_data_db-approved = abap_true.
*              gs_data_db-orig_user = <fs_rozdel>-uname.
*              gs_data_db-role = <fs_rozdel>-role.
*              CLEAR <fs_rozdel>-send.
*              EXIT.
*            ENDIF.
*            EXIT.
            IF lv_appr_found = abap_true.
              EXIT.
            ENDIF.
          ENDLOOP.
        ENDIF.
        LOOP AT lt_line TRANSPORTING NO FIELDS
           WHERE line_id <> gs_control_data-line_id AND
            line_status = zif_ca_uniframe_consts=>co_line_status_active.
          EXIT.
        ENDLOOP.
        IF sy-subrc <> 0.
          me->button_press( iv_button = CONV #( zif_ca_uniframe_consts=>co_control_operation_approve ) iv_process = gs_data_db-process iv_uname = gs_data_db-orig_user  ).
          gs_data_db-approved = abap_true.
          CLEAR gs_data_db-clarification.
          gs_data_db-uname = sy-uname.

          me->save_req( ).
        ELSE.
          gs_data_db-dpo_step   = gs_data_db-dpo_step  + 1.
          me->save_req( ).
        ENDIF.

* v pripade dohody pri schvaleni Vedoucim SP zmen status na Dohodach v statuse ND2 na ND3
        SELECT dpo_agreement FROM zhr_dpo_doh INTO TABLE @DATA(lt_agreements)
                                              WHERE dpo_request = @lv_dpo_request
                                                AND status  = 'ND2'.
        IF sy-subrc EQ 0.

          LOOP AT lt_agreements ASSIGNING FIELD-SYMBOL(<fs_agreements>).
            IF lv_uname IS INITIAL.
              SELECT SINGLE orig_user FROM zhr_dpo_histdoh INTO lv_uname WHERE dpo_agreement = <fs_agreements>-dpo_agreement.
              IF lv_uname IS NOT INITIAL.
                DATA(lo_agr) = NEW zcl_hr_dpo_agreement( lv_uname ).
              ENDIF.
            ENDIF.
            DATA(ls_agr) =  lo_agr->get_agreement( iv_agreement = CONV #( <fs_agreements>-dpo_agreement ) ).
            lo_agr->set_next_status(
              EXPORTING
                iv_next_status   = CONV #( 'ND3' )
                iv_clarification = CONV #( '' )
                iv_origin_user = gs_data_db-orig_user ).
          ENDLOOP.
        ENDIF.


***************ZAMITNUTI***********************************
      WHEN zif_ca_uniframe_consts=>co_control_oper_reject_aut
        OR zif_ca_uniframe_consts=>co_control_oper_reject_fin
        OR zif_ca_uniframe_consts=>co_control_oper_reject_stp.



        ls_key-form_id = gs_control_data-form_id.

        zcl_ca_uniframe=>get_instance(
                 EXPORTING
                   is_key = ls_key
                   iv_operation = gs_control_data-operation
                   iv_process_mode = gs_control_data-process_mode
                 IMPORTING
                   er_form = lo_form ).

        CHECK lo_form IS BOUND.
        lo_form_request ?= lo_form.

        lo_form_request->get_header( IMPORTING es_header_ui = DATA(ls_header_ui) ).

        lo_form_request->read_request(
          EXPORTING
            iv_dpo_request      =  me->gs_data_db-dpo_request
            iv_read_tmp_request = abap_true
        ).

        SELECT * FROM zca_uf_approver INTO TABLE @lt_approvers
                                       WHERE step_id = @gs_control_data-step_id.
        IF sy-subrc EQ 0.


          LOOP AT gt_rozdel ASSIGNING <fs_rozdel> WHERE send = abap_true.
            LOOP AT lt_approvers ASSIGNING <fs_approvers> WHERE approver_pernr = <fs_rozdel>-pernr.
              gs_data_db-rozdel_apr_pernr = <fs_rozdel>-pernr.
              gs_data_db-role = <fs_rozdel>-role.
              gs_data_db-orig_user = <fs_rozdel>-uname.
              CLEAR <fs_rozdel>-send.
              EXIT.
            ENDLOOP.
          ENDLOOP.
        ENDIF.
        IF gs_data_db-role = zcl_hr_dpo_roles=>co_hrbp.
          lo_form_request->clear_rozdel_send_after_reject( ).
        ENDIF.
        gs_data_db-clarification = ls_header_ui-note_actual.
        me->button_press( iv_button =  'REJECT' iv_process = gs_data_db-process iv_uname = gs_data_db-orig_user ).
        gs_data_db-uname = sy-uname.


*-- pokud uzivatel aktualni vetev zamita, WF konci
*-- kontrola, jestli jeste nejsou rozjete nejake dalsi vetve schvalovani, ty je treba vystornovat
        IF gs_control_data-operation = zif_ca_uniframe_consts=>co_control_oper_reject_aut.
          LOOP AT lt_line ASSIGNING FIELD-SYMBOL(<fs_line>)
            WHERE line_id <> gs_control_data-line_id AND
                  line_status = zif_ca_uniframe_consts=>co_line_status_active.
            zcl_ca_uniframe=>cancel_line_only(
              EXPORTING
                iv_line_id    = <fs_line>-line_id ).
          ENDLOOP.
        ENDIF.

        me->save_req( ).
    ENDCASE.

    CALL FUNCTION 'DEQUEUE_EZHR_DPO_ZAD'
      EXPORTING
*       MODE_ZHR_DPO_ZAD       = 'E'
*       MANDT       = SY-MANDT
        dpo_request = lv_dpo_request.
*       BEFORE_SAVE            =
*       X_DPO_REQUEST          = ' '
*       X_BEFORE_SAVE          = ' '
*       _SCOPE                 = '3'
*       _SYNCHRON              = ' '
*       _COLLECT               = ' '
    .


  ENDMETHOD.


  method APPL_ACTION_CANCEL_FORM.
*CALL METHOD SUPER->APPL_ACTION_CANCEL_FORM
**  importing
**    ev_result   =
**    et_messages =
*    .

    DATA: lt_return  TYPE bapirettab,
        lv_eb_dest TYPE rfcdest,
        lv_result  TYPE sysubrc,
        lv_msg     TYPE string.

  FIELD-SYMBOLS: <fs_line_db> LIKE LINE OF gt_line_db,
                 <fs_step_db> LIKE LINE OF gt_step_db.

  ev_result = 4.

*-- zakaznicke overeni moznosti storna
*  appl_cancel_form(
*    EXPORTING
*      iv_check_only   = iv_check_only
*    IMPORTING
*      ev_result       = lv_result
*      et_messages     = et_messages ).
*  IF lv_result <> 0.
*    RETURN.
*  ENDIF.

*-- zakaznicka akce pred provedenim storna
*  IF iv_check_only <> 'X'.
*    appl_action_cancel_form(
*      IMPORTING
*        ev_result       = lv_result
*        et_messages     = et_messages ).
*    IF lv_result <> 0.
*      RETURN.
*    ENDIF.
*  ENDIF.

*-- stornovani frameworkovych dat
*  IF iv_check_only <> 'X'.

*    lv_eb_dest = zcl_ca_uniframe_utils=>get_cust_param( iv_parameter_name = 'EB_DEST' ).
*    IF lv_eb_dest = ''.
*      MESSAGE e061(zca_uniframe) WITH 'EB_DEST' INTO lv_msg.
*      add_message(
*        IMPORTING
*          et_messages = et_messages ).
*      RETURN.
*    ENDIF.

*-- status formulare je stornovany
    gs_header_db-form_status = zif_ca_uniframe_consts=>co_form_status_canceled.

*-- zpracovani vsech vetvi schvalovani
    LOOP AT gt_line_db ASSIGNING <fs_line_db>.

*-- status vetve je stornovana
      <fs_line_db>-line_status = zif_ca_uniframe_consts=>co_line_status_canceled.

*-- zastaveni aktivniho schvalovaciho kroku ve vetvi a jeho status je stornovany
      READ TABLE gt_step_db ASSIGNING <fs_step_db>
        WITH KEY line_id = <fs_line_db>-line_id
                 step_status = zif_ca_uniframe_consts=>co_step_status_active.
      IF sy-subrc = 0.

        IF <fs_step_db>-uniproces_id <> ''.

          CALL FUNCTION 'ZWF_BAPI_STOP_WF_GUID'
            DESTINATION lv_eb_dest
            EXPORTING
              iv_guid               = <fs_step_db>-uniproces_id
            IMPORTING
              et_return             = lt_return
            EXCEPTIONS
              communication_failure = 1
              system_failure        = 2.

          IF sy-subrc <> 0.
            MESSAGE e066(zca_uniframe) INTO lv_msg.
            add_message(
              IMPORTING
                et_messages = et_messages ).
            RETURN.
          ELSEIF lt_return IS NOT INITIAL.
            APPEND LINES OF lt_return TO gt_messages.
            APPEND LINES OF lt_return TO et_messages.
            RETURN.
          ENDIF.

        ENDIF.

        <fs_step_db>-step_status = zif_ca_uniframe_consts=>co_step_status_canceled.

      ENDIF.

    ENDLOOP.

    save(
      IMPORTING
        ev_result    = lv_result
        et_messages  = et_messages ).

    IF lv_result <> 0.
      RETURN.
    ENDIF.

*  ENDIF.
  endmethod.


  method appl_fill_inbox_description.
*CALL METHOD SUPER->APPL_FILL_INBOX_DESCRIPTION
*  EXPORTING
*    IV_STEP_ID           =
**  importing
**    ev_inbox_description =
**    ev_result            =
**    et_messages          =
*    .
*    DATA lv_request(10) TYPE c.
*
*    select single dpo_request from zhr_dpo_hist into @data(lv_dpo_request)
*                                  where form_id = @gs_control_data-form_id.
*    if sy-subrc eq 0.
*      data(ls_request) =   me->read_request( iv_dpo_request = lv_dpo_request iv_read_tmp_request = abap_true ).
*
*      call function 'CONVERSION_EXIT_ALPHA_OUTPUT'
*        exporting
*          input         = ls_request-dpo_request
*       IMPORTING
*          OUTPUT        = lv_request
*                .
*
*      concatenate  text-001 lv_request ls_request-name into ev_inbox_description SEPARATED BY space. .
*    endif.

  endmethod.


  method APPL_FILL_INBOX_DESCRIPTION_ON.


    DATA: lv_request(10) TYPE c.

    select single dpo_request from zhr_dpo_hist into @data(lv_dpo_request)
                                  where form_id = @gs_control_data-form_id.
    if sy-subrc eq 0.
      data(ls_request) =   me->read_request( iv_dpo_request = lv_dpo_request iv_read_tmp_request = abap_true ).

*      call function 'CONVERSION_EXIT_ALPHA_OUTPUT'
*        exporting
*          input         = ls_request-dpo_request
*       IMPORTING
*          OUTPUT        = lv_request
*                .

      concatenate  text-001 ls_request-dpo_req_full ls_request-name into ev_inbox_description_on SEPARATED BY space.
    endif.



  endmethod.


  METHOD appl_generate_approving_form.
*CALL METHOD SUPER->APPL_GENERATE_APPROVING_FORM
**  importing
**    ev_result   =
**    et_messages =
*
    DATA: lv_usrid TYPE p0105-usrid,
          lv_pernr TYPE pernr_d.


    DATA: lt_approvers  TYPE pernr_tab,
          lv_step_order TYPE zca_uf_step_order,
          lv_result     TYPE sysubrc,
          lv_msg        TYPE string.

    FIELD-SYMBOLS: <fs_line_db>     LIKE LINE OF gt_line_db,
                   <fs_step_db>     LIKE LINE OF gt_step_db,
                   <fs_approver_db> LIKE LINE OF gt_approver_db.
*                   <fs_approvers>   LIKE LINE OF lt_approvers.

    ev_result = 4.

*-- pro jistotu promazani
    CLEAR gt_line_db.
    CLEAR gt_step_db.
    CLEAR gt_approver_db.

    DATA(lt_approver) = gt_approvers[].

    lv_step_order = lv_step_order + 1.
    LOOP AT lt_approver ASSIGNING FIELD-SYMBOL(<fs_ls_approver>).
      IF <fs_ls_approver>-approver_pernr = <fs_ls_approver>-step_id.

*-- jedna vetev schvalovani


        APPEND INITIAL LINE TO gt_line_db ASSIGNING <fs_line_db>.
        <fs_line_db>-line_id = zcl_ca_uniframe_utils=>generate_id( ).
        <fs_line_db>-form_id = gs_header_db-form_id.
        <fs_line_db>-line_type = 'APPR'.
        <fs_line_db>-line_status = zif_ca_uniframe_consts=>co_line_status_saved.
        lv_usrid = gs_data_db-uname..
        CALL FUNCTION 'RP_GET_PERNR_FROM_USERID'
          EXPORTING
            begda     = sy-datum
            endda     = sy-datum
            usrid     = lv_usrid
            usrty     = '0001'
          IMPORTING
            usr_pernr = lv_pernr
          EXCEPTIONS
            retcd     = 1
            OTHERS    = 2.

        <fs_line_db>-applicant_pernr = lv_pernr. "žadatel


* Metoda na zjištění schvalovatelů


        IF gt_approvers IS NOT INITIAL.



          APPEND INITIAL LINE TO gt_step_db ASSIGNING <fs_step_db>.
          <fs_step_db>-step_id = zcl_ca_uniframe_utils=>generate_id( ).
          <fs_step_db>-line_id = <fs_line_db>-line_id.
          <fs_step_db>-step_order = lv_step_order.
          <fs_step_db>-step_type = 'APPR'.
          <fs_step_db>-step_status = zif_ca_uniframe_consts=>co_step_status_saved.

          gs_data_db-step_id =  <fs_step_db>-step_id.
          gs_data_db-line_id =  <fs_step_db>-line_id.

          LOOP AT gt_approvers ASSIGNING FIELD-SYMBOL(<fs_approvers>) WHERE step_id = <fs_ls_approver>-approver_pernr .
            APPEND INITIAL LINE TO gt_approver_db ASSIGNING <fs_approver_db>.
            <fs_approver_db>-step_id = <fs_step_db>-step_id.
            <fs_approver_db>-approver_pernr = <fs_approvers>-approver_pernr.
          ENDLOOP.
        ENDIF.
      ENDIF.
    ENDLOOP.


    ev_result = 0.
  ENDMETHOD.


  method APPL_SAVE_FORM.
*CALL METHOD SUPER->APPL_SAVE_FORM
**  exporting
**    iv_temp_save =
**  importing
**    ev_result    =
**    et_messages  =
*    .

    break DZC2Y2.




  endmethod.


  method APPL_SET_BUTTONS_VISIBILITY.
*CALL METHOD SUPER->APPL_SET_BUTTONS_VISIBILITY
**  importing
**    es_buttons_visibility =
**    ev_result             =
**    et_messages           =
*    .
CLEAR es_buttons_visibility.

  "tisk umoznen pokud nezakladame
*  es_buttons_visibility-btn_print = xsdbool( gs_control_data-process_mode <> zif_ca_uniframe_consts=>co_control_proc_mode_new ).

  "BTN_APPROVE_SEND
  "BTN_REJECT_STEP
  "BTN_REJECT_AUTHOR

  CASE gs_control_data-process_mode.
    WHEN zif_ca_uniframe_consts=>co_control_proc_mode_new
      OR zif_ca_uniframe_consts=>co_control_proc_mode_edit.
*      es_buttons_visibility-btn_check = 'X'.
      es_buttons_visibility-btn_start_approving = 'X'.
      es_buttons_visibility-btn_insert_approvers = 'X'.
      es_buttons_visibility-btn_save = 'X'.
      es_buttons_visibility-btn_check = 'X'.

      es_buttons_visibility-btn_start_approving = 'X'.
      es_buttons_visibility-btn_insert_approvers = 'X'.

    WHEN zif_ca_uniframe_consts=>co_control_proc_mode_approve.
      es_buttons_visibility-btn_approve_accept = 'X'.

*      es_buttons_visibility-btn_reject_final = 'X'.
      es_buttons_visibility-btn_reject_author = 'X'.

      es_buttons_visibility-btn_reject_text_id = 'REJECT_DP'.
      es_buttons_visibility-btn_approve_text_id = 'APPR_DPO'.

      "zamitnuti "krok zpet" je mozne v kroku schvalovani > 1
      IF gt_line_db IS INITIAL OR gt_step_db IS INITIAL.
        me->read_line( ).
        me->read_step( ).
      ENDIF.

      SORT gt_step_db BY step_order.
      READ TABLE gt_step_db WITH KEY step_id = gs_control_data-step_id TRANSPORTING NO FIELDS.
      IF sy-tabix > 1.
        es_buttons_visibility-btn_reject_step = 'X'.
      ENDIF.

      es_buttons_visibility-btn_insert_approvers = 'X'.

      es_buttons_visibility-btn_inbox = 'X'.
*      es_buttons_visibility-btn_check = 'X'.
    WHEN zif_ca_uniframe_consts=>co_control_proc_mode_view.
  ENDCASE.

  endmethod.


  METHOD assign_term.

    DATA: ls_termzad   TYPE zhr_dpo_termzad,
          lv_open_date TYPE sy-datum.

    CHECK gs_data_db-process = 'P-CENTR'.

    lv_open_date = sy-datum.
    SELECT SINGLE value FROM zhr_dpo_cparam
                        INTO @DATA(lv_term_days)
                        WHERE parameter_dpo = 'TERMIN_ZA_DNI'.
    IF sy-subrc EQ 0.
      lv_open_date = lv_open_date + lv_term_days.
    ENDIF.

    IF iv_exclude_term IS NOT INITIAL.
      SELECT SINGLE term_date FROM zhr_dpo_term
                              INTO  lv_open_date
                              WHERE term_id = iv_exclude_term.
    ENDIF.

    SELECT * FROM zhr_dpo_term INTO TABLE @DATA(lt_term)
                                WHERE status = 'TO' "otevreny
                                  AND term_date GE @lv_open_date.
    IF sy-subrc EQ 0.
      SORT lt_term BY term_date ASCENDING.
      IF iv_exclude_term IS NOT INITIAL.
        DELETE lt_term WHERE term_id = iv_exclude_term."ak už predtým termín bol assignutý, tak aktuálny vymaž z ponuky.
      ENDIF.
      READ TABLE lt_term ASSIGNING FIELD-SYMBOL(<fs_term>) INDEX 1.
      IF sy-subrc EQ 0.
        ls_termzad-term_id = <fs_term>-term_id.
        ls_termzad-dpo_request = gs_data_db-dpo_request.
        gs_data_db-term_id = <fs_term>-term_id.
        INSERT zhr_dpo_termzad FROM ls_termzad.
        IF sy-subrc EQ 0.
          me->update_term_in_history( i_term_id = <fs_term>-term_id  iv_dpo_request = gs_data_db-dpo_request ).

          rs_return-term_id = <fs_term>-term_id.
          rs_return-return_code = 'OK'.
        ENDIF.
      ELSE.
        CLEAR gs_data_db-term_id.
        CLEAR rs_return-term_id.
        rs_return-return_code = 'FAIL'.
      ENDIF.
    ELSE.
      CLEAR rs_return-term_id.
      rs_return-return_code = 'FAIL'.
    ENDIF.

  ENDMETHOD.


  METHOD attachment_to_history.

    DATA lv_temp_string TYPE string.

    me->check_not_yet_approved( ).

    IF gs_data_db-role    = 'ZAD' AND
       gs_data_db-status  = 'NAA' .

      IF gt_not_approved_att IS NOT INITIAL.
        gs_data_db-clarification = TEXT-012.
        LOOP AT gt_not_approved_att ASSIGNING FIELD-SYMBOL(<fs_file>).
          lv_temp_string = |{ gs_data_db-clarification } { <fs_file>-filename }|.
          gs_data_db-clarification = lv_temp_string.
        ENDLOOP.
      ENDIF.

      IF gv_not_approved_vers IS NOT INITIAL.
        lv_temp_string = |{ gs_data_db-clarification } { TEXT-013 } { gv_not_approved_vers }|.
        gs_data_db-clarification = lv_temp_string.
      ENDIF.

    ENDIF.

  ENDMETHOD.


  method ATTACH_PREVIEW.

    DATA : ls_archobject TYPE zsd_sdp_archobject_s,
           lx_main       TYPE REF TO zcx_sd_sdp_main,
           lr_arch       TYPE REF TO ZCL_HR_DPO_ARCHOBJECT.

    DATA: lt_message TYPE bapirettab,
          lf_result  TYPE flag.

    CLEAR: et_message.
    ef_result = abap_true.

    IF is_attchm IS NOT INITIAL.
      "IF is_attchm-vbeln IS INITIAL.
        MOVE-CORRESPONDING is_attchm TO ls_archobject.

        lr_arch = ZCL_HR_DPO_ARCHOBJECT=>get_handler( iv_sap_object = 'ZHR_DPO' ).
        TRY.
            CALL METHOD lr_arch->get_doc
              EXPORTING
                is_archobject = ls_archobject
              IMPORTING
                ev_data       = ev_stream.

          CATCH zcx_sd_sdp_archobject  INTO lx_main.
*            go_log->add_exception( ir_ex = lx_main if_save = abap_true ).
*            MESSAGE e099(zsd_sdp) WITH 'ZCL_SD_SDP_SUPCPL_PER_BL' 'ATTACH_PREVIEW'  INTO gv_dummy_string.
*            zcl_sd_sdp_helper=>append_message_from_syst( CHANGING ct_message = et_message ).
            ef_result = abap_false.
        ENDTRY.

        ev_filename = is_attchm-filename.
        TRANSLATE ev_filename TO LOWER CASE.
*

    ENDIF.


  endmethod.


  METHOD button_press.


* zkontrouj podminku

    DATA(lv_condition) = setup_condition(
                           iv_button  = iv_button
                           iv_process = iv_process
                           iv_uname   = iv_uname
                         ).

    DATA(lv_status_to_check) = gs_data_db-status.

    IF me->is_button_check_relevant(
      EXPORTING
        iv_button          = iv_button
      CHANGING
        ch_status_to_check =   lv_status_to_check

                                       ) = abap_true.

    ELSE.
      RETURN.
    ENDIF.

    TRY.
* načti stisknutí tlačítka
        gs_custom_request =  gt_custom_request[ process = iv_process
                                                 button = iv_button
                                                 status = lv_status_to_check
                                                 req_condition = lv_condition ].
      CATCH cx_sy_itab_line_not_found .
        RETURN.
    ENDTRY.

*nastav následný status

* logika pro dalšiho žadatele
    IF iv_uname IS SUPPLIED AND iv_button =  'SENT_TO_APPROVE'.
      DATA(lv_pernr) = zcl_pa_vs_utils=>get_pernr_by_uname( iv_uname = iv_uname ).
      SORT gt_rozdel BY dpo_request role pernr.
      DELETE ADJACENT DUPLICATES FROM gt_rozdel COMPARING dpo_request role pernr.
      LOOP AT gt_rozdel ASSIGNING FIELD-SYMBOL(<fs_rozdel>)
        WHERE role = zcl_hr_dpo_roles=>co_zad_next  AND pernr = lv_pernr.
        gs_data_db-approved = abap_true.
        <fs_rozdel>-approved = gs_data_db-approved.
        gs_data_db-orig_user = iv_uname.
        gs_data_db-uname = sy-uname.
        me->send_mail_to_zad_next( ).

      ENDLOOP.

    ENDIF.

    gs_data_db-orig_user = iv_uname.
    gs_data_db-role = gs_custom_request-role.
    gs_data_db-status = gs_custom_request-next_status.

    me->attachment_to_history( ). "jenom pri opetovném pridani prilohy zadavatelem

    gs_data_db-dpo_step   = gs_data_db-dpo_step  + 1.

    IF gs_custom_request-method IS NOT INITIAL.

      CALL METHOD me->(gs_custom_request-method).
      "pri zmene stavu skontroluj, ci netreba zrušit task manager tasky
      " ak boli práve odoslane (methoda obsahujuca slovo TASK), tak samozrejme nic nerušit
      IF gs_custom_request-method NS 'TASK'.
        me->task_complete( ).
      ENDIF.

    ENDIF.

    me->update_change_sign( '' ).


  ENDMETHOD.


  METHOD change_term.

    DATA: ls_termzad TYPE zhr_dpo_termzad.

    SELECT SINGLE term_id FROM zhr_dpo_zad INTO @DATA(lv_old_term)
                                          WHERE dpo_request = @iv_dpo_request.
    SELECT SINGLE term_date, term_id FROM zhr_dpo_term INTO @DATA(ls_term_date)
                            WHERE term_id = @iv_dpo_term.
    IF sy-subrc EQ 0.
      ls_termzad-dpo_request = iv_dpo_request.
      ls_termzad-term_id = iv_dpo_term.

      DELETE FROM zhr_dpo_termzad WHERE dpo_request = iv_dpo_request
                                    AND term_id     = lv_old_term.
      IF sy-subrc EQ 0.
        INSERT zhr_dpo_termzad FROM ls_termzad.
        IF sy-subrc EQ 0.
          UPDATE zhr_dpo_zad SET
                                  term_id = iv_dpo_term
                                  WHERE dpo_request = iv_dpo_request.
          IF sy-subrc EQ 0.
            rs_return-dpo_request = iv_dpo_request.
            rs_return-return_code  = me->co_ok.
          ELSE.
            rs_return-dpo_request = iv_dpo_request.
            rs_return-return_code  = me->co_fail.
          ENDIF.
        ELSE.
          rs_return-dpo_request = iv_dpo_request.
          rs_return-return_code  = me->co_fail.
        ENDIF.
        me->update_term_in_history( i_term_id      = iv_dpo_term
                                    i_old_term_id  =   lv_old_term
                                    iv_dpo_request = iv_dpo_request ).
      ELSE.
* už záznam existuje, tak nastavim aj na žadosti
        UPDATE zhr_dpo_zad SET
                                  term_id = iv_dpo_term
                                  WHERE dpo_request = iv_dpo_request.
        IF sy-subrc EQ 0.
          rs_return-dpo_request = iv_dpo_request.
          rs_return-return_code  = me->co_ok.
        ELSE.
          rs_return-dpo_request = iv_dpo_request.
          rs_return-return_code  = me->co_fail.
        ENDIF.

      ENDIF.
    ENDIF.
    COMMIT WORK.

  ENDMETHOD.


  method CHECK_FIELD.

*    IF gs_data_db-template_code IS INITIAL
*    OR


  endmethod.


  method CHECK_FIELD_STAT_AUTH.

    DATA(lv_process) = iv_process.

    IF lv_process IS INITIAL.
       lv_process = 'P-CENTR'.
    ENDIF.

    SELECT SINGLE * FROM ZHR_DPO_CPRAVAST
                    INTO rs_result
                    where process = lv_process
                      and role    = iv_role
                      and field   = iv_field.


  endmethod.


  METHOD check_not_yet_approved.

    IF me->gt_not_approved_att IS INITIAL .

      SELECT *  FROM zhr_dpo_req_att
                 WHERE not_yet_approved = @abap_true
                   AND dpo_request = @gs_data_db-dpo_request
                   INTO TABLE @me->gt_not_approved_att.
    ENDIF.

    IF  me->gv_not_approved_vers IS INITIAL.

      SELECT SINGLE version FROM zhr_dpo_a004 INTO @gv_not_approved_vers
                            WHERE dpo_request = @gs_data_db-dpo_request
                              AND not_yet_approved = @abap_true.

    ENDIF.


    IF me->gt_not_approved_att  IS NOT INITIAL
    OR me->gv_not_approved_vers IS NOT INITIAL.
      return = abap_true.
    ENDIF.

  ENDMETHOD.


  METHOD clear_approvers.

    LOOP AT me->gt_rozdel ASSIGNING FIELD-SYMBOL(<fs_rozdel>).

      IF <fs_rozdel>-role NE zcl_hr_dpo_roles=>co_consult.
        <fs_rozdel>-send = abap_false.
        <fs_rozdel>-approved = abap_false.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  method clear_rozdel_send_after_reject.

    loop at me->gt_rozdel assigning field-symbol(<fs_rozdel>)
                                     where send eq abap_true
                                      and role NE zcl_hr_dpo_roles=>co_consult.
      <fs_rozdel>-send = abap_false.
    endloop.
     loop at me->gt_rozdel assigning <fs_rozdel>
                                     where task_manag_sent eq abap_true.
      <fs_rozdel>-task_manag_sent = abap_false.
    endloop.
    loop at me->gt_rozdel assigning <fs_rozdel>
                                     where role eq zcl_hr_dpo_roles=>CO_ZAD_NEXT.
      <fs_rozdel>-approved = abap_false.
    endloop.
  endmethod.


  method CONVERT_REQUEST.

  CONSTANTS: lv_lom TYPE c VALUE '/'.
  DATA       lv_sign(2) TYPE c.

    CASE chs_request-direction.
      WHEN 'I'.
         SPLIT chs_request-dpo_req_full AT lv_lom INTO chs_request-dpo_request chs_request-dpo_year lv_sign.
         CASE lv_sign.
           WHEN 'C'.
              chs_request-dpo_type = ZCL_HR_DPO_CONST=>dpo_process.
           WHEN 'D'.
              chs_request-dpo_type = ZCL_HR_DPO_CONST=>dpo_dohoda.
          ENDCASE.

      WHEN 'O'.
         CASE chs_request-dpo_type.
           WHEN ZCL_HR_DPO_CONST=>dpo_process.
              lv_sign = 'C'.
           WHEN ZCL_HR_DPO_CONST=>dpo_dohoda.
              lv_sign = 'D'.
         ENDCASE.
         chs_request-dpo_req_full = |{  chs_request-dpo_request ALPHA = OUT }| &&   lv_lom && chs_request-dpo_year && lv_lom && lv_sign .
         CONDENSE chs_request-dpo_req_full NO-GAPS.
    ENDCASE.



  endmethod.


  METHOD convert_string_to_text_table.

    DATA: lt_string TYPE string_table.
    DATA: lt_c255   TYPE etxml_line_tabtype.
    DATA: lv_tdformat_newline TYPE tdformat.
*    data lt_c132 type STANDARD TABLE OF tdline.

    FIELD-SYMBOLS <fs_text> TYPE tline.

    SPLIT iv_string AT cl_abap_char_utilities=>newline INTO TABLE lt_string.

    LOOP AT lt_string ASSIGNING FIELD-SYMBOL(<fs_string>).
      lv_tdformat_newline = '/'.
      AT FIRST.
        lv_tdformat_newline = '*'.
      ENDAT.
      AT LAST.
        lv_tdformat_newline = '*'.
      ENDAT.
      CLEAR lt_c255[].
      CALL FUNCTION 'ECATT_STRING_TO_TABLE'
        EXPORTING
          i_string        = <fs_string>
          i_target_length = '132'
*         i_target_length = '255'
        IMPORTING
          et_text         = lt_c255[].


      LOOP AT lt_c255 ASSIGNING FIELD-SYMBOL(<fs_c255>).
        APPEND INITIAL LINE TO rt_text_table ASSIGNING <fs_text>.
        <fs_text>-tdformat = ' '.
        AT FIRST.
          <fs_text>-tdformat = lv_tdformat_newline.
        ENDAT.
        <fs_text>-tdline   = <fs_c255>.

      ENDLOOP.
      IF sy-subrc NE 0.
        APPEND INITIAL LINE TO rt_text_table ASSIGNING <fs_text>.
        <fs_text>-tdformat = lv_tdformat_newline.
      ENDIF.

    ENDLOOP.

  ENDMETHOD.


  METHOD copy_request.
    DATA: ls_approver TYPE zhr_dpo_rozdel_s,
          lt_message  TYPE  bapiret2_t.
    DATA lv_dpo_request TYPE zhr_dpo_request.
    DATA lr_data    TYPE REF TO zhr_dpo_zad_struct.
    DATA ls_request_id TYPE zhr_dpo_request_s.
    DATA:ls_rozdel TYPE zhr_dpo_rozdel,
         lt_rozdel TYPE STANDARD TABLE OF zhr_dpo_rozdel.
    DATA(ls_request_source) = me->read_request( iv_dpo_request ).
    DATA(lo_request) = NEW zcl_hr_dpo_request( ).


    lo_request->init_form_data( iv_uname = iv_origin_user ).
    ls_request_id  = CORRESPONDING #( lo_request->get_request( ) ).
    CREATE DATA lr_data.
    ASSIGN lr_data->* TO FIELD-SYMBOL(<fs_data>).
    MOVE-CORRESPONDING ls_request_source TO <fs_data>.

    DATA(ls_request_new) = lo_request->read_request( iv_dpo_request =  ls_request_id-dpo_request ).
    <fs_data>-process = ls_request_new-process.
    <fs_data>-status  = ls_request_new-status.
    <fs_data>-dpo_req_full = ls_request_new-dpo_req_full.
    <fs_data>-next_status = ls_request_new-next_status.
    <fs_data>-dpo_step = ls_request_new-dpo_step.
    <fs_data>-request_date = ls_request_new-request_date.
    <fs_data>-dpo_year = ls_request_new-request_date.
    <fs_data>-dpo_request = ls_request_new-dpo_request.
    <fs_data>-role = ls_request_new-role.
    <fs_data>-creator = ls_request_new-creator.
    <fs_data>-term_id = ls_request_new-term_id.
    <fs_data>-term_date = ls_request_new-term_date.
    <fs_data>-orgeh = ls_request_new-orgeh.
    <fs_data>-orgeh_orig = ls_request_new-orgeh_orig.

    lo_request->set_request_data(
      EXPORTING
        ir_protocol_data = lr_data ).

    lo_request->save_req( ).
    DATA(lt_next_approvers) =   me->show_approval_fork(
      EXPORTING
        iv_dpo_request         =  ls_request_source-dpo_request
         iv_only_next_approvers = abap_true
    ).
    IF lt_next_approvers[] IS NOT INITIAL.
      LOOP AT lt_next_approvers ASSIGNING FIELD-SYMBOL(<fs_approvers>).
        IF <fs_approvers>-uname = iv_origin_user.
          CONTINUE.
        ENDIF.
        ls_approver-dpo_request = ls_request_new-dpo_request.
        ls_approver-pernr = <fs_approvers>-pernr.
        ls_approver-role = <fs_approvers>-role_key.
        lo_request->add_next_approver(
     EXPORTING
       is_approver = ls_approver

     IMPORTING
        et_message  = lt_message
).
*        <fs_approvers>-dpo_request = ls_request_new-dpo_request.
*        CLEAR: <fs_approvers>-approved, <fs_approvers>-form_id, <fs_approvers>-send, <fs_approvers>-task_manag_sent,
*               ls_rozdel.
*        MOVE-CORRESPONDING <fs_approvers> TO ls_rozdel.
*        ls_rozdel-role = <fs_approvers>-role_key.
*        APPEND ls_rozdel TO lt_rozdel.
      ENDLOOP.
* pridaj zakladatela povodnej zadosti do zadatel_next
      IF ls_request_source-creator NE iv_origin_user.
        ls_approver-dpo_request = ls_request_new-dpo_request.
        ls_approver-pernr = zcl_pa_vs_utils=>get_pernr_by_uname( iv_uname = ls_request_source-creator ).
        ls_approver-role = zcl_hr_dpo_roles=>co_zad_next.
        lo_request->add_next_approver(
     EXPORTING
       is_approver = ls_approver

     IMPORTING
        et_message  = lt_message
).
      ENDIF.
      IF lt_rozdel[] IS NOT INITIAL.
        INSERT zhr_dpo_rozdel FROM TABLE lt_rozdel.
        IF sy-subrc NE 0.
          ROLLBACK WORK.
        ELSE.
          COMMIT WORK.
        ENDIF.
      ENDIF.
    ENDIF.
    rv_dpo_request = ls_request_new-dpo_request.
  ENDMETHOD.


  METHOD create_approval_fork.

    DATA lv_orgeh TYPE orgeh.
    DATA ls_return TYPE bapiret2.
    DATA ls_dpo_rozdel TYPE zhr_dpo_rozdel.
    DATA lv_msg1 TYPE sy-msgv1.
    DATA lt_struc TYPE STANDARD TABLE OF struc.
    DATA lv_usrid TYPE  p0105-usrid.
    DATA lv_pernr TYPE pernr_d.
    DATA lt_message TYPE bapiret2_t.


    IF zcl_hr_dpo_roles=>check_manager_oj(
          EXPORTING  iv_uname = iv_uname
          IMPORTING  ev_orgeh = lv_orgeh ) = abap_true.

      IF lv_orgeh IS INITIAL.
        lv_msg1 = iv_uname.
        CALL FUNCTION 'BALW_BAPIRETURN_GET2'
          EXPORTING
            type   = 'E'
            cl     = 'ZHR_DPO'
            number = '005'
            par1   = lv_msg1
          IMPORTING
            return = ls_return.
        APPEND ls_return TO et_message.
      ENDIF.
      ls_dpo_rozdel-dpo_request = iv_dpo_request.
      ls_dpo_rozdel-role        = zcl_hr_dpo_roles=>co_requestor.
      ls_dpo_rozdel-uname       = iv_uname.
      lv_usrid = ls_dpo_rozdel-uname.
      CALL FUNCTION 'RP_GET_PERNR_FROM_USERID'
        EXPORTING
          begda     = sy-datum
          endda     = sy-datum
          usrid     = lv_usrid
          usrty     = '0001'
        IMPORTING
          usr_pernr = lv_pernr
        EXCEPTIONS
          retcd     = 1
          OTHERS    = 2.

      ls_dpo_rozdel-pernr =   lv_pernr.
      APPEND ls_dpo_rozdel TO me->gt_rozdel.

* identifikuj BP
      DO 20 TIMES.
        SELECT SINGLE * FROM zhr_dpo_bp INTO  @DATA(ls_bp)
                        WHERE orgeh EQ @lv_orgeh.
        IF sy-subrc EQ 0.
          EXIT.
        ELSE.
          CALL FUNCTION 'RH_STRUC_GET'
            EXPORTING
              act_otype       = 'O'
              act_objid       = lv_orgeh
              act_wegid       = 'O-O'
              authority_check = ' '
            TABLES
              result_struc    = lt_struc
            EXCEPTIONS
              no_plvar_found  = 1
              no_entry_found  = 2
              OTHERS          = 3.
          IF lt_struc[] IS NOT INITIAL .
            READ  TABLE lt_struc ASSIGNING FIELD-SYMBOL(<fs_struc>) WITH KEY objid = lv_orgeh.
            IF sy-subrc EQ 0.
              DATA(lv_level) = <fs_struc>-pdown.

              READ TABLE lt_struc ASSIGNING <fs_struc> WITH KEY level = lv_level.
              IF sy-subrc EQ 0.
                lv_orgeh = <fs_struc>-objid.
              ENDIF.
            ENDIF.

          ELSE.
            lv_msg1 = lv_orgeh.
            CALL FUNCTION 'BALW_BAPIRETURN_GET2'
              EXPORTING
                type   = 'E'
                cl     = 'ZHR_DPO'
                number = '006'
                par1   = lv_msg1
              IMPORTING
                return = ls_return.
            APPEND ls_return TO et_message.
            RETURN.
          ENDIF.
        ENDIF.
      ENDDO.

      ls_dpo_rozdel-dpo_request = iv_dpo_request.
      ls_dpo_rozdel-role        = zcl_hr_dpo_roles=>co_hrbp.
      ls_dpo_rozdel-uname       = ls_bp-hrbp.
      CLEAR: lv_usrid, lv_pernr.
      lv_usrid = ls_dpo_rozdel-uname   .
      CALL FUNCTION 'RP_GET_PERNR_FROM_USERID'
        EXPORTING
          begda     = sy-datum
          endda     = sy-datum
          usrid     = lv_usrid
          usrty     = '0001'
        IMPORTING
          usr_pernr = lv_pernr
        EXCEPTIONS
          retcd     = 1
          OTHERS    = 2.

      ls_dpo_rozdel-pernr =   lv_pernr.
      APPEND ls_dpo_rozdel TO me->gt_rozdel.

    ENDIF.
    IF   zcl_hr_dpo_roles=>check_sp( iv_uname = iv_uname ) = abap_true OR zcl_hr_dpo_roles=>check_manager_oj(
           EXPORTING  iv_uname = iv_uname
           IMPORTING  ev_orgeh = lv_orgeh ) = abap_true
        OR zcl_hr_dpo_roles=>check_hrbp( iv_uname = iv_uname ) = abap_true .

      IF   zcl_hr_dpo_roles=>check_sp( iv_uname = iv_uname ) = abap_true
      OR   zcl_hr_dpo_roles=>check_hrbp( iv_uname = iv_uname ) = abap_true .
        ls_dpo_rozdel-dpo_request = iv_dpo_request.
        ls_dpo_rozdel-role        = zcl_hr_dpo_roles=>co_requestor.
        ls_dpo_rozdel-uname       = iv_uname.
        lv_usrid = ls_dpo_rozdel-uname.
        CALL FUNCTION 'RP_GET_PERNR_FROM_USERID'
          EXPORTING
            begda     = sy-datum
            endda     = sy-datum
            usrid     = lv_usrid
            usrty     = '0001'
          IMPORTING
            usr_pernr = lv_pernr
          EXCEPTIONS
            retcd     = 1
            OTHERS    = 2.

        ls_dpo_rozdel-pernr =   lv_pernr.
        APPEND ls_dpo_rozdel TO me->gt_rozdel.

      ENDIF.
*  pridej vedouciho SP
      REFRESH lt_message.
      ls_dpo_rozdel-dpo_request = iv_dpo_request.
      ls_dpo_rozdel-role        = zcl_hr_dpo_roles=>co_ved_sp.
      DATA(ls_sp)               = zcl_hr_dpo_roles=>get_manager_sp( IMPORTING et_message = lt_message ).
      IF ls_sp IS NOT INITIAL.
        ls_dpo_rozdel-uname =   ls_sp-uname.
        ls_dpo_rozdel-pernr =   ls_sp-pernr.
        APPEND ls_dpo_rozdel TO me->gt_rozdel.
      ENDIF.
      LOOP AT lt_message[] INTO ls_return.
        APPEND ls_return TO et_message.
      ENDLOOP.
      REFRESH lt_message.

* pridej SP.
      DATA(lt_sp) =  zcl_hr_dpo_roles=>get_sp( IMPORTING et_message = lt_message ).
      LOOP AT lt_message[] INTO ls_return.
        APPEND ls_return TO et_message.
      ENDLOOP.
      LOOP AT lt_sp ASSIGNING FIELD-SYMBOL(<fs_sp>).
        ls_dpo_rozdel-dpo_request = iv_dpo_request.
        ls_dpo_rozdel-role        = zcl_hr_dpo_roles=>co_sp.
        ls_dpo_rozdel-uname       = <fs_sp>-uname.
        ls_dpo_rozdel-pernr       = <fs_sp>-pernr.
        APPEND ls_dpo_rozdel TO me->gt_rozdel.
      ENDLOOP.

* pridej odboraře.
      REFRESH lt_message.
      DATA(lt_unions) =  zcl_hr_dpo_roles=>get_unions( IMPORTING et_message = lt_message ).
      LOOP AT lt_message[] INTO ls_return.
        APPEND ls_return TO et_message.
      ENDLOOP.
      LOOP AT lt_unions ASSIGNING FIELD-SYMBOL(<fs_unions>).
        ls_dpo_rozdel-dpo_request = iv_dpo_request.
        ls_dpo_rozdel-role        = zcl_hr_dpo_roles=>co_union.
        ls_dpo_rozdel-uname       = <fs_unions>-uname.
        ls_dpo_rozdel-pernr       = <fs_unions>-pernr.
        APPEND ls_dpo_rozdel TO me->gt_rozdel.
      ENDLOOP.

    ENDIF.

  ENDMETHOD.


  method DELETE_ATTACHMENT.

    DATA: ls_attach TYPE ZHR_DPO_REQ_ATT,
          ls_return TYPE bapiret2.

    DELETE FROM ZHR_DPO_REQ_ATT WHERE dpo_request = is_attch-dpo_request
                                  AND guid        = is_attch-guid.
    IF sy-subrc EQ 0.
      rs_return-dpo_request = is_attch-dpo_request.
      rs_return-return_code = 'OK'.
      call function 'BALW_BAPIRETURN_GET2'
            exporting
              type   = 'S'
              cl     = 'ZHR_DPO'
              number = '009'
*              par1   = lv_par1
*              par2   = lv_par2
            importing
              return = ls_return.
          .
          append ls_return to et_message.
    ELSE.
       rs_return-dpo_request = is_attch-dpo_request.
      rs_return-return_code = 'FAIL'.
    ENDIF.


    me->update_change_sign( iv_changed = 'X' ).



  endmethod.


  METHOD delete_next_approver.

    DATA ls_return TYPE bapiret2.

    DELETE FROM zhr_dpo_rozdel WHERE dpo_request = iv_dpo_request
                                 AND role = iv_role
                                 AND uname = iv_uname.
    IF sy-subrc EQ 0.

      DELETE FROM zhr_dpo_rozdel WHERE dpo_request = iv_dpo_request
                                AND role = zcl_hr_dpo_roles=>co_hrbp
                                AND zad_uname_for_hrbp = iv_uname.

      CALL FUNCTION 'BALW_BAPIRETURN_GET2'
        EXPORTING
          type   = 'S'
          cl     = 'ZHR_DPO'
          number = '013'
*         par1   = lv_par1
        IMPORTING
          return = ls_return.

      APPEND ls_return TO et_message.
      COMMIT WORK.
      rs_return = 'OK'.

    ENDIF.



  ENDMETHOD.


  METHOD delete_request.

    DATA: ls_return TYPE bapiret2,
          lv_par    TYPE sy-msgv1.

    IF iv_dpo_request IS SUPPLIED.
      DATA(lv_dpo_request) = iv_dpo_request.
    ELSE.
      lv_dpo_request = gs_data_db-dpo_request.
    ENDIF.

    rs_return-dpo_request = lv_dpo_request.
    UPDATE zhr_dpo_zad SET status = iv_delete_status
                       WHERE dpo_request = lv_dpo_request.
    IF sy-subrc EQ 0.
      gs_data_db-dpo_request = lv_dpo_request.
      me->read_request(
        EXPORTING
          iv_dpo_request      =  lv_dpo_request                " ID žádosti

      ).
      DATA(ls_active_zad) = me->reload_active_zad( iv_dpo_request = lv_dpo_request ).
      gs_data_db-dpo_step   = gs_data_db-dpo_step  + 1.
      gs_data_db-uname      = ls_active_zad-real_user.
      gs_data_db-orig_user  = ls_active_zad-active_user.
      me->save_req( ).

      me->task_complete( ).
      SELECT dpo_request, form_id FROM zhr_dpo_hist INTO TABLE @DATA(lt_form_id)
                            WHERE dpo_request = @lv_dpo_request.
      IF sy-subrc EQ 0.
        LOOP AT lt_form_id ASSIGNING FIELD-SYMBOL(<fs_form_id>).
          SELECT line_id, line_status, form_id
                 INTO  TABLE @DATA(lt_line)
                 FROM zca_uf_line
                 WHERE form_id = @<fs_form_id>-form_id.
          IF sy-subrc EQ 0.
            LOOP AT lt_line ASSIGNING FIELD-SYMBOL(<fs_line>)
               WHERE line_status = zif_ca_uniframe_consts=>co_line_status_active.
              zcl_ca_uniframe=>cancel_line_only(
                EXPORTING
                  iv_line_id    = <fs_line>-line_id ).
            ENDLOOP.
            REFRESH lt_line.
          ENDIF.
        ENDLOOP.
      ENDIF.
      me->unassign_term( ).

      rs_return = 'OK'.
      lv_par    = lv_dpo_request.
      DATA(lv_number) = SWITCH sy-msgno( iv_delete_status WHEN 'STO' THEN '036'
                                                          ELSE '016' ).


      CALL FUNCTION 'BALW_BAPIRETURN_GET2'
        EXPORTING
          type   = 'S'
          cl     = 'ZHR_DPO'
          number = lv_number
          par1   = lv_par
        IMPORTING
          return = ls_return.
      .
      APPEND ls_return TO et_message.
    ELSE.
      rs_return = 'FAIL'.
    ENDIF.
    COMMIT WORK.


  ENDMETHOD.


  method DISPLAY_PDF.


    DATA: lv_dpo_request TYPE zhr_dpo_request,
          lv_obj_type    TYPE saeanwdid,
          lv_obj_id      TYPE saeobjid,
          lv_formname    TYPE FPNAME,
          lx_main        TYPE REF TO zcx_sd_sdp_main,
          lv_pdf_stream  TYPE xstring,

          fv_go_next     TYPE flag VALUE abap_true,

          lc_object_type TYPE saeanwdid.

    ef_result = abap_true.
    CLEAR et_message.

    CASE iv_form_type.
      WHEN 'INT'.
        lv_formname = 'ZHR_DPO_FORM_INTER'.
      WHEN 'EXT'.
         lv_formname = 'ZHR_DPO_FORM_REQUEST'.
    ENDCASE.



* - Call print
      TRY.
        call function 'Z_DPO_PREVIEW_PDF'
          exporting
            iv_form               = lv_formname
            iv_dpo_request        = iv_dpo_request
         IMPORTING
            EV_PDF_STREAM         = ev_pdf_stream
*           ES_FORMOUTPUT         =
                  .



        CATCH zcx_sd_sdp_main INTO lx_main.
          ef_result = abap_false.
          et_message = lx_main->get_bapirettab( ).
          RETURN.

      ENDTRY.




    ef_result = zcl_sd_sdp_helper=>bapirettab_nc_error( it_message = et_message ).

  endmethod.


  method DUMMY.

  endmethod.


  METHOD fill_approvers.

    DATA: ls_approvers TYPE zca_uf_approver.
    DATA  lv_usrid TYPE p0105-usrid.
    DATA  lv_pernr TYPE pernr_d.
    DATA  lt_filter_rozdel TYPE STANDARD TABLE OF zhr_dpo_rozdel.
    DATA  r_activity TYPE RANGE OF zhr_dpo_zastup-activity.
    DATA  ls_rozdel TYPE zhr_dpo_rozdel.
    DATA lt_message TYPE bapiret2_t.


    r_activity = VALUE #( sign = 'I' option = 'EQ' ( low = 'F' ) ( low = 'A' ) ). "vyber jen zástupce s opravnenim schvalovat



    LOOP AT me->gt_rozdel ASSIGNING FIELD-SYMBOL(<fs_rozdel>)
                                      WHERE role CS iv_role
                                        AND send EQ abap_false.
      IF iv_role = zcl_hr_dpo_roles=>co_ved_sp. "derivuj vedoucího SP k dnešnímu datu. V tabulce Rozdel muže být neaktuální záznam.
        DATA(ls_sp)               = zcl_hr_dpo_roles=>get_manager_sp( IMPORTING et_message = lt_message ).
        IF ls_sp-pernr IS NOT INITIAL.
          ls_approvers-approver_pernr = <fs_rozdel>-pernr =    ls_sp-pernr.
          <fs_rozdel>-uname = ls_sp-uname.
        ELSE.
          ls_approvers-approver_pernr = <fs_rozdel>-pernr.
        ENDIF.

      ELSE.
       ls_approvers-approver_pernr = <fs_rozdel>-pernr.
      ENDIF.



      ls_approvers-step_id = <fs_rozdel>-pernr.
      <fs_rozdel>-send = abap_true.
      APPEND ls_approvers TO rt_approvers.
      APPEND <fs_rozdel> TO lt_filter_rozdel.
*      EXIT.
    ENDLOOP.
    IF sy-subrc NE 0.
      IF iv_role = zcl_hr_dpo_roles=>co_ved_sp. "derivuj vedoucího SP k dnešnímu datu. V tabulce Rozdel muže být neaktuální záznam.
        ls_sp               = zcl_hr_dpo_roles=>get_manager_sp( IMPORTING et_message = lt_message ).
        IF ls_sp-pernr IS NOT INITIAL.
          ls_approvers-approver_pernr  = ls_rozdel-pernr =   ls_sp-pernr.
            ls_rozdel-send = abap_true.
            ls_approvers-step_id = ls_rozdel-pernr.
            ls_rozdel-uname = ls_sp-uname.
            ls_rozdel-role = 'VED_SP'.
            ls_rozdel-dpo_request = me->gt_rozdel[ 1 ]-dpo_request.
            APPEND ls_rozdel TO me->gt_rozdel.
            APPEND ls_approvers TO rt_approvers.


        ENDIF.
      ENDIF.
    ENDIF.



    CHECK lt_filter_rozdel[] IS NOT INITIAL.
    SELECT * FROM zhr_dpo_zastup INTO TABLE @DATA(lt_zastup)
             FOR ALL ENTRIES IN @lt_filter_rozdel
             WHERE creator EQ @lt_filter_rozdel-uname
               AND   activity IN @r_activity.



    LOOP AT lt_zastup ASSIGNING FIELD-SYMBOL(<fs_zastup>).
      lv_usrid = <fs_zastup>-deputy.
      CALL FUNCTION 'RP_GET_PERNR_FROM_USERID'
        EXPORTING
          begda     = sy-datum
          endda     = sy-datum
          usrid     = lv_usrid
          usrty     = '0001'
        IMPORTING
          usr_pernr = lv_pernr
        EXCEPTIONS
          retcd     = 1
          OTHERS    = 2.

      ls_approvers-approver_pernr = lv_pernr.
      READ TABLE me->gt_rozdel ASSIGNING <fs_rozdel> WITH KEY uname = <fs_zastup>-creator.
      IF sy-subrc EQ 0.
        ls_approvers-step_id = <fs_rozdel>-pernr.
        APPEND ls_approvers TO rt_approvers.
      ENDIF.
    ENDLOOP.

    SORT rt_approvers BY step_id approver_pernr.
    DELETE ADJACENT DUPLICATES FROM rt_approvers COMPARING step_id approver_pernr.

  ENDMETHOD.


  METHOD get_authorization_structure.
    DATA: lv_par1          TYPE sy-msgv1,
          lv_par2          TYPE sy-msgv2,
          lv_uname         TYPE sy-uname,
          lv_undefined(10) TYPE c VALUE 'undefined'.

    DATA ls_return TYPE bapiret2.
    DATA rs_compare TYPE RANGE OF zhr_dpo_cpravast-status_num_rq.

    lv_uname = iv_uname.
    IF lv_uname EQ co_undefined.
      CLEAR lv_uname.
    ELSE.
      lv_uname = iv_uname.
    ENDIF.

    IF iv_dpo_request IS INITIAL "jsme v preheldu nemame konkretni cislo zadosti
    OR iv_dpo_request EQ '0000000000'.

      DATA(lv_role) = zcl_hr_dpo_roles=>identify_my_role(  iv_name = lv_uname  ).

      IF lv_role IS INITIAL.
        rs_authority_struct-role = 'DUMMY'.
        rs_authority_struct-uname = iv_uname.
        CALL FUNCTION 'BALW_BAPIRETURN_GET2'
          EXPORTING
            type   = 'E'
            cl     = 'ZHR_DPO'
            number = '002'
          IMPORTING
            return = ls_return.
        .
        APPEND ls_return TO et_message.
        RETURN.
* role nebola odvodena
      ENDIF.

    ELSE." zname cislo zadosti, nacteme roli z rozdelovníka
      SELECT SINGLE a~dpo_request, a~dpo_type, a~status, b~status_num, a~changes  FROM zhr_dpo_zad AS a
                                  INNER JOIN zhr_dpo_cstat AS b

                                  ON a~status =  b~status
                                  INTO @DATA(ls_zad)
                                  WHERE dpo_request = @iv_dpo_request
                                    AND b~object = 'R'. "zadost, temporary?.

      DATA(lv_uname_adm) = zcl_pe_all_change_user=>get_uname( iv_appl_id = 'ZHR_DPO_REQUEST' ).
      IF iv_uname NE sy-uname AND iv_uname NE lv_uname_adm.
        SELECT SINGLE activity FROM zhr_dpo_zastup INTO @DATA(lv_activity)
                               WHERE creator = @iv_uname
                                 AND deputy  = @sy-uname.

        IF sy-subrc <> 0.

          IF lv_uname_adm <> sy-uname.
            SELECT SINGLE activity FROM zhr_dpo_zastup INTO @lv_activity
                               WHERE creator = @iv_uname
                                 AND deputy  = @lv_uname_adm.
          ENDIF.

        ENDIF.
        IF sy-subrc NE 0.
          RAISE EXCEPTION TYPE cx_no_authorization.
        ENDIF.

*                                  AND activity = 'C'.

      ENDIF.

      SELECT * FROM zhr_dpo_rozdel
                         INTO TABLE @DATA(lt_role)
                         WHERE dpo_request = @iv_dpo_request
                           AND uname = @lv_uname.
      IF lt_role[] IS NOT INITIAL.
        IF lines( lt_role ) = 1.
          lv_role = lt_role[ 1 ]-role.
        ELSE.
          IF line_exists( lt_role[ role = zcl_hr_dpo_roles=>co_ved_sp ]   ).
            lv_role = lt_role[ role = zcl_hr_dpo_roles=>co_ved_sp ]-role.
          ELSEIF line_exists( lt_role[ role = zcl_hr_dpo_roles=>co_sp ]   ).
            lv_role = lt_role[ role = zcl_hr_dpo_roles=>co_sp ]-role.
            IF ls_zad-status EQ 'ROJ'.
              IF line_exists( lt_role[ role = zcl_hr_dpo_roles=>co_requestor ]   ).
                lv_role = lt_role[ role = zcl_hr_dpo_roles=>co_requestor ]-role.
              ENDIF.
            ENDIF.
          ELSEIF  line_exists( lt_role[ role = zcl_hr_dpo_roles=>co_union ]   ).
            lv_role = lt_role[ role = zcl_hr_dpo_roles=>co_union ]-role.
          ELSEIF line_exists( lt_role[ role = zcl_hr_dpo_roles=>co_hrbp ]   ).
            lv_role = lt_role[ role = zcl_hr_dpo_roles=>co_hrbp ]-role.
            IF ls_zad-status EQ 'ROJ'.
              IF line_exists( lt_role[ role = zcl_hr_dpo_roles=>co_requestor ]   ).
                lv_role = lt_role[ role = zcl_hr_dpo_roles=>co_requestor ]-role.
              ENDIF.
            ENDIF.
            IF ls_zad-status EQ 'RAOJ'.
              IF line_exists( lt_role[ role = zcl_hr_dpo_roles=>co_zad_next ]   ).
                lv_role = lt_role[ role = zcl_hr_dpo_roles=>co_zad_next ]-role.
              ENDIF.
            ENDIF.
            IF NEW zcl_hr_dpo_request( )->status_exists_in_history( iv_dpo_request  =  iv_dpo_request
                                                                  iv_status       = 'ZHP' )
            OR ls_zad-status EQ 'NAA'.
              IF line_exists( lt_role[ role = zcl_hr_dpo_roles=>co_requestor ]   ).
                lv_role = lt_role[ role = zcl_hr_dpo_roles=>co_requestor ]-role.
              ENDIF.
            ENDIF.
          ELSEIF line_exists( lt_role[ role = zcl_hr_dpo_roles=>co_requestor ]   ).
            lv_role = lt_role[ role = zcl_hr_dpo_roles=>co_requestor ]-role.
          ENDIF.
        ENDIF.
      ENDIF.
      IF lt_role IS INITIAL.
* role se nena3la v rozdelovníku, tak zkusime identifikovat
        lv_role  = zcl_hr_dpo_roles=>identify_my_role( iv_dpo_request = iv_dpo_request iv_name = lv_uname  ).
        IF lv_role IS INITIAL.
          lv_par1 = lv_uname.
          lv_par2 = iv_dpo_request.
          CALL FUNCTION 'BALW_BAPIRETURN_GET2'
            EXPORTING
              type   = 'E'
              cl     = 'ZHR_DPO'
              number = '004'
              par1   = lv_par1
              par2   = lv_par2
            IMPORTING
              return = ls_return.
          .
          APPEND ls_return TO et_message.
          rs_authority_struct-role = 'DUMMY'.
          rs_authority_struct-uname = lv_uname.
          RETURN.
        ENDIF.


      ENDIF.


    ENDIF.

    IF  zcl_hr_dpo_roles=>check_admin( iv_uname = iv_uname ) = abap_true.
      lv_role = zcl_hr_dpo_roles=>co_admin.
    ENDIF.


    SELECT SINGLE * FROM zhr_dpo_cprava
       INTO @DATA(ls_prava)
            WHERE role = @lv_role
              AND process = @iv_dpo_process.

    IF sy-subrc EQ 0.
      IF sy-subrc EQ 0.
        SELECT SINGLE description FROM zhr_dpo_crolet
                         INTO @DATA(lv_desc)
                         WHERE role  =  @ls_prava-role
                           AND spras = @sy-langu.
      ENDIF.
      IF lv_activity IS NOT INITIAL.
        CASE lv_activity.
          WHEN 'C'.
            CLEAR: ls_prava-request_send.
*                   ls_prava-request_edit.
          WHEN 'A'.
            CLEAR ls_prava-request_create.
        ENDCASE.
      ENDIF.



*      IF lv_role = zcl_hr_dpo_roles=>CO_ZAD_NEXT.
*        IF line_exists( lt_role[ role = zcl_hr_dpo_roles=>CO_ZAD_NEXT task_manag_sent = '' ]   ).
*           CLEAR ls_prava-request_edit.
*        ENDIF.
*      ENDIF.

      rs_authority_struct = CORRESPONDING #( ls_prava ).
      rs_authority_struct-role_descr = lv_desc.

      IF iv_dpo_request IS NOT INITIAL
      AND iv_dpo_request NE  '0000000000'.
        SELECT SINGLE status FROM zhr_dpo_zad
                             INTO @DATA(lv_status)
                             WHERE dpo_request = @iv_dpo_request.
*        SELECT SINGLE a~status b~status_num FROM zhr_dpo_zad as a
*                             INNER JOIN zhr_dpo_cstat as b
*                             ON a~status = b~status
**                             AND a~object = b~object
*                             INTO @DATA(lv_status)
*                             WHERE dpo_request = @iv_dpo_request.
        IF sy-subrc EQ 0.

*          CASE lv_status.
*            WHEN 'ROJ'.
*              IF lv_uname NE sy-uname.
*                rs_authority_struct-request_send = abap_true.
*
*              ELSE.
*
*              ENDIF.
*          ENDCASE.
*          IF lv_status = 'ROJ'
*          OR lv_status = 'RDO'
*          OR ( lv_status = 'RAOJ' AND lv_role = zcl_hr_dpo_roles=>CO_ZAD_NEXT ) .
*
*            IF lv_uname NE sy-uname.
*
**              data(lv_uname) = zcl_pe_all_change_user=>get_uname( iv_appl_id = 'ZHR_DPO_REQUEST' ).
*
*              IF lv_uname NE sy-uname AND lv_role NE zcl_hr_dpo_roles=>co_consult." je to admin
*                rs_authority_struct-request_send = abap_true.
*              ELSE.
*
*                DATA(lv_name_by_admin) = zcl_pe_all_change_user=>get_uname( iv_appl_id = 'ZHR_DPO_REQUEST' ).
*                SELECT COUNT( * ) FROM zhr_dpo_zastup
*                                WHERE creator = lv_uname
*                                  AND deputy  = lv_name_by_admin
*                                  AND activity = 'C'.
*                IF sy-subrc EQ 0.
** zástupce s právem jenom zákládat
*                  rs_authority_struct-send_oj_only = abap_true.
*
*                ELSE.
*                  IF  lv_role NE zcl_hr_dpo_roles=>co_consult
*                  AND lv_role EQ zcl_hr_dpo_roles=>CO_ZAD_NEXT AND lv_status = 'ROJ'.
*                    rs_authority_struct-request_send = abap_true.
*                  ENDIF.
*                ENDIF.
*              ENDIF.
*
*            ELSE.
*              IF lv_status = 'ROJ' AND lv_role = zcl_hr_dpo_roles=>CO_ZAD_NEXT.
*              ELSE.
*                rs_authority_struct-request_send = abap_true.
*              ENDIF.
*            ENDIF.
*          ENDIF.

          IF  lv_status = 'RAOJ' AND lv_role = zcl_hr_dpo_roles=>co_zad_next.
            SELECT COUNT( * ) FROM zhr_dpo_rozdel
                              WHERE dpo_request = @iv_dpo_request
                               AND  role = @zcl_hr_dpo_roles=>co_zad_next
                               AND  uname = @lv_uname
                               AND  task_manag_sent = 'X'
                               AND  approved = ''.
            IF sy-subrc NE 0.
              CLEAR rs_authority_struct-request_send.
              CLEAR rs_authority_struct-request_edit.
            ENDIF.

          ENDIF.

        ENDIF.
      ELSE.
*        if lv_uname ne sy-uname.
*            CLEAR rs_authority_struct-request_deputy.
*        ENDIf.
      ENDIF.

* convert to true / false.
      FIELD-SYMBOLS: <lv_field>      TYPE any,
                     <lv_field_from> TYPE any.
      DATA: lr_descr_struc TYPE REF TO data.
      DATA: lo_structdescr TYPE REF TO cl_abap_structdescr.
      DATA lv_comp_name(50) TYPE c.

      CLEAR: lr_descr_struc, lo_structdescr.
      CREATE DATA lr_descr_struc LIKE rs_authority_struct. " <- any type
      lo_structdescr ?= cl_abap_structdescr=>describe_by_data_ref( p_data_ref = lr_descr_struc ).
      LOOP AT lo_structdescr->components ASSIGNING FIELD-SYMBOL(<lv_component>)
                                                   WHERE name CS '_O'.
        ASSIGN COMPONENT <lv_component>-name OF STRUCTURE rs_authority_struct TO <lv_field>.


        DATA(lv_len) = strlen( <lv_component>-name ).
        lv_len = lv_len - 2.
        lv_comp_name =  <lv_component>-name(lv_len).
        READ TABLE lo_structdescr->components ASSIGNING FIELD-SYMBOL(<lv_component_from>)

                                                     WITH KEY name = lv_comp_name.
        IF sy-subrc EQ 0.

          ASSIGN COMPONENT lv_comp_name OF STRUCTURE rs_authority_struct TO <lv_field_from>.

          IF <lv_field_from> = 'S' AND ls_zad IS  NOT INITIAL. "specialna logika pre authorizaciu podla statusu
            DATA(ls_auth_field_stat) =   me->check_field_stat_auth(
               EXPORTING
                 iv_process = ls_zad-dpo_type
                 iv_role    = lv_role
                 iv_field   = CONV #( lv_comp_name )

             ).




            rs_compare = VALUE #( sign = 'I' option = ls_auth_field_stat-option_f ( low = ls_auth_field_stat-status_num_rq  ) ).


            DATA lv_status_num TYPE zhr_dpo_status_num_req.
            lv_status_num = ls_zad-status_num.

            IF lv_comp_name = 'ADD_ATTACHMENT'.
              IF   NEW zcl_hr_dpo_request( )->status_exists_in_history( iv_dpo_request  =  iv_dpo_request
                                                                   iv_status       = 'ZHP' )
                AND ls_zad-status NE 'NAA'
                AND ls_zad-status NE 'PRO' AND ls_zad-status NE 'PRN' AND ls_zad-status NE 'PPE' .

                lv_status_num = '16'.

              ENDIF.
            ENDIF.

            IF lv_status_num IN rs_compare."splňuje podmínku statusu. Nastav nový
              <lv_field_from> = ls_auth_field_stat-new_field_value.

            ELSE." ináč nesplnuje a zmaz hodnotu
              CLEAR <lv_field_from>.
              IF <lv_component>-name = 'REQUEST_SEND_O' AND <lv_field_from> IS INITIAL "if you cannot send to approve, you cannot even edit.
              AND rs_authority_struct-request_edit IS NOT INITIAL
              AND lv_role = zcl_hr_dpo_roles=>co_zad_next.
                rs_authority_struct-request_edit = abap_false.
                rs_authority_struct-request_edit_o = 'false'.
              ENDIF.
            ENDIF.

          ENDIF.


          IF <lv_field_from> IS INITIAL.
            <lv_field> = 'false'.
          ELSE.
            <lv_field> = 'true'.
          ENDIF.
        ENDIF.

      ENDLOOP.

      IF rs_authority_struct-request_edit_o = 'false' AND rs_authority_struct-add_attachment_o = 'true'.
        rs_authority_struct-request_edit_o = 'true'.
*        IF ls_zad-changes = abap_true.
        rs_authority_struct-request_send_o = 'true'.
*        ENDIF.
      ENDIF.


* Chybí customizace pro roli &1 v tabulce ZHR_DPO_CPRAVA

* chýbajúci customizing pre prava.

    ELSE.

      lv_par1 = lv_role.
      CALL FUNCTION 'BALW_BAPIRETURN_GET2'
        EXPORTING
          type   = 'E'
          cl     = 'ZHR_DPO'
          number = '003'
          par1   = lv_par1
        IMPORTING
          return = ls_return.
      .
      APPEND ls_return TO et_message.

    ENDIF.

* ulož aktualni roli
    IF iv_dpo_request IS NOT INITIAL.
      me->gs_active_zad-dpo_request = iv_dpo_request.
      me->gs_active_zad-active_user = lv_uname.
      me->gs_active_zad-real_user   = zcl_pe_all_change_user=>get_uname( iv_appl_id = 'ZHR_DPO_REQUEST' ).
      me->gs_active_zad-role        = lv_role.
      me->gs_active_zad-aedat       = sy-datum.

      MODIFY zhr_dpo_zad_act FROM  me->gs_active_zad.
    ENDIF.

  ENDMETHOD.


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


  method GET_FULL_NAME.

       data(lv_pernr) = zcl_pa_vs_utils=>get_pernr_by_uname( iv_uname = gs_data_db-uname ).
        if lv_pernr is not initial.
          data(ls_user_data) = zcl_hr_dpo_roles=>get_pernr_details( iv_pernr = lv_pernr  ).
          rv_name_full = ls_user_data-full_name.
          CLEAR: lv_pernr, ls_user_data.
          lv_pernr = zcl_pa_vs_utils=>get_pernr_by_uname( iv_uname = gs_data_db-orig_user ).
          ls_user_data = zcl_hr_dpo_roles=>get_pernr_details( iv_pernr = lv_pernr  ).
          IF ( rv_name_full NE ls_user_data-full_name ) AND ls_user_data-full_name IS NOT INITIAL.
             rv_name_full = |vz. { rv_name_full } ( { ls_user_data-full_name } )|.
          ENDIF.

        endif.


  endmethod.


  METHOD get_history.

    DATA: lt_history_tab TYPE  zhr_dpo_hist_t.
    DATA: ls_address TYPE  bapiaddr3 .
    DATA lt_return TYPE STANDARD TABLE OF bapiret2.

    IF iv_dpo_request IS SUPPLIED.
      DATA(lv_dpo_request) = iv_dpo_request.
    ELSE.
      lv_dpo_request = gs_data_db-dpo_request.
    ENDIF.


    SELECT * FROM zhr_dpo_hist INTO CORRESPONDING FIELDS OF TABLE lt_history_tab
                               WHERE dpo_request = lv_dpo_request.

    IF sy-subrc EQ 0.

      SELECT role, description FROM zhr_dpo_crolet INTO TABLE @DATA(lt_role_desc)
                              FOR ALL ENTRIES IN @lt_history_tab
                              WHERE role EQ @lt_history_tab-role
                              AND spras EQ @sy-langu.


      SELECT * FROM zhr_dpo_cstatt INTO TABLE @DATA(lt_status)
                            WHERE object = @zcl_hr_dpo_request=>cv_request
                              AND spras  = @sy-langu.



      LOOP AT lt_history_tab ASSIGNING FIELD-SYMBOL(<fs_hist_tab>).

        READ TABLE lt_role_desc ASSIGNING FIELD-SYMBOL(<fs_role_desc>)
                                WITH KEY role = <fs_hist_tab>-role.
        IF sy-subrc EQ 0.
          <fs_hist_tab>-role_desc = <fs_role_desc>-description.
        ENDIF.

        READ TABLE lt_status ASSIGNING FIELD-SYMBOL(<fs_status>)
                              WITH KEY status = <fs_hist_tab>-next_status.
        IF sy-subrc EQ 0.
          <fs_hist_tab>-next_status_desc = <fs_status>-description.
        ENDIF.

        DATA(lv_pernr) = zcl_pa_vs_utils=>get_pernr_by_uname( iv_uname = <fs_hist_tab>-uname ).
        IF lv_pernr IS NOT INITIAL.
          DATA(ls_user_data) = zcl_hr_dpo_roles=>get_pernr_details( iv_pernr = lv_pernr  ).
          <fs_hist_tab>-name_full = ls_user_data-full_name.

          CLEAR: lv_pernr, ls_user_data.
          lv_pernr = zcl_pa_vs_utils=>get_pernr_by_uname( iv_uname = <fs_hist_tab>-orig_user ).
          ls_user_data = zcl_hr_dpo_roles=>get_pernr_details( iv_pernr = lv_pernr  ).
          IF no_behalfs = abap_true.
            <fs_hist_tab>-name_full = ls_user_data-full_name.
          ELSE.
            IF ( <fs_hist_tab>-name_full NE ls_user_data-full_name ) AND ls_user_data-full_name IS NOT INITIAL..
              <fs_hist_tab>-name_full = |vz. { <fs_hist_tab>-name_full } ( { ls_user_data-full_name } )|.
            ENDIF.
          ENDIF.
        ELSE.
          DATA ls_usr03 TYPE usr03.
          CLEAR ls_usr03.
          CALL FUNCTION 'SUSR_SHOW_USER_DETAILS'
            EXPORTING
              bname      = <fs_hist_tab>-uname
*             MANDT      = SY-MANDT
              no_display = 'X'
*           IMPORTING
*             OKCODE     =
*             ADDR_USR   =
            CHANGING
              user_usr03 = ls_usr03.
          <fs_hist_tab>-name_full = ls_usr03-name2.
        ENDIF.

      ENDLOOP.
    ENDIF.

    SORT lt_history_tab BY dpo_request dpo_step uname.

    rt_history_tab[] = lt_history_tab[].


  ENDMETHOD.


  METHOD get_instance_request.

    DATA lv_dpo_request TYPE zhr_dpo_request.

    lv_dpo_request = |{ iv_dpo_request ALPHA = IN }|.

    return =  NEW zcl_hr_dpo_request( ).

    return->reload_active_zad(
       EXPORTING
         iv_dpo_request =  lv_dpo_request

    ).

*    SELECT SINGLE * FROM zhr_dpo_zad_act INTO return->gs_active_zad
*                    WHERE dpo_request = lv_dpo_request.



  ENDMETHOD.


  method GET_LONG_TEXT.

    DATA ls_thead TYPE thead.

    SELECT SINGLE template_code, oj_text, url FROM ZHR_DPO_CSABL
                                         INTO @DATA(ls_long_text)
                                         WHERE template_code EQ @iv_template_code.

    IF sy-subrc EQ 0.
      SELECT SINGLE template_text FROM ZHR_DPO_CSABLT into rs_long_text-subject
                                   WHERE template_code = ls_long_text-template_code
                                     AND spras EQ sy-langu.
    ls_thead-tdid = 'ST'.
    ls_thead-tdname = ls_long_text-oj_text.
    ls_thead-tdspras = sy-langu.
    ls_thead-tdobject = 'TEXT'.
    rs_long_text-long_text = read_text( exporting  is_head    = ls_thead ).
*                                        importing  ev_subject = rs_long_text-subject ).
    rs_long_text-template_code = ls_long_text-template_code.
    rs_long_text-url = ls_long_text-url.

    ENDIF.



  endmethod.


  method get_long_texts_all.

    data ls_thead type thead.
    data lv_success type xfeld.

    read table gt_custom_template into gs_custom_template
                                  with key template_code = gs_data_db-template_code.


      ls_thead-tdid = 'ZOJ'.
      ls_thead-tdobject = 'ZHR_DPO'.
      ls_thead-tdspras = sy-langu.
      ls_thead-tdname = iv_dpo_request.
      clear lv_success.
      gs_data_db-text = read_text( exporting is_head = ls_thead
                                   ).


      ls_thead-tdid = 'ZSP'.
      ls_thead-tdobject = 'ZHR_DPO'.
      ls_thead-tdspras = sy-langu.
      ls_thead-tdname = iv_dpo_request.
      clear lv_success.
      gs_data_db-text_sp = read_text( exporting is_head = ls_thead
                                   importing ev_success = lv_success ).
      if lv_success is initial.
        ls_thead-tdid = 'ST'.
        ls_thead-tdname = gs_custom_template-sp_text.
        ls_thead-tdspras = sy-langu.
        ls_thead-tdobject = 'TEXT'.
        gs_data_db-text_sp = read_text( is_head = ls_thead ).
      endif.

      select single werks_param name from zhr_dpo_zad
                               into ( rs_long_text_all-werks_param, rs_long_text_all-name )
                               where dpo_request = iv_dpo_request.
      if rs_long_text_all-werks_param is initial.
        rs_long_text_all-werks_param = 'ZAD_ZAVODSP_MB'.
      endif.

      ls_thead-tdid = 'ZUN'.
      ls_thead-tdobject = 'ZHR_DPO'.
      ls_thead-tdspras = sy-langu.
      ls_thead-tdname = iv_dpo_request.
      clear lv_success.
      gs_data_db-text_union = read_text( exporting is_head = ls_thead
                                         importing ev_success = lv_success )..
      if lv_success is initial.
        select single value from zhr_dpo_cparam
                           into  ls_thead-tdname
                          where parameter_dpo eq rs_long_text_all-werks_param.



        ls_thead-tdid = 'ST'.

        ls_thead-tdspras = sy-langu.
        ls_thead-tdobject = 'TEXT'.
        gs_data_db-text_union = read_text( is_head = ls_thead ).
      endif.

      " podpisy
      DATA(lv_sign_sp) = read_text( is_head = VALUE #(
                                    tdid = 'ST'
                                    tdobject = 'TEXT'
                                    tdspras = 'C'
                                    tdname = 'ZHR_ZDPO_SIGN_SP' )  ).

      REPLACE ALL OCCURRENCES OF '&SIGN_SP&' IN  gs_data_db-text_sp WITH lv_sign_sp.

      rs_long_text_all-dpo_request = iv_dpo_request.
      rs_long_text_all-long_text_oj = gs_data_db-text.
      rs_long_text_all-long_text_sp = gs_data_db-text_sp.
      rs_long_text_all-long_text_union = gs_data_db-text_union.
      rs_long_text_all-pdf_internal_lnk = gs_data_db-pdf_internal_lnk.
      rs_long_text_all-dpo_request_full = gs_data_db-dpo_req_full.


  endmethod.


  METHOD get_mail_union.


    DATA: ls_thead      TYPE thead,
          lt_lnk_params TYPE zpe_all_tt_lnk_params,
          ls_lnk_params TYPE zpe_all_lnk_params.

    SELECT SINGLE template_code, dpo_req_full, name FROM zhr_dpo_zad INTO @DATA(ls_zad)
                                             WHERE dpo_request = @iv_dpo_request.
    IF sy-subrc EQ 0.

      SELECT SINGLE * FROM zhr_dpo_csabl INTO @DATA(ls_sabl)
                                         WHERE template_code = @ls_zad-template_code.


      ls_thead-tdid = 'ST'.
      ls_thead-tdname = SWITCH #( iv_button WHEN 'DohNavrh'  THEN ls_sabl-doh_proposal
                                            WHEN 'DohFinal1' THEN ls_sabl-doh_final1
                                            WHEN 'DohFinal2' THEN ls_sabl-doh_final2
                                            ELSE '' ).
      ls_thead-tdspras = sy-langu.
      ls_thead-tdobject = 'TEXT'.
      DATA(lv_template_text) = read_text( EXPORTING  is_head    = ls_thead iv_mail = abap_true ).


      e_subjectbody-subject_text = SWITCH #( iv_button WHEN 'DohNavrh'  THEN TEXT-t15
                                            WHEN 'DohFinal1' THEN TEXT-t16
                                            WHEN 'DohFinal2' THEN TEXT-t16
                                            ELSE '' ).
      e_subjectbody-subject_text = e_subjectbody-subject_text && '/' && ls_zad-name && '/'  && ls_zad-dpo_req_full.
      ls_lnk_params-value = iv_dpo_request.
      APPEND ls_lnk_params TO lt_lnk_params.
*      DATA(lv_link) = zcl_hr_dpo_lnk_generator=>generate_application_link( iv_id_application = 'ZHR_DPO_REQUEST'
*                                                            it_parameters = lt_lnk_params ).

      e_subjectbody-body_text = lv_template_text.
    ENDIF.

  ENDMETHOD.


  METHOD get_next_status_tab.

    DATA: lv_my_role TYPE zhr_dpo_role.
    DATA: lt_custom_request TYPE STANDARD TABLE OF zhr_dpo_czad.
    DATA: ls_next_status TYPE zhr_dpo_next_status.

    read_customizing( ).

    SELECT SINGLE dpo_type, status FROM zhr_dpo_zad
                                   INTO @DATA(ls_act_status)
                                   WHERE dpo_request = @iv_dpo_request.
    CHECK sy-subrc EQ 0.



    lv_my_role = gs_data_db-role.

    IF iv_ignore_actual_status IS INITIAL.
      LOOP AT gt_custom_request INTO gs_custom_request
                              WHERE process = ls_act_status-dpo_type
                                AND    status  = ls_act_status-status
                                AND    role    = zcl_hr_dpo_roles=>co_sp.
        APPEND gs_custom_request TO lt_custom_request.
      ENDLOOP.
    ELSE.
      LOOP AT gt_custom_request INTO gs_custom_request
                            WHERE process = ls_act_status-dpo_type
                              AND    role    = zcl_hr_dpo_roles=>co_sp.
        APPEND gs_custom_request TO lt_custom_request.
      ENDLOOP.
    ENDIF.


    CHECK sy-subrc EQ 0.

    IF ls_act_status-status = 'NAA'."special addition to status description for NAA status approval step.
      gs_custom_request = lt_custom_request[ status = 'NAA' next_status = 'ZHP' ].
      SELECT SINGLE button_desc FROM zhr_dpo_czadt INTO @DATA(ls_descrip)
                               WHERE process = @gs_custom_request-process AND
                                     status  = @gs_custom_request-status  AND
                                     role    = @gs_custom_request-role    AND
                                     button  = @gs_custom_request-button  AND
                                     spras   = @sy-langu.
    ENDIF.

    IF iv_ignore_appl_stat = abap_true.
      DELETE lt_custom_request WHERE application IS NOT INITIAL.
    ENDIF.
    LOOP AT lt_custom_request ASSIGNING FIELD-SYMBOL(<fs_custom_request>).
      ls_next_status-dpo_request = iv_dpo_request.
      ls_next_status-next_status = <fs_custom_request>-next_status.
      ls_next_status-method = <fs_custom_request>-method.
      ls_next_status-role = <fs_custom_request>-role.

      READ TABLE gt_status_desc ASSIGNING FIELD-SYMBOL(<fs_desc>)
                                          WITH KEY object = 'R'
                                                   status = ls_next_status-next_status.
      IF sy-subrc EQ 0.
        ls_next_status-status_num = <fs_desc>-status_num.
        ls_next_status-next_status_desc = <fs_desc>-description.
        IF ls_act_status-status = 'NAA'.

          ls_next_status-next_status_desc = |{ ls_next_status-next_status_desc } - { ls_descrip }|.
          gs_data_db-clarification = ls_descrip.
        ENDIF.
      ENDIF.

      APPEND ls_next_status TO rt_next_status_tab.
    ENDLOOP.



    SORT rt_next_status_tab BY status_num.
    gt_next_status_tab[] = rt_next_status_tab[].

  ENDMETHOD.


  method GET_NEXT_STEPS.

*    DATA: ls_status TYPE zhr_dpo_next_status.
*
*    SELECT * FROM ZHR_DPO_HIST INTO TABLE @DATA(lt_hist)
*
*
*
*    SELECT status FROM zhr_dpo_czad INTO TABLE @DATA(lt_zad)
*                  WHERE status = @iv_status
*                  AND role = @iv_role.
*    IF sy-subrc EQ 0.
*      SELECT * FROM zhr_dpo_cstatt INTO TABLE @DATA(lt_stat)
*               FOR ALL ENTRIES IN @lt_zad
*               WHERE status = @lt_zad-status
*                AND spras EQ @sy-langu.
*      IF sy-subrc EQ 0.
*        LOOP AT lt_zad ASSIGNING FIELD-SYMBOL(<fs_zad>).
*          ls_status-next_status = <fs_zad>.
*          READ TABLE lt_stat ASSIGNING FIELD-SYMBOL(<fs_stat>)
*                             WITH KEY status = <fs_zad>-status.
*          IF sy-subrc EQ 0.
*            ls_status-next_status_desc = <fs_stat>-description.
*          ENDIF.
*          ls_status-dpo_request = iv_dpo_request.
*        ENDLOOP.
*      ENDIF.
*    ENDIF.


  endmethod.


  METHOD get_other_roles.

    DATA ls_role TYPE zhr_dpo_other_roles_s.

    SELECT * FROM zhr_dpo_crolet
              INTO TABLE @DATA(lt_role)
              WHERE role EQ @zcl_hr_dpo_roles=>co_consult
                OR  role EQ @zcl_hr_dpo_roles=>co_zad_next.

    IF sy-subrc EQ 0.
      LOOP AT lt_role ASSIGNING FIELD-SYMBOL(<fs_role>).
        ls_role-role = <fs_role>-role.
        ls_role-role_descr = <fs_role>-description.
        APPEND ls_role TO rt_roles.
      ENDLOOP.
    ENDIF.


  ENDMETHOD.


  method GET_REQUEST.

    rs_dpo_request = gs_data_db.
  endmethod.


  METHOD get_request_list.

    DATA ls_request TYPE zhr_dpo_zad_struct.
    DATA ls_thead TYPE thead.

    DATA lv_pernr TYPE pernr_d.
    DATA lv_uname TYPE sy-uname.
    DATA lv_full TYPE zhr_dpo_request_full.
    DATA r_date TYPE RANGE OF sy-datum.
    DATA r_term_date TYPE RANGE OF sy-datum.
    DATA lv_datum TYPE sy-datum.
    DATA rs_date LIKE LINE OF r_date.
    DATA rs_compare_rq TYPE RANGE OF zhr_dpo_cpravast-status_num_rq.
    DATA rs_compare_ag TYPE RANGE OF zhr_dpo_cpravast-status_num_ag.
    DATA rs_nodisp_stat TYPE RANGE OF zhr_dpo_status_req.
    DATA: lt_return TYPE STANDARD TABLE OF bapiret2.
    DATA: ls_address TYPE bapiaddr3.
    DATA: r_status LIKE LINE OF status_range.
    DATA lt_rng_unit_id TYPE RANGE OF hrobjid.
    DATA(lt_theme) = get_domain_values( iv_name = 'ZHR_DPO_THEME' ).

    rs_nodisp_stat = VALUE #( sign = 'I' option = 'EQ' ( low = 'PON' ) ( low = 'VYM' )  ).

    READ TABLE creator_range ASSIGNING FIELD-SYMBOL(<fs_creator>) INDEX 1.
    IF sy-subrc EQ 0.
      lv_uname = <fs_creator>-low.
      REPLACE ALL OCCURRENCES OF '*'  IN lv_uname WITH ''.
      CONDENSE lv_uname NO-GAPS.
    ENDIF.

    IF iv_process IS NOT INITIAL.
      DATA(ls_auth_struc) = me->get_authorization_structure(
       EXPORTING
         iv_uname            = lv_uname
         iv_dpo_process          = iv_process

     ).


    ENDIF.

    DATA(lv_role) = zcl_hr_dpo_roles=>identify_my_role(  iv_name = lv_uname  ).

    IF request_date_range[] IS NOT INITIAL.
      rs_date-sign = 'I'.
      rs_date-option = 'BT'.
      LOOP AT request_date_range ASSIGNING FIELD-SYMBOL(<fs_date>).
        IF rs_date-low IS INITIAL.
          lv_datum = <fs_date>-low.
          ADD 1 TO lv_datum.
          rs_date-low  = lv_datum..
        ELSE.
          rs_date-high  = <fs_date>-low.
        ENDIF.
      ENDLOOP.
      APPEND rs_date TO r_date.
    ENDIF.

    IF term_date[] IS NOT INITIAL.
      IF   iv_process = zcl_hr_dpo_const=>dpo_dohoda.
        RETURN.
      ENDIF.
      rs_date-sign = 'I'.
      rs_date-option = 'BT'.
      LOOP AT term_date ASSIGNING <fs_date>.
        IF rs_date-low IS INITIAL.
          lv_datum = <fs_date>-low.
          ADD 1 TO lv_datum.
          rs_date-low  = lv_datum..
        ELSE.
          rs_date-high  = <fs_date>-low.
        ENDIF.
      ENDLOOP.
      APPEND rs_date TO r_term_date.
    ENDIF.



    IF lv_uname IS INITIAL.
      lv_uname = sy-uname.
    ENDIF.

    IF ls_auth_struc-request_disp = 'S'.



      DATA(ls_auth_field_stat) =   me->check_field_stat_auth(
          EXPORTING
            iv_process = zcl_hr_dpo_const=>dpo_process
            iv_role    =  lv_role
            iv_field   = 'REQUEST_DISP'

        ).
      ls_auth_struc-request_disp =  ls_auth_field_stat-new_field_value.
      DATA(lv_rq_max) = ls_auth_field_stat-status_type.

      rs_compare_rq = VALUE #( sign = 'I' option = ls_auth_field_stat-option_f ( low = ls_auth_field_stat-status_num_rq  ) ).

      ls_auth_field_stat =   me->check_field_stat_auth(
          EXPORTING
            iv_process = zcl_hr_dpo_const=>dpo_dohoda
            iv_role    =  lv_role
            iv_field   = 'REQUEST_DISP'

        ).
      rs_compare_ag = VALUE #( sign = 'I' option = ls_auth_field_stat-option_f ( low = ls_auth_field_stat-status_num_rq  ) ).
      DATA(lv_ag_max) = ls_auth_field_stat-status_type.
      DATA(lv_s_case) = abap_true.

    ENDIF.


    CASE ls_auth_struc-request_disp.

      WHEN 'X'. "pro tuto roli zobraz všechny aktivní žádosti

        IF name_range[] IS INITIAL.

          SELECT a~dpo_request, a~dpo_year, a~dpo_type, a~template_code, a~request_date, a~dpo_req_full,
                 a~status, a~name, a~send_date, a~term_id, a~requestor, a~orgeh,
                 b~uname, b~datum, b~time, b~form_id, b~role, b~next_status, b~dpo_step,
                  c~process, c~theme, a~approval_type, d~term_date, a~tasks_unfinished
                   FROM zhr_dpo_zad AS a
                   INNER JOIN zhr_dpo_hist AS b
                   ON  a~dpo_request EQ b~dpo_request
                   INNER JOIN zhr_dpo_csabl AS c
                   ON a~template_code EQ c~template_code
                   LEFT JOIN zhr_dpo_term AS d
                   ON a~term_id EQ d~term_id
                   INTO TABLE @DATA(lt_request_list)
                   WHERE a~dpo_request IN @request_range
                     AND a~dpo_year    IN @request_year_range
                     AND a~dpo_type    IN @request_type_range
                     AND b~datum       IN @r_date
                     AND a~status      IN @status_range
                     AND c~process     IN @process_range
                     AND a~deletion_flag EQ @abap_false
                     AND d~term_date   IN @r_term_date
                     AND a~tasks_unfinished IN @task_unfinished.

        ELSE.

          READ TABLE name_range ASSIGNING FIELD-SYMBOL(<fs_name>) INDEX 1.

          SELECT a~dpo_request, a~dpo_year, a~dpo_type, a~template_code, a~request_date, a~dpo_req_full,
           a~status, a~name, a~send_date, a~term_id, a~requestor, a~orgeh,
           b~uname, b~datum, b~time, b~form_id, b~role, b~next_status, b~dpo_step,
            c~process, c~theme, a~approval_type, d~term_date, a~tasks_unfinished
             FROM zhr_dpo_zad AS a
             INNER JOIN zhr_dpo_hist AS b
             ON  a~dpo_request EQ b~dpo_request
             INNER JOIN zhr_dpo_csabl AS c
             ON a~template_code EQ c~template_code
              LEFT JOIN zhr_dpo_term AS d
                   ON a~term_id EQ d~term_id
             INTO TABLE @lt_request_list
             WHERE a~dpo_request IN @request_range
               AND a~dpo_year    IN @request_year_range
               AND a~dpo_type    IN @request_type_range
               AND b~datum       IN @r_date
               AND a~status      IN @status_range
               AND c~process     IN @process_range
               AND a~name_caps   LIKE @<fs_name>-low
*               and a~orgeh       in @orgeh
               AND a~deletion_flag EQ @abap_false
                AND d~term_date   IN @r_term_date
               AND a~tasks_unfinished IN @task_unfinished.
*                 and b~uname       in @creator_range.
        ENDIF.

        IF lv_role NE 'ADMIN'.
          DELETE lt_request_list WHERE status IN rs_nodisp_stat."smaž uzavřené a zmazané.
        ENDIF.
      WHEN 'Z'. "pro tuto roli zobraz jenom žádosti, které má v rozdělovníku.

        DATA r_role TYPE RANGE OF zhr_dpo_rozdel-role.


        r_role = VALUE rsdsselopt_t(

              ( sign   = if_fsbp_const_range=>sign_include
                option = if_fsbp_const_range=>option_equal
                low    = 'KONZUL' )  ).


        case lv_role.
          WHEN 'ZAD'.

        ENDCASE.

        IF lv_role = zcl_hr_dpo_const=>cs_role-hrbp.
          DATA(lt_unit_id) = zcl_hr_dpo_roles=>get_units_for_hrbp( iv_username = lv_uname ).
          DATA(lt_user_period) = zcl_hr_dpo_roles=>get_hrbp_users( iv_username = lv_uname ).
          CLEAR lt_user_period. " bude reseno pomoci jednotek   HRBP
          LOOP AT lt_unit_id REFERENCE INTO dATA(lr_v_unit_id).
            APPEND VALUE #( sign = 'I' option = 'EQ' low = lr_v_unit_id->* ) TO lt_rng_unit_id.
          ENDLOOP.
        ENDIF.

        IF lines( lt_user_period ) = 0.
          lt_user_period = VALUE #( ( username = lv_uname date_from = 20200101 date_to = 99991231 ) ).
        ENDIF.

        IF lines( lt_user_period ) > 0.

          SELECT dpo_request, uname FROM zhr_dpo_rozdel INTO TABLE @DATA(lt_rozdel)
            FOR ALL ENTRIES IN @lt_user_period
                                       WHERE uname EQ @lt_user_period-username
                                         .
        ELSE.


          SELECT dpo_request, uname FROM zhr_dpo_rozdel INTO TABLE @lt_rozdel
                                       WHERE uname EQ @lv_uname.
*                                         AND role  IN @r_role .
        ENDIF.

        IF lines( lt_rng_unit_id ) > 0 .
          " vybereme zadosti, ktere jsou v oblasti
*          SELECT dpo_request, uname FROM zhr_dpo_rozdel INTO TABLE @lt_rozdel
*                                       WHERE uname EQ @lv_uname.
          SELECT dpo_request  APPENDING CORRESPONDING FIELDS OF TABLE @lt_rozdel
              FROM zhr_dpo_zad
              WHERE orgeh_orig IN @lt_rng_unit_id.
        ENDIF.

        IF lines( lt_rozdel ) > 0 .


          IF name_range[] IS INITIAL.

            SELECT a~dpo_request, a~dpo_year, a~dpo_type, a~template_code, a~request_date, a~dpo_req_full,
                 a~status, a~name, a~send_date, a~term_id, a~requestor, a~orgeh,
                 b~uname, b~datum, b~time, b~form_id, b~role, b~next_status, b~dpo_step,
                  c~process, c~theme, a~approval_type, d~term_date, a~tasks_unfinished
                   FROM zhr_dpo_zad AS a
                   INNER JOIN zhr_dpo_hist AS b
                   ON  a~dpo_request EQ b~dpo_request
                   INNER JOIN zhr_dpo_csabl AS c
                   ON a~template_code EQ c~template_code
                   LEFT JOIN zhr_dpo_term AS d
                   ON a~term_id EQ d~term_id
                  INTO TABLE @lt_request_list
                  FOR ALL ENTRIES IN @lt_rozdel
                   WHERE a~dpo_request EQ @lt_rozdel-dpo_request
                     AND a~dpo_request IN @request_range
                     AND a~dpo_year    IN @request_year_range
                     AND a~dpo_type    IN @request_type_range
                     AND b~datum       IN @r_date
                     AND a~status      IN @status_range
                     AND c~process     IN @process_range
                     AND d~term_date   IN @r_term_date
*                     and a~orgeh       in @orgeh
*                 and a~name        in @name_range
                     AND a~deletion_flag EQ @abap_false
                     AND a~tasks_unfinished IN @task_unfinished.
          ELSE.

            READ TABLE name_range ASSIGNING <fs_name> INDEX 1.

            SELECT a~dpo_request, a~dpo_year, a~dpo_type, a~template_code, a~request_date, a~dpo_req_full,
                a~status, a~name, a~send_date, a~term_id, a~requestor, a~orgeh,
                b~uname, b~datum, b~time, b~form_id, b~role, b~next_status, b~dpo_step,
                 c~process, c~theme, a~approval_type, d~term_date, a~tasks_unfinished
                  FROM zhr_dpo_zad AS a
                  INNER JOIN zhr_dpo_hist AS b
                  ON  a~dpo_request EQ b~dpo_request
                  INNER JOIN zhr_dpo_csabl AS c
                  ON a~template_code EQ c~template_code
                  LEFT JOIN zhr_dpo_term AS d
                   ON a~term_id EQ d~term_id
                 INTO TABLE @lt_request_list
                 FOR ALL ENTRIES IN @lt_rozdel
                  WHERE a~dpo_request EQ @lt_rozdel-dpo_request
                    AND a~dpo_request IN @request_range
                    AND a~dpo_year    IN @request_year_range
                    AND a~dpo_type    IN @request_type_range
                    AND b~datum       IN @r_date
                    AND a~status      IN @status_range
                    AND c~process     IN @process_range
*                    and a~orgeh       in @orgeh

                    AND d~term_date   IN @r_term_date
                    AND a~name_caps        LIKE @<fs_name>-low
                    AND a~deletion_flag EQ @abap_false
                    AND a~tasks_unfinished IN @task_unfinished.
          ENDIF.


        ENDIF.

      WHEN  ' '. "nic na zobrazeni
        RETURN.
    ENDCASE.

    IF lv_role NE 'ADMIN'.
      DELETE lt_request_list WHERE status IN rs_nodisp_stat."smaž uzavřené a zmazané.
    ENDIF.


    DELETE lt_request_list WHERE dpo_req_full IS INITIAL.

    IF lt_request_list[] IS NOT INITIAL.

      SELECT * FROM zhr_dpo_rozdel INTO TABLE @DATA(lt_rozdelit)
                                FOR ALL ENTRIES IN @lt_request_list
                                WHERE dpo_request = @lt_request_list-dpo_request.

*      SELECT term_id, term_date FROM zhr_dpo_term INTO TABLE @DATA(lt_term)
*                                FOR ALL ENTRIES IN @lt_request_list
*                                WHERE term_id EQ @lt_request_list-term_id.

      SELECT a~object, a~status, a~spras, a~description, b~status_num FROM zhr_dpo_cstatt AS a
                            INNER JOIN zhr_dpo_cstat AS b
                            ON  a~object = b~object
                            AND a~status = b~status
                            INTO TABLE @DATA(lt_status)
                            WHERE a~object = @zcl_hr_dpo_request=>cv_request
                              AND a~spras  = @sy-langu.
      SELECT * FROM zhr_dpo_cproct INTO TABLE @DATA(lt_process)
                                   FOR ALL ENTRIES IN @lt_request_list
                                   WHERE process = @lt_request_list-process
                                     AND spras   = @sy-langu.

      SELECT  theme, a~template_code, template_text, url FROM zhr_dpo_csabl AS a
                           INNER JOIN zhr_dpo_csablt AS b
                           ON a~template_code EQ b~template_code
                           INTO TABLE @DATA(lt_template)
                           FOR ALL ENTRIES IN @lt_request_list

                             WHERE a~template_code EQ @lt_request_list-template_code
                             AND b~spras EQ @sy-langu.



      DATA(lt_temp_list) = lt_request_list[].
      DATA(lt_stat_tmp_list) = lt_request_list[].
      SORT lt_stat_tmp_list BY dpo_request.
      SORT lt_temp_list BY  dpo_request DESCENDING dpo_step ASCENDING."prvý zaznam kvoli zastupcovi
      DELETE ADJACENT DUPLICATES FROM lt_temp_list COMPARING dpo_request.
      SORT lt_request_list BY  dpo_request DESCENDING dpo_step DESCENDING.
      DELETE ADJACENT DUPLICATES FROM lt_request_list COMPARING dpo_request.

    ELSE.
      RETURN.
    ENDIF.

    LOOP AT lt_request_list ASSIGNING FIELD-SYMBOL(<fs_request>).
      DATA(lv_tabix) = sy-tabix.
      CLEAR ls_request.


      MOVE-CORRESPONDING <fs_request> TO ls_request.
      ls_request-a0004_filled = zcl_hr_dpo_a004=>add_or_get( iv_request = ls_request-dpo_request )->get_complete( ).
*nezobrazuj dalšímu žadateli žádost, v statuse Ve zpracování OJ.
*      IF line_exists(  lt_rozdelit[ dpo_request = <fs_request>-dpo_request uname = lv_uname ] ).
*        DATA(lv_my_role) = lt_rozdelit[ dpo_request = <fs_request>-dpo_request uname = lv_uname ]-role.
*        IF lv_my_role = zcl_hr_dpo_roles=>CO_ZAD_NEXT AND <fs_request>-status = 'ROJ'.
*          CONTINUE.
*        ENDIF.
*      ENDIF.

      READ TABLE lt_rozdelit ASSIGNING FIELD-SYMBOL(<fs_rozdelit>)
                                   WITH KEY role = zcl_hr_dpo_roles=>co_hrbp
                                            dpo_request = <fs_request>-dpo_request.
      IF sy-subrc EQ 0.
        ls_request-hrbp_uname = <fs_rozdelit>-uname.
        lv_pernr = zcl_pa_vs_utils=>get_pernr_by_uname( iv_uname = ls_request-hrbp_uname ).
        IF lv_pernr IS NOT INITIAL.
          DATA(ls_user_data) = zcl_hr_dpo_roles=>get_pernr_details( iv_pernr = lv_pernr  ).
          ls_request-hrbrp_full_name = ls_user_data-full_name_s.
          CLEAR: ls_user_data, lv_pernr.
        ENDIF.

      ENDIF.

      READ TABLE lt_template ASSIGNING FIELD-SYMBOL(<fs_template>)
                   WITH KEY template_code = <fs_request>-template_code.
      IF sy-subrc EQ 0.
        ls_request-template_desc = <fs_template>-template_text.
        ls_request-url           = <fs_template>-url.
      ENDIF.

*      READ TABLE lt_term ASSIGNING FIELD-SYMBOL(<fs_term>)
*                 WITH KEY term_id = <fs_request>-term_id.
*      IF sy-subrc EQ 0.
*        ls_request-term_date = <fs_term>-term_date.
*
*      ENDIF.
      IF ls_request-tasks_unfinished = abap_true.
        ls_request-tasks_descr = TEXT-018.
      ELSE.
        ls_request-tasks_descr = TEXT-019.
      ENDIF.
      READ TABLE lt_status ASSIGNING FIELD-SYMBOL(<fs_status>)
                           WITH KEY status = <fs_request>-status.
      IF sy-subrc EQ 0.
        DATA(lv_act_stat) = <fs_status>-status_num.
        ls_request-status_descr = <fs_status>-description.
* vyrad zo zoznamu záznamy, ktoré maju nižší status ako treba
        IF lv_s_case = abap_true.

* najdi navyssi dosazeny status
          DATA(lv_max_stat) = <fs_status>-status_num.
          LOOP AT lt_stat_tmp_list ASSIGNING FIELD-SYMBOL(<fs_stat_req>)
                                   WHERE dpo_request =   ls_request-dpo_request.
            READ TABLE lt_status ASSIGNING <fs_status> WITH KEY status = <fs_stat_req>-next_status.
            IF sy-subrc EQ 0.
              IF lv_max_stat LE <fs_status>-status_num.
                lv_max_stat = <fs_status>-status_num.
              ENDIF.
            ENDIF.
          ENDLOOP.

          DATA(lv_stat) = COND zhr_dpo_status_num_req( WHEN ls_request-dpo_type = 'P-CENTR'  AND lv_rq_max = 'M' THEN lv_max_stat
                                                       WHEN ls_request-dpo_type = 'D-DOHODA' AND lv_ag_max = 'M' THEN lv_max_stat
                                                       ELSE lv_act_stat ).

          IF lv_role = zcl_hr_dpo_roles=>co_sp AND lv_uname = <fs_request>-requestor.
*žádost vytvorenou SP nemaž z jeho zoznamu.
          ELSE.
            CASE ls_request-dpo_type.
              WHEN 'P-CENTR'.
                IF lv_stat NOT IN rs_compare_rq.
                  DELETE lt_request_list INDEX lv_tabix.
                  CONTINUE.
                ENDIF.
              WHEN 'D-DOHODA'.
                IF lv_stat NOT IN rs_compare_ag.
                  DELETE lt_request_list INDEX lv_tabix.
                  CONTINUE.
                ENDIF.
              WHEN OTHERS.
            ENDCASE.
          ENDIF.
        ELSE.
*          IF <fs_status>-status_num = '01' AND lv_role NE zcl_hr_dpo_roles=>co_hrbp.
*            DELETE lt_request_list INDEX lv_tabix.
*            CONTINUE.
*          ENDIF.
        ENDIF.
      ENDIF.
      READ TABLE lt_status ASSIGNING <fs_status>
                           WITH KEY status = <fs_request>-next_status.
      IF sy-subrc EQ 0.
        ls_request-next_status_descr = <fs_status>-description.
      ENDIF.

      READ TABLE lt_process ASSIGNING FIELD-SYMBOL(<fs_process>)
                            WITH KEY process = <fs_request>-process.
      IF sy-subrc EQ 0.
        ls_request-process_desc = <fs_process>-description.
      ENDIF.

      TRY.
          DATA(ls_theme) = lt_theme[ domvalue_l = <fs_request>-theme ].
          ls_request-theme_long = ls_theme-ddtext.

        CATCH cx_sy_itab_line_not_found .
      ENDTRY.
      IF ls_request-dpo_req_full IS INITIAL.
        DATA(ls_conv) = VALUE zhr_dpo_zadconv( dpo_request = <fs_request>-dpo_request
                                                  dpo_year = <fs_request>-dpo_year
                                                  dpo_type = <fs_request>-dpo_type
                                                  direction = 'O' ).
        convert_request(
          CHANGING
            chs_request = ls_conv                 " Konverze čísla žádosti
        ).
        ls_request-dpo_req_full = ls_conv-dpo_req_full.
      ENDIF.
      ls_request-template_code = <fs_request>-template_code.
      ls_thead-tdid = 'ZOJ'.
      ls_thead-tdname = ls_request-dpo_request.
      ls_thead-tdspras = sy-langu.
      ls_thead-tdobject = 'ZHR_DPO'.

      ls_request-text = read_text( EXPORTING  is_head    = ls_thead
                                    ).

      lv_pernr = zcl_pa_vs_utils=>get_pernr_by_uname( iv_uname = <fs_request>-requestor ).
      IF lv_pernr IS NOT INITIAL.
        ls_user_data = zcl_hr_dpo_roles=>get_pernr_details( iv_pernr = lv_pernr  ).
        ls_request-requestor_name_full = ls_user_data-full_name_s.
        CLEAR: ls_user_data, lv_pernr.
      ENDIF.


      CLEAR: ls_address.
      REFRESH lt_return.

      READ TABLE lt_temp_list ASSIGNING FIELD-SYMBOL(<fs_temp>) WITH KEY dpo_request = ls_request-dpo_request.
      IF sy-subrc EQ 0.
        IF <fs_temp>-uname IS NOT INITIAL AND
          <fs_temp>-uname NE <fs_request>-requestor.

          lv_pernr = zcl_pa_vs_utils=>get_pernr_by_uname( iv_uname = <fs_temp>-uname ).
          IF lv_pernr IS NOT INITIAL.
            ls_user_data = zcl_hr_dpo_roles=>get_pernr_details( iv_pernr = lv_pernr  ).
            ls_request-user_name_full = ls_user_data-full_name_s.
            CLEAR: ls_user_data, lv_pernr.
          ENDIF.

        ENDIF.
      ENDIF.


      IF  request_full_range[] IS NOT INITIAL.
        LOOP AT request_full_range ASSIGNING FIELD-SYMBOL(<fs_range>).

          lv_full = '*' && <fs_range>-low && '*'.
          IF ls_request-dpo_req_full CP lv_full.
            APPEND ls_request TO rt_request_list.
          ENDIF.
        ENDLOOP.
      ELSE.
        APPEND ls_request TO rt_request_list.
      ENDIF.

    ENDLOOP.




    DATA lv_upper_case TYPE string.
    IF orgeh[] IS NOT INITIAL.
      READ TABLE orgeh ASSIGNING FIELD-SYMBOL(<fs_orgeh>) INDEX 1.
      IF sy-subrc EQ 0.
        DATA(lv_orgeh) = <fs_orgeh>-low.
        TRANSLATE lv_orgeh TO UPPER CASE.

        DATA(lt_request_tab) = rt_request_list[].
        REFRESH rt_request_list.
        LOOP AT lt_request_tab INTO ls_request.
          lv_upper_case = ls_request-orgeh.
          TRANSLATE lv_upper_case TO UPPER CASE.
          FIND lv_orgeh IN lv_upper_case IGNORING CASE MATCH COUNT DATA(lv_count).
          IF lv_count IS NOT INITIAL.
            APPEND ls_request TO rt_request_list.
            CLEAR lv_count.
          ENDIF.
        ENDLOOP.
      ENDIF.
    ENDIF.

    IF requestor_full_name[] IS NOT INITIAL.
      READ TABLE requestor_full_name ASSIGNING FIELD-SYMBOL(<fs_requestor>) INDEX 1.
      IF sy-subrc EQ 0.
        DATA(lv_requestorname) = <fs_requestor>-low.
        TRANSLATE lv_requestorname TO UPPER CASE.
        lt_request_tab[] = rt_request_list[].
        REFRESH rt_request_list.
        LOOP AT lt_request_tab INTO ls_request.
          lv_upper_case = ls_request-requestor_name_full.
          TRANSLATE lv_upper_case TO UPPER CASE.
          FIND lv_requestorname IN lv_upper_case IGNORING CASE MATCH COUNT lv_count.
          IF lv_count IS NOT INITIAL.
            APPEND ls_request TO rt_request_list.
            CLEAR lv_count.
          ENDIF.
        ENDLOOP.
      ENDIF.
    ENDIF.


    IF iv_from_term_string IS NOT INITIAL.
      lt_request_tab = rt_request_list[].
      REFRESH rt_request_list.
      LOOP AT lt_request_tab INTO ls_request.
        FIND iv_from_term_string IN ls_request-dpo_req_full IGNORING CASE MATCH COUNT lv_count.
        IF lv_count IS INITIAL.
          lv_upper_case = ls_request-name.
          TRANSLATE lv_upper_case TO UPPER CASE.
          FIND iv_from_term_string IN lv_upper_case IGNORING CASE MATCH COUNT lv_count.
          IF lv_count IS INITIAL.
            FIND iv_from_term_string IN ls_request-dpo_type IGNORING CASE MATCH COUNT lv_count.
            IF lv_count IS INITIAL.
              lv_upper_case = ls_request-orgeh.
              TRANSLATE lv_upper_case TO UPPER CASE.
              FIND iv_from_term_string IN lv_upper_case IGNORING CASE MATCH COUNT lv_count.
              IF lv_count IS INITIAL.
                lv_upper_case = ls_request-requestor_name_full.
                TRANSLATE lv_upper_case TO UPPER CASE.
                FIND iv_from_term_string IN lv_upper_case IGNORING CASE MATCH COUNT lv_count.
                IF lv_count IS INITIAL.
                  lv_upper_case = ls_request-hrbrp_full_name.
                  TRANSLATE lv_upper_case TO UPPER CASE.
                  FIND iv_from_term_string IN lv_upper_case IGNORING CASE MATCH COUNT lv_count.
                  IF lv_count IS INITIAL.
                    lv_upper_case = ls_request-process_desc.
                    TRANSLATE lv_upper_case TO UPPER CASE.
                    FIND iv_from_term_string IN lv_upper_case IGNORING CASE MATCH COUNT lv_count.

                  ENDIF.
                ENDIF.
              ENDIF.
            ENDIF.
          ENDIF.
        ENDIF.
        IF lv_count IS NOT INITIAL.
          APPEND ls_request TO rt_request_list.
          CLEAR lv_count.
        ENDIF.
      ENDLOOP.
    ENDIF.

  ENDMETHOD.


  method GET_WERKS_UNION_TEXT.

    DATA: ls_longtext_union TYPE ZHR_DPO_WERK_TEXT_S,
          ls_thead TYPE thead.

    SELECT a~parameter_dpo, a~value, b~description FROM zhr_dpo_cparam as a INNER JOIN zhr_dpo_cparamt as b
                           on a~parameter_dpo EQ b~parameter_dpo
                            INTO TABLE @data(lt_param)
                           WHERE a~parameter_dpo LIKE 'ZAD_ZAVODSP%'
                             AND spras EQ @sy-langu.
                         IF sy-subrc EQ 0.
                           LOOP AT lt_param ASSIGNING FIELD-SYMBOL(<fs_param>).
                              ls_longtext_union-werks_param = <fs_param>-parameter_dpo.
                              ls_longtext_union-werks_descr = <fs_param>-description.
                              ls_thead-tdid = 'ST'.
                              ls_thead-tdname = <fs_param>-value.
                              ls_thead-tdspras = sy-langu.
                              ls_thead-tdobject = 'TEXT'.
                              ls_longtext_union-text_union = read_text( is_head =  ls_thead ).

                              APPEND ls_longtext_union TO rt_longtext_union.
                           ENDLOOP.


                         ENDIF.


  endmethod.


  METHOD init_form_data.

    DATA ls_thead TYPE thead.
    DATA lv_usrid TYPE  p0105-usrid.
    DATA: lv_dpo_id     TYPE zhr_dpo_request,
          lv_dpo_id_ext TYPE zhr_dpo_request.
    DATA: lv_pernr TYPE pernr_d.

    DATA lt_message TYPE STANDARD TABLE OF bapiret2.


    DATA(lt_theme) = get_domain_values( iv_name = 'ZHR_DPO_THEME' ).
    TRY.
        DATA(ls_theme) = lt_theme[ domvalue_l = gs_custom_template-theme ].
        gs_data_db-theme_long = ls_theme-ddtext.

      CATCH cx_sy_itab_line_not_found .
    ENDTRY.

    SELECT SINGLE description FROM zhr_dpo_cstatt INTO gs_data_db-status_descr
                         WHERE object = zcl_hr_dpo_request=>cv_request
                           AND status = 'ROJ'
                           AND spras  = sy-langu.
    IF sy-subrc NE 0.
      SELECT SINGLE description FROM zhr_dpo_cstatt INTO gs_data_db-status_descr
                        WHERE object = zcl_hr_dpo_request=>cv_request
                          AND status = 'ROJ'
                          AND spras  = 'CS'.
    ENDIF.

    gs_data_db-role = zcl_hr_dpo_roles=>co_requestor.
    gs_data_db-process = 'P-CENTR'.
    gs_data_db-template_code = gs_custom_template-template_code.
    gs_data_db-status = 'ROJ'.
    gs_data_db-tasks_descr = TEXT-019.

    gs_data_db-theme = gs_custom_template-theme.
    gs_data_db-request_date = sy-datum.


    DATA(r_term_sp)    = VALUE  /iwbep/t_cod_select_options( sign = 'I' option = 'GE' ( low = sy-datum ) ).
    DATA(lt_term_list) = NEW zcl_hr_dpo_term( )->get_term_list( with_proposed_term = abap_true term_sp_range = r_term_sp ).
    IF line_exists( lt_term_list[ proposed_term = abap_true ] ).
      gs_data_db-term_date = lt_term_list[ proposed_term = abap_true ]-term_date.
      gs_data_db-term_id   = lt_term_list[ proposed_term = abap_true ]-term_id.
    ENDIF.
    ls_thead-tdid = 'ST'.
    ls_thead-tdname = gs_custom_template-oj_text.
    ls_thead-tdspras = sy-langu.
    ls_thead-tdobject = 'TEXT'.
    gs_data_db-text = read_text( is_head = ls_thead ).

    CALL FUNCTION 'NUMBER_GET_NEXT'
      EXPORTING
        nr_range_nr             = '01'
        object                  = 'ZHR_DPO_R'
      IMPORTING
        number                  = lv_dpo_id
      EXCEPTIONS
        interval_not_found      = 1
        number_range_not_intern = 2
        object_not_found        = 3
        quantity_is_0           = 4
        quantity_is_not_1       = 5
        interval_overflow       = 6
        buffer_overflow         = 7
        OTHERS                  = 8.


    DATA lv_year TYPE inri-toyear .
    lv_year = sy-datum(4).

    gs_data_db-dpo_year = lv_year.
    IF gs_data_db-dpo_request IS INITIAL.
      gs_data_db-dpo_request = lv_dpo_id.


    ENDIF.

    gs_data_db-creator = iv_uname.
    IF gs_data_db-creator IS INITIAL.
      gs_data_db-creator = sy-uname.
    ENDIF.
    lv_usrid = gs_data_db-creator.
    CALL FUNCTION 'RP_GET_PERNR_FROM_USERID'
      EXPORTING
        begda     = sy-datum
        endda     = sy-datum
        usrid     = lv_usrid
        usrty     = '0001'
      IMPORTING
        usr_pernr = lv_pernr
      EXCEPTIONS
        retcd     = 1
        OTHERS    = 2.

    IF lv_pernr IS NOT INITIAL.
      DATA(ls_user_data) = zcl_hr_dpo_roles=>get_pernr_details( iv_pernr = lv_pernr  ).
      gs_data_db-orgeh = ls_user_data-short.
      gs_data_db-orgeh_orig = ls_user_data-orgeh.
    ENDIF.
    gs_data_db-uname = sy-uname.
    gs_data_db-dpo_step = '1'.

*


  ENDMETHOD.


  METHOD is_button_check_relevant.


    return = abap_true.

    IF ( me->status_exists_in_history( iv_dpo_request  = gs_data_db-dpo_request
                                                                iv_status       = 'ZHP' )
          AND iv_button =  'SENT_TO_APPROVE' ).

      IF me->check_not_yet_approved( ).
        ch_status_to_check = 'ZHP'. "chovej se jako Zahajeno projednani.
      ELSE.
        return = abap_false.
      ENDIF.

    ENDIF.

  ENDMETHOD.


    method MOVE_ATTACHMENTS_TO_UNI.

  DATA: ls_attachment_ui TYPE ZCA_UF_ATTACHMENTS_UI.
    DATA(lt_attach_tab) = me->read_attachment_tab( iv_dpo_request = gs_data_db-dpo_request ).

    LOOP AT lt_attach_tab ASSIGNING FIELD-SYMBOL(<fs_tab>).
      ls_attachment_ui-attach_description = <fs_tab>-filename.
      ls_attachment_ui-file_name = <fs_tab>-filename.
      ls_attachment_ui-mime_type = <fs_tab>-MIMETYPE.
    APPEND ls_attachment_ui TO gt_attachments_ui.
   ENDLOOP.

*DPO_REQUEST
*UNAME
*GUID
*DOC_TYPE
*DOC_ID
*OBJECT_ID
*FILENAME
*MIMETYPE
*STATUS
*VALIDATE_AC
*POSIT
*LINK
*    ENDLOOP.
* GT_ATTACHMENTS_UI

  endmethod.


  method prepare_to_save.

    try.
        gs_custom_template = gt_custom_template[ template_code =  chs_requestdata-template_code ].
      catch cx_sy_itab_line_not_found .
    endtry.
*     chs_requestdata-dpo_type  = gs_custom_template-process .


    IF chs_requestdata-status IS INITIAL.

     read_next_step( iv_status  = 'ROJ' iv_process = gs_custom_template-process iv_role = zcl_hr_dpo_roles=>co_requestor ).

    ELSE.
     read_next_step( iv_status  = chs_requestdata-status iv_process = gs_custom_template-process iv_role = chs_requestdata-role ).
    ENDIF.

     chs_requestdata-next_status  = gs_custom_request-next_status.



  endmethod.


  METHOD read_attachment_tab.

    DATA: ls_attach_line TYPE zhr_dpo_att_s,
          lt_attach_tab  TYPE zhr_dpo_att_t,
          lv_guid(40)    TYPE c.

    IF iv_with_agreements = abap_true.
      SELECT * FROM zhr_dpo_req_att
              INTO TABLE @DATA(lt_attach)
              WHERE dpo_request = @iv_dpo_request
                AND term_id     = @iv_dpo_term.

    ELSE.
      SELECT * FROM zhr_dpo_req_att
               INTO TABLE @lt_attach
               WHERE dpo_request = @iv_dpo_request
                 AND term_id     = @iv_dpo_term
                 AND dpo_agreement = ''.
    ENDIF.
    IF sy-subrc EQ 0.

      IF iv_uname IS SUPPLIED.
        DATA(lv_role) = zcl_hr_dpo_roles=>identify_my_role(  iv_name = iv_uname iv_dpo_request = iv_dpo_request  ).
      ELSE.
        lv_role = gs_data_db-role.
      ENDIF.
      IF lv_role = 'HRBP'.
        SELECT COUNT( * ) FROM zhr_dpo_rozdel AS rozdel
                              WHERE  dpo_request = @iv_dpo_request
                                 AND role  = 'ZAD'
                                 AND pernr = ( SELECT pernr FROM zhr_dpo_rozdel WHERE dpo_request = @iv_dpo_request
                                                                                  AND role = 'HRBP'
                                                                                  AND pernr = rozdel~pernr   )  .
        IF sy-subrc EQ 0.
          lv_role = 'ZAD'.
        ENDIF.
      ENDIF.


      LOOP AT lt_attach ASSIGNING FIELD-SYMBOL(<fs_attach>).
        MOVE-CORRESPONDING <fs_attach> TO ls_attach_line.
        lv_guid = ls_attach_line-guid.
        ls_attach_line-link = zcl_hr_dpo_service=>get_attachment_link( iv_dpo_request = ls_attach_line-dpo_request iv_uname = ls_attach_line-uname iv_guid = lv_guid  ).

        IF <fs_attach>-not_yet_approved = abap_true .
* neschválenou prilohuz vidí jenom zadavatel a SP.
*          IF ( NEW zcl_hr_dpo_request( )->status_exists_in_history( iv_dpo_request  =  iv_dpo_request
*                                                                  iv_status       = 'ZHP' )
*            AND lv_role = 'ZAD' )
*           OR ( gs_data_db-status = 'NAA' AND ( lv_role = 'SP' OR lv_role = 'ZAD' ) ).
*
*            APPEND ls_attach_line TO lt_attach_tab.
*          ELSE.
*            CONTINUE.
*          ENDIF.
            APPEND ls_attach_line TO lt_attach_tab.
        ELSE.
*          IF gs_data_db-status = 'NAA' AND gs_data_db-role = 'SP'.
*            CONTINUE.
*          ELSE.
          APPEND ls_attach_line TO lt_attach_tab.
*          ENDIF.
        ENDIF.

      ENDLOOP.
    ENDIF.

    rt_attachment_tab[] = lt_attach_tab[].


  ENDMETHOD.


  METHOD read_customizing.

    CHECK gt_custom_request IS INITIAL.

    SELECT * FROM zhr_dpo_czad INTO TABLE gt_custom_request.



    SELECT * FROM zhr_dpo_csabl INTO TABLE gt_custom_template.

    READ TABLE gt_custom_template ASSIGNING FIELD-SYMBOL(<fs_templ>)
                                  WITH KEY template_code =  gs_data_db-template_code.



    SELECT * FROM zhr_dpo_cstat INTO CORRESPONDING FIELDS OF TABLE gt_status_desc.
    IF sy-subrc EQ 0.


      SELECT * FROM zhr_dpo_cstatt INTO TABLE @DATA(lt_status_desc)
                                  FOR ALL ENTRIES IN @gt_status_desc
                                  WHERE object = @gt_status_desc-object
                                    AND status = @gt_status_desc-status
                                    AND spras EQ @sy-langu.
      IF sy-subrc NE 0.
        SELECT * FROM zhr_dpo_cstatt INTO TABLE lt_status_desc
                                 FOR ALL ENTRIES IN gt_status_desc
                                 WHERE object = gt_status_desc-object
                                   AND status = gt_status_desc-status
                                   AND spras EQ 'CS'.
      ENDIF.

      SORT gt_status_desc BY status_num ASCENDING.
      LOOP AT gt_status_desc ASSIGNING FIELD-SYMBOL(<fs_desc>).
        READ TABLE lt_status_desc ASSIGNING FIELD-SYMBOL(<fs_lang>)
                                  WITH KEY object = <fs_desc>-object
                                           status = <fs_desc>-status.
        IF sy-subrc EQ 0.
          <fs_desc>-description = <fs_lang>-description.
        ENDIF.
      ENDLOOP.

    ENDIF.
  ENDMETHOD.


  method read_next_step.

    try.
        gs_custom_request =  gt_custom_request[ process = iv_process status = iv_status role = iv_role ].

      catch cx_sy_itab_line_not_found .
    endtry.

  endmethod.


  METHOD read_request.

    DATA ls_request TYPE zhr_dpo_zad_struct.
    DATA lv_full TYPE zhr_dpo_request_full.
    DATA(lt_theme) = get_domain_values( iv_name = 'ZHR_DPO_THEME' ).
    DATA ls_thead TYPE thead.
    DATA: lt_return TYPE STANDARD TABLE OF bapiret2.
    DATA: ls_address TYPE bapiaddr3.

    CHECK iv_dpo_request IS NOT INITIAL.

    SELECT SINGLE value FROM zhr_dpo_cparam INTO @DATA(lv_stav)
                                                   WHERE parameter_dpo = 'ZHR_CISL_STAV'.


    SELECT   b~form_id,a~dpo_request, a~dpo_year, a~dpo_type, a~template_code, a~request_date, a~dpo_req_full,
             a~status, a~name, a~send_date, a~term_id, a~before_save, a~requestor, a~werks_param, a~notif_status, a~orgeh, a~orgeh_orig,
             b~uname, b~datum, b~time, b~role, b~next_status,
             b~dpo_step,  c~process, c~theme, a~approval_type, a~changes, a~button_as_draft, a~tasks_unfinished
             FROM zhr_dpo_zad AS a
             INNER JOIN zhr_dpo_hist AS b
             ON  a~dpo_request EQ b~dpo_request
             AND a~before_save EQ b~before_save
             LEFT JOIN zhr_dpo_csabl AS c
             ON a~template_code EQ c~template_code
             INTO TABLE  @DATA(lt_req)
             WHERE a~dpo_request EQ @iv_dpo_request
             AND a~deletion_flag = @abap_false.
*               and a~before_save EQ @iv_read_tmp_request.
    IF sy-subrc EQ 0.
      SORT lt_req BY dpo_request dpo_step ASCENDING.
      READ TABLE lt_req ASSIGNING FIELD-SYMBOL(<fs_req>) INDEX 1.
      IF sy-subrc EQ 0.
        DATA(lv_dep) = <fs_req>-uname.
      ENDIF.

      SORT lt_req BY dpo_request dpo_step DESCENDING.
      READ TABLE lt_req ASSIGNING <fs_req>  WITH KEY before_save = iv_read_tmp_request.
      IF sy-subrc EQ 0.
        MOVE-CORRESPONDING <fs_req> TO ls_request.
      ELSE.
        READ TABLE lt_req ASSIGNING <fs_req> INDEX 1.
        IF sy-subrc EQ 0.
          MOVE-CORRESPONDING <fs_req> TO ls_request.
        ENDIF.
      ENDIF.
    ENDIF.
    IF ls_request IS NOT INITIAL.

      IF ls_request-request_date IS INITIAL.
        ls_request-request_date = <fs_req>-datum."zmena datumu
      ENDIF.
      ls_request-creator = <fs_req>-requestor.

      SELECT SINGLE term_id, term_date FROM zhr_dpo_term INTO @DATA(ls_term)

                                WHERE term_id EQ @ls_request-term_id.

      SELECT SINGLE * FROM zhr_dpo_cstatt INTO @DATA(ls_status)
                            WHERE object = @zcl_hr_dpo_request=>cv_request
                              AND status = @<fs_req>-status
                              AND spras  = @sy-langu.

      SELECT SINGLE * FROM zhr_dpo_cstatt INTO @DATA(ls_notifstatus)
                             WHERE object = 'N'
                               AND status = @<fs_req>-notif_status
                               AND spras  = @sy-langu.

      SELECT SINGLE * FROM zhr_dpo_cproct INTO @DATA(ls_process)
                                   WHERE process = @ls_request-process
                                     AND spras   = @sy-langu.


      SELECT SINGLE theme, a~template_code, template_text, url FROM zhr_dpo_csabl AS a
                            INNER JOIN zhr_dpo_csablt AS b
                            ON a~template_code EQ b~template_code
                            INTO  @DATA(ls_template)
                              WHERE a~template_code EQ @ls_request-template_code
                              AND b~spras EQ @sy-langu.

      SELECT * FROM zhr_dpo_rozdel INTO TABLE me->gt_rozdel
                                   WHERE dpo_request = iv_dpo_request.



      ls_request-template_desc = ls_template-template_text.
      ls_request-term_date = ls_term-term_date.
      ls_request-status_descr = ls_status-description.
      ls_request-next_status_descr = ls_status-description.
      ls_request-process_desc = ls_process-description.
      ls_request-url          = ls_template-url.
      ls_request-notif_status_desc = ls_notifstatus-description.


      DATA(lv_pernr) = zcl_pa_vs_utils=>get_pernr_by_uname( iv_uname = <fs_req>-requestor ).
      IF lv_pernr IS NOT INITIAL.
        DATA(ls_user_data) = zcl_hr_dpo_roles=>get_pernr_details( iv_pernr = lv_pernr  ).
        ls_request-requestor_name_full = ls_user_data-full_name.
        CLEAR: ls_user_data, lv_pernr.
      ENDIF.

      lv_pernr = zcl_pa_vs_utils=>get_pernr_by_uname( iv_uname = lv_dep ).
      IF lv_pernr IS NOT INITIAL.
        ls_user_data = zcl_hr_dpo_roles=>get_pernr_details( iv_pernr = lv_pernr  ).
        ls_request-user_name_full = ls_user_data-full_name.
        CLEAR: ls_user_data, lv_pernr.
      ENDIF.

      TRY.
          DATA(ls_theme) = lt_theme[ domvalue_l = ls_request-theme ].
          ls_request-theme_long = ls_theme-ddtext.

        CATCH cx_sy_itab_line_not_found .
      ENDTRY.
      IF ls_request-dpo_req_full IS INITIAL AND ls_request-dpo_request LT lv_stav.
        DATA(ls_conv) = VALUE zhr_dpo_zadconv( dpo_request = ls_request-dpo_request
                                                  dpo_year = ls_request-dpo_year
                                                  dpo_type = ls_request-dpo_type
                                                  direction = 'O' ).
        convert_request(
          CHANGING
            chs_request = ls_conv                 " Konverze čísla žádosti
        ).
        ls_request-dpo_req_full = ls_conv-dpo_req_full.
      ENDIF.
      ls_thead-tdid = 'ZOJ'.
      ls_thead-tdspras = sy-langu.
      ls_thead-tdobject = 'ZHR_DPO'.
      ls_thead-tdname = ls_request-dpo_request && iv_read_tmp_request.
      ls_request-text = read_text( EXPORTING  is_head    = ls_thead
                                    ).
      IF ls_request-text IS INITIAL.
        ls_thead-tdname = ls_request-dpo_request.
        ls_request-text = read_text( EXPORTING  is_head    = ls_thead
                                    ).
      ENDIF.

      gs_data_db = ls_request.
      IF iv_uni_process EQ abap_true.
        gs_data_db-uni_process = abap_true."sme v uniprocese
      ENDIF.

    ELSE.
      gs_data_db-dpo_request = iv_dpo_request.
    ENDIF.

    IF gs_data_db-tasks_unfinished = abap_true.
      gs_data_db-tasks_descr = TEXT-018.
    ELSE.
      gs_data_db-tasks_descr = TEXT-019.
    ENDIF.

    me->gs_data_db-a0004_filled = zcl_hr_dpo_a004=>add_or_get( iv_request = iv_dpo_request )->get_complete( ).

    gs_data_db-pdf_internal_lnk = zcl_hr_dpo_service=>create_pdf_link( iv_dpo_request ).

    rs_dpo_request = gs_data_db.
    IF rs_dpo_request-requestor_name_full = rs_dpo_request-user_name_full.
      CLEAR rs_dpo_request-user_name_full.
    ENDIF.

  ENDMETHOD.


  METHOD read_text.

    DATA: lt_lines TYPE TABLE OF tline.

    CALL FUNCTION 'READ_TEXT'
      EXPORTING
*       CLIENT                  = SY-MANDT
        id                      = is_head-tdid
        language                = is_head-tdspras
        name                    = is_head-tdname
        object                  = is_head-tdobject
      TABLES
        lines                   = lt_lines
      EXCEPTIONS
        id                      = 1
        language                = 2
        name                    = 3
        not_found               = 4
        object                  = 5
        reference_check         = 6
        wrong_access_to_archive = 7
        OTHERS                  = 8.
    IF sy-subrc <> 0.
      CALL FUNCTION 'READ_TEXT'
        EXPORTING
*         CLIENT                  = SY-MANDT
          id                      = is_head-tdid
          language                = 'C'
          name                    = is_head-tdname
          object                  = is_head-tdobject
        TABLES
          lines                   = lt_lines
        EXCEPTIONS
          id                      = 1
          language                = 2
          name                    = 3
          not_found               = 4
          object                  = 5
          reference_check         = 6
          wrong_access_to_archive = 7
          OTHERS                  = 8.
      IF sy-subrc NE 0.
        CALL FUNCTION 'READ_TEXT'
          EXPORTING
*           CLIENT                  = SY-MANDT
            id                      = is_head-tdid
            language                = 'E'
            name                    = is_head-tdname
            object                  = is_head-tdobject
          TABLES
            lines                   = lt_lines
          EXCEPTIONS
            id                      = 1
            language                = 2
            name                    = 3
            not_found               = 4
            object                  = 5
            reference_check         = 6
            wrong_access_to_archive = 7
            OTHERS                  = 8.
        IF sy-subrc EQ 0.
          ev_success = abap_true.
        ENDIF.
      ELSE.
        ev_success = abap_true.
      ENDIF.
    ELSE.
      ev_success = abap_true.
    ENDIF.

    LOOP AT lt_lines ASSIGNING FIELD-SYMBOL(<fs_text>).
      IF rv_longtext IS INITIAL.
        rv_longtext = <fs_text>-tdline.
        ev_subject  = <fs_text>-tdline.
      ELSE.
        CASE <fs_text>-tdformat.
          WHEN ' '

            OR '='.
            rv_longtext = |{ rv_longtext } { <fs_text>-tdline }|.
          WHEN '*'
            OR '/'.
            rv_longtext = SWITCH string( iv_mail WHEN  '' THEN |{ rv_longtext }\n{ <fs_text>-tdline }|
                                                WHEN  'X'  THEN |{ rv_longtext }<br>{ <fs_text>-tdline }| ).


        ENDCASE.

      ENDIF.

    ENDLOOP.



  ENDMETHOD.


  METHOD reload_active_zad.

    DATA lv_dpo_request TYPE zhr_dpo_request.

    lv_dpo_request =  |{ iv_dpo_request ALPHA = IN }|.

    DATA(lv_uname) = zcl_pe_all_change_user=>get_uname( iv_appl_id = 'ZHR_DPO_REQUEST' ).


    SELECT SINGLE * FROM zhr_dpo_zad_act INTO @return
                    WHERE dpo_request = @lv_dpo_request
                      AND real_user   = @lv_uname
                      AND aedat       = @sy-datum.

    IF sy-subrc NE 0.
      SELECT SINGLE * FROM zhr_dpo_zad_act INTO @return
                    WHERE
                          dpo_request = ''
                      AND real_user   = @lv_uname
                      AND aedat       = @sy-datum.
    ENDIF.

    IF sy-subrc <> 0.
      SELECT zhr_dpo_zad~term_id, zhr_dpo_term~process FROM zhr_dpo_zad
        INNER JOIN zhr_dpo_term ON zhr_dpo_zad~term_id = zhr_dpo_term~term_id
          WHERE dpo_request = @iv_dpo_request
        INTO TABLE @DATA(lt_term_header).


      DATA(lv_process) = VALUE #( lt_term_header[ 1 ]-process OPTIONAL ).

      DATA(lr_o_dpo_request) = NEW zcl_hr_dpo_request( ).
      lr_o_dpo_request->set_request( iv_dpo_request ).
      lr_o_dpo_request->get_authorization_structure( iv_dpo_request = iv_dpo_request iv_uname = lv_uname
                                            iv_dpo_process = lv_process ).

      SELECT SINGLE * FROM zhr_dpo_zad_act INTO @return
                    WHERE dpo_request = @lv_dpo_request
                      AND real_user   = @lv_uname
                      AND aedat       = @sy-datum.

    ENDIF.

    gs_active_zad = return.

  ENDMETHOD.


  method RUN_UNIPROCESS.

DATA:  lo_form            TYPE REF TO zcl_ca_uniframe,
         lo_form_request      TYPE REF TO zcl_hr_dpo_request,
         ls_key             TYPE zca_uf_key,
         lv_result          TYPE sysubrc,
         lv_attach_data     TYPE zca_uf_attach_data,
         ls_attach_ui       TYPE zca_uf_attachments_ui.

      ls_key-form_type = 'HR_DPO_REQ'.

      ls_key-form_id = me->gs_data_db-form_id.

      zcl_ca_uniframe=>get_instance(
          EXPORTING
            is_key = ls_key
            iv_operation = zif_ca_uniframe_consts=>co_control_operation_start_apr
            iv_process_mode = zif_ca_uniframe_consts=>co_control_proc_mode_new
          IMPORTING
            er_form = lo_form ).

      CHECK lo_form IS BOUND.
      lo_form_request ?= lo_form.

      lo_form_request->read_request(
        exporting
          iv_dpo_request      =  me->gs_data_db-dpo_request                " ID žádosti
          iv_read_tmp_request = abap_true                  " Nové vstup.hodnoty
*        receiving
*          rs_dpo_request      =                  " Struktura pro Žádosti
      )..
*      lo_form_request->MOVE_ATTACHMENTS_TO_UNI( ).
      lo_form_request->gt_approvers[] = me->gt_approvers[].
      lo_form_request->process( IMPORTING     ev_result = lv_result
                                             et_messages = gt_messages ).

       COMMIT WORK AND WAIT.

       lo_form_request->get_header( IMPORTING es_header_ui = DATA(ls_header_ui) ).
       gs_data_db-form_id = ls_header_ui-form_id.
       gs_data_db-line_id = ls_header_ui-line_id.

  endmethod.


  METHOD save_all_longtexts.

    gs_data_db-dpo_request = is_longtext-dpo_request.
    gs_data_db-werks_param  = is_longtext-werks_param.

    me->save_long_text(
      EXPORTING
        iv_text_type = 'OJ'
        iv_text      = is_longtext-long_text_oj
    ).

    me->save_long_text(
      EXPORTING
        iv_text_type = CONV #( zcl_hr_dpo_roles=>co_sp )
        iv_text      = is_longtext-long_text_sp
    ).


    me->save_long_text(
          EXPORTING
            iv_text_type = 'UN'                 " Komponenta čísla verze
            iv_text      = is_longtext-long_text_union
        ).

    UPDATE zhr_dpo_zad SET werks_param = is_longtext-werks_param
                       WHERE dpo_request = is_longtext-dpo_request.

    IF sy-subrc EQ 0.
      is_return-return_code = 'OK'.
    ELSE.
      is_return-return_code = 'FAIL'.
    ENDIF.

    is_return-dpo_request = is_longtext-dpo_request.

  ENDMETHOD.


  METHOD save_as_draft.
    save_as_draft_req( ).

  ENDMETHOD.


  METHOD save_as_draft_req.

     save_req(
        EXPORTING
*          iv_as_draft        = 'X'                  " Pole k zakřížkování
          iv_button_as_draft =  button_as_draft                " Pole k zakřížkování
     )

.
  ENDMETHOD.


  method SAVE_LONG_TEXT.

    data ls_header type thead.
    data lv_id type thead-tdid.
    data lv_name  type thead-tdname.
    data lv_object type thead-tdobject.
    data: lt_lines       type standard table of tline,
          lt_lines_check type standard table of tline.

    CASE iv_text_type.
      WHEN 'OJ'.
        ls_header-tdid =  lv_id = 'ZOJ'.
      WHEN zcl_hr_dpo_roles=>CO_SP.
         ls_header-tdid =  lv_id = 'ZSP'.

      WHEN 'UN'.
         ls_header-tdid =  lv_id = 'ZUN'.

    ENDCASE.


      ls_header-tdobject = lv_object =  'ZHR_DPO'.
      ls_header-tdspras = sy-langu.

    lv_name = gs_data_db-dpo_request .
    ls_header-tdname = gs_data_db-dpo_request.
    lt_lines[] = convert_string_to_text_table( iv_string = iv_text  ).
    DATA(lt_lines_save) = lt_lines[].

    call function 'READ_TEXT'
      exporting
*       CLIENT                  = SY-MANDT
        id                      = lv_id
        language                = sy-langu
        name                    = lv_name
        object                  = lv_object
      tables
        lines                   = lt_lines_check
      exceptions
        id                      = 1
        language                = 2
        name                    = 3
        not_found               = 4
        object                  = 5
        reference_check         = 6
        wrong_access_to_archive = 7
        others                  = 8.
    if sy-subrc <> 0.
      if lt_lines[] is not initial.
        call function 'CREATE_TEXT'
          exporting
            fid       = lv_id
            flanguage = sy-langu
            fname     = lv_name
            fobject   = lv_object
*           SAVE_DIRECT       = 'X'
*           FFORMAT   = '*'
          tables
            flines    = lt_lines
          exceptions
            no_init   = 1
            no_save   = 2
            others    = 3.

        COMMIT WORK AND WAIT.

         call function 'SAVE_TEXT'
        exporting
*         CLIENT   = SY-MANDT
          header   = ls_header
*         INSERT   = ' '
        tables
          lines    = lt_lines_save
        exceptions
          id       = 1
          language = 2
          name     = 3
          object   = 4
          others   = 5.

      endif.

    else.
      IF lt_lines_check[] NE lt_lines[].
        me->update_change_sign( 'X' ).
      ENDIF.


      call function 'SAVE_TEXT'
        exporting
*         CLIENT   = SY-MANDT
          header   = ls_header
*         INSERT   = ' '
        tables
          lines    = lt_lines
        exceptions
          id       = 1
          language = 2
          name     = 3
          object   = 4
          others   = 5.

    endif.

  COMMIT WORK.

  endmethod.


  METHOD save_req.

    DATA: ls_dpo_zad     TYPE zhr_dpo_zad,
          ls_dpo_hist    TYPE zhr_dpo_hist,
          lv_guid        TYPE  guid_32,
          lt_message     TYPE STANDARD TABLE OF  bapiret2,
          lt_lines       TYPE STANDARD TABLE OF tline,
          lt_lines_dummy TYPE STANDARD TABLE OF tline,
          lt_lines_check TYPE STANDARD TABLE OF tline,
          lv_year        TYPE inri-toyear.
    DATA  lv_id TYPE thead-tdid.
    DATA: lv_dpo_request TYPE zhr_dpo_request.
    DATA  lv_name  TYPE thead-tdname.
    DATA  lv_dpo_id_ext TYPE zhr_dpo_request.
    DATA  lv_object TYPE thead-tdobject.
    DATA: ls_header TYPE thead.
    DATA: ls_termzad   TYPE zhr_dpo_termzad.

    me->read_customizing( ).

    IF gs_data_db-dpo_year IS INITIAL.
      ls_dpo_zad-dpo_year = sy-datum(4).
      ls_dpo_zad-request_date = sy-datum.
    ELSE.
      ls_dpo_zad-dpo_year     = gs_data_db-dpo_year.
      ls_dpo_zad-request_date = gs_data_db-request_date.
    ENDIF.
    IF iv_button_as_draft IS NOT INITIAL.
      ls_dpo_zad-button_as_draft =  iv_button_as_draft.
    ELSE.
      ls_dpo_zad-button_as_draft = gs_data_db-button_as_draft.
    ENDIF.
    ls_dpo_zad-dpo_req_full  =  gs_data_db-dpo_req_full.
    ls_dpo_zad-dpo_request   = gs_data_db-dpo_request.
    ls_dpo_zad-status        = gs_data_db-status.
    ls_dpo_zad-approval_type = gs_data_db-approval_type.
    READ TABLE gt_custom_template ASSIGNING FIELD-SYMBOL(<fs_templ>)
                                  WITH KEY template_code =  gs_data_db-template_code.
    IF sy-subrc EQ 0.
      ls_dpo_zad-dpo_type =  gs_data_db-dpo_type = gs_data_db-process = <fs_templ>-process.

      IF  iv_button_as_draft IS NOT INITIAL AND gs_data_db-dpo_req_full IS INITIAL.
        lv_year = sy-datum(4).
        CALL FUNCTION 'NUMBER_GET_NEXT'
          EXPORTING
            nr_range_nr             = '01'
            object                  = 'ZHR_DPO_RY'
            toyear                  = lv_year
            ignore_buffer           = abap_true
          IMPORTING
            number                  = lv_dpo_id_ext
*           QUANTITY                =
*           RETURNCODE              =
          EXCEPTIONS
            interval_not_found      = 1
            number_range_not_intern = 2
            object_not_found        = 3
            quantity_is_0           = 4
            quantity_is_not_1       = 5
            interval_overflow       = 6
            buffer_overflow         = 7
            OTHERS                  = 8.

        DATA(ls_conv) = VALUE zhr_dpo_zadconv( dpo_request = lv_dpo_id_ext
                                               dpo_year = ls_dpo_zad-dpo_year
                                               dpo_type = ls_dpo_zad-dpo_type
                                               direction = 'O' ).
        convert_request(
          CHANGING
            chs_request = ls_conv  ).               " Konverze čísla žádosti

        gs_data_db-dpo_req_full =  ls_conv-dpo_req_full.
      ELSEIF gs_data_db-dpo_req_full IS NOT INITIAL.
        ls_conv = VALUE zhr_dpo_zadconv( dpo_req_full = gs_data_db-dpo_req_full
                                               direction = 'I' ).
        convert_request(
         CHANGING
           chs_request = ls_conv  ).
        IF ls_conv-dpo_type NE gs_data_db-dpo_type.
          ls_conv-direction = 'O'.
          ls_conv-dpo_type = gs_data_db-dpo_type.
          convert_request(
       CHANGING
         chs_request = ls_conv    ).

          gs_data_db-dpo_req_full =  ls_conv-dpo_req_full.       "
        ENDIF.
      ENDIF.



    ENDIF.

    ls_dpo_zad-dpo_req_full = gs_data_db-dpo_req_full .
    ls_dpo_zad-notif_status = gs_data_db-notif_status.
    ls_dpo_zad-orgeh = gs_data_db-orgeh.
    ls_dpo_zad-orgeh_orig = gs_data_db-orgeh_orig.


    ls_dpo_zad-template_code = gs_data_db-template_code.
    ls_dpo_zad-name = ls_dpo_zad-name_caps =  gs_data_db-name.
    TRANSLATE ls_dpo_zad-name_caps TO UPPER CASE.

    ls_dpo_zad-requestor = gs_data_db-creator.
    ls_dpo_zad-send_date = gs_data_db-send_date.
    ls_dpo_zad-term_id = SWITCH #( ls_dpo_zad-dpo_type WHEN 'D-DOHODA' THEN '0000000000'
                                                       ELSE gs_data_db-term_id ).

    IF gs_data_db-term_id IS NOT INITIAL.
      SELECT SINGLE term_id FROM zhr_dpo_zad
        INTO @DATA(lv_term_id)
        WHERE dpo_request = @gs_data_db-dpo_request.

      IF lv_term_id NE gs_data_db-term_id.

          DELETE FROM zhr_dpo_termzad
                                WHERE dpo_request = gs_data_db-dpo_request
                                     AND term_id  = lv_term_id.

      ENDIF.
      SELECT COUNT( * ) FROM zhr_dpo_termzad
                        WHERE term_id = gs_data_db-term_id
                          AND dpo_request = gs_data_db-dpo_request.
      IF sy-subrc NE 0.
        ls_termzad-term_id = gs_data_db-term_id.
        ls_termzad-dpo_request = gs_data_db-dpo_request.
        INSERT zhr_dpo_termzad FROM ls_termzad.
      ENDIF.
    ENDIF.

    ls_dpo_zad-changes = gs_data_db-changes.
    ls_dpo_hist-dpo_request = ls_dpo_zad-dpo_request.
    ls_dpo_hist-dpo_step = gs_data_db-dpo_step.
*    ls_dpo_hist-uname       = zcl_pe_all_change_user=>get_uname( iv_appl_id = 'ZHR_DPO_REQUEST' ).
     ls_dpo_hist-uname      = sy-uname.
    ls_dpo_hist-datum       = sy-datum.
    ls_dpo_hist-time        = sy-uzeit.
    ls_dpo_hist-role        = gs_data_db-role.
    ls_dpo_hist-next_status = gs_data_db-status.
    ls_dpo_hist-clarification = gs_data_db-clarification.
    ls_dpo_hist-orig_user = SWITCH #( gs_data_db-orig_user WHEN '' THEN  gs_data_db-creator
                                                           ELSE gs_data_db-orig_user ).

    IF gs_data_db-form_id IS INITIAL.
      lv_guid = cl_system_uuid=>create_uuid_c32_static( ).
      ls_dpo_hist-form_id =  gs_data_db-form_id = lv_guid.
    ELSE.
      ls_dpo_hist-form_id =  gs_data_db-form_id .
      ls_dpo_hist-line_id =  gs_data_db-line_id.
    ENDIF.
    SELECT COUNT( * ) FROM zhr_dpo_ukoly
                      WHERE status = 'N'
                        AND dpo_request = ls_dpo_zad-dpo_request.
    IF sy-subrc EQ 0.
      ls_dpo_zad-tasks_unfinished = abap_true.
    ELSE.
      ls_dpo_zad-tasks_unfinished = abap_false.
    ENDIF.

    ls_header-tdid = 'ZOJ'.

    ls_header-tdobject = 'ZHR_DPO'.
    ls_header-tdspras = sy-langu.
    lv_id = 'ZOJ'.
    lv_object = 'ZHR_DPO'.



    SELECT COUNT( * ) FROM zhr_dpo_rozdel
                      WHERE dpo_request = gs_data_db-dpo_request
                        AND uname EQ gs_data_db-creator .
    IF sy-subrc NE 0 .
      create_approval_fork(
     EXPORTING
       iv_dpo_request =  gs_data_db-dpo_request                " ID žádosti
       iv_uname       =  gs_data_db-creator                     " Jméno uživatele
      IMPORTING
        et_message     = lt_message                 " Návratová tabulka
   ).
    ENDIF.

    LOOP AT gt_rozdel ASSIGNING FIELD-SYMBOL(<fs_rozdel>).
      <fs_rozdel>-before_save = iv_as_draft.
      IF <fs_rozdel>-role = gs_data_db-role  AND <fs_rozdel>-pernr = gs_data_db-rozdel_apr_pernr.

        <fs_rozdel>-approved = gs_data_db-approved.
      ENDIF.
      IF <fs_rozdel>-role = zcl_hr_dpo_roles=>co_consult AND <fs_rozdel>-send IS INITIAL
      AND gs_data_db-dpo_req_full IS NOT INITIAL.
        IF gs_data_db-orig_user  IS  INITIAL.
          gs_data_db-orig_user = gs_data_db-creator.
        ENDIF.
        CASE gs_data_db-dpo_type.
          WHEN 'P-CENTR'.
            me->send_mail_to_consultant( 'ZAD_MAIL_TO_CONS_C' ).
          WHEN 'D-DOHODA'.
            me->send_mail_to_consultant( 'ZAD_MAIL_TO_CONS_A' ).
          WHEN OTHERS.
        ENDCASE.

        <fs_rozdel>-send = abap_true.
      ENDIF.
    ENDLOOP.

    IF iv_as_draft EQ abap_true.
      ls_dpo_zad-before_save = abap_true.
      ls_dpo_hist-before_save = abap_true.

    ELSE.
      CLEAR:
      ls_dpo_zad-before_save,
      ls_dpo_hist-before_save.
    ENDIF.



    MODIFY zhr_dpo_zad FROM ls_dpo_zad.
    MODIFY zhr_dpo_rozdel FROM TABLE gt_rozdel.

*    SELECT COUNT( * ) FROM zhr_dpo_hist
*                      WHERE dpo_request = ls_dpo_hist-dpo_request
*                        AND dpo_step    = ls_dpo_hist-dpo_step
*                        AND before_save = ls_dpo_hist-before_save.
*    IF sy-subrc NE 0.
*     IF  gs_data_db-dpo_req_full IS NOT INITIAL.
    INSERT zhr_dpo_hist FROM ls_dpo_hist.
    IF ls_dpo_hist-dpo_step = '01' AND ls_dpo_zad-term_id IS NOT INITIAL.
      me->update_term_in_history(
        i_term_id      = ls_dpo_zad-term_id                 " ID DPO termínu
        iv_dpo_request = ls_dpo_zad-dpo_request
        is_hist        = ls_dpo_hist                " ID žádosti
        i_old_term_id  = 0                  " ID DPO termínu
      ).
    ENDIF.
*     ENDIF.
*    ENDIF.

    lv_name = gs_data_db-dpo_request && iv_as_draft.
    ls_header-tdname = gs_data_db-dpo_request && iv_as_draft.
    lt_lines[] = convert_string_to_text_table( iv_string = gs_data_db-text  ).

    CALL FUNCTION 'READ_TEXT'
      EXPORTING
*       CLIENT                  = SY-MANDT
        id                      = lv_id
        language                = sy-langu
        name                    = lv_name
        object                  = lv_object
      TABLES
        lines                   = lt_lines_check
      EXCEPTIONS
        id                      = 1
        language                = 2
        name                    = 3
        not_found               = 4
        object                  = 5
        reference_check         = 6
        wrong_access_to_archive = 7
        OTHERS                  = 8.
    IF sy-subrc <> 0.
      IF lt_lines[] IS NOT INITIAL.
        lt_lines_dummy = CORRESPONDING #( lt_lines ).
        CALL FUNCTION 'CREATE_TEXT'
          EXPORTING
            fid       = lv_id
            flanguage = sy-langu
            fname     = lv_name
            fobject   = lv_object
*           SAVE_DIRECT       = 'X'
            fformat   = '/'
          TABLES
            flines    = lt_lines_dummy
          EXCEPTIONS
            no_init   = 1
            no_save   = 2
            OTHERS    = 3.
      ENDIF.
    ENDIF.



    CALL FUNCTION 'SAVE_TEXT'
      EXPORTING
*       CLIENT   = SY-MANDT
        header   = ls_header
*       INSERT   = ' '
      TABLES
        lines    = lt_lines
      EXCEPTIONS
        id       = 1
        language = 2
        name     = 3
        object   = 4
        OTHERS   = 5.
    IF sy-subrc <> 0.
    ENDIF.

    IF iv_as_draft IS  INITIAL.
* Temporary záznam mažeme.
      DELETE FROM zhr_dpo_zad  WHERE dpo_request = gs_data_db-dpo_request
                                 AND before_save = abap_true.
      DELETE FROM zhr_dpo_hist WHERE dpo_request = gs_data_db-dpo_request
                                 AND before_save = abap_true.
      DELETE FROM zhr_dpo_rozdel WHERE dpo_request = gs_data_db-dpo_request
                                  AND before_save = abap_true.
      lv_name = gs_data_db-dpo_request && abap_true.
      REFRESH lt_lines_check.
      CALL FUNCTION 'READ_TEXT'
        EXPORTING
*         CLIENT                  = SY-MANDT
          id                      = lv_id
          language                = sy-langu
          name                    = lv_name
          object                  = lv_object
        TABLES
          lines                   = lt_lines_check
        EXCEPTIONS
          id                      = 1
          language                = 2
          name                    = 3
          not_found               = 4
          object                  = 5
          reference_check         = 6
          wrong_access_to_archive = 7
          OTHERS                  = 8.
      IF lt_lines_check[] IS NOT INITIAL.
        CALL FUNCTION 'DELETE_TEXT'
          EXPORTING
*           CLIENT   = SY-MANDT
            id       = lv_id
            language = sy-langu
            name     = lv_name
            object   = lv_object
*           SAVEMODE_DIRECT       = ' '
*           TEXTMEMORY_ONLY       = ' '
*           LOCAL_CAT             = ' '
**         EXCEPTIONS
**           NOT_FOUND             = 1
**           OTHERS                = 2
          .
        IF sy-subrc <> 0.
* Implement suitable error handling here
        ENDIF.
      ENDIF.


    ENDIF.



    COMMIT WORK AND WAIT.



  ENDMETHOD.


  METHOD send_mail_hrbp_returns.
    DATA: lc_separator TYPE c VALUE ';'.

    DATA: lo_employee TYPE REF TO zcl_pe_all_employee.

    DATA: lv_subject    TYPE so_obj_des,
          lv_sender     TYPE xubname,
          lt_email_body TYPE soli_tab,
          ls_email_line TYPE soli,
          lv_userid     TYPE uname,
          lv_email      TYPE soos1-recextnam,
          lt_lnk_params TYPE zpe_all_tt_lnk_params,
          ls_lnk_params TYPE zpe_all_lnk_params,
          ls_thead      TYPE thead..

    DATA:
      lt_list_email TYPE STANDARD TABLE OF zibwa_smtp,
      ls_list_email TYPE zibwa_smtp.

    SELECT SINGLE value FROM zhr_dpo_cparam INTO ls_thead-tdname
                             WHERE parameter_dpo = 'ZAD_MAIL_SP_RET'.
    IF sy-subrc EQ  0.

      ls_thead-tdid = 'ST'.
      ls_thead-tdspras = sy-langu.
      ls_thead-tdobject = 'TEXT'.
      DATA(lv_text) = read_text( EXPORTING  is_head    = ls_thead ).
      DATA(lt_body) = convert_string_to_text_table( iv_string = lv_text ).

    ENDIF.

    lv_subject = TEXT-t12.

    DATA(lv_pernr) = zcl_pa_vs_utils=>get_pernr_by_uname( iv_uname = gs_data_db-orig_user ).

    LOOP AT gt_rozdel ASSIGNING FIELD-SYMBOL(<fs_rozdel>) WHERE role CS zcl_hr_dpo_roles=>co_hrbp
                                                            OR  role CS zcl_hr_dpo_roles=>co_requestor.

      IF <fs_rozdel>-pernr IS NOT INITIAL AND <fs_rozdel>-pernr NE lv_pernr."HRBP co vraci zadost mail neodstane
        DATA(ls_user_data) = zcl_hr_dpo_roles=>get_pernr_details( iv_pernr = <fs_rozdel>-pernr  ).
        ls_list_email-email = ls_user_data-email.
        IF ls_list_email-email IS NOT INITIAL.
          APPEND ls_list_email TO lt_list_email.
        ENDIF.
        CLEAR: ls_user_data.
      ENDIF.
    ENDLOOP.



* Pripravime telo notifikacni zpravy
    IF ( ( sy-sysid EQ 'SK2' ) OR ( sy-sysid EQ 'SK4' ) ).
      CONCATENATE sy-sysid 'TEST:' lv_subject INTO lv_subject SEPARATED BY space.
    ELSE.
      lv_subject = lv_subject.
    ENDIF.

    ls_lnk_params-value = gs_data_db-dpo_request.
    APPEND ls_lnk_params TO lt_lnk_params.
    SELECT SINGLE value FROM zhr_dpo_cparam INTO lv_sender
                      WHERE parameter_dpo = 'ZHR_MAIL_SENDER_USER'.
    IF sy-subrc NE 0.
      lv_sender = sy-uname.
    ENDIF.

    IF lt_body[] IS NOT INITIAL.
      LOOP AT lt_body ASSIGNING FIELD-SYMBOL(<fs_body>).
        IF <fs_body> CS '$ZADOST$'.
          REPLACE FIRST OCCURRENCE OF '$ZADOST$' IN <fs_body> WITH gs_data_db-dpo_req_full.
        ENDIF.
        IF <fs_body> CS '$APPL$'.
          DATA lt_lnk  TYPE zpe_all_tt_lnk_params.
          DATA(ls_line) = CONV SO_TEXT255( zcl_hr_dpo_lnk_generator=>generate_application_link( iv_id_application = 'ZHR_DPO_REQUEST'
                                                         it_parameters = lt_lnk   ) ).
          REPLACE FIRST OCCURRENCE OF 'detail/' IN ls_line WITH ''.
          ls_email_line-line = <fs_body>-tdline.
          REPLACE FIRST OCCURRENCE OF '$APPL$' IN ls_email_line-line WITH | <a href="{ ls_line }" >Projednání s odbory</a>|.
          APPEND ls_email_line TO lt_email_body.
          CONTINUE.
        ENDIF.
        IF <fs_body> CS '$LINK$'.
          ls_email_line-line = zcl_hr_dpo_lnk_generator=>generate_application_link( iv_id_application = 'ZHR_DPO_REQUEST'
                                                              it_parameters = lt_lnk_params ).
          ls_email_line-line = ls_email_line-line && '/U0VMRg=='.
          ls_email_line-line = |<a href="{ ls_email_line-line }" >Odkaz na konkrétní žádost</a>|.
          APPEND ls_email_line TO lt_email_body.
          CONTINUE.
        ENDIF.

        ls_email_line = <fs_body>-tdline.
        APPEND ls_email_line TO lt_email_body.
      ENDLOOP.
    ENDIF.
    IF lt_list_email[] IS INITIAL.
      EXIT. " Seznam spravcu neni zadan, nic nebudeme odesilat
    ENDIF.

* Samotne odeslani notifikacni zpravy
    IF lt_list_email IS NOT INITIAL.
      CALL FUNCTION 'Z_HR_DPO_MAIL'
        EXPORTING
          i_subject = lv_subject
          x_commit  = 'X'
          i_sender  = lv_sender
        TABLES
          t_email   = lt_list_email
          t_content = lt_email_body
        EXCEPTIONS
          error     = 1
*         OTHERS    = 2
        .
      IF sy-subrc IS INITIAL.
        rv_return = abap_true.
      ENDIF.
    ENDIF.


  ENDMETHOD.


  METHOD send_mail_sp_returns.
    DATA: lc_separator TYPE c VALUE ';'.

    DATA: lo_employee TYPE REF TO zcl_pe_all_employee.

    DATA: lv_subject    TYPE so_obj_des,
          lv_sender     TYPE xubname,
          lt_email_body TYPE soli_tab,
          ls_email_line TYPE soli,
          lv_userid     TYPE uname,
          lv_parameter  TYPE char30,
          lv_email      TYPE soos1-recextnam,
          lt_lnk_params TYPE zpe_all_tt_lnk_params,
          ls_lnk_params TYPE zpe_all_lnk_params,
          ls_thead      TYPE thead..

    DATA:
      lt_list_email TYPE STANDARD TABLE OF zibwa_smtp,
      ls_list_email TYPE zibwa_smtp.

    CASE gs_data_db-dpo_type.
      WHEN 'P-CENTR'.
        lv_parameter = 'ZAD_MAIL_SP_RET'.
      WHEN OTHERS.
        lv_parameter = 'ZAD_MAIL_SP_RET_A'.
    ENDCASE.

    SELECT SINGLE value FROM zhr_dpo_cparam INTO ls_thead-tdname
                             WHERE parameter_dpo = lv_parameter.
    IF sy-subrc EQ  0.

      ls_thead-tdid = 'ST'.
      ls_thead-tdspras = sy-langu.
      ls_thead-tdobject = 'TEXT'.
      DATA(lv_text) = read_text( EXPORTING  is_head    = ls_thead ).
      DATA(lt_body) = convert_string_to_text_table( iv_string = lv_text ).

    ENDIF.

    lv_subject = TEXT-t12.


    LOOP AT gt_rozdel ASSIGNING FIELD-SYMBOL(<fs_rozdel>) WHERE role CS zcl_hr_dpo_roles=>co_hrbp
                                                            OR  role CS zcl_hr_dpo_roles=>co_requestor.

      IF <fs_rozdel>-role CS zcl_hr_dpo_roles=>co_hrbp AND gs_data_db-dpo_type NE 'P-CENTR'."mail na HRBP len v centralnom inak preskoc
        CONTINUE.
      ENDIF.

      IF <fs_rozdel>-pernr IS NOT INITIAL.
        DATA(ls_user_data) = zcl_hr_dpo_roles=>get_pernr_details( iv_pernr = <fs_rozdel>-pernr  ).
        ls_list_email-email = ls_user_data-email.
        IF ls_list_email-email IS NOT INITIAL.
          APPEND ls_list_email TO lt_list_email.
        ENDIF.
        CLEAR: ls_user_data.
      ENDIF.
    ENDLOOP.



* Pripravime telo notifikacni zpravy
    IF ( ( sy-sysid EQ 'SK2' ) OR ( sy-sysid EQ 'SK4' ) ).
      CONCATENATE sy-sysid 'TEST:' lv_subject INTO lv_subject SEPARATED BY space.
    ELSE.
      lv_subject = lv_subject.
    ENDIF.

    ls_lnk_params-value = gs_data_db-dpo_request.
    APPEND ls_lnk_params TO lt_lnk_params.
    lv_sender = sy-uname.

    IF lt_body[] IS NOT INITIAL.
      LOOP AT lt_body ASSIGNING FIELD-SYMBOL(<fs_body>).
        IF <fs_body> CS '$ZADOST$'.
          REPLACE FIRST OCCURRENCE OF '$ZADOST$' IN <fs_body> WITH gs_data_db-dpo_req_full.
        ENDIF.
        IF <fs_body> CS '$APPL$'.
          DATA lt_lnk  TYPE zpe_all_tt_lnk_params.
          DATA(ls_line) = CONV SO_TEXT255( zcl_hr_dpo_lnk_generator=>generate_application_link( iv_id_application = 'ZHR_DPO_REQUEST'
                                                         it_parameters = lt_lnk   ) ).
          REPLACE FIRST OCCURRENCE OF 'detail/' IN ls_line WITH ''.
          ls_email_line-line = <fs_body>-tdline.
          REPLACE FIRST OCCURRENCE OF '$APPL$' IN ls_email_line-line WITH | <a href="{ ls_line }" >Projednání s odbory</a>|.
          APPEND ls_email_line TO lt_email_body.
          CONTINUE.
        ENDIF.
        IF <fs_body> CS '$LINK$'.
          ls_email_line-line = zcl_hr_dpo_lnk_generator=>generate_application_link( iv_id_application = 'ZHR_DPO_REQUEST'
                                                              it_parameters = lt_lnk_params ).
          ls_email_line-line = ls_email_line-line && '/U0VMRg=='.
          ls_email_line-line = |<a href="{ ls_email_line-line }" >Odkaz na konkrétní žádost</a>|.
          APPEND ls_email_line TO lt_email_body.
          CONTINUE.
        ENDIF.

        ls_email_line = <fs_body>-tdline.
        APPEND ls_email_line TO lt_email_body.
      ENDLOOP.
    ENDIF.
    IF lt_list_email[] IS INITIAL.
      EXIT. " Seznam spravcu neni zadan, nic nebudeme odesilat
    ENDIF.

* Samotne odeslani notifikacni zpravy
    IF lt_list_email IS NOT INITIAL.
      CALL FUNCTION 'Z_HR_DPO_MAIL'
        EXPORTING
          i_subject = lv_subject
          x_commit  = 'X'
          i_sender  = lv_sender
        TABLES
          t_email   = lt_list_email
          t_content = lt_email_body
        EXCEPTIONS
          error     = 1
*         OTHERS    = 2
        .
      IF sy-subrc IS INITIAL.
        rv_return = abap_true.
      ENDIF.
    ENDIF.


  ENDMETHOD.


  METHOD send_mail_to_consultant.
    DATA: lc_separator TYPE c VALUE ';'.

    DATA: lo_employee TYPE REF TO zcl_pe_all_employee.

    DATA: lv_subject    TYPE so_obj_des,
          lv_sender     TYPE xubname,
          lt_email_body TYPE soli_tab,
          ls_email_line TYPE soli,
          lv_userid     TYPE uname,
          lv_email      TYPE soos1-recextnam,
          lt_lnk_params TYPE zpe_all_tt_lnk_params,
          lt_lnk        TYPE zpe_all_tt_lnk_params,
          ls_lnk_params TYPE zpe_all_lnk_params,
          ls_thead      TYPE thead.

    DATA:
      lt_list_email TYPE STANDARD TABLE OF zibwa_smtp,
      ls_list_email TYPE zibwa_smtp.


    SELECT SINGLE value FROM zhr_dpo_cparam INTO ls_thead-tdname
                             WHERE parameter_dpo = iv_so10_text_name.
    IF sy-subrc EQ  0.

      ls_thead-tdid = 'ST'.
      ls_thead-tdspras = sy-langu.
      ls_thead-tdobject = 'TEXT'.
      DATA(lv_text) = read_text( EXPORTING  is_head    = ls_thead ).
      DATA(lt_body) = convert_string_to_text_table( iv_string = lv_text ).

    ENDIF.

    lv_subject = TEXT-t13.


    LOOP AT gt_rozdel ASSIGNING FIELD-SYMBOL(<fs_rozdel>) WHERE role CS zcl_hr_dpo_roles=>co_consult
                                                            AND send EQ ''.

      IF <fs_rozdel>-pernr IS NOT INITIAL.
        DATA(ls_user_data) = zcl_hr_dpo_roles=>get_pernr_details( iv_pernr = <fs_rozdel>-pernr  ).
        ls_list_email-email = ls_user_data-email.
        IF ls_list_email-email IS NOT INITIAL.
          APPEND ls_list_email TO lt_list_email.
        ENDIF.
        CLEAR: ls_user_data.
      ENDIF.
    ENDLOOP.



* Pripravime telo notifikacni zpravy
    IF ( ( sy-sysid EQ 'SK2' ) OR ( sy-sysid EQ 'SK4' ) ).
      CONCATENATE sy-sysid 'TEST:' lv_subject INTO lv_subject SEPARATED BY space.
    ELSE.
      lv_subject = lv_subject.
    ENDIF.

    ls_lnk_params-value = gs_data_db-dpo_request.
    APPEND ls_lnk_params TO lt_lnk_params.
    SELECT SINGLE value FROM zhr_dpo_cparam INTO lv_sender
                       WHERE parameter_dpo = 'ZHR_MAIL_SENDER_USER'.
    IF sy-subrc NE 0.
      lv_sender = sy-uname.
    ENDIF.

    IF lt_body[] IS NOT INITIAL.
      LOOP AT lt_body ASSIGNING FIELD-SYMBOL(<fs_body>).
        IF <fs_body> CS '$ZADOST$'.
          REPLACE FIRST OCCURRENCE OF '$ZADOST$' IN <fs_body> WITH gs_data_db-dpo_req_full.
        ENDIF.
        IF <fs_body> CS '$CELE_JMENO$'.
          ls_email_line = <fs_body>-tdline.
          REPLACE FIRST OCCURRENCE OF '$CELE_JMENO$' IN ls_email_line  WITH get_full_name( ).
          APPEND ls_email_line TO lt_email_body.
          CONTINUE.
        ENDIF.
        IF <fs_body> CS '$APPL$'.
          DATA(ls_line) = CONV SO_TEXT255( zcl_hr_dpo_lnk_generator=>generate_application_link( iv_id_application = 'ZHR_DPO_REQUEST'
                                                         it_parameters = lt_lnk   ) ).
          REPLACE FIRST OCCURRENCE OF 'detail/' IN ls_line WITH ''.
          ls_email_line-line = <fs_body>-tdline.
          REPLACE FIRST OCCURRENCE OF '$APPL$' IN ls_email_line-line WITH | <a href="{ ls_line }" >Projednání s odbory</a>|.
          APPEND ls_email_line TO lt_email_body.
          CONTINUE.
        ENDIF.
        IF <fs_body> CS '$LINK$'.
          ls_email_line-line = zcl_hr_dpo_lnk_generator=>generate_application_link( iv_id_application = 'ZHR_DPO_REQUEST'
                                                              it_parameters = lt_lnk_params ).
          ls_email_line-line = ls_email_line-line && '/U0VMRg=='.
          ls_email_line-line = |<a href="{ ls_email_line-line }" >Odkaz na konkrétní žádost</a>|.
          APPEND ls_email_line TO lt_email_body.
          CONTINUE.
        ENDIF.

        ls_email_line = <fs_body>-tdline.
        APPEND ls_email_line TO lt_email_body.
      ENDLOOP.
    ENDIF.
    IF lt_list_email[] IS INITIAL.
      EXIT. " Seznam spravcu neni zadan, nic nebudeme odesilat
    ENDIF.

* Samotne odeslani notifikacni zpravy
    IF lt_list_email IS NOT INITIAL.
      CALL FUNCTION 'Z_HR_DPO_MAIL'
        EXPORTING
          i_subject = lv_subject
          x_commit  = 'X'
          i_sender  = lv_sender
        TABLES
          t_email   = lt_list_email
          t_content = lt_email_body
        EXCEPTIONS
          error     = 1
*         OTHERS    = 2
        .
      IF sy-subrc IS INITIAL.
        rv_return = abap_true.
      ENDIF.
    ENDIF.
  ENDMETHOD.


  METHOD send_mail_to_hrbp.

    DATA: lc_separator TYPE c VALUE ';'.

    DATA: lo_employee TYPE REF TO zcl_pe_all_employee.

    DATA: lv_subject    TYPE so_obj_des,
          lv_sender     TYPE xubname,
          lt_email_body TYPE soli_tab,
          ls_email_line TYPE soli,
          lv_userid     TYPE uname,
          lv_email      TYPE soos1-recextnam,
          lt_lnk_params TYPE zpe_all_tt_lnk_params,
          ls_lnk_params TYPE zpe_all_lnk_params,
          ls_thead      TYPE thead..

    DATA:
      lt_list_email TYPE STANDARD TABLE OF zibwa_smtp,
      ls_list_email TYPE zibwa_smtp.

    SELECT SINGLE value FROM zhr_dpo_cparam INTO ls_thead-tdname
                             WHERE parameter_dpo = 'DOH_MAIL_HRBP'.
    IF sy-subrc EQ  0.

      ls_thead-tdid = 'ST'.
      ls_thead-tdspras = sy-langu.
      ls_thead-tdobject = 'TEXT'.
      DATA(lv_text) = read_text( EXPORTING  is_head    = ls_thead ).
      DATA(lt_body) = convert_string_to_text_table( iv_string = lv_text ).

    ENDIF.

    lv_subject = TEXT-t01.

*    DATA(lt_fork) = me->show_approval_fork( iv_dpo_request =  gs_data_db-dpo_request iv_only_next_approvers = '' ).
    SELECT hrbp FROM zhr_dpo_bp INTO TABLE @DATA(lt_hrbp) WHERE hrbp NE ''.
    IF sy-subrc EQ 0.
      LOOP AT lt_hrbp ASSIGNING FIELD-SYMBOL(<fs_hrbp>).
        DATA(lv_pernr) = zcl_pa_vs_utils=>get_pernr_by_uname( iv_uname = <fs_hrbp>-hrbp ).
        IF lv_pernr IS NOT INITIAL.
          DATA(ls_user_data) = zcl_hr_dpo_roles=>get_pernr_details( iv_pernr = lv_pernr  ).
          ls_list_email-email = ls_user_data-email.
          APPEND ls_list_email TO lt_list_email.
          CLEAR: ls_user_data, lv_pernr.
        ENDIF.
      ENDLOOP.
    ENDIF.


* Pripravime telo notifikacni zpravy
    IF ( ( sy-sysid EQ 'SK2' ) OR ( sy-sysid EQ 'SK4' ) ).
      CONCATENATE sy-sysid 'TEST:' lv_subject INTO lv_subject SEPARATED BY space.
    ELSE.
      lv_subject = lv_subject.
    ENDIF.

    ls_lnk_params-value = gs_data_db-dpo_request.
    APPEND ls_lnk_params TO lt_lnk_params.

    IF lt_body[] IS NOT INITIAL.
      LOOP AT lt_body ASSIGNING FIELD-SYMBOL(<fs_body>).
        IF <fs_body> CS '$DOHODA$'.
          REPLACE FIRST OCCURRENCE OF '$DOHODA$' IN <fs_body> WITH gs_data_db-dpo_req_full.
        ENDIF.
        IF <fs_body> CS '$TEMA$'.
          REPLACE FIRST OCCURRENCE OF '$TEMA$' IN <fs_body> WITH gs_data_db-theme_long.
        ENDIF.
        IF <fs_body> CS '$NAZEV$'.
          REPLACE FIRST OCCURRENCE OF '$NAZEV$' IN <fs_body> WITH gs_data_db-name.
        ENDIF.
       IF <fs_body> CS '$APPL$'.
          DATA lt_lnk  TYPE zpe_all_tt_lnk_params.
          DATA(ls_line) = CONV SO_TEXT255( zcl_hr_dpo_lnk_generator=>generate_application_link( iv_id_application = 'ZHR_DPO_REQUEST'
                                                         it_parameters = lt_lnk   ) ).
          REPLACE FIRST OCCURRENCE OF 'detail/' IN ls_line WITH ''.
          ls_email_line-line = <fs_body>-tdline.
          REPLACE FIRST OCCURRENCE OF '$APPL$' IN ls_email_line-line WITH | <a href="{ ls_line }" >Projednání s odbory</a>|.
          APPEND ls_email_line TO lt_email_body.
          CONTINUE.
        ENDIF.
        IF <fs_body> CS '$LINK$'.
          ls_email_line-line = zcl_hr_dpo_lnk_generator=>generate_application_link( iv_id_application = 'ZHR_DPO_REQUEST'
                                                              it_parameters = lt_lnk_params ).
          ls_email_line-line = ls_email_line-line && '/U0VMRg=='.
          ls_email_line-line = |<a href="{ ls_email_line-line }" >Odkaz na konkrétní žádost</a>|.
          APPEND ls_email_line TO lt_email_body.
          CONTINUE.
        ENDIF.

        ls_email_line = <fs_body>-tdline.
        APPEND ls_email_line TO lt_email_body.
      ENDLOOP.
    ELSE.
      SELECT SINGLE value FROM zhr_dpo_cparam INTO lv_sender
                      WHERE parameter_dpo = 'ZHR_MAIL_SENDER_USER'.
      IF sy-subrc NE 0.
        lv_sender = sy-uname.
      ENDIF.



      IF lt_email_body[] IS INITIAL.
        ls_email_line = TEXT-t02.
        APPEND ls_email_line TO lt_email_body.
        ls_email_line = TEXT-t03.
        APPEND ls_email_line TO lt_email_body.
        CONCATENATE TEXT-t04 '  ' gs_data_db-dpo_req_full INTO ls_email_line SEPARATED BY space.
        APPEND ls_email_line TO lt_email_body.
        CONCATENATE TEXT-t05 '          ' gs_data_db-theme_long INTO ls_email_line SEPARATED BY space.
        APPEND ls_email_line TO lt_email_body.
        CONCATENATE TEXT-t06 gs_data_db-name INTO ls_email_line SEPARATED BY space.
        APPEND ls_email_line TO lt_email_body.
        ls_email_line = TEXT-t07.
        APPEND ls_email_line TO lt_email_body.
        ls_email_line = zcl_hr_dpo_lnk_generator=>generate_application_link( iv_id_application = 'ZHR_DPO_REQUEST'
                                                                  it_parameters = lt_lnk_params ).
        APPEND ls_email_line TO lt_email_body.
        CLEAR ls_email_line.
        APPEND ls_email_line TO lt_email_body.
        ls_email_line = TEXT-t08.
        APPEND ls_email_line TO lt_email_body.
        ls_email_line = TEXT-t09.
        APPEND ls_email_line TO lt_email_body.
        ls_email_line = TEXT-t10.
        APPEND ls_email_line TO lt_email_body.
      ENDIF.

    ENDIF.
    IF lt_list_email[] IS INITIAL.
      EXIT. " Seznam spravcu neni zadan, nic nebudeme odesilat
    ENDIF.

* Samotne odeslani notifikacni zpravy
    IF lt_list_email IS NOT INITIAL.
      CALL FUNCTION 'Z_HR_DPO_MAIL'
        EXPORTING
          i_subject = lv_subject
          x_commit  = 'X'
          i_sender  = lv_sender
        TABLES
          t_email   = lt_list_email
          t_content = lt_email_body
        EXCEPTIONS
          error     = 1
*         OTHERS    = 2
        .
      IF sy-subrc IS INITIAL.
        rv_return = abap_true.
      ENDIF.
    ENDIF.


  ENDMETHOD.


  METHOD send_mail_to_sp.
    DATA: lc_separator TYPE c VALUE ';'.

    DATA: lo_employee TYPE REF TO zcl_pe_all_employee.

    DATA: lv_subject    TYPE so_obj_des,
          lv_sender     TYPE xubname,
          lt_email_body TYPE soli_tab,
          ls_email_line TYPE soli,
          lv_userid     TYPE uname,
          lv_email      TYPE soos1-recextnam,
          lt_lnk_params TYPE zpe_all_tt_lnk_params,
          ls_lnk_params TYPE zpe_all_lnk_params,
          ls_thead      TYPE thead..

    DATA:
      lt_list_email TYPE STANDARD TABLE OF zibwa_smtp,
      ls_list_email TYPE zibwa_smtp.


    SELECT SINGLE value FROM zhr_dpo_cparam INTO ls_thead-tdname
                             WHERE parameter_dpo = 'ZAD_MAIL_SP'.
    IF sy-subrc EQ  0.

      ls_thead-tdid = 'ST'.
      ls_thead-tdspras = sy-langu.
      ls_thead-tdobject = 'TEXT'.
      DATA(lv_text) = read_text( EXPORTING  is_head    = ls_thead ).
      DATA(lt_body) = convert_string_to_text_table( iv_string = lv_text ).

    ENDIF.

    lv_subject = TEXT-t14.

*    DATA(lt_fork) = me->show_approval_fork( iv_dpo_request =  gs_data_db-dpo_request iv_only_next_approvers = '' ).


    LOOP AT gt_rozdel ASSIGNING FIELD-SYMBOL(<fs_rozdel>) WHERE role EQ zcl_hr_dpo_roles=>CO_SP.

      IF <fs_rozdel>-pernr IS NOT INITIAL.
        DATA(ls_user_data) = zcl_hr_dpo_roles=>get_pernr_details( iv_pernr = <fs_rozdel>-pernr  ).
        ls_list_email-email = ls_user_data-email.
        IF ls_list_email-email IS NOT INITIAL.
          APPEND ls_list_email TO lt_list_email.
        ENDIF.
        CLEAR: ls_user_data.
      ENDIF.
    ENDLOOP.



* Pripravime telo notifikacni zpravy
    IF ( ( sy-sysid EQ 'SK2' ) OR ( sy-sysid EQ 'SK4' ) ).
      CONCATENATE sy-sysid 'TEST:' lv_subject INTO lv_subject SEPARATED BY space.
    ELSE.
      lv_subject = lv_subject.
    ENDIF.

    ls_lnk_params-value = gs_data_db-dpo_request.
    APPEND ls_lnk_params TO lt_lnk_params.
    SELECT SINGLE value FROM zhr_dpo_cparam INTO lv_sender
                      WHERE parameter_dpo = 'ZHR_MAIL_SENDER_USER'.
    IF sy-subrc NE 0.
      lv_sender = sy-uname.
    ENDIF.

    IF lt_body[] IS NOT INITIAL.
      LOOP AT lt_body ASSIGNING FIELD-SYMBOL(<fs_body>).
        IF <fs_body> CS '$ZADOST$'.
          REPLACE FIRST OCCURRENCE OF '$ZADOST$' IN <fs_body> WITH gs_data_db-dpo_req_full.
        ENDIF.
        IF <fs_body> CS '$JMENO$'.
          ls_email_line = <fs_body>-tdline.
          REPLACE FIRST OCCURRENCE OF '$JMENO$' IN ls_email_line  WITH get_full_name( ).
          APPEND ls_email_line TO lt_email_body.
          CONTINUE.

*          REPLACE FIRST OCCURRENCE OF '$JMENO$' IN <fs_body> WITH gs_data_db-user_name_full.
        ENDIF.
        IF <fs_body> CS '$APPL$'.
          DATA lt_lnk  TYPE zpe_all_tt_lnk_params.
          DATA(ls_line) = CONV SO_TEXT255( zcl_hr_dpo_lnk_generator=>generate_application_link( iv_id_application = 'ZHR_DPO_REQUEST'
                                                         it_parameters = lt_lnk   ) ).
          REPLACE FIRST OCCURRENCE OF 'detail/' IN ls_line WITH ''.
          ls_email_line-line = <fs_body>-tdline.
          REPLACE FIRST OCCURRENCE OF '$APPL$' IN ls_email_line-line WITH | <a href="{ ls_line }" >Projednání s odbory</a>|.
          APPEND ls_email_line TO lt_email_body.
          CONTINUE.
        ENDIF.
        IF <fs_body> CS '$LINK$'.
          ls_email_line-line = zcl_hr_dpo_lnk_generator=>generate_application_link( iv_id_application = 'ZHR_DPO_REQUEST'
                                                              it_parameters = lt_lnk_params ).
          ls_email_line-line = ls_email_line-line && '/U0VMRg=='.
          ls_email_line-line = |<a href="{ ls_email_line-line }" >Odkaz na konkrétní žádost</a>|.
          APPEND ls_email_line TO lt_email_body.
          CONTINUE.
        ENDIF.

        ls_email_line = <fs_body>-tdline.
        APPEND ls_email_line TO lt_email_body.
      ENDLOOP.
    ELSE.


    ENDIF.
    IF lt_list_email[] IS INITIAL.
      EXIT. " Seznam spravcu neni zadan, nic nebudeme odesilat
    ENDIF.

* Samotne odeslani notifikacni zpravy
    IF lt_list_email IS NOT INITIAL.
      CALL FUNCTION 'Z_HR_DPO_MAIL'
        EXPORTING
          i_subject = lv_subject
          x_commit  = 'X'
          i_sender  = lv_sender
        TABLES
          t_email   = lt_list_email
          t_content = lt_email_body
        EXCEPTIONS
          error     = 1
*         OTHERS    = 2
        .
      IF sy-subrc IS INITIAL.
        rv_return = abap_true.
      ENDIF.
    ENDIF.
  ENDMETHOD.


  METHOD send_mail_to_zad_next.

    DATA: lc_separator TYPE c VALUE ';'.

    DATA: lo_employee TYPE REF TO zcl_pe_all_employee.

    DATA: lv_subject    TYPE so_obj_des,
          lv_sender     TYPE xubname,
          lt_email_body TYPE soli_tab,
          ls_email_line TYPE soli,
          lv_userid     TYPE uname,
          lv_email      TYPE soos1-recextnam,
          lt_lnk_params TYPE zpe_all_tt_lnk_params,
          ls_lnk_params TYPE zpe_all_lnk_params,
          ls_thead      TYPE thead..

    DATA:
      lt_list_email TYPE STANDARD TABLE OF zibwa_smtp,
      ls_list_email TYPE zibwa_smtp.

    CHECK gs_data_db-changes = 'X'.

    SELECT SINGLE value FROM zhr_dpo_cparam INTO ls_thead-tdname
                             WHERE parameter_dpo = 'ZAD_MAIL_ZAD_NEXT'.
    IF sy-subrc EQ  0.

      ls_thead-tdid = 'ST'.
      ls_thead-tdspras = sy-langu.
      ls_thead-tdobject = 'TEXT'.
      DATA(lv_text) = read_text( EXPORTING  is_head    = ls_thead ).
      DATA(lt_body) = convert_string_to_text_table( iv_string = lv_text ).

    ENDIF.

    lv_subject = TEXT-t11.

*    DATA(lt_fork) = me->show_approval_fork( iv_dpo_request =  gs_data_db-dpo_request iv_only_next_approvers = '' ).


    LOOP AT gt_rozdel ASSIGNING FIELD-SYMBOL(<fs_rozdel>) WHERE role CS zcl_hr_dpo_roles=>co_requestor. "Mátl opraveno co_hrbp

      IF <fs_rozdel>-pernr IS NOT INITIAL AND <fs_rozdel>-uname NE gs_data_db-orig_user.
        DATA(ls_user_data) = zcl_hr_dpo_roles=>get_pernr_details( iv_pernr = <fs_rozdel>-pernr  ).
        ls_list_email-email = ls_user_data-email.
        IF ls_list_email-email IS NOT INITIAL.
          APPEND ls_list_email TO lt_list_email.
        ENDIF.
        CLEAR: ls_user_data.
      ENDIF.
    ENDLOOP.



* Pripravime telo notifikacni zpravy
    IF ( ( sy-sysid EQ 'SK2' ) OR ( sy-sysid EQ 'SK4' ) ).
      CONCATENATE sy-sysid 'TEST:' lv_subject INTO lv_subject SEPARATED BY space.
    ELSE.
      lv_subject = lv_subject.
    ENDIF.

    ls_lnk_params-value = gs_data_db-dpo_request.
    APPEND ls_lnk_params TO lt_lnk_params.
    SELECT SINGLE value FROM zhr_dpo_cparam INTO lv_sender
                      WHERE parameter_dpo = 'ZHR_MAIL_SENDER_USER'.
    IF sy-subrc NE 0.
      lv_sender = sy-uname.
    ENDIF.

    IF lt_body[] IS NOT INITIAL.
      LOOP AT lt_body ASSIGNING FIELD-SYMBOL(<fs_body>).
        IF <fs_body> CS '$ZADOST$'.
          REPLACE FIRST OCCURRENCE OF '$ZADOST$' IN <fs_body> WITH gs_data_db-dpo_req_full.
        ENDIF.
        IF <fs_body> CS '$JMENO$'.
          ls_email_line = <fs_body>-tdline.
          REPLACE FIRST OCCURRENCE OF '$JMENO$' IN ls_email_line  WITH get_full_name( ).
          APPEND ls_email_line TO lt_email_body.
          CONTINUE.


*          REPLACE FIRST OCCURRENCE OF '$JMENO$' IN <fs_body> WITH gs_data_db-user_name_full.
        ENDIF.
       IF <fs_body> CS '$APPL$'.
          DATA lt_lnk  TYPE zpe_all_tt_lnk_params.
          DATA(ls_line) = CONV so_text255( zcl_hr_dpo_lnk_generator=>generate_application_link( iv_id_application = 'ZHR_DPO_REQUEST'
                                                         it_parameters = lt_lnk   ) ).
          REPLACE FIRST OCCURRENCE OF 'detail/' IN ls_line WITH ''.
          ls_email_line-line = <fs_body>-tdline.
          REPLACE FIRST OCCURRENCE OF '$APPL$' IN ls_email_line-line WITH | <a href="{ ls_line }" >Projednání s odbory</a>|.
          APPEND ls_email_line TO lt_email_body.
          CONTINUE.
        ENDIF.
        IF <fs_body> CS '$LINK$'.
          ls_email_line-line = zcl_hr_dpo_lnk_generator=>generate_application_link( iv_id_application = 'ZHR_DPO_REQUEST'
                                                              it_parameters = lt_lnk_params ).
          ls_email_line-line = ls_email_line-line && '/U0VMRg=='.
          ls_email_line-line = |<a href="{ ls_email_line-line }" >Odkaz na konkrétní žádost</a>|.
          APPEND ls_email_line TO lt_email_body.
          CONTINUE.
        ENDIF.

        ls_email_line = <fs_body>-tdline.
        APPEND ls_email_line TO lt_email_body.
      ENDLOOP.
    ELSE.




    ENDIF.
    IF lt_list_email[] IS INITIAL.
      EXIT. " Seznam spravcu neni zadan, nic nebudeme odesilat
    ENDIF.

* Samotne odeslani notifikacni zpravy
    IF lt_list_email IS NOT INITIAL.
      CALL FUNCTION 'Z_HR_DPO_MAIL'
        EXPORTING
          i_subject = lv_subject
          x_commit  = 'X'
          i_sender  = lv_sender
        TABLES
          t_email   = lt_list_email
          t_content = lt_email_body
        EXCEPTIONS
          error     = 1
*         OTHERS    = 2
        .
      IF sy-subrc IS INITIAL.
        rv_return = abap_true.
      ENDIF.
    ENDIF.


  ENDMETHOD.


  method SEND_REQUEST_TO_UNION.

  endmethod.


  METHOD setup_condition.

    CHECK iv_button CS 'APPROVE'.

    CASE gs_data_db-status.


      WHEN 'ROJ'.
        DATA(lv_uname) = zcl_pe_all_change_user=>get_uname( iv_appl_id = 'ZHR_DPO_REQUEST' ).

        IF me->gs_data_db-creator NE gs_data_db-uname.
          SELECT SINGLE * FROM zhr_dpo_zastup
                       INTO @DATA(ls_zastup)
                       WHERE creator = @me->gs_data_db-creator
                         AND deputy  = @lv_uname.

          IF ls_zastup-activity = 'C'."jenom zadavani
            rv_condition = 'A'.
            RETURN.
          ENDIF.
        ENDIF.

        DATA(lt_rozdel) = me->gt_rozdel[].
        SORT lt_rozdel BY dpo_request role uname.
        DELETE ADJACENT DUPLICATES FROM  lt_rozdel COMPARING dpo_request role uname.

        IF iv_process NE zcl_hr_dpo_const=>dpo_dohoda.
          IF  zcl_hr_dpo_roles=>check_hrbp( iv_uname = me->gs_data_db-creator ) = abap_true.
            DELETE lt_rozdel WHERE role NS zcl_hr_dpo_roles=>co_requestor.
            IF   lines( lt_rozdel ) = 1.
              rv_condition = 'H'.
              RETURN.
            ENDIF.
          ENDIF.
*      rv_condition = 'H'.
*      return.
        ENDIF.
        IF  line_exists( lt_rozdel[ role = zcl_hr_dpo_roles=>co_zad_next ]   ).
        ELSE.
          IF  zcl_hr_dpo_roles=>check_sp( iv_uname = me->gs_data_db-creator ) = abap_true.
            rv_condition = 'S'.
            RETURN.
          ENDIF.
        ENDIF.

        lt_rozdel = me->gt_rozdel[].
        SORT lt_rozdel BY dpo_request role uname.
        DELETE ADJACENT DUPLICATES FROM  lt_rozdel COMPARING dpo_request role uname.
        DELETE lt_rozdel WHERE role NS zcl_hr_dpo_roles=>co_requestor.
        IF   lines( lt_rozdel ) = 1 AND zcl_hr_dpo_roles=>check_sp( iv_uname = me->gs_data_db-creator ) = abap_false.
          rv_condition = 'O'.
        ENDIF.

      WHEN 'RAOJ'.

        lt_rozdel = me->gt_rozdel[].
        SORT lt_rozdel BY dpo_request role uname.
        DELETE ADJACENT DUPLICATES FROM  lt_rozdel COMPARING dpo_request role uname.
        DELETE lt_rozdel WHERE role NS zcl_hr_dpo_roles=>co_zad_next.
        DELETE lt_rozdel WHERE approved EQ abap_true.
        IF lines( lt_rozdel ) GT 0.
          IF   lines( lt_rozdel ) = 1 AND line_exists( lt_rozdel[ uname = iv_uname ] ) .
            rv_condition = 'L'.

            IF zcl_hr_dpo_roles=>check_hrbp( iv_uname = me->gs_data_db-creator ) = abap_true
            AND me->gs_data_db-process =  'P-CENTR'.
              lt_rozdel = me->gt_rozdel[].
              SORT lt_rozdel BY dpo_request role uname.
              DELETE ADJACENT DUPLICATES FROM  lt_rozdel COMPARING dpo_request role uname.
              DELETE lt_rozdel WHERE role NS zcl_hr_dpo_roles=>co_hrbp.
              DELETE lt_rozdel WHERE approved EQ abap_true.
              IF   lines( lt_rozdel ) = 1.
                rv_condition = 'B'.
              ENDIF.
            ENDIF.


            RETURN.
          ENDIF.
        ELSE.

*        IF gs_data_db-role = zcl_hr_dpo_roles=>CO_ZAD_NEXT.
*           rv_condition = 'L'.
*          return.
*        ENDIF.

          lt_rozdel = me->gt_rozdel[].
          SORT lt_rozdel BY dpo_request role uname.
          DELETE ADJACENT DUPLICATES FROM  lt_rozdel COMPARING dpo_request role uname.
          DELETE lt_rozdel WHERE role NS zcl_hr_dpo_roles=>co_hrbp.
          DELETE lt_rozdel WHERE approved EQ abap_true.
          IF   lines( lt_rozdel ) = 1.
            rv_condition = 'B'.
            RETURN.
          ENDIF.
          IF gs_data_db-role CS zcl_hr_dpo_roles=>co_hrbp.
            rv_condition = 'L'.
            RETURN.
          ENDIF.
        ENDIF.
      WHEN OTHERS.

    ENDCASE.



  ENDMETHOD.


  method SET_DEPUTY.



        rt_deputy_tab = ZCL_HR_DPO_ROLES=>GET_CREATOR_LIST( ).



  endmethod.


  METHOD set_next_status.


    me->get_next_status_tab(
      EXPORTING
        iv_dpo_request     =  gs_data_db-dpo_request
        iv_ignore_actual_status = iv_ignore_actual_status
    ).

* načti stisknutí tlačítka
    READ TABLE gt_next_status_tab ASSIGNING FIELD-SYMBOL(<fs_tab>)
                                  WITH KEY next_status = iv_next_status.



    IF sy-subrc EQ 0.

*nastav následný status
      IF iv_next_status IS NOT INITIAL.
        gs_data_db-status = <fs_tab>-next_status.
        gs_data_db-next_status = <fs_tab>-next_status.
        IF iv_next_status = 'SUN'.
          gs_data_db-send_date = sy-datum.
        ENDIF.
      ENDIF.

      DATA(lv_prev_role) = gs_data_db-role.
      gs_data_db-role = <fs_tab>-role.

      IF lv_prev_role = 'ZAD' AND gs_data_db-role = 'SP' "special logic when setting approving from NAA to ZHP
      AND gs_data_db-status = 'ZHP'.
        SELECT filename  FROM zhr_dpo_req_att
               WHERE not_yet_approved = @abap_true
                 AND dpo_request = @gs_data_db-dpo_request
                 INTO TABLE @DATA(lt_filename).
        IF sy-subrc EQ 0.
          LOOP AT lt_filename ASSIGNING FIELD-SYMBOL(<fs_file>).

            UPDATE zhr_dpo_req_att SET not_yet_approved = @abap_false
                                   WHERE dpo_request = @gs_data_db-dpo_request.
          ENDLOOP.

        ENDIF.

        SELECT SINGLE version  FROM zhr_dpo_a004
               WHERE not_yet_approved = @abap_true
                 AND      dpo_request = @gs_data_db-dpo_request
                 INTO  @DATA(lv_version).
        IF sy-subrc EQ 0.
          UPDATE zhr_dpo_a004 SET not_yet_approved = @abap_false
                              WHERE    dpo_request = @gs_data_db-dpo_request
                                AND        version = @lv_version.
          UPDATE zhr_dpo_a004_i SET       not_yet_approved = @abap_false
                                 WHERE         dpo_request = @gs_data_db-dpo_request
                                 AND               version = @lv_version.
        ENDIF.

      ENDIF.

      IF iv_notif_status IS NOT INITIAL.
        gs_data_db-notif_status = iv_notif_status.
      ENDIF.

      IF iv_clarification IS NOT INITIAL.
        gs_data_db-clarification = iv_clarification.
      ENDIF.
      gs_data_db-uname = sy-uname.
      gs_data_db-orig_user = iv_uname.
      gs_data_db-changes = abap_false.
      gs_data_db-dpo_step   = gs_data_db-dpo_step  + 1.

      CALL METHOD me->(<fs_tab>-method).
      "pri zmene stavu skontroluj, ci netreba zrušit task manager tasky
      " ak boli práve odoslane (methoda obsahujuca slovo TASK), tak samozrejme nic nerušit
      IF <fs_tab>-method NS 'TASK'.
        me->task_complete( ).
      ENDIF.

      rs_return-return_code = 'OK'.
      rs_return-dpo_request = gs_data_db-dpo_request.

    ELSE.
      rs_return-return_code = 'FAIL'.
      rs_return-dpo_request = gs_data_db-dpo_request.
    ENDIF.
*  načti

  ENDMETHOD.


  method SET_REQUEST.
    gs_data_db-dpo_request = iv_dpo_request.
    return  = me.
  endmethod.


  method SET_REQUEST_DATA.

   "kompletni prepis dat umoznime pouze pri:
  "- zakladani
  "- editaci
  "- schvalovani v kroku Zadatel
*  IF gs_control_data-process_mode = zif_ca_uniframe_consts=>co_control_proc_mode_new OR
*     gs_control_data-process_mode = zif_ca_uniframe_consts=>co_control_proc_mode_edit OR
*     ( gs_control_data-process_mode = zif_ca_uniframe_consts=>co_control_proc_mode_approve AND
*       gs_control_data-step_type = zcl_damprot_generic_uf=>co_step_type_zadatel ).
    ASSIGN ir_protocol_data->* TO FIELD-SYMBOL(<fs_data>).
    MOVE-CORRESPONDING <fs_data> TO gs_data_db.
*  ENDIF.


  endmethod.


  METHOD show_approval_fork.

    DATA: ls_approval TYPE zhr_dpo_rozdel_s.
    DATA: lt_return   TYPE STANDARD TABLE OF bapiret2.
    DATA: ls_address TYPE bapiaddr3,
          lv_nr      TYPE zhr_dpo_rozdel-ordernr,
          lv_max_nr  TYPE zhr_dpo_rozdel-ordernr.
    TYPES: lr_pernr TYPE RANGE OF pernr_d,
           lr_role  TYPE RANGE OF zhr_dpo_role.

    IF iv_pernr IS NOT INITIAL.
      DATA(r_pernr) = VALUE lr_pernr( sign = 'I' option = 'EQ' ( low = iv_pernr ) ).
    ENDIF.
    IF iv_role IS NOT INITIAL.
      DATA(r_role) = VALUE lr_role( sign = 'I' option = 'EQ' ( low = iv_role ) ).
    ENDIF.

    SELECT *  FROM zhr_dpo_rozdel INTO TABLE @DATA(lt_approval)
                                 WHERE dpo_request EQ @iv_dpo_request
                                   AND pernr IN @r_pernr
                                   AND role  IN @r_role.
    IF iv_only_next_approvers EQ abap_true.
      DELETE lt_approval WHERE role NE zcl_hr_dpo_roles=>co_consult
                           AND role NE zcl_hr_dpo_roles=>CO_ZAD_NEXT.

      CLEAR lv_nr.
      SORT lt_approval BY ordernr ASCENDING.
      LOOP AT lt_approval ASSIGNING FIELD-SYMBOL(<fs_next>) WHERE role = zcl_hr_dpo_roles=>CO_ZAD_NEXT.
        lv_nr  = lv_nr + 1.
        <fs_next>-ordernr = lv_nr.
      ENDLOOP.
      lv_max_nr = lv_nr.

    ENDIF.
    IF lt_approval[] IS NOT INITIAL.

      SELECT role, description FROM zhr_dpo_crolet INTO TABLE @DATA(lt_role_desc)
                               FOR ALL ENTRIES IN @lt_approval
                               WHERE role EQ @lt_approval-role
                               AND spras EQ @sy-langu.

      LOOP AT lt_approval ASSIGNING FIELD-SYMBOL(<fs_approval>).
        CLEAR ls_approval.
        REFRESH lt_return.

        MOVE-CORRESPONDING <fs_approval> TO ls_approval.
        READ TABLE lt_role_desc ASSIGNING FIELD-SYMBOL(<fs_desc>)
                                WITH KEY role = <fs_approval>-role.
        IF sy-subrc EQ 0.
          ls_approval-role_key = ls_approval-role.
          ls_approval-role = <fs_desc>-description.
        ENDIF.

        DATA(lv_pernr) = zcl_pa_vs_utils=>get_pernr_by_uname( iv_uname = <fs_approval>-uname ).
        IF lv_pernr IS NOT INITIAL.
          DATA(ls_user_data) = zcl_hr_dpo_roles=>get_pernr_details( iv_pernr = lv_pernr  ).
          ls_approval-name_full  = ls_user_data-full_name_s.
          ls_approval-department = ls_user_data-short.
          ls_approval-email      = ls_user_data-email.
          ls_approval-fax_number = ls_user_data-fax_number.
          ls_approval-tel1_numbr = ls_user_data-tel1_numbr.

          IF ls_approval-role_key = zcl_hr_dpo_roles=>co_consult.
            ls_approval-ordernr = '999'.
          ENDIF.
          IF ls_approval-role_key = zcl_hr_dpo_roles=>CO_ZAD_NEXT
          AND ls_approval-ordernr IS INITIAL.
            ADD 1 TO lv_max_nr.
            ls_approval-ordernr = lv_max_nr.
          ENDIF.


          APPEND ls_approval TO rt_approval_tab.
          CLEAR: ls_user_data, lv_pernr.

        ENDIF.

      ENDLOOP.
    ENDIF.

    CHECK iv_only_next_approvers = abap_true.
    SORT rt_approval_tab BY ordernr.


  ENDMETHOD.


  METHOD status_exists_in_history.

    DATA lv_dpo_req TYPE  ZHR_DPO_REQUEST.

    return = abap_false.

    lv_dpo_req = |{ iv_dpo_request ALPHA = IN }|.

    DATA(history_steps) = get_history( iv_dpo_request = lv_dpo_req ).

    IF line_exists(  history_steps[ next_status = 'STO' ]  ).
      RETURN.
    ENDIF.

    IF line_exists( history_steps[ next_status = iv_status ] ).
      return = abap_true.
    ENDIF.

  ENDMETHOD.


  METHOD task_complete.

    DATA: lv_result   TYPE xfeld,
          lt_message  TYPE bapiret2_t,
          lv_resolver TYPE uname.

    IF gt_rozdel[] IS INITIAL.
      SELECT * FROM zhr_dpo_rozdel INTO TABLE me->gt_rozdel
                                WHERE dpo_request = gs_data_db-dpo_request.
    ENDIF.

    LOOP AT gt_rozdel ASSIGNING FIELD-SYMBOL(<fs_rozdel>)
                                 WHERE task_manag_sent = abap_true.

      me->task_manager_complete(
        EXPORTING
          iv_dpo_request =  gs_data_db-dpo_request
          iv_resolver    = <fs_rozdel>-uname
         IMPORTING
           ef_result      = lv_result
           et_message     = lt_message
      ).
      <fs_rozdel>-task_manag_sent = abap_false.
    ENDLOOP.


  ENDMETHOD.


  method TASK_MANAG.

    data: lv_result   type xfeld,
          lt_message  type bapiret2_t,
          lv_resolver type uname.


    SORT gt_rozdel BY role ordernr ASCENDING.

    loop at gt_rozdel assigning field-symbol(<fs_rozdel>)
                                 WHERE role = iv_role
                                   AND approved IS INITIAL.



      me->task_manager_create(
        exporting
          iv_dpo_request      =  gs_data_db-dpo_request
          iv_dpo_request_full = gs_data_db-dpo_req_full
          iv_resolver         = <fs_rozdel>-uname
          iv_message_type     = iv_message_type
         importing
           ef_result          = lv_result
           et_message         = lt_message ).

       IF lv_result = abap_true.
* task manager sent
         <fs_rozdel>-task_manag_sent = abap_true.

         IF gs_data_db-approval_type = abap_true . "ked schvalujeme po poradi, tak notifikace po jednom
            EXIT.
         ENDIF.
       ENDIF.

    endloop.


  endmethod.


  method task_manager_cancel.

    data: ls_request         type zmcancel_task_request_msg,
          lo_clientproxy     type ref to zmco_cancel_task,
          lo_async_messaging type ref to if_wsprotocol_async_messaging,
          lx_fault type ref to cx_ai_system_fault.



    ls_request-sap_guid = iv_dpo_request.
    ls_request-application_id = iv_dpo_request.

*APPEND request_str TO ls_request_tab.


    try.
*     Create proxy client
        create object lo_clientproxy.

        lo_async_messaging ?= lo_clientproxy->get_protocol( if_wsprotocol=>async_messaging ).
        lo_async_messaging->set_serialization_context( zcl_pe_apr_const=>wps_queue_id ).

*     Do asynchronous client proxy call
        call method lo_clientproxy->cancel_task
          exporting
            output = ls_request.
            ef_result = abap_true.
*      COMMIT WORK.
      catch cx_ai_system_fault into lx_fault.
*   Error handling
    endtry.

    commit work.

endmethod.


  METHOD task_manager_complete.


    DATA: lo_clientproxy TYPE REF TO zmco_task_manager_sk_si,
          ls_output      TYPE zmremove_tasks_request,
          ls_item        TYPE zmcreated_tasks_list_type,
          lv_id          TYPE zmid_type,
          lv_source      TYPE zmsource_type.

* staré ID = DPO_REQUEST && RESOLVER. Nove ID = GUID.
* Kdyz GUID neexistuje v tabulce zhr_dpo_task_man použi staré ID
    IF iv_guid IS NOT INITIAL.
      lv_id = iv_guid.
    ELSE.
      lv_id = iv_dpo_request && iv_resolver.
    ENDIF.

    IF iv_guid IS INITIAL.
      SELECT SINGLE guid FROM zhr_dpo_task_man INTO @DATA(lv_guid)
                           WHERE dpo_request  = @iv_dpo_request
                             AND dpo_resolver = @iv_resolver.
      IF sy-subrc EQ 0.
        lv_id = lv_guid.
      ENDIF.
    ENDIF.

  IF iv_guid IS NOT INITIAL OR lv_guid IS NOT INITIAL.
    UPDATE zhr_dpo_task_man SET upd_uname  = sy-uname
                               upd_date   = sy-datum
                               upd_time   = sy-uzeit
                               closed     = abap_true
                               task_state = 'FINISHED'
                           WHERE guid = lv_id.
  ENDIF.

  lv_source = 'PROJEDNANI-ODBORY'.
  TRY.
      lo_clientproxy = NEW #( ).
      ls_output-removed_tasks_list-count = 1.
      ls_output-removed_tasks_list-removed_task = VALUE #( ( id = lv_id source = lv_source  ) ).

      lo_clientproxy->remove_tasks( EXPORTING output = ls_output IMPORTING input = DATA(ls_input) ).


    CATCH cx_ai_system_fault.
      "do nothing
    CATCH cx_ai_application_fault.
      "do nothing
  ENDTRY.


  COMMIT WORK.





ENDMETHOD.


  METHOD task_manager_create.

    DATA: lo_clientproxy TYPE REF TO zmco_task_manager_sk_si,
          lv_guid        TYPE guid_32.
    DATA: ls_tm_tab    TYPE zhr_dpo_task_man.
    TYPES: created_task_type TYPE zmcreated_task_type.
    DATA:  lt_parameter TYPE zmparameter_type_tab.
    DATA:  ls_parameter TYPE zmparameter_type.
    DATA:  lt_lnk_params TYPE zpe_all_tt_lnk_params.
    DATA:  ls_lnk_params TYPE zpe_all_lnk_params.
    DATA:  lo_sys_exception TYPE REF TO cx_ai_system_fault.
    DATA:  ls_request        TYPE zmcreate_tasks_request.
    DATA:  ls_response      TYPE zmcreate_tasks_response.
    DATA:  gs_created_task TYPE created_task_type.
    DATA:  gt_created_task TYPE STANDARD TABLE OF  created_task_type.
    TYPES: localization_type TYPE zmtask_manager_sk_si_localiza1.
    DATA:  gs_localization TYPE localization_type.
    DATA:  gt_localization TYPE STANDARD TABLE OF  localization_type.
    TYPES: login_type TYPE zmlogin_type.
    DATA:  gs_login TYPE login_type.
    DATA:  gt_login TYPE STANDARD TABLE OF  login_type.

    CASE iv_message_type.
      WHEN '1'.
        CONCATENATE TEXT-002 iv_dpo_request_full INTO gs_localization-name SEPARATED BY space.
        gs_localization-description = TEXT-003.

      WHEN '2'.
        CONCATENATE TEXT-002 iv_dpo_request_full INTO gs_localization-name SEPARATED BY space.
        gs_localization-description = TEXT-003.
      WHEN '3'.
        CONCATENATE TEXT-001 iv_dpo_request_full TEXT-005 INTO gs_localization-name SEPARATED BY space.
        gs_localization-description = TEXT-003.
      WHEN '4'.
        CONCATENATE TEXT-002 iv_dpo_request_full INTO gs_localization-name SEPARATED BY space.
        gs_localization-description = TEXT-006.
      WHEN OTHERS.
    ENDCASE.



    CALL FUNCTION 'GUID_CREATE'
      IMPORTING
        ev_guid_32 = lv_guid.

*    ls_lnk_params-name = 'DpoRequest'.
    ls_lnk_params-value = iv_dpo_request.
    APPEND ls_lnk_params TO lt_lnk_params.
*    CONCATENATE text-002 iv_dpo_request INTO gs_localization-name SEPARATED BY space.
*    gs_localization-description = text-003.
    gs_localization-url = zcl_hr_dpo_lnk_generator=>generate_application_link( iv_id_application = 'ZHR_DPO_REQUEST'
                                                             it_parameters = lt_lnk_params ).
    gs_localization-url = gs_localization-url && '/U0VMRg=='.

*    gs_localization-url = gs_localization-url && iv_dpo_request.
*    gs_localization-url = '/sap/opu/odata/sap/ZHR_DPO_REQUEST01_SRV/RequestDataSet(' && iv_dpo_request && ')'.
    gs_localization-language = 'cs'.
    APPEND gs_localization TO gt_localization.
    gs_created_task-localizations-localization = gt_localization.
    ls_parameter-name = 'DDTS_ID'.
    ls_parameter-value = iv_dpo_request.
    APPEND ls_parameter TO lt_parameter.
    gs_created_task-parameters-parameter = lt_parameter.
    gs_login = iv_resolver.
    APPEND gs_login TO gt_login.
    gs_created_task-resolvers-logins-login       = gt_login.
    gs_created_task-id = iv_dpo_request && iv_resolver.              "char100
***********************************************
    gs_created_task-id = ls_tm_tab-guid = lv_guid.
    ls_tm_tab-dpo_request  = iv_dpo_request.
    ls_tm_tab-dpo_resolver = iv_resolver.
    ls_tm_tab-dpo_req_full = iv_dpo_request_full.
    ls_tm_tab-crt_date  = sy-datum.
    ls_tm_tab-crt_time  = sy-uzeit.
    ls_tm_tab-crt_uname = sy-uname.
    ls_tm_tab-processor = iv_resolver.
    ls_tm_tab-task_state = 'READY'.

    gs_created_task-source = 'PROJEDNANI-ODBORY'.         "char40
    gs_created_task-template_code = 'HR_DPO_CREATE_TASK'.  "char30
    gs_created_task-category = 'Ostatní'(010).               "char30
    gs_created_task-creation_date = zcl_pe_all_utils=>convert_date_time_for_wps( iv_datum = sy-datum
                                                                                      iv_time = sy-uzeit ).
    gs_created_task-submitter = sy-uname.            "char64
    gs_created_task-expiration_date = ''. "'20130203100405'. "dec15        .... datum expirace nemusí být vyplněno
    gs_created_task-priority = 3.                 "int2
    gs_created_task-number = 1.                  "int4           ..... první věta
    APPEND gs_created_task TO gt_created_task.

    ls_request-created_tasks_list-created_task = gt_created_task.
    ls_request-created_tasks_list-count = 1.


    TRY.
*     Create proxy client
        CREATE OBJECT lo_clientproxy.

*     Do asynchronous client proxy call
        CALL METHOD lo_clientproxy->create_tasks
          EXPORTING
            output = ls_request
          IMPORTING
            input  = ls_response.
*       COMMIT WORK.
      CATCH cx_ai_system_fault INTO lo_sys_exception.
      CATCH cx_root.
*   CATCH cx_ai_application_fault .
*   Error handling
    ENDTRY.
    INSERT zhr_dpo_task_man FROM ls_tm_tab.
    COMMIT WORK AND WAIT.
    ef_result = abap_true.




  ENDMETHOD.


  method task_oj.

    me->clear_rozdel_send_after_reject( ).

    clear gs_data_db-form_id.
    me->clear_approvers( ).
    CASE gs_data_db-role.
      WHEN zcl_hr_dpo_roles=>co_hrbp.
         me->send_mail_hrbp_returns( ).
      WHEN zcl_hr_dpo_roles=>CO_SP.
         me->send_mail_sp_returns( ).
      WHEN OTHERS.
    ENDCASE.

    me->task_manag( iv_role = zcl_hr_dpo_roles=>co_hrbp iv_message_type = '1' ).



  endmethod.


  METHOD task_oj_next.


    me->task_manag( iv_role = zcl_hr_dpo_roles=>CO_ZAD_NEXT iv_message_type = '1' ).

  ENDMETHOD.


  METHOD task_sp1.

*    me->send_mail_to_sp( ).
*    me->assign_term( ).
    me->task_manag( iv_role = zcl_hr_dpo_roles=>CO_SP iv_message_type = '2' ).

  ENDMETHOD.


  METHOD task_sp1_agr.
    me->send_mail_to_sp( ).
*    me->send_mail_to_hrbp( ).
    me->task_manag( iv_role = zcl_hr_dpo_roles=>CO_SP iv_message_type = '2' ).

  ENDMETHOD.


  method TASK_SP2.
    me->task_manag( iv_role = zcl_hr_dpo_roles=>CO_SP iv_message_type = '3' ).
  endmethod.


  method TASK_SP3.
     me->task_manag( iv_role = zcl_hr_dpo_roles=>CO_SP iv_message_type = '4' ).
  endmethod.


  method TEST_METHOD.

    read_customizing( ).
    init_form_data( ).
    data(ls_request) = get_request( ).

  endmethod.


  method UNASSIGN_TERM.

    IF gs_data_db-term_id IS NOT INITIAL.
       DELETE FROM zhr_dpo_termzad
*       UPDATE      zhr_dpo_termzad SET deletion_flag = abap_true
                                WHERE dpo_request = gs_data_db-dpo_request
                                     AND term_id     = gs_data_db-term_id.
       IF sy-subrc EQ 0.
         UPDATE zhr_dpo_zad SET term_id = ''
           WHERE dpo_request = gs_data_db-dpo_request.
         IF sy-subrc EQ 0.
           CLEAR gs_data_db-term_id.
         ENDIF.

       ENDIF.


    ENDIF.

  endmethod.


  method UNI_HRBP.

   DO.

    me->gt_approvers = me->fill_approvers( zcl_hr_dpo_roles=>co_hrbp ).

    IF me->gt_approvers[] IS INITIAL.
      EXIT.
    ENDIF.
    clear gs_data_db-form_id.
    me->run_uniprocess( ).

   ENDDO.


  endmethod.


  method uni_hrbp_return.

*    me->unassign_term( ).
    me->clear_approvers( ).
    clear gs_data_db-form_id.
    me->uni_hrbp( ).

  endmethod.


  method uni_oj.

    do.

      me->gt_approvers = me->fill_approvers( zcl_hr_dpo_roles=>CO_ZAD_NEXT ).
      if me->gt_approvers[] is initial.
        exit.
      endif.
      clear gs_data_db-form_id.
      me->run_uniprocess( ).

    enddo.

  endmethod.


  method uni_ved_sp.

    clear gs_data_db-form_id.
    me->gt_approvers = me->fill_approvers( zcl_hr_dpo_roles=>co_ved_sp ).
    me->run_uniprocess( ).

  endmethod.


  method UPDATE_CHANGE_SIGN.

    CHECK gs_data_db-dpo_request IS NOT INITIAL.

    gs_data_db-changes = iv_changed.
    UPDATE zhr_dpo_zad SET changes = iv_changed
           WHERE dpo_request = gs_data_db-dpo_request.
  endmethod.


  method UPDATE_NEXT_APPROVER.

    DATA ls_rozdel TYPE  zhr_dpo_rozdel.

    MOVE-CORRESPONDING is_approver TO ls_rozdel.
    UPDATE zhr_dpo_rozdel FROM ls_rozdel.
    IF sy-subrc NE 0.
*      ls_rozdel-before_save = abap_true.
      UPDATE zhr_dpo_rozdel FROM ls_rozdel.
    ENDIF.


  endmethod.


  METHOD update_term_in_history.


    IF i_old_term_id IS SUPPLIED.
      DATA(lv_old_term_id) = i_old_term_id.
    ELSE.

    SELECT SINGLE term_id FROM zhr_dpo_zad INTO @lv_old_term_id
                                    WHERE dpo_request = @iv_dpo_request.

    ENDIF.

    CHECK lv_old_term_id NE i_term_id.

    SELECT SINGLE * FROM zhr_dpo_hist INTO @DATA(ls_hist)
                      WHERE dpo_request = @iv_dpo_request AND
                            dpo_step    = ( SELECT MAX( dpo_step ) FROM zhr_dpo_hist WHERE dpo_request = @iv_dpo_request  ).

    IF sy-subrc EQ 0.

      DATA(ls_zad_act) = me->reload_active_zad( iv_dpo_request ).

      SELECT SINGLE term_date FROM zhr_dpo_term INTO @DATA(lv_date)
                            WHERE term_id = @i_term_id.
      IF sy-subrc EQ 0.
        ADD 1 TO ls_hist-dpo_step.
        ls_hist-datum = sy-datum.
        ls_hist-time  = sy-uzeit.
        IF ls_zad_act-role IS NOT INITIAL.
        ls_hist-role       =  ls_zad_act-role.
         ls_hist-uname     = ls_zad_act-real_user.
         ls_hist-orig_user = ls_zad_act-active_user.
         ls_hist-uname = ls_zad_act-real_user.
        ELSE.
          ls_hist-role  = is_hist-role.
          ls_hist-uname = is_hist-uname.
          ls_hist-orig_user = is_hist-orig_user.
        ENDIF.

        ls_hist-clarification = |{ TEXT-t18 } { lv_date DATE = USER } | .

        INSERT zhr_dpo_hist FROM ls_hist.
      ENDIF.
    ENDIF.


  ENDMETHOD.


  method ZIF_CA_UNIFRAME_ECOCKPIT_DPR~GET_TASK_HEADER_DETAIL_ECO.

   break dzc26y2.

  endmethod.


  METHOD zif_pe_all_task_mng~do_action.

    DATA: lv_app_name TYPE zpe_all_app_name,
          lv_app_text TYPE zpe_all_app_text,

          lo_task     TYPE REF TO zcl_pe_apr_wps_handler,

          lv_text     TYPE string,
          lf_result   TYPE flag,
          lt_message  TYPE bapirettab,
          lv_uname    TYPE sy-uname,
          lv_dpo_req  TYPE zhr_dpo_zad-dpo_request,
          lx_root     TYPE REF TO zcx_pe_apr_wps.

    DATA: lv_result   TYPE xfeld,

          lv_resolver TYPE uname.

    CLEAR et_message.

    ef_result = abap_true.

    me->zif_pe_all_task_mng~get_app_name( IMPORTING ev_app_name = lv_app_name ev_app_text = lv_app_text ).

    CASE iv_action.
      WHEN zcl_pe_all_const=>task_mng_action_finish.

        SELECT SINGLE *  FROM zhr_dpo_task_man INTO @DATA(ls_task)
                                 WHERE guid = @iv_guid.

        IF sy-subrc EQ 0.
          lv_dpo_req = ls_task-dpo_request.
          lv_uname   = ls_task-dpo_resolver.
        ELSE.
          lv_dpo_req = iv_guid(10).
          lv_uname   = iv_guid+10.
        ENDIF.

        TRY.
            DATA(lo_request) = NEW zcl_hr_dpo_request( ).
            DATA(ls_request) = lo_request->read_request(
              EXPORTING
                iv_dpo_request      = lv_dpo_req  ).


            IF lo_request->gt_rozdel[] IS INITIAL.
              SELECT * FROM zhr_dpo_rozdel INTO TABLE lo_request->gt_rozdel
                                        WHERE dpo_request = lv_dpo_req
                                          AND uname       = lv_uname.
            ENDIF.




            LOOP AT lo_request->gt_rozdel ASSIGNING FIELD-SYMBOL(<fs_rozdel>)
                                         WHERE task_manag_sent = abap_true
                                           AND uname           = lv_uname.

              me->task_manager_complete(
                EXPORTING
                  iv_guid        = iv_guid
                  iv_dpo_request =  lv_dpo_req
                  iv_resolver    = <fs_rozdel>-uname
                 IMPORTING
                   ef_result      = lv_result
                   et_message     = lt_message
              ).
              <fs_rozdel>-task_manag_sent = abap_false.

            ENDLOOP.


            lo_request->save_req( ).

          CATCH zcx_pe_apr_wps INTO lx_root.
*          APPEND LINES OF lx_root->bapirettab TO et_message.
            ef_result = abap_false.
        ENDTRY.

      WHEN OTHERS.
        MESSAGE e138(zpe_all) WITH iv_action lv_app_name lv_app_text INTO lv_text.
        ef_result = abap_false.
        zcl_pe_all_utils=>append_message_from_syst( CHANGING ct_bapiret = et_message ).

    ENDCASE.



  ENDMETHOD.


  METHOD zif_pe_all_task_mng~get_app_name.

    CLEAR: et_message.

    ef_result = abap_true.

    ev_app_name = 'ZHR_DPO'.
    ev_app_text = 'Projednání s Odbory'.

  ENDMETHOD.


  METHOD zif_pe_all_task_mng~get_list.

    DATA: lv_app_name     TYPE zpe_all_app_name,
          lv_app_text     TYPE zpe_all_app_text,

          lv_current_date TYPE datum,

          lv_where        TYPE string,
          lv_text         TYPE string,
          lt_task         TYPE zpe_prq_task_t,
          ls_task         TYPE zpe_prq_task_s,
          lr_crt_date     TYPE RANGE OF sydatum,
          ls_search_param LIKE LINE OF it_search_param,
          lr_range_dpo_r  TYPE RANGE OF zhr_dpo_zad-dpo_request,
          lr_range_req    TYPE RANGE OF zhr_dpo_zad-dpo_req_full,
          lt_range_date   TYPE RANGE OF sydatum,
          lt_range_wps_s  TYPE RANGE OF zpe_all_task_wps_state,
          ls_task_manag   TYPE zpe_all_task_mng_s,

          lx_root         TYPE REF TO cx_root.

    FIELD-SYMBOLS: <fs_task>     LIKE LINE OF lt_task,
                   <fs_task_mng> LIKE LINE OF et_task_mng.

    CLEAR: et_message, et_task_mng.

    ef_result = abap_true.

    lv_current_date = zcl_pe_all_settings=>gv_current_date.

    me->zif_pe_all_task_mng~get_app_name( IMPORTING ev_app_name = lv_app_name ev_app_text = lv_app_text ).

    READ TABLE it_search_param WITH KEY name = 'WPS_STATE' INTO ls_search_param.
    IF sy-subrc EQ 0.
      DATA(lr_state) = ls_search_param-value_range .
    ENDIF.

    READ TABLE it_search_param WITH KEY name = 'CRT_DATE' INTO ls_search_param.
    IF sy-subrc EQ 0.
      lr_crt_date = ls_search_param-value_range.
    ENDIF.

    READ TABLE it_search_param WITH KEY name = 'PROCESSOR' INTO ls_search_param.
    IF sy-subrc EQ 0.
      DATA(lr_processor) = ls_search_param-value_range.
    ENDIF.

    READ TABLE it_search_param WITH KEY name = 'DPO_REQ_FULL' INTO ls_search_param.
    IF sy-subrc EQ 0.
      lr_range_req = ls_search_param-value_range.

    ENDIF.

    READ TABLE it_search_param WITH KEY name = 'DPO_REQUEST' INTO ls_search_param.
    IF sy-subrc EQ 0.
      lr_range_dpo_r  = ls_search_param-value_range.

    ENDIF.



    DATA(lo_request) = NEW zcl_hr_dpo_request( ).


      SELECT * FROM zhr_dpo_task_man INTO TABLE @DATA(lt_task_manag)
                                          WHERE task_state   IN @lr_state
                                           AND  crt_date     IN @lr_crt_date
                                           AND  processor    IN @lr_processor
                                           AND  dpo_req_full IN @lr_range_req
                                           AND  dpo_resolver IN @lr_processor
                                           AND  dpo_request  IN @lr_range_dpo_r .
      IF sy-subrc EQ 0.
        LOOP AT lt_task_manag INTO DATA(ls_dpo_task_manag).
          ls_task_manag-app_name  = lv_app_name.
          ls_task_manag-guid      = ls_dpo_task_manag-guid.
          ls_task_manag-crt_date  = ls_dpo_task_manag-crt_date.
          ls_task_manag-crt_uname = ls_dpo_task_manag-crt_uname.
          ls_task_manag-crt_time  = ls_dpo_task_manag-crt_time.
          ls_task_manag-processor = ls_dpo_task_manag-processor.
          ls_task_manag-wps_state = ls_dpo_task_manag-task_state.
          ls_task_manag-info = ls_dpo_task_manag-dpo_req_full.
          APPEND ls_task_manag TO et_task_mng.
        ENDLOOP.
      ENDIF.



    TRY.

            SELECT DISTINCT rozdel~dpo_request, uname FROM zhr_dpo_rozdel AS rozdel
              INNER JOIN zhr_dpo_zad AS zad
              ON rozdel~dpo_request = zad~dpo_request
               INTO  TABLE
             @DATA(lt_rozdel)
              WHERE  zad~dpo_req_full IN @lr_range_req  AND
                     zad~dpo_request  IN @lr_range_dpo_r  AND
                     rozdel~uname     IN @lr_processor  AND
                     rozdel~task_manag_sent = @abap_true
                  .


            IF sy-subrc EQ 0.
              LOOP AT lt_rozdel ASSIGNING FIELD-SYMBOL(<fs_rozdel>).
                IF line_exists( lt_task_manag[ dpo_request  = <fs_rozdel>-dpo_request
                                               dpo_resolver = <fs_rozdel>-uname  ] ).
*                 zaznam už je vybran novým generovaným guid, nepridavej.
                ELSE.
                  ls_task-guid      =  <fs_rozdel>-dpo_request && <fs_rozdel>-uname.
                  ls_task-processor =  <fs_rozdel>-uname.
                  ls_task-wps_state = 'READY'.
                  APPEND ls_task TO lt_task.
                ENDIF.
              ENDLOOP.
        ENDIF.

* hledani jednoho zaznamu na zaklade cisla zadosti a jmena
      IF lt_task IS INITIAL AND et_task_mng IS INITIAL.
        READ TABLE it_search_param WITH KEY name = 'DPO_REQUEST' INTO DATA(ls_search_param_req).
        IF sy-subrc EQ 0.
          READ TABLE it_search_param WITH KEY name = 'PROCESSOR' INTO ls_search_param.
          IF sy-subrc EQ 0.
            ls_task-guid = ls_search_param_req-value_range[ 1 ]-low && ls_search_param-value_range[ 1 ]-low.
            ls_task-processor =   ls_search_param-value_range[ 1 ]-low.
            ls_task-wps_state = 'READY'.
            APPEND ls_task TO lt_task.
          ENDIF.

        ENDIF.
      ENDIF.

        LOOP AT lt_task ASSIGNING <fs_task>.

          APPEND INITIAL LINE TO et_task_mng ASSIGNING <fs_task_mng>.
          MOVE-CORRESPONDING <fs_task> TO <fs_task_mng>.
          <fs_task_mng>-app_name = lv_app_name.


          DATA(ls_request) = lo_request->read_request(
            EXPORTING
              iv_dpo_request      =  <fs_task>-guid(10)  ).

          <fs_task_mng>-info = ls_request-dpo_req_full.

        ENDLOOP.

      CATCH cx_root INTO lx_root.
        MESSAGE e134(zpe_all) WITH lv_app_name lv_app_text INTO lv_text.
        ef_result = abap_false.
        zcl_pe_all_utils=>append_message_from_syst( CHANGING ct_message = et_message ).
    ENDTRY.

    zcl_pe_all_settings=>set_current_date( iv_date = lv_current_date ).


  ENDMETHOD.


  METHOD zif_pe_all_task_mng~get_task.

    DATA: lv_app_name TYPE zpe_all_app_name,
          lv_app_text TYPE zpe_all_app_text,

          lv_text     TYPE string,
          lv_dpo_req  TYPE zhr_dpo_zad-dpo_request,
          lv_uname    TYPE sy-uname,
          ls_task     TYPE zpe_apr_d_wps,

          lx_root     TYPE REF TO cx_root.

    CLEAR: et_message, es_task_mng.

    ef_result = abap_true.

    SELECT SINGLE *  FROM zhr_dpo_task_man INTO @DATA(ls_dpo_task_manag)
                                 WHERE guid = @iv_guid.

    IF sy-subrc EQ 0.
      lv_dpo_req = ls_dpo_task_manag-dpo_request.
      lv_uname   = ls_dpo_task_manag-dpo_resolver.
    ELSE.
      lv_dpo_req = iv_guid(10).
      lv_uname   = iv_guid+10.
    ENDIF.



    es_task_mng-guid = iv_guid.

    me->zif_pe_all_task_mng~get_app_name( IMPORTING ev_app_name = lv_app_name ev_app_text = lv_app_text ).

    es_task_mng-app_name = lv_app_name.
    DATA(lo_request) = NEW zcl_hr_dpo_request( ).
    DATA(ls_request) = lo_request->read_request(
              EXPORTING
                iv_dpo_request      = lv_dpo_req ).



    es_task_mng-crt_date  = ls_dpo_task_manag-crt_date.
    es_task_mng-crt_uname = ls_dpo_task_manag-crt_uname.
    es_task_mng-crt_time  = ls_dpo_task_manag-crt_time.
    es_task_mng-processor = ls_dpo_task_manag-processor.
    es_task_mng-wps_state = ls_dpo_task_manag-task_state.
    es_task_mng-info = ls_dpo_task_manag-dpo_req_full.
    es_task_mng-upd_date  = ls_dpo_task_manag-upd_date.
    es_task_mng-upd_time  = ls_dpo_task_manag-upd_time.
    es_task_mng-upd_uname  = ls_dpo_task_manag-upd_uname.

    es_task_mng-info = ls_request-dpo_req_full.




  ENDMETHOD.
ENDCLASS.
