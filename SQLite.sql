---Q1
SELECT customer_id, COUNT(DISTINCT subscription_id) AS duplicate_subscriptions FROM sub
WHERE subscription_typ LIKE '%Paid%' AND status LIKE '%Active%'
GROUP BY customer_id
HAVING COUNT(DISTINCT subscription_id) > 1
---THOUGHT PROCESS:
---Identify customers with more than one active paid subscription.

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
---Identify active paid subscriptions where a payment is expected but no matching payment exists for the renewal date.

---Q4 
SELECT sub.* FROM sub
LEFT JOIN Pay
ON sub.subscription_id = Pay.subscription_id
WHERE sub.subscription_typ LIKE '%Trial%' AND sub.status LIKE '%Active%' AND sub.trial_end_date IS NOT NULL AND Pay.payment_id IS NULL
---THOUGHT PROCESS
---Identify all Trial Accounts + active accounts + accounts with a trial end date + No payments an be done

---Q5
Select *, ROUND((REPLACE(billing_amount, '$', '') * 1.0) - (REPLACE(psp_amount, '$', '') * 1.0), 2) as difference from pay
WHERE ROUND( (REPLACE(billing_amount, '$', '') * 1.0) - (REPLACE(psp_amount, '$', '') * 1.0), 2) <> 0
---THOUGHT PROCESS
---Identify a difference between what we charged vs the money we got.
