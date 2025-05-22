/* t_ae_ctcae3.sas - T14.1.3 CTCAE Grade ≥3 Adverse Events Summary Table */

libname adam "~/myfolders/3_adam/";

/* Step 1: 計算每組母數 (N) */
proc sql;
    create table n_counts as
    select TRTA, count(distinct USUBJID) as N
    from adam.adsl
    where SAFFL = "Y"
    group by TRTA;
quit;

/* Step 2: 每組各 AETERM 的不重複 Grade ≥3 人數 */
proc sql;
    create table tox3_counts as
    select TRTA, AETERM, count(distinct USUBJID) as Count
    from adam.adae
    where SAFFL = "Y" and AETOXGR in ("3", "4", "5")
    group by TRTA, AETERM;
quit;

/* Step 3: 合併總 N，計算百分比 */
proc sql;
    create table tox3_summary as
    select 
        a.TRTA,
        a.AETERM,
        a.Count,
        n.N,
        cats(put(a.Count, 3.), " (", put(100*a.Count/n.N, 5.1), "%)") as CountPct
    from tox3_counts a
    left join n_counts n
    on a.TRTA = n.TRTA;
quit;

/* Step 4: 建立轉置格式報表 */
proc sort data=tox3_summary; by AETERM TRTA; run;

proc transpose data=tox3_summary out=tox3_report(drop=_name_) delimiter=_;
    by AETERM;
    id TRTA;
    var CountPct;
run;

/* Step 5: 輸出成 .rtf 報表 */
ods rtf file="~/myfolders/4_tlf/output/ae_ctcae3.rtf" style=journal;
title "Table 14.1.3 CTCAE Grade ≥3 Adverse Events Summary";
proc print data=tox3_report label noobs; run;
ods rtf close;
