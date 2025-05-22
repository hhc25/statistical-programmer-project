/* ae.sas - SDTM AE creation for renamed short columns */

libname raw "~/myfolders/1_raw_data/";
libname sdtm "~/myfolders/2_sdtm/";

proc import datafile="~/myfolders/1_raw_data/ae.csv"
    out=ae_raw
    dbms=csv
    replace;
    guessingrows=max;
    getnames=yes;
run;

data sdtm.ae;
    set ae_raw;

    STUDYID = "ONC001";
    DOMAIN = "AE";

/*     AESTDTC = put(input(AESTDTC_RAW, yymmdd10.), yymmdd10.); */
/*     AEENDTC = put(input(AEENDTC_RAW, yymmdd10.), yymmdd10.); */

    AESTDTC = AESTDTC_RAW;
    AEENDTC = AEENDTC_RAW;
    format AESTDTC AEENDTC yymmdd10.;

    AESER   = ifc(AESER_RAW = "Yes", "Y", "N");
    AESDTH  = ifc(AESDTH_RAW = "Yes", "Y", "N");
    AESLIFE = ifc(AESLIFE_RAW = "Yes", "Y", "N");
    AESHOSP = ifc(AESHOSP_RAW = "Yes", "Y", "N");
    AESDISAB = ifc(AESDISAB_RAW = "Yes", "Y", "N");
    AESCONG = ifc(AESCONG_RAW = "Yes", "Y", "N");
    AESMIE  = ifc(AESMIE_RAW = "Yes", "Y", "N");

    /* CTCAE Grade conversion */
/*     length AETOXGR $1; */
/*     if index(GRADE, "Grade 1") then AETOXGR = "1"; */
/*     else if index(GRADE, "Grade 2") then AETOXGR = "2"; */
/*     else if index(GRADE, "Grade 3") then AETOXGR = "3"; */
/*     else if index(GRADE, "Grade 4") then AETOXGR = "4"; */
/*     else if index(GRADE, "Grade 5") then AETOXGR = "5"; */
    
    if index(GRADE, "Grade 1") then AESEV = "MILD";
    else if index(GRADE, "Grade 2") then AESEV = "MODERATE";
    else if index(GRADE, "Grade 3") then AESEV = "SEVERE";

    /*for ADaM*/
   GRADE = GRADE;

    keep STUDYID DOMAIN USUBJID SITEID AETERM AESTDTC AEENDTC AEOUT AEREL AESER
         AESDTH AESLIFE AESHOSP AESDISAB AESCONG AESMIE AESEV AEACN GRADE;
run;
