class ZCL_HR_DPO_TERM definition
  public
  inheriting from ZCL_HR_DPO_MAIN
  final
  create public .

public section.

  types:
    TT_CUSTOM_REQUEST TYPE STANDARD TABLE OF ZHR_DPO_CZAD .
  types:
    TT_CUSTOM_TEMPLATE TYPE STANDARD TABLE OF ZHR_DPO_CSABL .
  types RO_REQUEST_REF type ref to ZCL_HR_DPO_REQUEST .

  constants CV_PARAM_TERM_EMAIL_HEADER type ZHR_DPO_PARAMETER value 'TERM_EMAIL_HEAD' ##NO_TEXT.
  constants CV_PARAM_TERM_EMAIL_FOOTER type ZHR_DPO_PARAMETER value 'TERM_EMAIL_FOOT' ##NO_TEXT.
  data GS_DATA_DB type ZHR_DPO_TERM_STRUCT .
  data GS_CUSTOM_REQUEST type ZHR_DPO_CZAD .
  data GT_CUSTOM_REQUEST type TT_CUSTOM_REQUEST .
  data GS_CUSTOM_TEMPLATE type ZHR_DPO_CSABL .
  data GT_CUSTOM_TEMPLATE type TT_CUSTOM_TEMPLATE .
  data GV_PROCESS_TYPE type ZHR_DPO_PROCESS value 'PC' ##NO_TEXT.
  constants CV_REQUEST type ZHR_DPO_OBJECT value 'R' ##NO_TEXT.
  constants CO_OK type ZHR_RETURN_OK_CODE value 'OK' ##NO_TEXT.
  constants CO_FAIL type ZHR_RETURN_OK_CODE value 'FAIL' ##NO_TEXT.
  data:
    TT_REQUEST_REF_TAB TYPE STANDARD TABLE OF ro_request_ref .

  class-methods GET_EMAIL_HEADER_AND_FOOTER
    returning
      value(RS_EMAIL_HEADER_AND_FOOTER) type ZHR_DPO_TERM_EMAIL_S .
  methods READ_CUSTOMIZING .
  methods GET_TERMS
    returning
      value(RETURN) type ZHR_DPO_TERM_STRUCT .
  methods TEST_METHOD .
  methods BUTTON_PRESS
    importing
      !IV_BUTTON type ZHR_DPO_BUTTON
      !IV_CONDITION type ZHR_DPO_CONDITION .
  methods SAVE_AS_DRAFT_TERM .
  methods SAVE_TERM
    returning
      value(RS_RETURN) type ZHR_DPO_TERM_RETURN_S .
  methods UNI_HRBP .
  methods GET_TERM_LIST
    importing
      !TERM_DATE_RANGE type /IWBEP/T_COD_SELECT_OPTIONS optional
      !TERM_RANGE type /IWBEP/T_COD_SELECT_OPTIONS optional
      !LOCATION_RANGE type /IWBEP/T_COD_SELECT_OPTIONS optional
      !STATUS_RANGE type /IWBEP/T_COD_SELECT_OPTIONS optional
      !PROCESS_RANGE type /IWBEP/T_COD_SELECT_OPTIONS optional
      !TERM_SP_RANGE type /IWBEP/T_COD_SELECT_OPTIONS optional
      !TERM_ODB_RANGE type /IWBEP/T_COD_SELECT_OPTIONS optional
      !TERM_ZARAD_RANGE type /IWBEP/T_COD_SELECT_OPTIONS optional
      !WITH_PROPOSED_TERM type XFELD optional
    returning
      value(RT_TERM_LIST) type ZHR_DPO_ZAD_STRUCT_T .
  methods READ_TERM
    importing
      !IV_TERM type ZHR_DPO_ID_TERM
    returning
      value(RS_TERM) type ZHR_DPO_TERM_STRUCT .
  class-methods READ_TEXT
    importing
      !IS_HEAD type THEAD optional
      !IV_MAIL type XFELD optional
    exporting
      !ET_TEXT type TLINE_T
    returning
      value(RV_LONGTEXT) type STRING .
  class-methods CONVERT_REQUEST
    changing
      !CHS_REQUEST type ZHR_DPO_ZADCONV .
  class-methods GET_DOMAIN_VALUES
    importing
      !IV_NAME type DDOBJNAME
    returning
      value(RT_DD07V) type DD07V_TAB .
  class-methods GET_LONG_TEXT
    importing
      !IV_TEXT_CODE type ZHR_DPO_PARAMETER
      !IV_MAIL type XFELD optional
    returning
      value(RS_LONG_TEXT) type STRING .
  methods GET_REQUEST
    importing
      !IV_DPO_TERM type ZHR_DPO_ID_TERM
      !IV_DPO_REQUEST type ZHR_DPO_REQUEST
    returning
      value(RS_REQUEST) type ZHR_DPO_TERM_REQ_S .
  methods GET_REQUESTS_TABLE
    importing
      !IV_TERM type ZHR_DPO_ID_TERM
      !IV_ONLY_NON_ELECTRONIC type XFELD optional
    exporting
      !ET_MESSAGE type BAPIRET2_T
    returning
      value(RT_REQUEST_TAB) type ZHR_DPO_TERM_REQ_T .
  methods ADD_REQUEST_TO_TERM
    importing
      !IV_DPO_REQUEST type ZHR_DPO_REQUEST
      !IV_DPO_TERM type ZHR_DPO_ID_TERM
    returning
      value(RS_STATUS) type ZHR_DPO_TERM_RETURN_S .
  methods REMOVE_REQUEST_FROM_TERM
    importing
      !IV_DPO_REQUEST type ZHR_DPO_REQUEST
      !IV_DPO_TERM type ZHR_DPO_ID_TERM
    returning
      value(RS_STATUS) type ZHR_DPO_TERM_RETURN_S .
  methods CREATE_TERM
    importing
      !IV_LOCATION type ZHR_DPO_LOCATION
      !IV_FREQUENCY type ZHR_DPO_FREQUENCY
      !IV_DATE_FROM type DATEFROM
      !IV_DATE_TO type DATETO
    returning
      value(RS_RETURN) type ZHR_DPO_TERM_RETURN_S .
  methods SET_TERM
    importing
      !IS_TERM type ZHR_DPO_TERM_STRUCT .
  methods CONVERT_STRING_TO_TEXT_TABLE
    importing
      !IV_STRING type STRING
    returning
      value(RT_TEXT_TABLE) type TLINE_T .
  class-methods MAIL_CONTACTS
    importing
      !IV_BUTTON_PRESS type ZHR_DPO_BUTTON
    returning
      value(RS_MAIL_LIST) type STRINGVAL .
  methods UPDATE_ORDER_NR
    importing
      !IV_DPO_TERM type ZHR_DPO_ID_TERM
      !IV_DPO_REQUEST type ZHR_DPO_REQUEST
      !IV_ORDERNR type ZHR_DPO_ORDER_NR
      !IV_TIME type SY-UZEIT
      !IV_DPO_DURATION type ZHR_DPO_TERM_DUR
    returning
      value(RS_RETURN) type ZHR_DPO_TERM_RETURN_S .
  class-methods PREPARE_WORD_TEMPLATE
    importing
      !IV_DPO_REQUEST type ZHR_DPO_REQUEST
      !IV_DPO_TERM type ZHR_DPO_ID_TERM optional
      !IV_XSTRING type XSTRING
    exporting
      !EV_FINAL_XSTRING type XSTRING .
  methods UPDATE_REQUESTS_STATUS
    importing
      !IV_UNAME type SY-UNAME optional .
  methods UPDATE_REQ_STAT_FROM_TO
    importing
      !IV_STATUS_FROM type ZHR_DPO_STATUS_REQ
      !IV_STATUS_TO type ZHR_DPO_STATUS_REQ
      !IV_ORIGIN_USER type UNAME optional
    returning
      value(RT_UPDATED_REQUESTS) type ZHR_DPO_ZAD_T .
  methods DELETE_TERM
    exporting
      !ET_MESSAGE type BAPIRETTAB
    returning
      value(RS_RETURN) type ZHR_DPO_TERM_RETURN_S .

  methods INIT_FORM_DATA
    redefinition .
  methods SAVE_AS_DRAFT
    redefinition .
