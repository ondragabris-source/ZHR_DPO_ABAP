class ZCL_HR_DPO_NOTIF definition
  public
  inheriting from ZCL_HR_DPO_MAIN
  final
  create public .

public section.

  types:
    TT_CUSTOM_REQUEST TYPE STANDARD TABLE OF ZHR_DPO_CZAD .
  types:
    TT_CUSTOM_TEMPLATE TYPE STANDARD TABLE OF ZHR_DPO_CSABL .

  data GS_DATA_DB type ZHR_DPO_NOTIF_S .
  data GS_CUSTOM_REQUEST type ZHR_DPO_CZAD .
  data GT_CUSTOM_REQUEST type TT_CUSTOM_REQUEST .
  data GS_CUSTOM_TEMPLATE type ZHR_DPO_CSABL .
  data GT_CUSTOM_TEMPLATE type TT_CUSTOM_TEMPLATE .
  data GV_PROCESS_TYPE type ZHR_DPO_PROCESS value 'PC' ##NO_TEXT.
  constants CV_REQUEST type ZHR_DPO_OBJECT value 'R' ##NO_TEXT.

  methods READ_CUSTOMIZING .
  methods READ_NOTIF
    importing
      !IV_DPO_REQUEST type ZHR_DPO_REQUEST
      !IV_DPO_TERM type ZHR_DPO_ID_TERM
    returning
      value(RETURN) type ZHR_DPO_NOTIF_S .
  methods TEST_METHOD .
  methods BUTTON_PRESS
    importing
      !IV_BUTTON type ZHR_DPO_BUTTON
      !IV_CONDITION type ZHR_DPO_CONDITION .
  methods SAVE_AS_DRAFT_TERM .
  methods SAVE_TERM .
  methods UNI_HRBP .
  methods GET_NOTIF_HISTORY
    importing
      !IV_TERM type ZHR_DPO_ID_TERM
      !IV_DPO_REQUEST type ZHR_DPO_REQUEST
    exporting
      !ET_MESSAGE type BAPIRET2_T
    returning
      value(RT_NOTIF_TAB) type ZHR_DPO_NOTIF_T .
  methods GET_NOTIFICATION
    importing
      !IV_TERM type ZHR_DPO_ID_TERM
      !IV_DPO_REQUEST type ZHR_DPO_REQUEST
    exporting
      !ET_MESSAGE type BAPIRET2_T
    returning
      value(RS_NOTIF) type ZHR_DPO_NOTIF_S .
  methods READ_TEXT
    importing
      !IS_HEAD type THEAD optional
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
  methods GET_LONG_TEXT
    importing
      !IV_TEXT_CODE type ZHR_DPO_VALUE
    returning
      value(RS_LONG_TEXT) type STRING .
  methods GET_REQUESTS_TABLE
    importing
      !IV_TERM type ZHR_DPO_ID_TERM
    exporting
      !ET_MESSAGE type BAPIRET2_T
    returning
      value(RT_REQUEST_TAB) type ZHR_DPO_TERM_REQ_T .

  methods INIT_FORM_DATA
    redefinition .
  methods SAVE_AS_DRAFT
    redefinition .
protected section.
private section.

  methods UNI_OJ .
ENDCLASS.



