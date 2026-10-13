class ZCL_HR_DPO_TASK definition
  public
  final
  create public .

public section.

  class-methods GET
    importing
      !IV_DPO_REQUEST type ZHR_DPO_REQUEST
    returning
      value(RO_TASK) type ref to ZCL_HR_DPO_TASK .
  methods CONSTRUCTOR .
  methods SAVE
    importing
      !IS_TASK type ZHR_DPO_UKOLY_S
    exporting
      !ET_MESSAGE type BAPIRETTAB
      !EV_RESULT type ZHR_DPO_TASK_RETURN_S
    returning
      value(ER_RETURN) type ZHR_DPO_UKOLY_S .
  methods DELETE_TASK
    importing
      !IV_DPO_TASK type ZHR_DPO_TASK
    exporting
      !ET_MESSAGE type BAPIRETTAB
    returning
      value(RS_RETURN) type ZHR_DPO_TASK_RETURN_S .
  methods GET_TASK
    importing
      !IV_DPO_TASK type ZHR_DPO_TASK
    returning
      value(RS_TASK) type ZHR_DPO_UKOLY_S .
  class-methods GET_TASK_LIST
    importing
      !SO_PERNR type /IWBEP/T_COD_SELECT_OPTIONS optional
      !SO_UNAME type /IWBEP/T_COD_SELECT_OPTIONS optional
      !SO_STATUS type /IWBEP/T_COD_SELECT_OPTIONS optional
      !SO_FINISH_DATE type /IWBEP/T_COD_SELECT_OPTIONS optional
      !SO_DPO_TASK type /IWBEP/T_COD_SELECT_OPTIONS optional
      !SO_DPO_REQUEST type /IWBEP/T_COD_SELECT_OPTIONS optional
      !SO_TEXT type /IWBEP/T_COD_SELECT_OPTIONS optional
      !SO_FULLNAME type /IWBEP/T_COD_SELECT_OPTIONS optional
      !SO_DPO_REQ_FULL type /IWBEP/T_COD_SELECT_OPTIONS optional
      !SO_HRBP_USER type /IWBEP/T_COD_SELECT_OPTIONS optional
    returning
      value(RT_TASKS) type ZHR_DPO_UKOLY_T .
  class-methods GET_TASK_STATUS_LIST
    returning
      value(RT_STATUS_LIST) type ZHR_DPO_CSTATT_T .
protected section.
private section.
ENDCLASS.