protected section.

  class-methods GET_EMAIL_CONTACTS_UNION
    returning
      value(RS_MAIL_LIST) type ZHR_DPO_EMAIL_ADDRESSES .
private section.

  methods UNI_OJ .
ENDCLASS.



CLASS ZCL_HR_DPO_TERM IMPLEMENTATION.


  METHOD add_request_to_term.

    DATA: ls_termzad TYPE zhr_dpo_termzad.

*    SELECT SINGLE dpo_request FROM zhr_dpo_zad INTO @data(lv_dpo_req)
*                              WHERE dpo_req_full = @iv_dpo_request_full.
*    IF sy-subrc EQ 0.

      ls_termzad-dpo_request = iv_dpo_request.

*    ENDIF.

    ls_termzad-term_id = iv_dpo_term.
    SELECT MAX( ordernr )  FROM zhr_dpo_termzad
                           INTO @DATA(lv_ordernr)
                           WHERE term_id = @iv_dpo_term.
    SELECT a~term_id INTO TABLE @DATA(lt_terms)
                     FROM zhr_dpo_termzad AS a
                     INNER JOIN zhr_dpo_term AS b
                     ON a~term_id EQ b~term_id
                     WHERE a~dpo_request = @iv_dpo_request
                       AND ( b~status = 'TO'
                        OR   b~status = 'TN' ).

    ls_termzad-ordernr = lv_ordernr + 1.
    INSERT zhr_dpo_termzad FROM ls_termzad.
    IF sy-subrc EQ 0.
      DATA(lr_o_dpo_request) = NEW zcl_hr_dpo_request( ).
      lr_o_dpo_request->set_request( iv_dpo_request ).

      lr_o_dpo_request->update_term_in_history( i_term_id = iv_dpo_term iv_dpo_request = iv_dpo_request ).
*      NEW zcl_hr_dpo_request( )->set_request( iv_dpo_request )->update_term_in_history( i_term_id = iv_dpo_term iv_dpo_request = iv_dpo_request ).
      UPDATE zhr_dpo_zad SET term_id = iv_dpo_term
                         WHERE dpo_request = iv_dpo_request.

      rs_status-term_id = iv_dpo_term.
      rs_status-return_code  = me->co_ok.
    ELSE.
      rs_status-term_id = iv_dpo_term.
      rs_status-return_code  = me->co_fail.
    ENDIF.


  ENDMETHOD.


  METHOD BUTTON_PRESS.


* zkontrouj podminku
*  DATA(lv_condition) = setup_condition( ).
*  lv_condition = iv_condition.

* TRY.
** načti stisknutí tlačítka
*    gs_custom_request =  gt_custom_request[ process =  gv_process_type
*                                             button = iv_button
*                                             status = gs_data_db-status
*                                             role = gs_data_db-role
*                                             req_condition = lv_condition ].
*    CATCH cx_sy_itab_line_not_found .
*  ENDTRY.
*
*nastav následný status
*  gs_data_db-status = gs_custom_request-status.
*  gs_data_db-next_status = gs_custom_request-next_status.
*
*  CALL METHOD me->(gs_custom_request-method).


*  načti


  ENDMETHOD.


  method CONVERT_REQUEST.

  CONSTANTS: lv_lom TYPE c VALUE '/'.

    CASE chs_request-direction.
      WHEN 'I'.
         SPLIT chs_request-dpo_req_full AT lv_lom INTO chs_request-dpo_request chs_request-dpo_year chs_request-dpo_type.
      WHEN 'O'.
         chs_request-dpo_req_full = |{  chs_request-dpo_request ALPHA = OUT }| &&   lv_lom && chs_request-dpo_year && lv_lom && chs_request-dpo_type .
         CONDENSE chs_request-dpo_req_full NO-GAPS.
    ENDCASE.



  endmethod.


  method CONVERT_STRING_TO_TEXT_TABLE.

    data: lt_string type string_table.
    data: lt_c255   type etxml_line_tabtype.
*    data lt_c132 type STANDARD TABLE OF tdline.

    field-symbols <fs_text> type tline.

    split iv_string at cl_abap_char_utilities=>newline into table lt_string.

    loop at lt_string assigning field-symbol(<fs_string>).
      clear lt_c255[].
      call function 'ECATT_STRING_TO_TABLE'
        exporting
          i_string        = <fs_string>
          i_target_length = '132'
*           i_target_length = '255'
        importing
          et_text         = lt_c255[].


      loop at lt_c255 assigning field-symbol(<fs_c255>).
        append initial line to rt_text_table assigning <fs_text>.
        <fs_text>-tdformat = ' '.
        at first.
          <fs_text>-tdformat = '*'.
        endat.
        <fs_text>-tdline   = <fs_c255>.

      endloop.
      IF sy-subrc NE 0.
          append initial line to rt_text_table assigning <fs_text>.
           <fs_text>-tdformat = '*'.
      ENDIF.

    endloop.

  endmethod.


  method CREATE_TERM.

    DATA ls_thead TYPE thead.
    DATA: ls_term TYPE zhr_dpo_term,
          lv_term_date TYPE sy-datum,
          lv_new_date TYPE sy-datum,
          lv_times TYPE i,
          lv_days  TYPE i,
          lv_months TYPE i,
          lv_time   TYPE uzeit.
    data lv_id type thead-tdid.
    data lv_name  type thead-tdname.
    data lv_spras type sy-langu.
    data lv_object type thead-tdobject.

    lv_times = 365.

     lv_term_date = iv_date_from.

    if iv_date_from = iv_date_to.
      lv_times = 1.
    ENDIF.
    IF iv_frequency EQ 'Jednou'."to do
      lv_times = 1.
    ENDIF.


    SELECT SINGLE value FROM zhr_dpo_cparam
               INTO  @DATA(lv_final)
               WHERE parameter_dpo = 'TER_POPISF'.
        SELECT SINGLE value FROM zhr_dpo_cparam
               INTO @DATA(lv_propose)
               WHERE parameter_dpo = 'TER_POPISN'.

    select SINGLE value from zhr_dpo_cparam into @data(lv_start_time)
                                   where parameter_dpo = 'TERM_START_TIME'.


    DO lv_times TIMES.

    ls_term-term_date =  lv_term_date.
    ls_term-term_time =  lv_start_time && '00'.
    lv_days = 17.
              call function 'IGN_TIMESTAMP_PLUSMINUS'
            exporting
              start_date      = lv_term_date
              start_time      = sy-uzeit
               FORWARD         = ' '
              BACKWARD        = 'X'
              DAYS            = lv_days
*             HOURS           = '0'
*              minutes         = '0'
*             SECONDS         = '0'
            importing
           RESULT_DATE     = lv_new_date

*              result_time     = lv_time
            exceptions
              parameter_error = 1
              others          = 2.

    ls_term-term_sp = lv_new_date.
    ls_term-time_sp = '140000'.
    lv_days = 15.
              call function 'IGN_TIMESTAMP_PLUSMINUS'
            exporting
              start_date      = lv_term_date
              start_time      = sy-uzeit
              FORWARD         = ' '
              BACKWARD        = 'X'
              DAYS            = lv_days
*             HOURS           = '0'
*              minutes         = '0'
*             SECONDS         = '0'
            importing
           RESULT_DATE     = lv_new_date
*              result_time     = lv_time
            exceptions
              parameter_error = 1
              others          = 2.

    ls_term-term_odbory = lv_new_date.
    ls_term-time_odbory = '120000'.

    lv_days = 3.
              call function 'IGN_TIMESTAMP_PLUSMINUS'
            exporting
              start_date      = lv_term_date
              start_time      = sy-uzeit
              FORWARD         = ' '
              BACKWARD        = 'X'
              DAYS            = lv_days
*             HOURS           = '0'
*              minutes         = '0'
*             SECONDS         = '0'
            importing
           RESULT_DATE     = lv_new_date
