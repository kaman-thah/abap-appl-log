class ZCX_APPL_LOG_NO_EXISTENCE definition
  public
  inheriting from ZCX_APPL_LOG
  create public .

*"* public components of class ZCX_APPL_LOG_NO_EXISTENCE
*"* do not include other source files here!!!
public section.

  constants ZCX_APPL_LOG_NO_EXISTENCE type SOTR_CONC value '8F7A085176113572E1000000C0A80004'. "#EC NOTEXT
  constants ZCX_OBJECT_SUBOBJECT type SOTR_CONC value '16BA0851A4563672E1000000C0A80004'. "#EC NOTEXT
  data LOGNR type BALOGNR .

  methods CONSTRUCTOR
    importing
      !TEXTID like TEXTID optional
      !PREVIOUS like PREVIOUS optional
      !LOGNR type BALOGNR optional .
protected section.
*"* protected components of class ZCX_APPL_LOG_NO_EXISTENCE
*"* do not include other source files here!!!
private section.
*"* private components of class ZCX_APPL_LOG_NO_EXISTENCE
*"* do not include other source files here!!!
ENDCLASS.



CLASS ZCX_APPL_LOG_NO_EXISTENCE IMPLEMENTATION.


method CONSTRUCTOR.
CALL METHOD SUPER->CONSTRUCTOR
EXPORTING
TEXTID = TEXTID
PREVIOUS = PREVIOUS
.
 IF textid IS INITIAL.
   me->textid = ZCX_APPL_LOG_NO_EXISTENCE .
 ENDIF.
me->LOGNR = LOGNR .
endmethod.
ENDCLASS.
