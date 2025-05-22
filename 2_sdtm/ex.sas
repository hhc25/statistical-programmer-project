/* ex.sas - Create SDTM.EX (Exposure) from trt.csv */

libname raw "~/myfolders/1_raw_data/";
libname sdtm "~/myfolders/2_sdtm/";

proc import datafile="~/myfolders/1_raw_data/trt.csv"
    out=trt_raw
    dbms=csv
    replace;
    guessingrows=max;
    getnames=yes;
run;


data sdtm.ex;
    set trt_raw;

    STUDYID = "ONC001";
    DOMAIN = "EX";

    EXTRT = TRTA;

/*  當日期為文字格式時才用：把字串轉成日期型別，再套用格式 */
/* 	EXSTDTC = input(strip(compress(TRTSDT)), yymmdd10.); */
/* 	EXENDTC = input(strip(compress(TRTEDT)), yymmdd10.); */
/* 	format EXSTDTC EXENDTC yymmdd10.; */

/*  因已為數字格式，不用input */
	EXSTDTC = TRTSDT;
	EXENDTC = TRTEDT;
	format EXSTDTC EXENDTC yymmdd10.;


    EXDOSE   = DoseAmount;
    EXDOSU   = EXDOSU;
    EXROUTE  = EXROUTE;
    EXFREQ   = Freq;
    EXREASND = EXREASND;
    EXADJ    = DoseAdj;

    keep STUDYID DOMAIN USUBJID EXTRT EXSTDTC EXENDTC EXDOSE EXDOSU EXROUTE EXFREQ EXREASND EXADJ;
run;


