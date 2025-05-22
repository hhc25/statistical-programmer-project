/* dm.sas - Create SDTM.DM */
libname raw "~/myfolders/1_raw_data/";
libname sdtm "~/myfolders/2_sdtm/";

proc import datafile="~/myfolders/1_raw_data/demog.csv"
    out=demog_raw
    dbms=csv
    replace;
    getnames=yes;
run;

data sdtm.dm;
    set demog_raw;
    STUDYID  = "ONC001";
    DOMAIN   = "DM";
    SUBJID   = USUBJID;
    SITEID   = "SITE01";
    SEX = Gender;
    RACE = Ethnicity;
    AGE = AgeYears;
    ARM      = ARMCD;
    COUNTRY  = "USA";
/*     RFSTDTC = put(input(RANDDT, yymmdd10.), yymmdd10.); */
    RFSTDTC = RANDDT;
    format RFSTDTC yymmdd10.;
    keep STUDYID DOMAIN USUBJID SUBJID SITEID SEX RACE AGE ARM ARMCD COUNTRY RFSTDTC;
run;
