class ZCL_APPL_LOG_MSG definition
  public
  create protected .

*"* public components of class ZCL_APPL_LOG_MSG
*"* do not include other source files here!!!
public section.

  class-methods GET_PROBCLASS
    importing
      !IV_MSGTY type SYMSGTY
    returning
      value(RV_PROBCLASS) type BALPROBCL .
  methods CONSTRUCTOR
    importing
      !IS_MSG type BAL_S_MSG .
  class-methods CREATE_SYMSG
    returning
      value(RO_MSG) type ref to ZCL_APPL_LOG_MSG .
  methods ADD_PARAM
    importing
      !ID_PARAM type BALPAR
      !ID_VALUE type ANY .
  methods ADD_CALLBACK
    importing
      !ID_ROUTINE type BALUEF
      !ID_FORM type XFELD
      !ID_PROGRAM type BALUEP .
  methods GET_MSG
    returning
      value(RS_MSG) type BAL_S_MSG .
  class-methods CREATE_BAPIRET1
    importing
      !IS_MSG type BAPIRET1
    returning
      value(RO_MSG) type ref to ZCL_APPL_LOG_MSG .
  class-methods CREATE_BAPIRET2
    importing
      !IS_MSG type BAPIRET2
    returning
      value(RO_MSG) type ref to ZCL_APPL_LOG_MSG .
  class-methods CREATE_T100_EXC
    importing
      !IO_EXC type ref to IF_T100_MESSAGE
    returning
      value(RO_MSG) type ref to ZCL_APPL_LOG_MSG .
protected section.
*"* protected components of class ZCL_APPL_LOG_MSG
*"* do not include other source files here!!!

  data S_MSG type BAL_S_MSG .
private section.
*"* private components of class ZCL_APPL_LOG_MSG
*"* do not include other source files here!!!
ENDCLASS.



CLASS ZCL_APPL_LOG_MSG IMPLEMENTATION.


method ADD_CALLBACK.
  me->s_msg-params-callback-userexitf = id_routine.
  IF id_form IS INITIAL.
    me->s_msg-params-callback-userexitt = 'F'.
  ELSE.
    me->s_msg-params-callback-userexitp = id_program.
  ENDIF.
endmethod.


method ADD_PARAM.
  DATA
    : ls_par  TYPE bal_s_par
    .
  ls_par-parname  = id_param.
  ls_par-parvalue = id_value.

  APPEND ls_par TO me->s_msg-params-t_par.
endmethod.


method CONSTRUCTOR.
  me->s_msg = is_msg.
  me->s_msg-probclass = get_probclass( iv_msgty = me->s_msg-msgty ).
endmethod.


method CREATE_BAPIRET1.
  DATA
    : ls_msg  TYPE bal_s_msg
    .
  ls_msg-msgty = is_msg-type.
  ls_msg-msgid = is_msg-id.
  ls_msg-msgno = is_msg-number.
  ls_msg-msgv1 = is_msg-message_v1.
  ls_msg-msgv2 = is_msg-message_v2.
  ls_msg-msgv3 = is_msg-message_v3.
  ls_msg-msgv4 = is_msg-message_v4.
  CREATE OBJECT ro_msg
    EXPORTING
      is_msg = ls_msg.
endmethod.


method CREATE_BAPIRET2.
  DATA
    : ls_msg  TYPE bal_s_msg
    .
  ls_msg-msgty = is_msg-type.
  ls_msg-msgid = is_msg-id.
  ls_msg-msgno = is_msg-number.
  ls_msg-msgv1 = is_msg-message_v1.
  ls_msg-msgv2 = is_msg-message_v2.
  ls_msg-msgv3 = is_msg-message_v3.
  ls_msg-msgv4 = is_msg-message_v4.
  CREATE OBJECT ro_msg
    EXPORTING
      is_msg = ls_msg.
endmethod.


method CREATE_SYMSG.
  DATA
    : ls_msg  TYPE bal_s_msg
    .
  MOVE-CORRESPONDING sy TO ls_msg.
  CREATE OBJECT ro_msg
    EXPORTING
      is_msg = ls_msg.
endmethod.


method CREATE_T100_EXC.

  DATA
    : l_msg   TYPE string
    .
  IF NOT io_exc IS BOUND.
    RETURN.
  ENDIF.

  CALL METHOD cl_message_helper=>set_msg_vars_for_if_t100_msg
    EXPORTING
      text = io_exc.
  MESSAGE ID sy-msgid TYPE 'E' NUMBER sy-msgno
      INTO l_msg
      WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.

  ro_msg = zcl_appl_log_msg=>create_symsg( ).

endmethod.


method GET_MSG.
  rs_msg = me->s_msg.
endmethod.


method GET_PROBCLASS.
  CASE iv_msgty.
    WHEN 'I'.
      rv_probclass = '3'. " Mittel
    WHEN 'W'.
      rv_probclass = '2'. " Wichtig
    WHEN 'E' OR 'A' OR 'X'.
      rv_probclass = '1'. " Sehr wichtig
    WHEN OTHERS.
      rv_probclass = '4'. " Zusatzinfo
  ENDCASE.
endmethod.
ENDCLASS.