*              result_time     = lv_time
            exceptions
              parameter_error = 1
              others          = 2.

    ls_term-term_zarad = lv_new_date.
    ls_term-time_zarad = '090000'.


    ls_term-location  = iv_location.
    ls_term-process   = 'P-CENTR'.
    ls_term-status = 'TO'. "termín otevreny

    call function 'NUMBER_GET_NEXT'
      exporting
        nr_range_nr                   = '01'
        object                        = 'ZHR_DPO_T'
     IMPORTING
        NUMBER                        = ls_term-term_id
     EXCEPTIONS
       INTERVAL_NOT_FOUND            = 1
       NUMBER_RANGE_NOT_INTERN       = 2
       OBJECT_NOT_FOUND              = 3
       QUANTITY_IS_0                 = 4
       QUANTITY_IS_NOT_1             = 5
       INTERVAL_OVERFLOW             = 6
       BUFFER_OVERFLOW               = 7
       OTHERS                        = 8
              .
    if sy-subrc <> 0.
* Implement suitable error handling here
    endif.




   ls_thead-tdname = lv_final.
   gs_data_db-final = zcl_hr_dpo_term=>read_text( is_head = ls_thead ).

    INSERT zhr_dpo_term FROM ls_term.
    IF sy-subrc EQ 0.
      rs_return-term_id = ls_term-term_id.
      rs_return-return_code = 'OK'.

    ls_thead-tdid = 'ST'.
    ls_thead-tdname = lv_propose.
    ls_thead-tdspras = sy-langu.
    ls_thead-tdobject = 'TEXT'.
    me->read_text(
      exporting
         is_head     = ls_thead
       importing
         et_text     =  DATA(lt_text)

    ).


     lv_id = 'PRO'.
     lv_name = ls_term-term_id.
     lv_object = 'ZHR_DPO'.
     lv_spras = sy-langu.

      if lt_text[] is not initial.
        call function 'CREATE_TEXT'
          exporting
            fid       = lv_id
            flanguage = sy-langu
            fname     = lv_name
            fobject   = lv_object
*           SAVE_DIRECT       = 'X'
*           FFORMAT   = '*'
          tables
            flines    = lt_text
          exceptions
            no_init   = 1
            no_save   = 2
            others    = 3.
      endif.

      ls_thead-tdname = lv_final.
      REFRESH lt_text.
      me->read_text(
      exporting
         is_head     = ls_thead
       importing
         et_text     =  lt_text

    ).
    if lt_text[] is not initial.
      lv_id = 'FIN'.
        call function 'CREATE_TEXT'
          exporting
            fid       = lv_id
            flanguage = sy-langu
            fname     = lv_name
            fobject   = lv_object
*           SAVE_DIRECT       = 'X'
*           FFORMAT   = '*'
          tables
            flines    = lt_text
          exceptions
            no_init   = 1
            no_save   = 2
            others    = 3.
      endif.


    ELSE.
      rs_return-term_id = ls_term-term_id.
      rs_return-return_code = 'FAIL'.
    ENDIF.
    CASE iv_frequency.
      WHEN 'Tyden'.
           lv_days = 7.
            call function 'IGN_TIMESTAMP_PLUSMINUS'
            exporting
              start_date      = lv_term_date
              start_time      = sy-uzeit
              FORWARD         = 'X'
*             BACKWARD        = ' '
              DAYS            = lv_days
            importing
           RESULT_DATE     = lv_new_date
*              result_time     = lv_time
            exceptions
              parameter_error = 1
              others          = 2.
          if sy-subrc <> 0.
* Implement suitable error handling here
          endif.
      WHEN 'DvouTyden'.
             lv_days = 14.
              call function 'IGN_TIMESTAMP_PLUSMINUS'
            exporting
              start_date      = lv_term_date
              start_time      = sy-uzeit
              FORWARD         = 'X'
*             BACKWARD        = ' '
              DAYS            = lv_days
*             HOURS           = '0'
*              minutes         = '0'
*             SECONDS         = '0'
            importing
           RESULT_DATE     = lv_new_date
*              result_time     = lv_time
            exceptions
              parameter_error = 1
              others          = 2.
          if sy-subrc <> 0.
* Implement suitable error handling here
          endif.
      WHEN 'CtyrTyden'.
             lv_days = 28.

              call function 'IGN_TIMESTAMP_PLUSMINUS'
            exporting
              start_date      = lv_term_date
              start_time      = sy-uzeit
              FORWARD         = 'X'
*             BACKWARD        = ' '
              DAYS            = lv_days
*             HOURS           = '0'
*              minutes         = '0'
*             SECONDS         = '0'
            importing
           RESULT_DATE     = lv_new_date
*              result_time     = lv_time
            exceptions
              parameter_error = 1
              others          = 2.

*             call function 'BKK_ADD_MONTH_TO_DATE'
*               exporting
*                 months        = lv_months
*                 olddate       = lv_term_date
**              IMPORTING
*                 NEWDATE       = lv_new_date
                       .

      WHEN OTHERS.
    ENDCASE.


      IF lv_new_date IS INITIAL.
        EXIT.
      ENDIF.
      IF lv_new_date GE iv_date_to.
        EXIT.
      ENDIF.
      IF lv_new_date(4) GT iv_date_from(4)."další rok
        EXIT.
      ENDIF.
    lv_term_date = lv_new_date.

    ENDDO.
    COMMIT WORK.

  endmethod.


  method delete_term.

    data: ls_bapiret type bapiret2,
          lv_par1    type sy-msgv1.

    rs_return-term_id = gs_data_db-term_id.
    select * from zhr_dpo_termzad into table @data(lt_zad)
                                  where term_id = @gs_data_db-term_id.
    if sy-subrc eq 0.
      loop at lt_zad assigning field-symbol(<fs_zad>).
        data(lo_request) = new zcl_hr_dpo_request( ).
        data(ls_request) = lo_request->read_request( <fs_zad>-dpo_request  ).
        data(ls_result) =   lo_request->assign_term( iv_exclude_term = gs_data_db-term_id ).
        if ls_result-return_code = 'FAIL'.
          lv_par1 = ls_request-dpo_req_full.
          call function 'BALW_BAPIRETURN_GET2'
            exporting
              type   = 'E'
              cl     = 'ZHR_DPO'
              number = '017'
              par1   = lv_par1
            importing
              return = ls_bapiret.


          rs_return-return_code = ls_result-return_code.
          append ls_bapiret to et_message.
        endif.
        append lo_request to tt_request_ref_tab.
      endloop.

      check et_message[] is initial.

      loop at tt_request_ref_tab assigning field-symbol(<fso_request>).
        ls_request = <fso_request>->get_request( ).
        delete from zhr_dpo_termzad where term_id = gs_data_db-term_id
                                     and dpo_request = ls_request-dpo_request.
        if sy-subrc eq 0.
          <fso_request>->save_req( ).
        endif.
      endloop.