CLASS ZCL_HR_DPO_NOTIF IMPLEMENTATION.


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


  method GET_LONG_TEXT.

    data ls_thead type thead.

    select single value from zhr_dpo_cparam
                                         into @data(lv_text)
                                         where parameter_dpo = @iv_text_code.

    if sy-subrc eq 0.
      ls_thead-tdid = 'ST'.
      ls_thead-tdname = lv_text.
      ls_thead-tdspras = sy-langu.
      ls_thead-tdobject = 'TEXT'.
      rs_long_text = read_text(  ls_thead  ).


    endif.


  endmethod.


  method GET_NOTIFICATION.

    SELECT * FROM zhr_dpo_histzap INTO TABLE @DATA(lt_notif)
                                 WHERE dpo_request = @iv_dpo_request
                                   AND term_id     = @iv_term.

    IF sy-subrc EQ 0.
      SORT lt_notif BY seqnr DESCENDING.
      DELETE ADJACENT DUPLICATES FROM lt_notif COMPARING dpo_request term_id.
      READ TABLE lt_notif ASSIGNING FIELD-SYMBOL(<fs_notif>) INDEX 1.
      IF sy-subrc EQ 0.
        MOVE-CORRESPONDING <fs_notif> TO rs_notif.

      ENDIF.

    ENDIF.

  endmethod.


  method get_notif_history.

    data: ls_notif      type zhr_dpo_notif_s,
          s_dpo_request type range of zhr_dpo_request,
          s_term        type range of zhr_dpo_id_term.

    if iv_dpo_request is not initial.

      s_dpo_request = value #( sign = 'I'  option = 'EQ' ( low = iv_dpo_request  ) ).
    endif.
    if iv_term is not initial.
      s_term = value #( sign = 'I'  option = 'EQ' ( low = iv_term  ) ).
    endif.


   DATA(lo_request) = NEW zcl_hr_dpo_request( ).
    DATA(ls_request) = lo_request->read_request( iv_dpo_request = iv_dpo_request ).




        move-corresponding ls_request to ls_notif.
        ls_notif-request_status_desc = ls_request-status_descr .

        append ls_notif to rt_notif_tab.





  endmethod.


  method get_requests_table.

    data: ls_request_s type zhr_dpo_term_req_s,
          lv_time      type uzeit,
          lv_duration  type i.



    select * from zhr_dpo_termzad into table @data(lt_termzad)
                                   where term_id eq @iv_term.
    if sy-subrc eq 0.
      select * from zhr_dpo_cparam into table @data(lt_param)
                                   where parameter_dpo = 'TERM_START_TIME'
                                     or  parameter_dpo = 'TERM_REQUEST_DURAT'.
      if sy-subrc eq 0.
        read table lt_param assigning field-symbol(<fs_param>)
                                    with key parameter_dpo = 'TERM_START_TIME'.
        if sy-subrc eq 0.
          lv_time = <fs_param>-value.
        endif.
        read table lt_param assigning <fs_param>
                                    with key parameter_dpo = 'TERM_REQUEST_DURAT'.
        if sy-subrc eq 0.
          lv_duration = <fs_param>-value.
        endif.
      endif.

      select * from zhr_dpo_cstatt into table @data(lt_stat_desc)
                                   where spras eq @sy-langu.

      select dpo_request, dpo_year, dpo_type, status, name, request_date, orgeh, orgeh_orig, notif_status
                 from zhr_dpo_zad into table @data(lt_request_tab)
                 for all entries in   @lt_termzad
                 where dpo_request eq @lt_termzad-dpo_request.
      if sy-subrc eq 0.
        select objid, short from hrp1000 into table @data(lt_short)
                            for all entries in @lt_request_tab
                            where otype = 'O'
                             and  objid = @lt_request_tab-orgeh_orig.


        loop at lt_request_tab assigning field-symbol(<fs_req>).
          clear ls_request_s.
          move-corresponding <fs_req> to ls_request_s.
          ls_request_s-request_name  = <fs_req>-name.
          call function 'IGN_TIMESTAMP_PLUSMINUS'
            exporting
              start_date      = sy-datum
              start_time      = lv_time
*             FORWARD         = 'X'
*             BACKWARD        = ' '
*             DAYS            = '0'
*             HOURS           = '0'
              minutes         = lv_duration
*             SECONDS         = '0'
            importing
*             RESULT_DATE     =
              result_time     = lv_time
            exceptions
              parameter_error = 1
              others          = 2.
          if sy-subrc <> 0.
* Implement suitable error handling here
          endif.


          ls_request_s-req_time = lv_time.
          add lv_duration to lv_time.
          read table lt_short assigning field-symbol(<fs_short>)
                              with key objid = <fs_req>-orgeh.
          if sy-subrc eq 0.
            ls_request_s-short = <fs_short>-short.
          endif.


          read table lt_stat_desc assigning field-symbol(<fs_stat_desc>)
                                    with key object = 'R'
                                             status = <fs_req>-status.
          if sy-subrc eq 0.
            ls_request_s-status_descr = <fs_stat_desc>-description.
          endif.
          ls_request_s-notif_status = <fs_req>-notif_status.
          read table lt_stat_desc assigning <fs_stat_desc>
                                  with key object = 'N'
                                           status = ls_request_s-notif_status.
          if sy-subrc eq 0.
            ls_request_s-notif_status_descr = <fs_stat_desc>-description.
          endif.

          read table lt_termzad assigning field-symbol(<fs_termzad>)
                                with key dpo_request = <fs_req>-dpo_request.

          if sy-subrc eq 0.
            ls_request_s-result_term = <fs_termzad>-result_term.

          endif.

          data(ls_conv) = value zhr_dpo_zadconv( dpo_request = ls_request_s-dpo_request
                                             dpo_year = ls_request_s-dpo_year
                                             dpo_type = ls_request_s-dpo_type
                                             direction = 'O' ).
          zcl_hr_dpo_request=>convert_request(
            changing
              chs_request = ls_conv                 " Konverze čísla žádosti
          ).
          ls_request_s-dpo_req_full = ls_conv-dpo_req_full.

          append ls_request_s to rt_request_tab.
        endloop.

      endif.

    endif.

  endmethod.


  METHOD INIT_FORM_DATA.

    DATA ls_thead TYPE thead.
    DATA lv_template_code TYPE zhr_dpo_templ_code.

