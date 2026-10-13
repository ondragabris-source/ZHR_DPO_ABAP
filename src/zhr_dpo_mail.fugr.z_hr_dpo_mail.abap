function Z_HR_DPO_MAIL.
*"----------------------------------------------------------------------
*"*"Lokální rozhraní:
*"  IMPORTING
*"     VALUE(I_SUBJECT) TYPE  SO_OBJ_DES DEFAULT 'BWA robot'
*"     VALUE(X_COMMIT) TYPE  XFELD DEFAULT ' '
*"     VALUE(I_SENDER) TYPE  XUBNAME OPTIONAL
*"  TABLES
*"      T_EMAIL STRUCTURE  ZIBWA_SMTP
*"      T_CONTENT TYPE  SOLI_TAB OPTIONAL
*"  EXCEPTIONS
*"      ERROR
*"----------------------------------------------------------------------

*"  15.6.2010 Vytvořeno kopií z fm Z_IBWA_MAIL;
*"  doplněn vst paramatr i_sender, má přednost před sy-uname


  data: send_request  type ref to cl_bcs,
        document      type ref to cl_document_bcs,
        sender        type ref to cl_sapuser_bcs,
        recipient     type ref to if_recipient_bcs,
        exception     type ref to cx_bcs,
        t_text        type soli_tab,
        e_result      type boolean,
        l_email       type ad_smtpadr,
        usr           type xubname,
        lv_smtpaddr     TYPE ad_smtpadr.

  if t_email[] is initial.
    message w214(zpedoch) raising error.
  endif.

  try.

      send_request = cl_bcs=>create_persistent( ).

      t_text[] = t_content[].

      document = cl_document_bcs=>create_document(
                      i_type       = 'HTM'
                      i_text       = t_text
*                      i_length     = '12'
                      i_subject    = i_subject
                      i_importance = '9').
      call method send_request->SET_STATUS_ATTRIBUTES(
                      i_requested_status = 'N'
                      i_status_mail      = 'N').
      call method send_request->set_document( document ).

*     --------- set sender -------------------------------------------
      CLEAR: sender.
*      IF i_sender IS NOT INITIAL.
*        SELECT SINGLE bname FROM usr01 INTO usr WHERE bname = i_sender.
*        IF sy-subrc IS INITIAL.
*          sender = cl_sapuser_bcs=>create( i_sender ).
*        ENDIF.
*      ENDIF.
*      IF sender   IS INITIAL.
*        sender = cl_sapuser_bcs=>create( sy-uname ).
*      ENDIF.

*--  ODESILATEL

        lv_smtpaddr = text-001.
        DATA(lr_sender) = cl_cam_address_bcs=>create_internet_address( lv_smtpaddr ).
        send_request->set_sender(
          i_sender = lr_sender ).
*      ENDIF.


*      call method send_request->set_sender
*        exporting
*          i_sender = sender.

*     --------- add recipient (Email) -----------------------
      loop at t_email into l_email.
        recipient =
        cl_cam_address_bcs=>create_internet_address( l_email ).

*     add recipient with its respective attributes to send request
        call method send_request->add_recipient
          exporting
            i_recipient = recipient.
      endloop.
*     ---------- send document ---------------------------------------
      call method send_request->send(
        exporting
          i_with_error_screen = 'X'
        receiving
          result              = e_result ).

    if x_commit eq 'X'.
      commit work.
    endif.
    catch cx_bcs into exception.
      message e215(zpedoch) with exception->error_type raising error.
  endtry.
endfunction.
