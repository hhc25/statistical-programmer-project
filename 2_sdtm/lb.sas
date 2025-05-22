/* lb.sas - Create SDTM.LB */
libname raw "~/myfolders/1_raw_data/";
libname sdtm "~/myfolders/2_sdtm/";

proc import datafile="~/myfolders/1_raw_data/lab.csv"
    out=lab_raw
    dbms=csv
    replace;
    getnames=yes;
run;

data sdtm.lb;
    set lab_raw;
    STUDYID = "ONC001";
    DOMAIN = "LB";
    LBORRES = Result;
    LBNRIND = Flag;
    
    LBDTC = TestDate;
    format LBDTC yymmdd10.;
    
    LBSPEC = "BLOOD";
    LBTESTCD = LBTEST;
    LBTEST = LBTEST;
    LBORRESU = "U/L";
    keep STUDYID DOMAIN USUBJID LBTESTCD LBTEST LBORRES LBORRESU LBNRIND LBDTC LBSPEC;
run;
