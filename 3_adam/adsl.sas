/* adsl.sas - Create ADaM.ADSL from SDTM.DM + EX */

libname sdtm "~/myfolders/2_sdtm/";
libname adam "~/myfolders/3_adam/";

/* 合併 DM 與 EX：取得受試者基本資料與治療日期 */
proc sql;
    create table dm_ex as
    select 
        dm.USUBJID,
        dm.SEX, dm.AGE, dm.RACE, dm.ARM,
        min(EXSTDTC) format=yymmdd10. as TRTSDT,
        max(EXENDTC) format=yymmdd10. as TRTEDT
    from sdtm.dm as dm
    left join sdtm.ex as ex
        on dm.USUBJID = ex.USUBJID
    group by dm.USUBJID;
quit;




/* 建立 ADSL */
data adam.adsl;
    set dm_ex;
    /* 分析旗標 */
    ITTFL = "Y";/* 預設所有人納入 ITT */
	SAFFL = ifc(TRTSDT ne ., "Y", "N"); /* 有用藥才納入 SAF */
    /*SAFFL = ifn(TRTSDT ne ., "Y", "N");    

    /*衍生天數（Day 1 為第1天）*/
    if TRTSDT ne . then TRTSDY = 1;
    if TRTEDT ne . and TRTSDT ne . then
        TRTEDY = TRTEDT - TRTSDT + 1;
    format TRTSDT TRTEDT yymmdd10.;
    
    /*for後續其他adam使用*/
    TRTA = ARM; 
    
    keep USUBJID SEX AGE RACE ARM TRTA TRTSDT TRTEDT TRTSDY TRTEDY ITTFL SAFFL;
run;
