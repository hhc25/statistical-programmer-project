/* tu.sas - Create SDTM.TU */
libname raw "~/myfolders/1_raw_data/";
libname sdtm "~/myfolders/2_sdtm/";

filename tumorf "~/myfolders/1_raw_data/tumor.csv";

/* 檢查檔案是否成功匯入 */
proc import datafile=tumorf
    out=tu_raw
    dbms=csv
    replace;
    getnames=yes;
run;

proc contents data=tu_raw; run;

data sdtm.tu;
    set tu_raw;
    STUDYID = "ONC001";
    DOMAIN = "TU";
    TUTESTCD = "LSMEAS";
    TUTEST = "Lesion Measurement";
    TUMRS = Response;
    TUEVAL = Evaluator;
    TUSTRESN = NumResult;

    keep STUDYID DOMAIN USUBJID TUTESTCD TUTEST TULOC TUDTC TUMSIZ TUMRS TUEVAL TUSTRESC TUSTRESN TUTPT;
run;
