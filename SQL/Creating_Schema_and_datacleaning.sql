CREATE DATABASE IF NOT EXISTS Telco_Customer_Churn;

USE Telco_Customer_Churn;

CREATE TABLE Customers_original (
	Customer_id VARCHAR(55) NOT NULL UNIQUE PRIMARY KEY, 
    Gender ENUM('Male', 'Female') NOT NULL, 
    SeniorCitizen BOOLEAN NOT NULL, 
    Partner ENUM('Yes', 'No') NOT NULL, 
    Dependents ENUM('Yes', 'No') NOT NULL, 
    Tenure INT NOT NULL, 
    PhoneService ENUM('Yes', 'No') NOT NULL, 
    MultipleLines ENUM('Yes', 'No', 'No phone service') NOT NULL, 
    InternetService ENUM('DSL', 'Fiber optic', 'No') NOT NULL, 
    OnlineSecurity ENUM('Yes', 'No', 'No internet service') NOT NULL, 
    OnlineBackup ENUM('Yes', 'No', 'No internet service') NOT NULL, 
    DeviceProtection ENUM('Yes', 'No', 'No internet service') NOT NULL, 
    TechSupport ENUM('Yes', 'No', 'No internet service') NOT NULL, 
    StreamingTV ENUM('Yes', 'No', 'No internet service') NOT NULL, 
    StreamingMovies ENUM('Yes', 'No', 'No internet service') NOT NULL, 
    Contract ENUM('Month-to-month', 'One year', 'Two year') NOT NULL, 
    PaperlessBilling ENUM('Yes', 'No') NOT NULL, 
    PaymentMethod VARCHAR(55) NOT NULL, 
    MonthlyCharges DECIMAL(10 ,2) NOT NULL, 
    TotalCharges DECIMAL(10, 2) NOT NULL, 
    Churn ENUM('Yes', 'No') NOT NULL
);		/* Imported 7032 records of 7043. Error found in TotalCharges as ''. 
		Creating a staging table with TotalCharges as VARCHAR and then perform 
        data cleaning operations*/
        
CREATE TABLE Customers_staging (
	Customer_id VARCHAR(55) NOT NULL UNIQUE PRIMARY KEY, 
    Gender ENUM('Male', 'Female') NOT NULL, 
    SeniorCitizen BOOLEAN NOT NULL, 
    Partner ENUM('Yes', 'No') NOT NULL, 
    Dependents ENUM('Yes', 'No') NOT NULL, 
    Tenure INT NOT NULL, 
    PhoneService ENUM('Yes', 'No') NOT NULL, 
    MultipleLines ENUM('Yes', 'No', 'No phone service') NOT NULL, 
    InternetService ENUM('DSL', 'Fiber optic', 'No') NOT NULL, 
    OnlineSecurity ENUM('Yes', 'No', 'No internet service') NOT NULL, 
    OnlineBackup ENUM('Yes', 'No', 'No internet service') NOT NULL, 
    DeviceProtection ENUM('Yes', 'No', 'No internet service') NOT NULL, 
    TechSupport ENUM('Yes', 'No', 'No internet service') NOT NULL, 
    StreamingTV ENUM('Yes', 'No', 'No internet service') NOT NULL, 
    StreamingMovies ENUM('Yes', 'No', 'No internet service') NOT NULL, 
    Contract ENUM('Month-to-month', 'One year', 'Two year') NOT NULL, 
    PaperlessBilling ENUM('Yes', 'No') NOT NULL, 
    PaymentMethod VARCHAR(55) NOT NULL, 
    MonthlyCharges DECIMAL(10 ,2) NOT NULL, 
    TotalCharges VARCHAR(55) NOT NULL, 
    Churn ENUM('Yes', 'No') NOT NULL
);			/* Imported 7043 records successfully */

SELECT Totalcharges FROM customers_staging
WHERE totalcharges = ' ';	-- Confirming the errors in TotalCharges are due to ' ' in place of decimal

-- Updating totalcharges ' ' to 0.00
UPDATE customers_staging 
SET totalcharges = '0.00'
WHERE totalcharges = ' ';

-- Modifying totalcharges from VARCHAR to DECIMAL NOT NULL
ALTER TABLE customers_staging
MODIFY COLUMN totalcharges DECIMAL(10, 2) NOT NULL;

-- Verifying changes
DESCRIBE customers_staging;

-- Inserting values from customers_staging to customers_original where customer_id is not existing
INSERT INTO customers_original (customer_id, gender, seniorcitizen, partner, dependents, tenure, 
								phoneservice, multiplelines, internetservice, onlinesecurity, onlinebackup, 
                                deviceprotection, techsupport, streamingtv, streamingmovies, contract, 
                                paperlessbilling, paymentmethod, monthlycharges, totalcharges, churn)  
SELECT 
	s.customer_id, s.gender, s.seniorcitizen, s.partner, s.dependents, s.tenure, s.phoneservice, s.multiplelines, 
    s.internetservice, s.onlinesecurity, s.onlinebackup, s.deviceprotection, s.techsupport, s.streamingtv, 
    s.streamingmovies, s.contract, s.paperlessbilling, s.paymentmethod, s.monthlycharges, s.totalcharges, s.churn 
FROM customers_staging s 
LEFT JOIN customers_original r 
ON s.customer_id = r.customer_id
WHERE r.customer_id IS NULL;

-- Verifying data in customers_original
DESCRIBE customers_original;

SELECT COUNT(*) FROM customers_original;	-- all the records are imported successfully

-- Creating a copy of customers_original as customers
CREATE TABLE Customers LIKE Customers_original;

INSERT INTO customers 
SELECT * FROM customers_original;

-- Verifying customers table 
DESCRIBE customers;

SELECT * FROM customers;

SELECT COUNT(*) FROM customers;
