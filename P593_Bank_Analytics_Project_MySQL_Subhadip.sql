use bankloan;
select * from finance_1;
select * from finance_2;

# KPI 1 : Year wise loan amount status
select year(issue_d) as Year_issue_date, 
concat("$ ", format(round(sum(loan_amnt)/1000000,0),0), " M") as Total_loan_amnt 
from finance_1
group by Year_issue_date
order by Year_issue_date;

/* data cleaning:
select * from finance_1;
alter table finance_1 rename column ï»¿id to id;

select * from finance_2;
alter table finance_2 rename column ï»¿id to id;
*/

# KPI 2 : Grade and sub grade wise revol_bal
select grade, sub_grade, 
concat("$ ", format(sum(revol_bal)/1000000,0), " M") as Total_revol_bal 
from finance_1 inner join finance_2
on(finance_1.id = finance_2.id)
group by grade, sub_grade
order by grade, sub_grade;

# KPI 3 : Total Payment for Verified Status Vs Total Payment for Non Verified Status
select verification_status, 
concat("$ ", format(round(sum(total_pymnt)/1000000,2),2), " M") as Total_payment
from finance_1 inner join finance_2
on(finance_1.id = finance_2.id)
group by verification_status;

# KPI 4 : State wise and last_credit_pull_d wise loan status
select addr_state, last_credit_pull_d, loan_status
from finance_1 inner join finance_2
on(finance_1.id = finance_2.id)
group by addr_state, last_credit_pull_d, loan_status
order by last_credit_pull_d;

# KPI 5 : Home ownership Vs last payment date stats
select home_ownership, last_pymnt_d,
concat("$ ", format(round(sum(last_pymnt_amnt)/1000,2),2), " K") as Total_amount
from finance_1 inner join finance_2
on(finance_1.id = finance_2.id)
group by home_ownership, last_pymnt_d
order by home_ownership, last_pymnt_d;