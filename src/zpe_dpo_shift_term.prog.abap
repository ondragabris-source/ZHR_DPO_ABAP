*&---------------------------------------------------------------------*
*& Report ZPE_DPO_SHIFT_TERM
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpe_dpo_shift_term.

DATA: ls_termzad   TYPE zhr_dpo_termzad.
TYPES: BEGIN OF ty_output,
         dpo_request  TYPE zhr_dpo_zad-dpo_request,
         dpo_req_full TYPE zhr_dpo_zad-dpo_req_full,
         term_id      TYPE zhr_dpo_zad-term_id,
         term_date    TYPE zhr_dpo_term-term_date,
         term_sp      TYPE zhr_dpo_term-term_sp,
         term_odbory  TYPE zhr_dpo_term-term_odbory,
         new_term_id  TYPE zhr_dpo_zad-term_id,
         new_date     TYPE zhr_dpo_term-term_date,
         term_type    TYPE char30,
       END OF ty_output.
DATA: gt_output TYPE STANDARD TABLE OF ty_output,
      gs_output TYPE ty_output.

SELECT-OPTIONS:
  s_doprq FOR gs_output-dpo_request.

PARAMETERS: p_test AS CHECKBOX DEFAULT 'X'.

START-OF-SELECTION.

  AUTHORITY-CHECK OBJECT 'S_TCODE'
     ID 'TCD' FIELD 'ZHRPA_DPO_SHIFT_TERM'.
  IF sy-subrc <> 0.
* Implement a suitable exception handling here
    MESSAGE e024(zhr_dpo) INTO DATA(lv_text).
* Nemáte autorizaci na spuštění programu.

  ENDIF.

  TYPES tr_status TYPE RANGE OF zhr_dpo_zad-status.

  DATA(r_req_status) = VALUE tr_status( sign = 'I' option = 'EQ' ( low = 'ROJ') ( low = 'RAOJ') ( low = 'RHRPB')  ).

* najdi zadosti s proslym terminem
  SELECT  zhr_dpo_zad~dpo_request, zhr_dpo_zad~dpo_req_full, zhr_dpo_zad~term_id,
          zhr_dpo_term~term_date, zhr_dpo_term~term_sp, zhr_dpo_term~term_odbory,
          zhr_dpo_term~process
      FROM zhr_dpo_zad
      INNER JOIN zhr_dpo_term
           ON zhr_dpo_zad~term_id EQ zhr_dpo_term~term_id
           INTO TABLE @DATA(lt_zad)
           WHERE ( ( zhr_dpo_term~term_sp LT @sy-datum ) OR ( zhr_dpo_term~term_sp EQ @sy-datum ) AND zhr_dpo_term~time_sp LT @sy-uzeit )
           AND zhr_dpo_term~status EQ 'TO'
           AND zhr_dpo_zad~dpo_request IN @s_doprq
           AND zhr_dpo_zad~status IN @r_req_status.

  DELETE lt_zad[] WHERE dpo_req_full IS INITIAL.
  IF lt_zad[] IS NOT INITIAL.
* najdi nejblizsi vhodny termin.


    SELECT term_id, term_date, process  FROM zhr_dpo_term INTO TABLE @DATA(lt_new_term)
                          WHERE ( term_sp EQ @sy-datum AND  time_sp GT @sy-uzeit )
                             OR term_sp GT @sy-datum.



    IF sy-subrc EQ 0.
      SORT lt_new_term BY term_date.
      DATA(ls_new_term) = lt_new_term[ 1 ].

      LOOP AT lt_zad ASSIGNING FIELD-SYMBOL(<fs_zad>).

        IF p_test IS INITIAL.
          UPDATE zhr_dpo_zad SET term_id = ls_new_term-term_id
                         WHERE dpo_request = <fs_zad>-dpo_request.
          IF sy-subrc EQ 0.
            ls_termzad-term_id = ls_new_term-term_id.
            ls_termzad-dpo_request = <fs_zad>-dpo_request.
            INSERT zhr_dpo_termzad FROM ls_termzad.
            IF sy-subrc EQ 0.

              DELETE FROM zhr_dpo_termzad
                        WHERE dpo_request = <fs_zad>-dpo_request
                                  AND term_id     = <fs_zad>-term_id.

              DATA(lr_o_dpo_request) = NEW zcl_hr_dpo_request( ).
              lr_o_dpo_request->set_request( <fs_zad>-dpo_request ).
              lr_o_dpo_request->get_header( ).
              lr_o_dpo_request->get_authorization_structure( iv_dpo_request = <fs_zad>-dpo_request iv_uname = sy-uname iv_dpo_process = <fs_zad>-process ).
              lr_o_dpo_request->update_term_in_history( i_term_id      = ls_new_term-term_id
                                                                                                         i_old_term_id  =  <fs_zad>-term_id
                                                                                                         iv_dpo_request = <fs_zad>-dpo_request ).


