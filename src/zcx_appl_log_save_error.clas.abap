class ZCX_APPL_LOG_SAVE_ERROR definition
  public
  inheriting from ZCX_APPL_LOG
  create public .

*"* public components of class ZCX_APPL_LOG_SAVE_ERROR
*"* do not include other source files here!!!
public section.

  constants ZCX_APPL_LOG_SAVE_ERROR type SOTR_CONC value '924D065130093972E1000000C0A80004'. "#EC NOTEXT

  methods CONSTRUCTOR
    importing
      !TEXTID like TEXTID optional
      !PREVIOUS like PREVIOUS optional .
protected section.
*"* protected components of class ZCX_APPL_LOG_SAVE_ERROR
*"* do not include other source files here!!!
private section.
*"* private components of class ZCX_APPL_LOG_SAVE_ERROR
*"* do not include other source files here!!!
ENDCLASS.



CLASS ZCX_APPL_LOG_SAVE_ERROR IMPLEMENTATION.


method CONSTRUCTOR.
CALL METHOD SUPER->CONSTRUCTOR
EXPORTING
TEXTID = TEXTID
PREVIOUS = PREVIOUS
.
 IF textid IS INITIAL.
   me->textid = ZCX_APPL_LOG_SAVE_ERROR .
 ENDIF.
endmethod.
ENDCLASS.