*      loop at lt_zad assigning <fs_zad>.
*        delete from zhr_dpo_termzad where term_id = gs_data_db-term_id
*                                      and dpo_request = <fs_zad>-dpo_request.
*        if sy-subrc eq 0.
*          lo_request = new zcl_hr_dpo_request( ).
*          lo_request->read_request( <fs_zad>-dpo_request  ).
*          lo_request->assign_term( iv_exclude_term = gs_data_db-term_id ).
*          lo_request->save_req( ).
*        endif.
*
*      endloop.
    endif.


    delete from zhr_dpo_term where term_id = gs_data_db-term_id.
    if sy-subrc eq 0.
      rs_return-return_code = 'OK'.
    else.
      rs_return-return_code = 'FAIL'.
    endif.
    commit work.

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


  METHOD get_email_contacts_union.
    CLEAR rs_mail_list.
    SELECT * FROM zhr_dpo_bp INTO @DATA(ls_dpo_bp).
      DATA(lv_pernr) = zcl_pa_vs_utils=>get_pernr_by_uname( iv_uname = ls_dpo_bp-hrbp ).
      IF lv_pernr IS NOT INITIAL.
        DATA(ls_contact_data) = zcl_hr_dpo_roles=>get_pernr_details( iv_pernr = lv_pernr ).
        IF ls_contact_data-email IS NOT INITIAL.
          IF rs_mail_list IS INITIAL.
            rs_mail_list = ls_contact_data-email.
          ELSE.
            rs_mail_list = rs_mail_list && `;` && ls_contact_data-email.
          ENDIF.
        ENDIF.
      ENDIF.
    ENDSELECT.
  ENDMETHOD.


  METHOD get_email_header_and_footer.
    CLEAR rs_email_header_and_footer.
    rs_email_header_and_footer-header_text = zcl_hr_dpo_term=>get_long_text( iv_text_code = zcl_hr_dpo_term=>cv_param_term_email_header iv_mail = 'X' ).
    rs_email_header_and_footer-footer_text = zcl_hr_dpo_term=>get_long_text( iv_text_code = zcl_hr_dpo_term=>cv_param_term_email_footer iv_mail = 'X').
  ENDMETHOD.


  method get_long_text.

    data ls_thead type thead.

    select single value from zhr_dpo_cparam
                                         into @data(lv_text)
                                         where parameter_dpo = @iv_text_code.

    if sy-subrc eq 0.
      ls_thead-tdid = 'ST'.
      ls_thead-tdname = lv_text.
      ls_thead-tdspras = sy-langu.
      ls_thead-tdobject = 'TEXT'.
      rs_long_text = zcl_hr_dpo_term=>read_text( is_head = ls_thead iv_mail = iv_mail  ).


    endif.


  endmethod.


  method get_request.

call function 'CONVERSION_EXIT_ALPHA_INPUT'
  exporting
    input         = iv_dpo_request
  IMPORTING
    OUTPUT        = rs_request-dpo_request
          .

call function 'CONVERSION_EXIT_ALPHA_INPUT'
  exporting
    input         = iv_dpo_term
  IMPORTING
    OUTPUT        = rs_request-term_id
          .

   endmethod.


  METHOD get_requests_table.

    DATA: ls_request_s TYPE zhr_dpo_term_req_s,
          lv_time      TYPE uzeit,
          lv_duration  TYPE i,
          lv_new_dur   TYPE i,
          lv_order_nr  TYPE zhr_dpo_order_nr.


    DATA: lt_termzad TYPE TABLE OF zhr_dpo_termzad.

    SELECT SINGLE term_time FROM zhr_dpo_term INTO lv_time
                                 WHERE term_id = iv_term.
    SELECT zhr_dpo_termzad~* FROM zhr_dpo_termzad
        INNER JOIN zhr_dpo_zad ON zhr_dpo_zad~dpo_request = zhr_dpo_termzad~dpo_request
          AND zhr_dpo_zad~term_id = zhr_dpo_termzad~term_id
        INTO CORRESPONDING FIELDS OF TABLE  @lt_termzad
        WHERE zhr_dpo_termzad~term_id EQ @iv_term.
*                                      and ordernr NE '000'.
*                                     and deletion_flag = @abap_false.
    IF sy-subrc EQ 0.
      SELECT * FROM zhr_dpo_cparam INTO TABLE @DATA(lt_param)
                                   WHERE
*         parameter_dpo = 'TERM_START_TIME'
                                        parameter_dpo = 'TERM_REQUEST_DURAT'.
      IF sy-subrc EQ 0.
        SELECT * FROM zhr_dpo_rozdel INTO TABLE @DATA(lt_rozdel)
                         FOR ALL ENTRIES IN  @lt_termzad
                         WHERE dpo_request = @lt_termzad-dpo_request.


*        read table lt_param assigning field-symbol(<fs_param>)
*                                    with key parameter_dpo = 'TERM_START_TIME'.
*        if sy-subrc eq 0.
*          lv_time = <fs_param>-value && '00'.
*        endif.
        READ TABLE lt_param ASSIGNING FIELD-SYMBOL(<fs_param>)
                                    WITH KEY parameter_dpo = 'TERM_REQUEST_DURAT'.
        IF sy-subrc EQ 0.
          lv_duration = <fs_param>-value .
        ENDIF.
      ENDIF.

      DATA(r_status) = VALUE rsdsselopt_t(
                 sign   = if_fsbp_const_range=>sign_exclude
                 option = if_fsbp_const_range=>option_equal
                 ( low    = 'VYM' )
                 ( low    = 'ROJ' )
                 ( low    = 'RAOJ' )
                 ( low    = 'RHRPB' )
                 ( low    = 'RSP' )
                 ( low    = 'ASP' )
                 ( low    = 'PRO' )
                 ( low    = 'PRN' ) ).


      SELECT * FROM zhr_dpo_cstatt INTO TABLE @DATA(lt_stat_desc)
                                   WHERE spras EQ @sy-langu.

      SELECT dpo_request, dpo_year, dpo_type, status, name, request_date, orgeh, orgeh_orig, requestor, notif_status, dpo_req_full
                 FROM zhr_dpo_zad

                 INTO TABLE @DATA(lt_request_tab)
                 FOR ALL ENTRIES IN   @lt_termzad
                 WHERE dpo_request EQ @lt_termzad-dpo_request
                   AND dpo_type = 'P-CENTR'
                   AND status IN @r_status.
      IF sy-subrc EQ 0.

        SELECT objid, short FROM hrp1000 INTO TABLE @DATA(lt_short)
                          FOR ALL ENTRIES IN @lt_request_tab
                          WHERE objid EQ @lt_request_tab-orgeh_orig
                            AND otype EQ 'O'
                            AND plvar EQ '01'
                            AND langu EQ @sy-langu
                            AND begda LE @sy-datum
                            AND endda GE @sy-datum
                            AND istat EQ '1'.




*        SELECT objid, short FROM hrp1000 INTO TABLE @DATA(lt_short)
*                            FOR ALL ENTRIES IN @lt_request_tab
*                            WHERE otype = 'O'
*                             AND  objid = @lt_request_tab-orgeh_orig.


        SORT lt_termzad BY ordernr.

        LOOP AT lt_termzad ASSIGNING FIELD-SYMBOL(<fs_termzad_main>).

          LOOP AT lt_request_tab ASSIGNING FIELD-SYMBOL(<fs_req>)
                                           WHERE dpo_request = <fs_termzad_main>-dpo_request .
            CLEAR ls_request_s.
            MOVE-CORRESPONDING <fs_req> TO ls_request_s.
            ls_request_s-duration = <fs_termzad_main>-duration.
            IF ls_request_s-duration IS INITIAL.
              ls_request_s-duration = lv_duration.
            ENDIF.
            ls_request_s-request_name  = <fs_req>-name.

            IF <fs_req>-status = 'PPE' OR <fs_req>-status = 'BPE'.
              <fs_termzad_main>-ordernr = '999'.
            ENDIF.

*            IF <fs_termzad_main>-ordernr IS INITIAL.
           IF <fs_termzad_main>-ordernr NE '999'.
              <fs_termzad_main>-ordernr = lv_order_nr + 1.
            ENDIF.


            READ TABLE lt_rozdel ASSIGNING FIELD-SYMBOL(<fs_rozdel>)
                                    WITH KEY role = 'HRBP'
                                             dpo_request = <fs_req>-dpo_request.
            IF sy-subrc EQ 0.
              ls_request_s-hrbp_uname = <fs_rozdel>-uname.

              DATA(lv_pernr) = zcl_pa_vs_utils=>get_pernr_by_uname( iv_uname = ls_request_s-hrbp_uname ).
              IF lv_pernr IS NOT INITIAL.
                DATA(ls_user_data) = zcl_hr_dpo_roles=>get_pernr_details( iv_pernr = lv_pernr  ).
                ls_request_s-hrbrp_full_name  = ls_user_data-full_name_s.
                CLEAR: ls_user_data, lv_pernr.
              ENDIF.
            ENDIF.

            READ TABLE lt_rozdel ASSIGNING <fs_rozdel>
                                    WITH KEY role = 'ZAD'
                                             dpo_request = <fs_req>-dpo_request.
            IF sy-subrc EQ 0.
              ls_request_s-creator = <fs_req>-requestor.
              lv_pernr = zcl_pa_vs_utils=>get_pernr_by_uname( iv_uname = ls_request_s-creator ).
              IF lv_pernr IS NOT INITIAL.
                ls_user_data = zcl_hr_dpo_roles=>get_pernr_details( iv_pernr = lv_pernr  ).
                ls_request_s-creator_full_name  = ls_user_data-full_name_s.
                CLEAR: ls_user_data, lv_pernr.
              ENDIF.

            ENDIF.

            ls_request_s-erdat = <fs_req>-request_date.
            ls_request_s-req_time = <fs_termzad_main>-req_time.
