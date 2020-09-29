class ZCL_APPL_LOG_DISPLAY definition
  public
  create public .

*"* public components of class ZCL_APPL_LOG_DISPLAY
*"* do not include other source files here!!!
public section.

  data O_CONTAINER type ref to CL_GUI_CONTAINER read-only .
  data S_PROFILE type BAL_S_PROF read-only .

  methods CONSTRUCTOR .
  methods DISPLAY
    raising
      ZCX_APPL_LOG .
  methods SET_PROFILE
    importing
      !IS_PROFILE type BAL_S_PROF .
  methods SET_CONTAINER
    importing
      !IO_CONTAINER type ref to CL_GUI_CONTAINER optional .
  methods ADD_LOG
    importing
      !IO_LOG type ref to ZCL_APPL_LOG .
protected section.
*"* protected components of class ZCL_APPL_LOG_DISPLAY
*"* do not include other source files here!!!
private section.
*"* private components of class ZCL_APPL_LOG_DISPLAY
*"* do not include other source files here!!!

  data T_LOGS type GYT_LOGS .
  data CONTROL_HANDLE type BALCNTHNDL .
ENDCLASS.



CLASS ZCL_APPL_LOG_DISPLAY IMPLEMENTATION.


method ADD_LOG.
  APPEND io_log TO me->t_logs.
endmethod.


method CONSTRUCTOR.
endmethod.


method DISPLAY.

  DATA
    : lt_logh   TYPE bal_t_logh
    , lo_log    TYPE REF TO zcl_appl_log
    .
  LOOP AT t_logs INTO lo_log.
    INSERT lo_log->log_handle INTO TABLE lt_logh.
  ENDLOOP.

  IF NOT me->control_handle IS INITIAL.
    CALL FUNCTION 'BAL_CNTL_REFRESH'
      EXPORTING
        i_control_handle  = me->control_handle
        i_t_log_handle    = lt_logh
      EXCEPTIONS
        control_not_found = 1
        internal_error    = 2
        OTHERS            = 3.
    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE zcx_appl_log.
    ENDIF.
  ELSEIF me->o_container IS BOUND.
    CALL FUNCTION 'BAL_CNTL_CREATE'
      EXPORTING
        i_container          = me->o_container
        i_s_display_profile  = me->s_profile
        i_t_log_handle       = lt_logh
      IMPORTING
        e_control_handle     = me->control_handle
      EXCEPTIONS
        profile_inconsistent = 1
        internal_error       = 2
        OTHERS               = 3.
    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE zcx_appl_log.
    ENDIF.
  ELSE.
    CALL FUNCTION 'BAL_DSP_LOG_DISPLAY'
      EXPORTING
        i_s_display_profile  = me->s_profile
        i_t_log_handle       = lt_logh
      EXCEPTIONS
        profile_inconsistent = 1
        internal_error       = 2
        no_data_available    = 3
        no_authority         = 4
        OTHERS               = 5.
    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE zcx_appl_log.
    ENDIF.
  ENDIF.

endmethod.


method SET_CONTAINER.
  me->o_container = io_container.
endmethod.


method SET_PROFILE.
  me->s_profile = is_profile.
endmethod.
ENDCLASS.
