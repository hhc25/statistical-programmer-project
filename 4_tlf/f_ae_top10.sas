/* f_ae_top10.sas - F14.1 Top 10 Adverse Events Frequency Plot */

libname adam "~/myfolders/3_adam/";
ods graphics / reset outputfmt=png imagename="ae_top10" imagefmt=png;
ods listing gpath="~/myfolders/4_tlf/output/";

title "Figure 14.1 Top 10 Most Frequent Adverse Events";

proc sql;
    /* 計算每組 AETERM 發生人數 */
    create table ae_counts as
    select TRTA, AETERM, count(distinct USUBJID) as Count
    from adam.adae
    where SAFFL = "Y"
    group by TRTA, AETERM;

    /* 找出總體最常見的前 10 名 AE */
    create table ae_total as
    select AETERM, sum(Count) as TotalCount
    from ae_counts
    group by AETERM
    order by TotalCount desc;
quit;

/* 取出前 10 名 AE 詞條 */
proc sql outobs=10;
    create table top10_terms as
    select AETERM from ae_total;
quit;

/* 篩選前 10 的 AE 進行視覺化 */
proc sql;
    create table ae_top10 as
    select a.*
    from ae_counts a
    inner join top10_terms t
    on a.AETERM = t.AETERM;
quit;

/* 繪製群組長條圖 */
proc sgplot data=ae_top10;
    vbar AETERM / response=Count group=TRTA groupdisplay=cluster datalabel;
    xaxis discreteorder=data label="Adverse Event Term";
    yaxis label="Number of Subjects";
run;

ods listing close;
