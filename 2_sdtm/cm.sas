/* cm.sas - Create SDTM.CM */
libname raw "~/myfolders/1_raw_data/";
libname sdtm "~/myfolders/2_sdtm/";

proc import datafile="~/myfolders/1_raw_data/concomitant.csv"
    out=cm_raw
    dbms=csv
    replace;
    getnames=yes;
run;

data sdtm.cm;
    set cm_raw;
    STUDYID = "ONC001";
    DOMAIN = "CM";
    CMDOSE = Dosage;
    CMROUTE = Route;
    CMINDC = Reason;
    keep STUDYID DOMAIN USUBJID CMTRT CMDECOD CMCLAS CMINDC CMSTDTC CMENDTC CMROUTE CMDOSFRQ CMDOSE CMDOSU CMCONT;
run;
