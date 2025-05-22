/* l_ae_listing.sas - L14.2.1 AE Listing */

libname adam "~/myfolders/3_adam/";

ods rtf file="~/myfolders/4_tlf/output/ae_listing.rtf" style=journal;
title "Listing 14.2.1 Adverse Events Listing";

proc report data=adam.adae nowd split='|' missing;
    columns USUBJID AETERM AETOXGR AESEV AESER AESTDTC AEENDTC TRTA SAFFL ASTDY AENDY TRTEMFL;

    define USUBJID / "Subject ID" width=14;
    define AETERM  / "Adverse Event Term" width=25;
    define AETOXGR / "CTCAE Grade" width=10;
    define AESEV   / "Severity" width=10;
    define AESER   / "Serious?" width=8;
    define AESTDTC / "Start Date" width=12;
    define AEENDTC / "End Date" width=12;
    define TRTA    / "Treatment Arm" width=16;
    define SAFFL   / "Safety Flag" width=8;
    define ASTDY   / "Start Day" width=10;
    define AENDY   / "End Day" width=10;
    define TRTEMFL / "Occurred on Treatment?" width=14;

run;

ods rtf close;