*            IF ls_request_s-req_time IS INITIAL.
            ls_request_s-req_time = lv_time.
*            ENDIF.

            READ TABLE lt_short ASSIGNING FIELD-SYMBOL(<fs_short>)
                                WITH KEY objid = <fs_req>-orgeh_orig.
            IF sy-subrc EQ 0.
              ls_request_s-short = <fs_short>-short.
            ENDIF.


            READ TABLE lt_stat_desc ASSIGNING FIELD-SYMBOL(<fs_stat_desc>)
                                      WITH KEY object = 'R'
                                               status = <fs_req>-status.
            IF sy-subrc EQ 0.
              ls_request_s-status_descr = <fs_stat_desc>-description.
            ENDIF.


            ls_request_s-result_term = <fs_termzad_main>-result_term.
            ls_request_s-notif_status = <fs_req>-notif_status.
            ls_request_s-ordernr = <fs_termzad_main>-ordernr.

            READ TABLE lt_stat_desc ASSIGNING <fs_stat_desc>
                                    WITH KEY object = 'N'
                                             status = ls_request_s-notif_status.
            IF sy-subrc EQ 0.
              ls_request_s-notif_status_descr = <fs_stat_desc>-description.
            ENDIF.
*            endif.
            IF ls_request_s-dpo_req_full IS INITIAL.
              DATA(ls_conv) = VALUE zhr_dpo_zadconv( dpo_request = ls_request_s-dpo_request
                                                 dpo_year = ls_request_s-dpo_year
                                                 dpo_type = ls_request_s-dpo_type
                                                 direction = 'O' ).
              zcl_hr_dpo_request=>convert_request(
                CHANGING
                  chs_request = ls_conv                 " Konverze čísla žádosti
              ).
              ls_request_s-dpo_req_full = ls_conv-dpo_req_full.

            ENDIF.
            ls_request_s-term_id = iv_term.
            IF ls_request_s-dpo_type = 'P-CENTR'.
              APPEND ls_request_s TO rt_request_tab.
            ENDIF.
          ENDLOOP.
          IF sy-subrc NE 0.
            CONTINUE.
          ENDIF.
          IF <fs_termzad_main>-ordernr NE '999'.
            lv_order_nr = <fs_termzad_main>-ordernr.
          ENDIF.
          lv_new_dur = ls_request_s-duration.
          IF  <fs_termzad_main>-ordernr EQ '999'.
            CLEAR:  lv_new_dur, ls_request_s-duration.
          ENDIF.
          CALL FUNCTION 'IGN_TIMESTAMP_PLUSMINUS'
            EXPORTING
              start_date      = sy-datum
              start_time      = lv_time
              forward         = 'X'
*             BACKWARD        = ' 'f
*             DAYS            = '0'
*             HOURS           = '0'
              minutes         = lv_new_dur
*             SECONDS         = '0'
            IMPORTING
*             RESULT_DATE     =
              result_time     = lv_time
            EXCEPTIONS
              parameter_error = 1
              OTHERS          = 2.
          IF sy-subrc <> 0.
* Implement suitable error handling here
          ENDIF.

        ENDLOOP.

      ENDIF.

    ENDIF.
    SORT rt_request_tab BY ordernr.
    IF iv_only_non_electronic = abap_true.
      DELETE rt_request_tab WHERE ordernr = '999'.
    ENDIF.


  ENDMETHOD.


  method GET_TERMS.

    return = gs_data_db.
  endmethod.


  METHOD get_term_list.

    DATA ls_term TYPE zhr_dpo_term_struct.
    DATA ls_thead TYPE thead.
    DATA r_date TYPE RANGE OF sy-datum.
    DATA r_date_sp TYPE RANGE OF sy-datum.
    DATA r_date_odb TYPE RANGE OF sy-datum.
    DATA r_date_zarad TYPE RANGE OF sy-datum.
    DATA lv_datum TYPE sy-datum.
    DATA lv_act_found TYPE xfeld.
    DATA rs_date LIKE LINE OF r_date.

    IF with_proposed_term = 'E'.
      r_date = CORRESPONDING #( term_date_range ).
    ELSE.

      IF term_date_range[] IS NOT INITIAL.
        rs_date-sign = 'I'.
        rs_date-option = 'BT'.
        LOOP AT term_date_range ASSIGNING FIELD-SYMBOL(<fs_date>).
          IF rs_date-low IS INITIAL.
            lv_datum = <fs_date>-low.
            ADD 1 TO lv_datum.
            rs_date-low  = lv_datum..
          ELSE.
            rs_date-high  = <fs_date>-low.
          ENDIF.
        ENDLOOP.
        IF rs_date-high IS INITIAL  .
          rs_date-high = '99991231'.
        ENDIF.
        APPEND rs_date TO r_date.
      ENDIF.

    ENDIF.

    CLEAR rs_date.
    DATA(lv_proposed_term) = with_proposed_term.
    IF lines( term_sp_range ) = 1.
      lv_proposed_term = abap_true.
    ENDIF.
    IF term_sp_range[] IS NOT INITIAL.
      rs_date-sign = 'I'.
      rs_date-option = 'BT'.
      LOOP AT term_sp_range ASSIGNING <fs_date>.
        IF rs_date-low IS INITIAL.
          lv_datum = <fs_date>-low.
          IF lv_proposed_term = abap_false.
            ADD 1 TO lv_datum.
          ENDIF.
          rs_date-low  = lv_datum.
          IF lv_proposed_term = abap_true.
            rs_date-option = 'GE'.
            IF sy-uzeit GT '140000'.
* po 14h musime o den posunout
              ADD 1 TO lv_datum.
            ENDIF.
          ENDIF.
        ELSE.
          rs_date-high  = <fs_date>-low.
        ENDIF.

      ENDLOOP.
      APPEND rs_date TO r_date_sp.
    ENDIF.

    CLEAR rs_date.
    IF term_odb_range[] IS NOT INITIAL.
      rs_date-sign = 'I'.
      rs_date-option = 'BT'.
      LOOP AT term_odb_range ASSIGNING <fs_date>.
        IF rs_date-low IS INITIAL.
          lv_datum = <fs_date>-low.
          ADD 1 TO lv_datum.
          rs_date-low  = lv_datum.
        ELSE.
          rs_date-high  = <fs_date>-low.
        ENDIF.
      ENDLOOP.
      APPEND rs_date TO r_date_odb.
    ENDIF.

    CLEAR rs_date.
    IF term_zarad_range[] IS NOT INITIAL.
      rs_date-sign = 'I'.
      rs_date-option = 'BT'.
      LOOP AT term_zarad_range ASSIGNING <fs_date>.
        IF rs_date-low IS INITIAL.
          lv_datum = <fs_date>-low.
          ADD 1 TO lv_datum.
          rs_date-low  = lv_datum.
        ELSE.
          rs_date-high  = <fs_date>-low.
        ENDIF.
      ENDLOOP.
      APPEND rs_date TO r_date_zarad.
    ENDIF.


    SELECT   a~term_id, a~location, a~term_date, a~term_time, a~status, b~description,
             a~process, a~term_sp, a~time_sp, a~term_odbory, a~time_odbory,
             a~term_zarad, a~time_zarad, a~note
             FROM zhr_dpo_term AS a
             LEFT JOIN zhr_dpo_cstatt AS b
             ON  a~status EQ b~status

             INTO TABLE @DATA(lt_term_list)
             WHERE a~term_id  IN @term_range
               AND a~location IN @location_range
               AND a~term_date   IN @r_date
               AND a~status      IN @status_range
               AND a~term_sp     IN @r_date_sp
               AND a~term_odbory IN @r_date_odb
               AND a~term_zarad  IN @r_date_zarad
               AND spras EQ @sy-langu.


    IF sy-subrc EQ 0.
      SELECT process, description FROM zhr_dpo_cproct
                                  INTO TABLE @DATA(lt_process)
                                   FOR ALL ENTRIES IN @lt_term_list
                                   WHERE process EQ @lt_term_list-process
                                   AND spras EQ @sy-langu.


      SORT lt_term_list BY term_date ASCENDING term_time ASCENDING.


      LOOP AT lt_term_list ASSIGNING FIELD-SYMBOL(<fs_term>).
        IF ( ( <fs_term>-term_date EQ sy-datum AND <fs_term>-term_time GT sy-uzeit )
        OR <fs_term>-term_date GT sy-datum ) AND lv_act_found IS INITIAL.
          ls_term-highlight = 'Error'.