CLASS ZCL_HR_DPO_TASK IMPLEMENTATION.


  method CONSTRUCTOR.
  endmethod.


  method DELETE_TASK.

    rs_return-dpo_task = iv_dpo_task.
    rs_return-return_code = 'OK'.

    DELETE FROM zhr_dpo_ukoly WHERE dpo_task = iv_dpo_task.
    IF sy-subrc NE 0.
      rs_return-return_code = 'FAIL'.
    ENDIF.

    COMMIT WORK.

  endmethod.


  method GET.
     ro_task = new zcl_hr_dpo_task( ) .
  endmethod.


  method GET_TASK.

    SELECT SINGLE * FROM zhr_dpo_ukoly INTO @DATA(ls_ukoly)
                    WHERE  dpo_task    = @iv_dpo_task.

    IF sy-subrc EQ 0.
      MOVE-CORRESPONDING ls_ukoly TO rs_task.


    ENDIF.

  endmethod.


  METHOD get_task_list.
    DATA r_date TYPE RANGE OF sy-datum.
    DATA lv_datum TYPE sy-datum.
    DATA so_hrbp TYPE /iwbep/t_cod_select_options.
    DATA rs_date LIKE LINE OF r_date.

    DATA: ls_task TYPE zhr_dpo_ukoly_s.

    IF so_finish_date[] IS NOT INITIAL.
      LOOP AT so_finish_date ASSIGNING FIELD-SYMBOL(<fs_date>).
        IF rs_date-low IS INITIAL.
          lv_datum = <fs_date>-low.
          ADD 1 TO lv_datum.
          rs_date-low  = lv_datum.
        ELSE.
          rs_date-high  = <fs_date>-low.
        ENDIF.

      ENDLOOP.
      rs_date-sign = 'I'.
      rs_date-option = 'BT'.
      APPEND rs_date TO r_date.
    ENDIF.

    IF so_text[] IS NOT INITIAL.
      LOOP AT so_text ASSIGNING FIELD-SYMBOL(<fs_text>).
        DATA(lv_upper) = CONV char255( <fs_text>-low ).
        TRANSLATE lv_upper TO UPPER CASE.
        DATA(r_upper) = VALUE rsdsselopt_t(
               ( sign   = 'I'
                 option = 'CP'
                 low    = |*{ lv_upper }*| ) ).
      ENDLOOP.
    ENDIF.

    IF so_dpo_req_full[] IS NOT INITIAL.
      LOOP AT so_dpo_req_full ASSIGNING FIELD-SYMBOL(<fs_req_full>).
        DATA(r_req_full) = VALUE rsdsselopt_t(
               ( sign   = 'I'
                 option = 'CP'
                 low    = |{ <fs_req_full>-low }*| ) ).

      ENDLOOP.
    ENDIF.
    IF so_uname[] IS NOT INITIAL.
      so_hrbp = so_uname[].
      LOOP AT so_hrbp ASSIGNING FIELD-SYMBOL(<fs_hrbp>).
        IF  <fs_hrbp>-low = 'SELF'.
          <fs_hrbp>-low = sy-uname.
        ENDIF.
      ENDLOOP.

      SELECT a~*, b~dpo_req_full, c~uname, a~dpo_task FROM zhr_dpo_ukoly AS a
               INNER JOIN zhr_dpo_zad AS b
               ON a~dpo_request EQ b~dpo_request
               INNER JOIN zhr_dpo_rozdel AS c
               ON a~dpo_request EQ c~dpo_request
               INTO TABLE @DATA(lt_tasks)
               WHERE dpo_task IN @so_dpo_task
                 AND a~dpo_request IN @so_dpo_request
                 AND a~pernr  IN @so_pernr
                 AND a~status IN @so_status
                 AND a~uname  IN @so_hrbp
                 AND b~dpo_req_full IN @r_req_full
                 AND finish_date IN @r_date
                 AND c~uname IN @so_hrbp
                 AND c~role EQ 'HRBP'
                 AND a~task_text_upper IN @r_upper.

      SORT lt_tasks BY dpo_task.
      DELETE ADJACENT DUPLICATES FROM lt_tasks COMPARING dpo_task.

    ELSE.
      SELECT a~*, b~dpo_req_full FROM zhr_dpo_ukoly AS a
           INNER JOIN zhr_dpo_zad AS b
           ON a~dpo_request EQ b~dpo_request

           INTO TABLE @lt_tasks
           WHERE dpo_task IN @so_dpo_task
             AND a~dpo_request IN @so_dpo_request
             AND a~pernr  IN @so_pernr
             AND a~status IN @so_status
             AND a~uname  IN @so_uname
             AND b~dpo_req_full IN @r_req_full
             AND finish_date IN @r_date

             AND a~task_text_upper IN @r_upper.
    ENDIF.



    DATA(lt_status_desc) = zcl_hr_dpo_request=>get_domain_values( 'ZHR_DPO_TASK_STAT'  ).

    LOOP AT lt_tasks ASSIGNING FIELD-SYMBOL(<fs_task>).
      DATA(ls_user_data) = zcl_hr_dpo_roles=>get_pernr_details( iv_pernr = <fs_task>-a-pernr  ).
      MOVE-CORRESPONDING <fs_task>-a TO ls_task.
      ls_task-dpo_req_full =  <fs_task>-dpo_req_full.
      ls_task-full_name = ls_user_data-full_name.
      ls_task-status_descr = lt_status_desc[ domvalue_l = ls_task-status ]-ddtext.
      APPEND ls_task TO rt_tasks.
    ENDLOOP.


    IF so_fullname[] IS NOT INITIAL.
      READ TABLE so_fullname ASSIGNING FIELD-SYMBOL(<fs_requestor>) INDEX 1.
      IF sy-subrc EQ 0.
        DATA(lv_requestorname) = <fs_requestor>-low.
        TRANSLATE lv_requestorname TO UPPER CASE.
        DATA(lt_tasks_tab) = rt_tasks[].
        REFRESH rt_tasks.
        LOOP AT lt_tasks_tab INTO ls_task.
          DATA(lv_upper_case) = ls_task-full_name.
          TRANSLATE lv_upper_case TO UPPER CASE.
          FIND lv_requestorname IN lv_upper_case IGNORING CASE MATCH COUNT  DATA(lv_count).
          IF lv_count IS NOT INITIAL.
            APPEND ls_task TO rt_tasks.
            CLEAR lv_count.
          ENDIF.
        ENDLOOP.
      ENDIF.
    ENDIF.
    SORT rt_tasks BY dpo_request DESCENDING.

  ENDMETHOD.


  method GET_TASK_STATUS_LIST.

    DATA: ls_status TYPE zhr_dpo_cstatt.

    DATA(lt_values) = ZCL_HR_DPO_SERVICE=>get_domain_values( iv_name = 'ZHR_DPO_TASK_STAT' ).

    LOOP AT lt_values ASSIGNING FIELD-SYMBOL(<fs_values>).
      ls_status-status = <fs_values>-domvalue_l.
      ls_status-description = <fs_values>-ddtext.
      APPEND ls_status TO rt_status_list.
    ENDLOOP.

  endmethod.


  METHOD save.

    DATA: ls_task  TYPE zhr_dpo_ukoly,
          lv_bname TYPE usr02-bname.


    MOVE-CORRESPONDING is_task TO ls_task.
    IF ls_task-uname IS INITIAL AND ls_task-pernr IS NOT INITIAL.
      CALL FUNCTION 'PTRV_CONVERT_PERNR_TO_USERID'
        EXPORTING
          personnel_number  = ls_task-pernr
          validity_date     = sy-datum
        IMPORTING
          user_id           = lv_bname
        EXCEPTIONS
          user_id_not_found = 1
          OTHERS            = 2.

      ls_task-uname = lv_bname .
    ENDIF.
    IF is_task-dpo_task IS INITIAL.
      CALL FUNCTION 'NUMBER_GET_NEXT'
        EXPORTING
          nr_range_nr             = '01'
          object                  = 'ZHR_DPO_U'
        IMPORTING
          number                  = ls_task-dpo_task
        EXCEPTIONS
          interval_not_found      = 1
          number_range_not_intern = 2
          object_not_found        = 3
          quantity_is_0           = 4
          quantity_is_not_1       = 5
          interval_overflow       = 6
          buffer_overflow         = 7
          OTHERS                  = 8.
      IF sy-subrc <> 0.
* Implement suitable error handling here
      ENDIF.
    ENDIF.

    ls_task-task_text_upper = ls_task-task_text.
    TRANSLATE ls_task-task_text_upper TO UPPER CASE.
    MODIFY zhr_dpo_ukoly FROM  ls_task.
    IF sy-subrc EQ 0.
      COMMIT WORK.
      SELECT COUNT( * ) FROM zhr_dpo_ukoly
                           WHERE dpo_request = ls_task-dpo_request
                             AND status = 'N'.
      IF sy-subrc EQ 0.
        DATA(lv_unfinished_tasks) =  abap_true.
      ELSE.
        lv_unfinished_tasks =  abap_false.
      ENDIF.
      UPDATE zhr_dpo_zad SET tasks_unfinished = lv_unfinished_tasks
                          WHERE dpo_request = ls_task-dpo_request.

    ELSE.
      ROLLBACK WORK.
    ENDIF.

    er_return = is_task.
    er_return-dpo_task = ls_task-dpo_task.

  ENDMETHOD.
ENDCLASS.
