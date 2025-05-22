/* adae.sas - Create ADaM.ADAE from SDTM.AE + ADSL */

libname sdtm "~/myfolders/2_sdtm/";
libname adam "~/myfolders/3_adam/";

/* Step 1: 合併 ADSL（提供治療期資訊與組別） */
proc sql;
    create table ae_merged as
    select 
        ae.USUBJID,
        adsl.TRTA,
        adsl.SAFFL,
        ae.AETERM, ae.AESEV, ae.AEREL, ae.AESER, ae.AESTDTC, ae.AEENDTC,
        ae.GRADE,
        adsl.TRTSDT, adsl.TRTEDT
    from sdtm.ae as ae
    left join adam.adsl as adsl
        on ae.USUBJID = adsl.USUBJID;
quit;

/* Step 2: 衍生分析欄位 */
data adam.adae;
    set ae_merged;

    length TRTEMFL $1;

    /* 發生日與結束日相對天數（Day 1 = 1） */
    ASTDY = AESTDTC - TRTSDT + 1;
    AENDY = AEENDTC - TRTSDT + 1;

    /* 是否在治療期內發生 */
    if . <= AESTDTC <= TRTEDT then TRTEMFL = "Y";
    else TRTEMFL = "N";
    
    length AETOXGR $1;
	if index(GRADE, "Grade 1") then AETOXGR = "1";
	else if index(GRADE, "Grade 2") then AETOXGR = "2";
	else if index(GRADE, "Grade 3") then AETOXGR = "3";
	else if index(GRADE, "Grade 4") then AETOXGR = "4";
	else if index(GRADE, "Grade 5") then AETOXGR = "5";


    format AESTDTC AEENDTC TRTSDT TRTEDT yymmdd10.;
    keep USUBJID AETERM AESEV AETOXGR AEREL AESER AESTDTC AEENDTC TRTA TRTSDT TRTEDT ASTDY AENDY TRTEMFL SAFFL;
run;
