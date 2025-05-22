/* adex.sas - Create ADaM.ADEX from SDTM.EX + ADSL */

libname sdtm "~/myfolders/2_sdtm/";
libname adam "~/myfolders/3_adam/";

/* Step 1: 合併 EX + ADSL 提供分析旗標與組別 */
proc sql;
    create table ex_merged as
    select 
        ex.USUBJID,
        adsl.TRTA,
        adsl.SAFFL,
        ex.EXDOSE,
        ex.EXSTDTC,
        ex.EXENDTC
    from sdtm.ex as ex
    left join adam.adsl as adsl
        on ex.USUBJID = adsl.USUBJID;
quit;

/* Step 2: 衍生暴露天數與每位受試者總量 */
data ex_calculated;
    set ex_merged;

    length EXDUR 8;
    if EXSTDTC ne . and EXENDTC ne . then EXDUR = EXENDTC - EXSTDTC + 1;

    EXDOSETOT = EXDOSE * EXDUR;

    format EXSTDTC EXENDTC yymmdd10.;
run;

/* Step 3: 彙總每位受試者總暴露 */
proc sql;
    create table adam.adex as
    select 
        USUBJID,
        TRTA,
        SAFFL,
        sum(EXDOSETOT) as TOTDOSE,
        sum(EXDUR) as TOTDUR
    from ex_calculated
    group by USUBJID, TRTA, SAFFL;
quit;