*Information - Modrá
*Error - červená
*Success - Zelená
*Warning - Oranžová
          lv_act_found = abap_true.

        ENDIF.

        MOVE-CORRESPONDING <fs_term> TO ls_term.
        ls_term-status_desc = <fs_term>-description.
        READ TABLE lt_process ASSIGNING FIELD-SYMBOL(<fs_process>)
                              WITH KEY process = <fs_term>-process.
        IF sy-subrc EQ 0.
          ls_term-process_desc = <fs_process>-description.
        ENDIF.
        ls_thead-tdid = 'PRO'.
        ls_thead-tdname = ls_term-term_id.
        ls_thead-tdspras = sy-langu.
        ls_thead-tdobject = 'ZHR_DPO'.
        ls_term-proposal = zcl_hr_dpo_term=>read_text( EXPORTING  is_head    = ls_thead ).
        ls_thead-tdid = 'FIN'.
        ls_thead-tdname = ls_term-term_id.
        ls_thead-tdspras = sy-langu.
        ls_thead-tdobject = 'ZHR_DPO'.
        ls_term-final = read_text( EXPORTING  is_head    = ls_thead ).

        APPEND ls_term TO rt_term_list.
        CLEAR ls_term.
      ENDLOOP.


* najdi najbližši vhodny termin pri zakladani žádosti FIA2008-244
      IF lv_proposed_term = abap_true.
        SORT lt_term_list BY term_sp ASCENDING term_time ASCENDING.
        LOOP AT lt_term_list ASSIGNING <fs_term>.
          IF ( ( <fs_term>-term_sp EQ sy-datum AND <fs_term>-time_sp GT sy-uzeit )
          OR <fs_term>-term_sp GT sy-datum ).

            READ TABLE rt_term_list ASSIGNING FIELD-SYMBOL(<fs_rt_list>)
                                    WITH KEY term_id = <fs_term>-term_id.
            IF sy-subrc EQ 0.
              <fs_rt_list>-proposed_term = abap_true.
            ENDIF.
            EXIT.
          ENDIF.
        ENDLOOP.
      ENDIF.

    ENDIF.


    SORT rt_term_list BY term_date  term_time .


  ENDMETHOD.


  METHOD INIT_FORM_DATA.

    DATA ls_thead TYPE thead.
    DATA lv_template_code TYPE zhr_dpo_templ_code.

*    TRY.

*        gs_custom_request =  gt_custom_request[ process =  gv_process_type status = 'ROJ' ].
        gs_custom_template = gt_custom_template[ template_code =  lv_template_code ].

*      CATCH cx_sy_itab_line_not_found .
*    ENDTRY.

    ls_thead-tdid = 'ST'.
    ls_thead-tdname = gs_custom_template-request_mail_text.
    ls_thead-tdspras = sy-langu.
    ls_thead-tdobject = 'TEXT'.
    gs_data_db-proposal = zcl_hr_dpo_term=>read_text( is_head =  ls_thead ).

   ls_thead-tdname = gs_custom_template-notation_mail_text.
   gs_data_db-final = read_text( is_head = ls_thead ).


    ENDMETHOD.


  METHOD mail_contacts.
    CLEAR rs_mail_list.
    DATA lv_parameter TYPE zhr_dpo_parameter.

    CASE iv_button_press.
      WHen 'DohNavrh'
        OR 'DohFinal1'
        OR 'DohFinal1'.
         lv_parameter = 'ROZD_C5'.
      WHEN 'Proposal'.
        lv_parameter = 'ROZD_C2'.
      WHEN 'Final'.
        lv_parameter = 'ROZD_C3'.
      WHEN 'Union'.
        lv_parameter = 'ROZD_C1'.
*        rs_mail_list = zcl_hr_dpo_term=>get_email_contacts_union( ).
    ENDCASE.

    IF rs_mail_list IS INITIAL
      AND lv_parameter IS NOT INITIAL
    .
      SELECT SINGLE value FROM zhr_dpo_cparam INTO @DATA(lv_distr_list)
                         WHERE parameter_dpo = @lv_parameter.
      IF sy-subrc EQ 0.
        rs_mail_list =  zcl_hr_dpo_service=>get_distribution_list_mails( iv_distribution_list = CONV #( lv_distr_list ) ).
      ENDIF.
    ENDIF.

  ENDMETHOD.


  method prepare_word_template.

    data: lv_length     type i,
          lt_data_tab   type standard table of x255,
          lv_docx       type xstring,
          lv_string     type string,
          lv_longtext   type string,
          lr_docx       type ref to cl_docx_document,
          lr_main       type ref to cl_docx_maindocumentpart,
          lr_custom_col type ref to cl_openxml_partcollection,
          lr_custom     type ref to cl_oxml_customxmlpart,
          lv_it         type i,
          lv_custom_xml type xstring,
          lv_date       type string,
          it_tab        type filetable,
          lv_filename   type string,
          lv_rc         type i,
          lv_radek      type string value '<w:t>Radek</w:t>'.

* 1ST STEP - READ FILE AND FIND CUSTOM XML

    data(lo_request) = new zcl_hr_dpo_request( ).

    data(ls_request) = lo_request->read_request( iv_dpo_request ).
    data(lt_lines) =  lo_request->convert_string_to_text_table( iv_string = ls_request-text  ).
    data(lt_history) = lo_request->get_history( no_behalfs = 'X' ).



    lv_docx = iv_xstring.

    call method cl_docx_document=>load_document
      exporting
        iv_data = lv_docx
      receiving
        rr_doc  = lr_docx.

    check lr_docx is bound.
    lr_main = lr_docx->get_maindocumentpart( ).
    data(lv_xml) = lr_main->get_data( ).
    call function 'CRM_IC_XML_XSTRING2STRING'
      exporting
        inxstring = lv_xml
      importing
        outstring = lv_string.

    loop at lt_lines assigning field-symbol(<fs_lines>).
      lv_longtext = lv_longtext && '<w:t>' && <fs_lines>-tdline && '</w:t><w:cr/>'.
    endloop.
    replace first occurrence of lv_radek in lv_string with lv_longtext.
    call function 'SCMS_STRING_TO_XSTRING'
      exporting
        text   = lv_string
      importing
        buffer = lv_xml.
* Replace main part with new data and save it
    lr_main->feed_data( iv_data = lv_xml ).
    lv_docx = lr_docx->get_package_data( ).


    lr_custom_col = lr_main->get_customxmlparts( ).
* We can have more than 1 custom xml files
* so let's find correct one and if exists
    data(lv_size) = lr_custom_col->get_count( ).
    data: lv_flag type flag value abap_false.
    do lv_size times.
      lv_it = sy-index - 1.
      lr_custom ?= lr_custom_col->get_part( iv_index = lv_it ).
      lv_xml = lr_custom->get_data( ).
      call function 'CRM_IC_XML_XSTRING2STRING'
        exporting
          inxstring = lv_xml
        importing
          outstring = lv_string.

      find first occurrence of 'xmlns="WORD_TEMPLATE"' in lv_string.
      if sy-subrc eq 0.
* our custom xml was found
        lv_flag = abap_true.
        exit.
      endif.
    enddo.
    data: ls_thead type thead.



* 2ND STEP - CREATE OR CHANGE CUSTOM XML
*---------------------------------------
    case lv_flag.
      when abap_false. "our custom xml is not there yet so we create it
*    lr_custom = lr_main->add_customxmlpart( ).
*
*    CONCATENATE '<?xml version="1.0" encoding="utf-8"?>'
*              '<data xmlns="custom">'
*              '<NAME>%Name%</NAME>'
*              '<LAST_NAME>%Last Name%</LAST_NAME>'
*              '<DATE>%Date%</DATE>'
*              '</data>'
*    INTO DATA(lv_custom).
*
*    CALL FUNCTION 'SCMS_STRING_TO_XSTRING'
*      EXPORTING
*        text   = lv_custom
*      IMPORTING
*        buffer = lv_custom_xml.
      when abap_true.  "we provide data for document
* lr_custom and lv_xml are correctly filled from loop
* Change data in custom XML
        call function 'CRM_IC_XML_XSTRING2STRING'
          exporting
            inxstring = lv_xml
          importing
            outstring = lv_string.






        replace first occurrence of '%RequestName%' in lv_string
        with ls_request-name.
        replace first occurrence of '%REQUEST_FULL%' in lv_string
        with ls_request-dpo_req_full.
        concatenate ls_request-term_date+6(2) '.' ls_request-term_date+4(2) '.' ls_request-term_date+0(4)
        into lv_date.
        replace first occurrence of '%Date%' in lv_string
        with lv_date.

* za ŠA mena
        data: lv_names type string.
        data(lt_hist_tmp) = lt_history[].
        sort lt_hist_tmp by role uname datum descending time descending.
        delete adjacent duplicates from lt_hist_tmp comparing role orig_user.

        loop at lt_hist_tmp assigning field-symbol(<fs_hist>)
                                       where ( role = 'ZAD_NEXT'
                                          or role = 'ZAD'
                                          or role = 'HRBP' )
*                                          or role = 'SP' )
                                         and clarification eq ''
                                         and form_id is not initial.
          .


          if lv_names is initial.
            lv_names = <fs_hist>-name_full && ','.
          else.
            if lv_names cs <fs_hist>-name_full.
              continue.
            endif.
            <fs_hist>-name_full = <fs_hist>-name_full && ','.
            concatenate lv_names  <fs_hist>-name_full into lv_names separated by space.
          endif.
        endloop.

        lt_hist_tmp = lt_history[].
        sort lt_hist_tmp by role uname datum descending time descending.
        loop at lt_hist_tmp assigning <fs_hist>
                                           where role = 'SP'
                                             and next_status = 'ASP'.
          if lv_names cs <fs_hist>-name_full.
            exit.
          endif.
          <fs_hist>-name_full = <fs_hist>-name_full && ','.
          concatenate lv_names  <fs_hist>-name_full into lv_names separated by space.
          exit.
        endloop.

        data(lv_len) = strlen( lv_names ).
        lv_len = lv_len - 1."odstran carku na konci
        lv_names = lv_names(lv_len).

        replace first occurrence of '%LONG_TEXT%' in lv_string
          with lv_names.


        call function 'SCMS_STRING_TO_XSTRING'
          exporting
            text   = lv_string
          importing
            buffer = lv_custom_xml.

    endcase.