*    TRY.

*        gs_custom_request =  gt_custom_request[ process =  gv_process_type status = 'ROJ' ].
        gs_custom_template = gt_custom_template[ template_code =  lv_template_code ].

*      CATCH cx_sy_itab_line_not_found .
*    ENDTRY.
*
*    ls_thead-tdid = 'ST'.
*    ls_thead-tdname = gs_custom_template-request_mail_text.
*    ls_thead-tdspras = sy-langu.
*    ls_thead-tdobject = 'TEXT'.
*    gs_data_db-proposal = read_text( ls_thead ).
*
*   ls_thead-tdname = gs_custom_template-notation_mail_text.
*   gs_data_db-final = read_text( ls_thead ).


    ENDMETHOD.


  method READ_CUSTOMIZING.

    SELECT * FROM ZHR_DPO_CZAD INTO TABLE gt_custom_request.

    SELECT * FROM zhr_dpo_csabl INTO TABLE gt_custom_template.

  endmethod.


  method READ_NOTIF.

    SELECT SINGLE * FROM zhr_dpo_zad INTO @DATA(ls_zad)
                    WHERE dpo_request = @iv_dpo_request
                      AND before_save = @abap_false.

*    SELECT SINGLE * FROM zhr_dpo_term INTO @DATA(ls_term)
*                    WHERE term_id = @iv_dpo_term.

    gs_data_db-request_name = ls_zad-name.
    gs_data_db-dpo_req_full = ls_zad-dpo_request.
    gs_data_db-notif_status = ls_zad-notif_status.
    gs_data_db-request_status = ls_zad-status .
*    gs_data_db-datum = ls_term-term_date.
    gs_data_db-request = ls_zad-dpo_request.
*    gs_data_db-term_id = ls_term-term_id.
     select single * from zhr_dpo_cstatt into @data(ls_status)
                          where object = @zcl_hr_dpo_request=>cv_request
                            and status = @ls_zad-status
                            and spras  = @sy-langu.
     IF sy-subrc EQ 0.
       gs_data_db-request_status_desc = ls_status-description.
     ENDIF.
     CLEAR ls_status.
     select single * from zhr_dpo_cstatt into ls_status
                          where object = 'N'
                            and status = ls_zad-notif_status
                            and spras  = sy-langu.
     IF sy-subrc EQ 0.
       gs_data_db-notif_status_desc = ls_status-description.
     ENDIF.

    return = gs_data_db.
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
      WHEN ' '.
          rv_longtext = |{ rv_longtext } { <fs_text>-tdline }|.
      WHEN '*'.
          rv_longtext = |{ rv_longtext }\n{ <fs_text>-tdline }|.
    ENDCASE.

  endif.

ENDLOOP.



  ENDMETHOD.


  method SAVE_AS_DRAFT.
*CALL METHOD SUPER->SAVE_AS_DRAFT
*    .


     save_term( ).
  endmethod.


  METHOD SAVE_AS_DRAFT_TERM.

     save_term( ).


  ENDMETHOD.


  METHOD SAVE_TERM.

*DATA: ls_dpo_zad TYPE zhr_dpo_zad,
*      ls_dpo_hist TYPE zhr_dpo_hist.
*
*
*
*  ls_dpo_zad-dpo_year = gs_data_db-dpo_year.
*  ls_dpo_zad-dpo_type = gs_data_db-dpo_type.
*  ls_dpo_zad-dpo_request = gs_data_db-dpo_request.
*
*  ls_dpo_zad-template_code = gs_data_db-template_code.
*  ls_dpo_zad-request_date = sy-datum.
*  ls_dpo_zad-status = gs_data_db-status.
*  ls_dpo_zad-name = gs_data_db-name.
*  ls_dpo_zad-send_date = gs_data_db-send_date.
*  ls_dpo_zad-term_id = gs_data_db-term_id.
*
*  MODIFY zhr_dpo_zad FROM ls_dpo_zad.
*
*
*  ls_dpo_hist-dpo_request = gs_data_db-dpo_request.
*  ls_dpo_hist-uname       = sy-uname.
*  ls_dpo_hist-datum       = sy-datum.
*  ls_dpo_hist-time        = sy-uzeit.
*  ls_dpo_hist-role        = gs_data_db-role.
*  ls_dpo_hist-next_status = gs_data_db-next_status.
**  ls_dpo_hist-clarification = gs_data_db-
*
*  MODIFY zhr_dpo_hist FROM ls_dpo_hist.

  ENDMETHOD.


  method TEST_METHOD.

    read_customizing( ).
    init_form_data( ).
*    data(ls_request) = get_terms( ).

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
ENDCLASS.
