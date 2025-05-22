/* l_cm_listing.sas - L14.2.2 Concomitant Medication Listing */

libname sdtm "~/myfolders/2_sdtm/";
libname adam "~/myfolders/3_adam/";

ods rtf file="~/myfolders/4_tlf/output/cm_listing.rtf" style=journal;
title "Listing 14.2.2 Concomitant Medications";

proc sql;
    create table cm_merged as
    select 
        cm.USUBJID,
        adsl.TRTA,
        adsl.SAFFL,
        cm.CMTRT,
        cm.CMDOSFRQ,
        cm.CMROUTE,
        cm.CMSTDTC,
        cm.CMENDTC
    from sdtm.cm as cm
    left join adam.adsl as adsl
    on cm.USUBJID = adsl.USUBJID;
quit;

proc report data=cm_merged nowd split='|' missing;
    columns USUBJID CMTRT CMDOSFRQ CMROUTE CMSTDTC CMENDTC TRTA SAFFL;

    define USUBJID   / "Subject ID" width=14;
    define CMTRT     / "Medication" width=25;
    define CMDOSFRQ  / "Frequency" width=14;
    define CMROUTE   / "Route" width=12;
    define CMSTDTC   / "Start Date" width=12;
    define CMENDTC   / "End Date" width=12;
    define TRTA      / "Treatment Arm" width=16;
    define SAFFL     / "Safety Flag" width=8;

run;

ods rtf close;