* 3RD STEP - SAVE IT
*---------------------------------------
    lr_custom->feed_data( iv_data = lv_custom_xml ).
    lv_docx = lr_docx->get_package_data( ).
    lv_length  = xstrlen( lv_docx ).
    ev_final_xstring = lv_docx.


  endmethod.


  method READ_CUSTOMIZING.

    SELECT * FROM ZHR_DPO_CZAD INTO TABLE gt_custom_request.

    SELECT * FROM zhr_dpo_csabl INTO TABLE gt_custom_template.

  endmethod.


  method read_term.

    data ls_thead type thead.

    select single a~term_id, a~location, a~term_date, a~term_time, a~status, b~description,
             a~process, a~term_sp, a~time_sp, a~term_odbory, a~time_odbory, a~term_zarad, a~time_zarad, a~note
             from zhr_dpo_term as a
             inner join zhr_dpo_cstatt as b
             on  a~status eq b~status
             into @data(ls_term_list)
             where a~term_id  eq @iv_term
               and spras eq @sy-langu.


    if sy-subrc eq 0.
      select single  description from zhr_dpo_cproct
                                  into  @rs_term-process_desc
                                  where process eq @ls_term_list-process
                                  and spras eq @sy-langu.


    endif.

    MOVE-CORRESPONDING ls_term_list TO rs_term.
    rs_term-status_desc = ls_term_list-description.
*    rs_term-highlight = 'Success'.


    ls_thead-tdid = 'PRO'.
    ls_thead-tdname = iv_term.
    ls_thead-tdspras = sy-langu.
    ls_thead-tdobject = 'ZHR_DPO'.
    rs_term-proposal = zcl_hr_dpo_term=>read_text( exporting  is_head    = ls_thead
                                  ).
    IF rs_term-proposal IS INITIAL.

    ENDIF.

    ls_thead-tdid = 'FIN'.
    rs_term-final = read_text( exporting  is_head    = ls_thead
                                ).
    MOVE-CORRESPONDING rs_term TO gs_data_db.


  endmethod.


  METHOD READ_TEXT.

 DATA: lt_lines TYPE TABLE OF tline.

CALL FUNCTION 'READ_TEXT'
  EXPORTING
*   CLIENT                        = SY-MANDT
    id                            = is_head-tdid
    language                      = is_head-tdspras
    NAME                          = is_head-tdname
    OBJECT                        = is_head-tdobject
  TABLES
    lines                         = lt_lines
 EXCEPTIONS
   ID                            = 1
   LANGUAGE                      = 2
   NAME                          = 3
   NOT_FOUND                     = 4
   OBJECT                        = 5
   REFERENCE_CHECK               = 6
   WRONG_ACCESS_TO_ARCHIVE       = 7
   OTHERS                        = 8
          .
IF sy-subrc <> 0.
* Implement suitable error handling here
ENDIF.

LOOP AT lt_lines ASSIGNING FIELD-SYMBOL(<fs_text>).
  if rv_longtext IS INITIAL.
     rv_longtext = <fs_text>-tdline.
  else.
    case <fs_text>-tdformat.
      WHEN ' '
        OR '/'.
          rv_longtext = |{ rv_longtext } { <fs_text>-tdline }|.
      WHEN '*'.
          rv_longtext = SWITCH string( iv_mail WHEN  '' THEN |{ rv_longtext }\n{ <fs_text>-tdline }|
                                               WHEN  'X'  THEN |{ rv_longtext }<br>{ <fs_text>-tdline }| ).
    ENDCASE.

  endif.

ENDLOOP.
et_text[] = lt_lines[].


  ENDMETHOD.


  method remove_request_from_term.

    data: ls_termzad type zhr_dpo_termzad.



    data(lo_request) = new zcl_hr_dpo_request( ).
    lo_request->read_request( iv_dpo_request ).
    ls_termzad-dpo_request = iv_dpo_request.
    ls_termzad-term_id = iv_dpo_term.
*    ls_termzad-deletion_flag = abap_true.

    delete from zhr_dpo_termzad where term_id = iv_dpo_term
                                  and dpo_request = iv_dpo_request.

    if sy-subrc eq 0.

      lo_request->assign_term( iv_exclude_term = iv_dpo_term ).
      lo_request->save_req( ).
*
      rs_status-term_id = iv_dpo_term.
      rs_status-return_code  = me->co_ok.
    else.
      rs_status-term_id = iv_dpo_term.
      rs_status-return_code  = me->co_ok.
    endif.
    commit work.

  endmethod.


  method SAVE_AS_DRAFT.
