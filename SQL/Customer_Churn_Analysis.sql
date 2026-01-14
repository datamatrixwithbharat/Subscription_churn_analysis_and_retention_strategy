USE telco_customer_churn;

-- What % of customers churn?
SELECT 
	ROUND( 
		(
			COUNT(CASE WHEN churn = 'Yes' THEN 1 END) / COUNT(*)
		) * 100, 
	2) AS customers_churn_rate
FROM customers;		-- Identified fair customer churn with 26.54%

-- How does churn vary by contract type
SELECT 
	contract, 
	ROUND( 
		(
			COUNT(CASE WHEN churn = 'Yes' THEN 1 END) / COUNT(*)
		) * 100, 
	2) AS customers_churn_rate
FROM customers
GROUP BY contract
ORDER BY customers_churn_rate DESC;	/* High customer churn in Month-to-Month contract with 42.71%
										One year contract with 11.27% and lowest churn recorded 
										in Two year contract with 2.83% */

-- How does churn vary by tenure
SELECT 
	CASE 
		WHEN tenure <= 6 THEN '0-6 months' 
        WHEN tenure <= 12 THEN '7-12 months' 
        WHEN tenure <= 24 THEN '13-24 months'
        ELSE '24+ months'
	END AS tenure_band, 
	ROUND( 
		(
			COUNT(CASE WHEN churn = 'Yes' THEN 1 END) / COUNT(*)
		) * 100, 
	2) AS customers_churn_rate
FROM customers
GROUP BY tenure_band
ORDER BY customers_churn_rate DESC;	/* Customer churn is high at 0-6 months tenure with 53% and 
									low at greater than 24 months tenure with 14% */

-- How does churn vary by payment method
SELECT 
	paymentmethod, 
	ROUND( 
		(
			COUNT(CASE WHEN churn = 'Yes' THEN 1 END) / COUNT(*)
		) * 100, 
	2) AS customers_churn_rate
FROM customers
GROUP BY paymentmethod
ORDER BY customers_churn_rate DESC;		/* Customer churn found high in electronic check method with 45.29%, 
											mailed check with 19.11% and lowest churn recorded for credit card method
                                            with 15.24% and bank transfer with 16.71% */

-- How does churn vary by monthly charges
SELECT 
	CASE 
		WHEN monthlycharges <= 50 THEN 'Low' 
        WHEN monthlycharges <= 80 THEN 'Medium'
        ELSE 'High'
	END AS Charges_band,
	ROUND( 
		(
			COUNT(CASE WHEN churn = 'Yes' THEN 1 END) / COUNT(*)
		) * 100, 
	2) AS customers_churn_rate
FROM customers
GROUP BY charges_band
ORDER BY customers_churn_rate DESC;		/* Customer churn at high charges band is recorded at 34% and 16% at low charges band */

-- Which segments churn the most?
-- Here the strongest churn drivers are contract, tenure, paymentmethod, monthlycharges - creating buckets for segmentaion
SELECT 
	contract, 
    paymentmethod, 
    CASE 
		WHEN tenure <= 6 THEN '0-6 months' 
        WHEN tenure <= 12 THEN '7-12 months' 
        WHEN tenure <= 24 THEN '13-24 months'
        ELSE '24+ months'
	END AS tenure_band, 
    CASE 
		WHEN monthlycharges <= 50 THEN 'Low' 
        WHEN monthlycharges <= 80 THEN 'Medium'
        ELSE 'High'
	END AS Charges_band, 
    COUNT(*) AS total_customers, 
    COUNT(CASE WHEN churn = 'Yes' THEN 1 END) AS churned_customers, 
    ROUND( 
		(COUNT(CASE WHEN churn = 'Yes' THEN 1 END)/COUNT(*)) * 100, 2
    ) AS churn_rate
FROM customers
GROUP BY contract, paymentmethod, tenure_band, charges_band
HAVING COUNT(*) > 20
ORDER BY churn_rate DESC;
/* High strength churn drivers are 

	contract = month-to-month
    paymentmethod = all types
    tenure = 0 to 24 months
    monthlycharges = medium to high
	
    Therefore customers with high tenures and contract of one or two year are high valued customers*/

-- What behaviors indicate early churn risk?
SELECT 
	contract, 
    paymentmethod, 
    CASE 
		WHEN monthlycharges <= 50 THEN 'Low' 
        WHEN monthlycharges <= 80 THEN 'Medium'
        ELSE 'High'
	END AS Charges_band, 
    COUNT(*) AS total_customers, 
    COUNT(CASE WHEN churn = 'Yes' THEN 1 END) AS churned_customers, 
    ROUND( 
		(COUNT(CASE WHEN churn = 'Yes' THEN 1 END)/COUNT(*)) * 100, 2
    ) AS churn_rate
FROM customers
WHERE tenure < 6
GROUP BY contract, paymentmethod, charges_band
ORDER BY churn_rate DESC;
/* customers with month-to-month contract with high monthly charges have high churn rate */