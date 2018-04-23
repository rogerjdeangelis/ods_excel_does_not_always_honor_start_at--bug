ODS excel does not always honor start_at (Bug)

Could not get odslayout or ods grid to work the way I wanted?
Start_at is ignored on second report;

HAVE
====

  Two reports and I want to place the second report right after the first report


    NAME       SEX    AGE    HEIGHT    WEIGHT

    Alfred      M      14     69.0      112.5
    Alice       F      13     56.5       84.0
    Barbara     F      13     65.3       98.0


    NAME       SEX    AGE    HEIGHT    WEIGHT

    Carol       F      14     62.8      102.5
    Henry       M      14     63.5      102.5
    James       M      12     57.3       83.0


WANT
====

    NAME       SEX    AGE    HEIGHT    WEIGHT

    Alfred      M      14     69.0      112.5
    Alice       F      13     56.5       84.0
    Barbara     F      13     65.3       98.0
                                                One blank line
    Carol       F      14     62.8      102.5
    Henry       M      14     63.5      102.5
    James       M      12     57.3       83.0

GET
===
    NAME       SEX    AGE    HEIGHT    WEIGHT

    Alfred      M      14     69.0      112.5
    Alice       F      13     56.5       84.0
    Barbara     F      13     65.3       98.0
                                                Two blank lines

    Carol       F      14     62.8      102.5
    Henry       M      14     63.5      102.5
    James       M      12     57.3       83.0


PROBLEM CODE
======================

* just in case;
%utlfkil(d:/xls/class.xlsx);
title;
footnote;

ods excel file="d:/xls/class.xlsx";
ods excel options(sheet_name="class" sheet_interval="none" start_at="A1"); * a1 not needed;
PROC REPORT DATA=sashelp.class(obs=3) NOCENTER missing;
RUN;quit;


* BUG this report starts at A6!!! not A5;

ods excel options(start_at="A5");
options missing="";
PROC REPORT DATA=sashelp.class(firstobs=4 obs=6) NOCENTER missing;
COLUMN  _all_;
DEFINE  name   / display " ";
DEFINE  AGE    / display " "  ;
DEFINE  SEX    / DISPLAY " "  ;
DEFINE  WEIGHT / display  " " ;
DEFINE  HEIGHT / display  " " ;
RUN;quit;
ods excel close;