*                 NEW zcl_hr_dpo_request( )->set_request( <fs_zad>-dpo_request )->update_term_in_history( i_term_id      = ls_new_term-term_id
*                                                                                                         i_old_term_id  =  <fs_zad>-term_id
*                                                                                                         iv_dpo_request = <fs_zad>-dpo_request ).
            ENDIF.
          ENDIF.
        ENDIF.
        CLEAR gs_output.
        gs_output-term_type = TEXT-001.
        MOVE-CORRESPONDING <fs_zad> TO gs_output.
        gs_output-new_date = ls_new_term-term_date.
        gs_output-new_term_id = ls_new_term-term_id.
        APPEND gs_output TO gt_output.

      ENDLOOP.

    ELSE.
      MESSAGE 'Termín SP nenalezen' TYPE 'E'.

    ENDIF.

  ENDIF.

  REFRESH: r_req_status, lt_zad.
  CLEAR ls_new_term.

  r_req_status = VALUE tr_status( sign = 'I' option = 'EQ' ( low = 'RSP') ( low = 'ASP') ( low = 'AVSP')  ).

* najdi zadosti s proslym terminem
  SELECT zhr_dpo_zad~dpo_request, zhr_dpo_zad~dpo_req_full, zhr_dpo_zad~term_id, zhr_dpo_term~term_date, zhr_dpo_term~term_sp, zhr_dpo_term~term_odbory, zhr_dpo_term~process
      FROM zhr_dpo_zad INNER JOIN zhr_dpo_term
           ON zhr_dpo_zad~term_id EQ zhr_dpo_term~term_id
           INTO TABLE @lt_zad
           WHERE ( ( zhr_dpo_term~term_odbory LT @sy-datum ) OR ( zhr_dpo_term~term_odbory EQ @sy-datum ) AND zhr_dpo_term~time_odbory LT @sy-uzeit )
           AND zhr_dpo_term~status EQ 'TO'
           AND zhr_dpo_zad~dpo_request IN @s_doprq
           AND zhr_dpo_zad~status IN @r_req_status.

  DELETE lt_zad[] WHERE dpo_req_full IS INITIAL.
  IF lt_zad[] IS NOT INITIAL.
    WRITE:/ 'Updatni termin Odbory'.
* najdi nejblizsi vhodny termin.
    SELECT  term_id, term_date FROM zhr_dpo_term INTO TABLE  @lt_new_term
                          WHERE ( term_odbory EQ @sy-datum AND  time_odbory GT @sy-uzeit )
                               OR term_odbory GT @sy-datum.

    IF sy-subrc EQ 0.
      SORT lt_new_term BY term_date.


*      ls_new_term = lt_new_term[ 1 ].

      LOOP AT lt_zad ASSIGNING <fs_zad>.
        LOOP AT lt_new_term INTO ls_new_term
            WHERE process = <fs_zad>-process.
          EXIT.
        ENDLOOP.
        IF sy-subrc <> 0.
          ls_new_term = lt_new_term[ 1 ].
        ENDIF.
        IF p_test IS INITIAL.
          UPDATE zhr_dpo_zad SET term_id = ls_new_term-term_id
                         WHERE dpo_request = <fs_zad>-dpo_request.
          IF sy-subrc EQ 0.
            ls_termzad-term_id = ls_new_term-term_id.
            ls_termzad-dpo_request = <fs_zad>-dpo_request.
            INSERT zhr_dpo_termzad FROM ls_termzad.
            IF sy-subrc EQ 0.
              DELETE FROM zhr_dpo_termzad
                        WHERE dpo_request = <fs_zad>-dpo_request
                                  AND term_id     = <fs_zad>-term_id.

              lr_o_dpo_request = NEW zcl_hr_dpo_request( ).

              lr_o_dpo_request->get_authorization_structure(  iv_dpo_request = <fs_zad>-dpo_request
                                                              iv_uname = sy-uname
                                                              iv_dpo_process = <fs_zad>-process ).

              lr_o_dpo_request->update_term_in_history( i_term_id      = ls_new_term-term_id
                                                                                                      i_old_term_id  =  <fs_zad>-term_id
                                                                                                      iv_dpo_request = <fs_zad>-dpo_request ).

