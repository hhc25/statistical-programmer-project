/* f_ae_grade_dist.sas - F14.2 CTCAE Grade Distribution by Treatment Arm */

libname adam "~/myfolders/3_adam/";
ods graphics / reset outputfmt=png imagename="ae_grade_dist" imagefmt=png;
ods listing gpath="~/myfolders/4_tlf/output/";

title "Figure 14.2 CTCAE Grade Distribution by Treatment Arm";

proc freq data=adam.adae noprint;
    where SAFFL = "Y" and AETOXGR ne "";
    tables TRTA*AETOXGR / out=ae_grade_freq(drop=percent);
run;

proc sgplot data=ae_grade_freq;
    vbar TRTA / response=count group=AETOXGR groupdisplay=stack stat=sum datalabel;
    xaxis label="Treatment Arm";
    yaxis label="Number of Adverse Events";
run;

ods listing close;