*CALL METHOD SUPER->SAVE_AS_DRAFT
*    .


     save_term( ).
  endmethod.


  METHOD SAVE_AS_DRAFT_TERM.

     save_term( ).


  ENDMETHOD.


  method save_term.

    data: ls_zhr_dpo_term type zhr_dpo_term.
    data lv_id type thead-tdid.
    data lv_name  type thead-tdname.
    data lv_object type thead-tdobject.
    data: ls_header      type thead,
          lt_lines       type standard table of tline,
          lt_lines_check type standard table of tline.


    ls_header-tdid = 'PRO'.
    ls_header-tdobject = 'ZHR_DPO'.
    ls_header-tdspras = sy-langu.
    lv_id = 'PRO'.
    lv_object = 'ZHR_DPO'.

    lv_name = gs_data_db-term_id.
    ls_header-tdname = gs_data_db-term_id.
    lt_lines[] = convert_string_to_text_table( iv_string = gs_data_db-proposal  ).

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
        endif.
      else.
        call function 'SAVE_TEXT'
          exporting
*           CLIENT   = SY-MANDT
            header   = ls_header
*           INSERT   = ' '
          tables
            lines    = lt_lines
          exceptions
            id       = 1
            language = 2
            name     = 3
            object   = 4
            others   = 5.

      endif.



    ls_header-tdid =  lv_id =  'FIN'.
    lv_name = gs_data_db-term_id.
    ls_header-tdname = gs_data_db-term_id.
    lt_lines[] = convert_string_to_text_table( iv_string = gs_data_db-final  ).

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
      ENDIF.
      else.
        call function 'SAVE_TEXT'
          exporting
*           CLIENT   = SY-MANDT
            header   = ls_header
*           INSERT   = ' '
          tables
            lines    = lt_lines
          exceptions
            id       = 1
            language = 2
            name     = 3
            object   = 4
            others   = 5.

      endif.





    move-corresponding gs_data_db to ls_zhr_dpo_term.
    modify zhr_dpo_term from ls_zhr_dpo_term.
    if sy-subrc eq 0.
      rs_return-term_id = ls_zhr_dpo_term-term_id.
      rs_return-return_code = 'OK'.
    else.
      rs_return-term_id = ls_zhr_dpo_term-term_id.
      rs_return-return_code = 'FAIL'.
    endif.

    COMMIT WORK.

  endmethod.


  method SET_TERM.

    MOVE-CORRESPONDING is_term TO gs_data_db.


  endmethod.


  method TEST_METHOD.

    read_customizing( ).
    init_form_data( ).
    data(ls_request) = get_terms( ).

  endmethod.


  method UNI_HRBP.

*    WRITE 'Zavolána metoda UNI_HRBP'.
*
*    gs_data_db-send_date = sy-datum.
*    save_req( ).




  endmethod.


  method UNI_OJ.

*       WRITE 'Zavolána metoda UNI_OJ'.
*        gs_data_db-send_date = sy-datum.
*      save_req( ).
  endmethod.


  method UPDATE_ORDER_NR.

    SELECT SINGLE * FROM zhr_dpo_termzad INTO @DATA(ls_termzad)
                            WHERE dpo_request = @iv_dpo_request
                             AND term_id = @iv_dpo_term.
    IF sy-subrc EQ 0.
      IF iv_ordernr IS NOT INITIAL.
        ls_termzad-ordernr = iv_ordernr.
      ENDIF.
      IF iv_time IS NOT INITIAL.
        ls_termzad-req_time = iv_time.
      ENDIF.
      IF iv_dpo_duration IS NOT INITIAL.
        ls_termzad-duration = iv_dpo_duration.
      ENDIF.

    ENDIF.
    MODIFY zhr_dpo_termzad FROM ls_termzad.

*    UPDATE zhr_dpo_termzad SET ordernr = iv_ordernr
**                               req_time = iv_time
*                                duration  = iv_dpo_duration
*                           WHERE dpo_request = iv_dpo_request
*                             AND term_id = iv_dpo_term.
*    ENDIF.
*    IF iv_time IS NOT INITIAL AND iv_ordernr IS INITIAL.
*    UPDATE zhr_dpo_termzad SET
*                                 req_time = iv_time
*                                 duration  = iv_dpo_duration
*                           WHERE dpo_request = iv_dpo_request
*                             AND term_id = iv_dpo_term.
*    ENDIF.
*    IF iv_time IS NOT INITIAL AND iv_ordernr IS NOT INITIAL.
*    UPDATE zhr_dpo_termzad SET   ordernr = iv_ordernr
*                                  req_time = iv_time
*                                 duration  = iv_dpo_duration
*                           WHERE dpo_request = iv_dpo_request
*                             AND term_id = iv_dpo_term.
*    ENDIF.
    IF sy-subrc EQ 0.
      COMMIT WORK.
      rs_return-return_code = 'OK'.
      rs_return-term_id = iv_dpo_term.
    ELSE.
       rs_return-return_code = 'FAIL'.
      rs_return-term_id = iv_dpo_term.
    ENDIF.
  endmethod.


  method update_requests_status.


    data: lv_status type zhr_dpo_status_req.

    check gs_data_db-status eq 'TN'
       or gs_data_db-status eq 'TF'.


    DATA(r_status) = VALUE rsdsselopt_t(
                 sign   = if_fsbp_const_range=>sign_exclude
*                 sign = if_fsbp_const_range=>sign_include
                 option = if_fsbp_const_range=>option_equal
*                 ( low    = 'SUN' )
*                 ( low    = 'ANO' )  ).
                 ( low    = 'VYM' )
                 ( low    = 'ROJ' )
                 ( low    = 'RAOJ' )
                 ( low    = 'RHRPB' )
                 ( low    = 'RSP' )
                 ( low    = 'ASP' )
                 ( low    = 'AVSP' )
                 ( low    = 'PRO' )
                 ( low    = 'PRN' )
                 ( low    = 'BPE' )
                 ( low    = 'PPE' )
                 ( low    = 'STO' )
                ).

    select * from zhr_dpo_termzad into table @data(lt_termzad)
                                  where term_id = @gs_data_db-term_id
                                    and dpo_request IN ( SELECT dpo_request FROM zhr_dpo_zad
                                                        WHERE term_id = @gs_data_db-term_id
                                                          AND ( status IN @r_status ) ).
                          .
    if sy-subrc eq 0.
      loop at lt_termzad assigning field-symbol(<fs_termzad>).
        data(lo_request) = new zcl_hr_dpo_request( ).
        lo_request->read_request( iv_dpo_request = <fs_termzad>-dpo_request   ).

        case gs_data_db-status.
          when 'TN'.
            lv_status = 'ANO'.
          when 'TF'.
            lv_status = 'PZP'.
          when others.

        endcase.

        if lv_status is not initial.
          data(ls_return) = lo_request->set_next_status( iv_next_status = conv #( lv_status )
                                         iv_ignore_actual_status = abap_true
                                         iv_uname = iv_uname  ).
          lo_request->save_req( ).
        endif.

      endloop.
    endif.

  endmethod.


  METHOD update_req_stat_from_to.
    DATA: lv_next_status TYPE zhr_dpo_status_req.
    REFRESH rt_updated_requests.
    SELECT * FROM zhr_dpo_termzad INTO TABLE @DATA(lt_termzad)
      WHERE term_id = @gs_data_db-term_id
    .
    IF sy-subrc EQ 0.
      LOOP AT lt_termzad ASSIGNING FIELD-SYMBOL(<fs_termzad>).
        CLEAR lv_next_status.
        DATA(lo_request) = NEW zcl_hr_dpo_request( ).
        DATA(ls_request) = lo_request->read_request( iv_dpo_request = <fs_termzad>-dpo_request   ).
        IF ls_request-status = iv_status_from.
          lv_next_status = iv_status_to.
          DATA(ls_return) = lo_request->set_next_status( iv_next_status = lv_next_status
                                                         iv_ignore_actual_status = abap_true
                                                         iv_uname = iv_origin_user  ).
          lo_request->save_req( ).
          DATA(ls_updated_request) = lo_request->read_request( iv_dpo_request = <fs_termzad>-dpo_request ).
          APPEND ls_updated_request TO rt_updated_requests.
        ENDIF.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