*              NEW zcl_hr_dpo_request( )->set_request( <fs_zad>-dpo_request )->update_term_in_history( i_term_id      = ls_new_term-term_id
*                                                                                                      i_old_term_id  =  <fs_zad>-term_id
*                                                                                                      iv_dpo_request = <fs_zad>-dpo_request ).
            ENDIF.
          ENDIF.
        ENDIF.
        CLEAR gs_output.
        gs_output-term_type = TEXT-002.
        MOVE-CORRESPONDING <fs_zad> TO gs_output.
        gs_output-new_date = ls_new_term-term_date.
        gs_output-new_term_id = ls_new_term-term_id.
        APPEND gs_output TO gt_output.
      ENDLOOP.
    ELSE.
      MESSAGE 'Termín Odborů nenalezen' TYPE 'E'.
    ENDIF.

  ENDIF.

* smaž temporary žádosti
  SELECT * FROM zhr_dpo_zad
                            WHERE ( dpo_req_full IS INITIAL
                              OR  dpo_req_full LIKE '/%'
                              OR  dpo_req_full LIKE '%/' )
                            AND request_date LT @sy-datum
                            and dpo_request IN @s_doprq
                            INTO TABLE @DATA(lt_zad_del).


  LOOP AT lt_zad_del ASSIGNING FIELD-SYMBOL(<fs_zad_del>).
    IF p_test IS INITIAL.
      DELETE FROM zhr_dpo_zad WHERE dpo_request = <fs_zad_del>-dpo_request.
    ENDIF.
    IF sy-subrc EQ 0.
*      gs_output-dpo_req_full = <fs_zad_del>-dpo_req_full.
*      gs_output-dpo_request = <fs_zad_del>-dpo_request.
*      gs_output-term_type = TEXT-007.
*      APPEND gs_output TO gt_output.
      IF p_test IS INITIAL.
        DELETE FROM zhr_dpo_termzad WHERE dpo_request = <fs_zad_del>-dpo_request.
      ENDIF.
    ENDIF.
  ENDLOOP.
   IF p_test IS INITIAL.
     DELETE FROM zhr_dpo_zad_act WHERE aedat LT sy-datum AND dpo_request IN s_doprq.
    ENDIF.

  cl_salv_table=>factory( IMPORTING r_salv_table = DATA(go_alv)
                       CHANGING  t_table   = gt_output ).

  DATA(go_columns) = go_alv->get_columns( ).
  DATA(go_column) = go_columns->get_column( 'TERM_TYPE' ).
  go_column->set_short_text( CONV #( TEXT-003 ) ).
  go_column->set_medium_text( CONV #( TEXT-003 ) ).
  go_column->set_long_text( CONV #( TEXT-003 ) ).

  go_column = go_columns->get_column( 'NEW_DATE' ).
  go_column->set_short_text( CONV #( TEXT-004 ) ).
  go_column->set_medium_text( CONV #( TEXT-004 ) ).
  go_column->set_long_text( CONV #( TEXT-004 ) ).

  go_column = go_columns->get_column( 'NEW_TERM_ID' ).
  go_column->set_visible( if_salv_c_bool_sap=>false ).
  go_column->set_short_text( CONV #( TEXT-005 ) ).
  go_column->set_medium_text( CONV #( TEXT-005 ) ).
  go_column->set_long_text( CONV #( TEXT-005 ) ).

  go_column = go_columns->get_column( 'DPO_REQUEST' ).
  go_column->set_visible( if_salv_c_bool_sap=>false ).
  go_column->set_short_text( CONV #( TEXT-006 ) ).
  go_column->set_medium_text( CONV #( TEXT-006 ) ).
  go_column->set_long_text( CONV #( TEXT-006 ) ).

  go_column = go_columns->get_column( 'TERM_ID' ).
  go_column->set_visible( if_salv_c_bool_sap=>false ).

  go_columns->set_optimize( abap_true ).
  DATA(go_functions) = go_alv->get_functions( ).
  go_functions->set_all( abap_true ).

  go_alv->display( ).
