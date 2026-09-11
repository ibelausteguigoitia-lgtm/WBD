---Q1
SELECT * , count(customer_id) as duplicate fROM sub
group by customer_id
having subscription_typ like '%paid%' and status like '%active%' and duplicate > 1
---THOUGHT PROCESS:
---Identify duplicate customers, User must have paid and it's an active account.

---Q2
SELECT *, COUNT(payment_id) AS total_charges, MAX(REPLACE(billing_amount, '$', '') * 1.0) * (COUNT(payment_id) - 1) AS overbilled_amount FROM Pay
GROUP BY subscription_id, billing_cycle_da
HAVING COUNT(payment_id) > 1;
---THOUGHT PROCESS:
---Count how many times a user got charged the same billing cycle.

---Q3
select * from sub
left join Pay
on sub.customer_id=pay.customer_id and sub.renewal_date = pay.billing_cycle_da
where sub.subscription_typ like '%paid%' and sub.status like '%Active%' and sub.expected_payment like '%Yes%' AND pay.payment_id IS NULL
---THOUGHT PROCESS
---Account must be active, subscription appeards as "Paid" (even if it's not the case", but the system is waiting for a payment to be done, that is to say Expected Payment = Yes.

---Q4 
select * from sub
where subscription_typ like '%Trial%' and status like '%Active%' and trial_end_date is not null
---THOUGHT PROCESS
---Identify all Trial Accounts + active accounts + accounts with a trial end date

---Q5
Select *, ROUND((REPLACE(billing_amount, '$', '') * 1.0) - (REPLACE(psp_amount, '$', '') * 1.0), 2) as difference from pay
where difference > 0
---THOUGHT PROCESS
---Identify a difference between what we charged vs the money we got.
