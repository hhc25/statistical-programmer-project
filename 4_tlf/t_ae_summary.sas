/* t_ae_summary.sas - T14.1.1 Adverse Events Summary Table */

libname adam "~/myfolders/3_adam/";

/* Step 1: 計算每組母數 (N) */
proc sql;
    create table n_counts as
    select TRTA, count(distinct USUBJID) as N
    from adam.adsl
    where SAFFL = "Y"
    group by TRTA;
quit;

/* Step 2: 每組各 AETERM 的不重複人數 */
proc sql;
    create table ae_counts as
    select TRTA, AETERM, count(distinct USUBJID) as Count
    from adam.adae
    where SAFFL = "Y"
    group by TRTA, AETERM;
quit;

/* Step 3: 合併總 N，計算百分比 */
proc sql;
    create table ae_summary as
    select 
        a.TRTA,
        a.AETERM,
        a.Count,
        n.N,
        cats(put(a.Count, 3.), " (", put(100*a.Count/n.N, 5.1), "%)") as CountPct
    from ae_counts a
    left join n_counts n
    on a.TRTA = n.TRTA;
quit;

/* Step 4: 建立轉置格式報表 */
proc sort data=ae_summary; by AETERM TRTA; run;

proc transpose data=ae_summary out=ae_report(drop=_name_) delimiter=_;
    by AETERM;
    id TRTA;
    var CountPct;
run;

/* Step 5: 輸出成 .rtf 報表 */
ods rtf file="~/myfolders/4_tlf/output/ae_summary.rtf" style=journal;
title "Table 14.1.1 Adverse Events Summary";
proc print data=ae_report label noobs; run;
ods rtf close;
