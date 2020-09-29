class ZCX_APPL_LOG definition
  public
  inheriting from CX_STATIC_CHECK
  create public .

*"* public components of class ZCX_APPL_LOG
*"* do not include other source files here!!!
public section.

  constants ZCX_INCONSISTENT_INTERFACE type SOTR_CONC value '6678085176113572E1000000C0A80004'. "#EC NOTEXT

  methods CONSTRUCTOR
    importing
      !TEXTID like TEXTID optional
      !PREVIOUS like PREVIOUS optional .
protected section.
*"* protected components of class ZCX_APPL_LOG
*"* do not include other source files here!!!
private section.
*"* private components of class ZCX_APPL_LOG
*"* do not include other source files here!!!
ENDCLASS.



CLASS ZCX_APPL_LOG IMPLEMENTATION.


method CONSTRUCTOR.
CALL METHOD SUPER->CONSTRUCTOR
EXPORTING
TEXTID = TEXTID
PREVIOUS = PREVIOUS
.
endmethod.
ENDCLASS.
