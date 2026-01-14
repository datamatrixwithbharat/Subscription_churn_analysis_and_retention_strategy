**Project Title:**
Subscription_churn_analysis_and_retention_strategy

**Objective:**
Customer churn directly impacts recurring revenue. This project identifies churn drivers, segments high-risk customers, and builds an interpretable churn prediction model to enable proactive retention strategies.

**Tools used:**
MySQL

**About Dataset**
Telco customer churn - https://www.kaggle.com/code/emineyetm/telco-customer-churn/input

*Customers*
customer_id, gender, seniorcitizen, partner, dependants, tenure, phoneservice, multiplelines, internetservice, onlinesecurity,
onlinebackup, deviceprotection, techsupport, streamingtv, streamingmovies, contract, paperlessbilling, paymentmethod, monthlycharges, totalcharges, churn.

# SQL analysis - product thinking, cohort analysis, retention analysis

**Key findings**

- Identified fair customer churn with 26.54% -> customer retention operations would impact revenue loss.

- High customer churn in Month-to-Month contract with 42.71%
    One year contract with 11.27% and 
    lowest churn recorded in Two year contract with 2.83%. 

- Customer churn is high at 0-6 months tenure with 53% and 
    low at 24+ months tenure with 14%.

- Customer churn found high in electronic check method with 45.29%, 
    mailed check with 19.11% and lowest churn recorded for credit card method with 15.24% 
    and bank transfer with 16.71%.

- Customer churn at high charges band is recorded at 34% and 16% at low charges band.

- High strength churn drivers are 

	contract = month-to-month
    paymentmethod = all types
    tenure = 0 to 24 months
    monthlycharges = medium to high
	
    Therefore customers with high tenures and contract of one or two year are high valued customers.

- customers with month-to-month contract with high monthly charges have high churn rate.

# Delete from here
This sounds like a paid consulting engagement.

🔍 Phase 1: SQL Analysis (Product Thinking)
Business Questions


What % of customers churn?


How does churn vary by:


contract type


tenure


payment method


monthly charges




Which segments churn the most?


What behaviors indicate early churn risk?


📌 Output: Churn drivers, not just stats

🔮 Phase 2: Python Prediction Model (Simple & Explainable)
Target
Churn = Yes / No
Recommended model


Logistic Regression (primary)


Decision Tree (secondary)


Key focus (very important):


Feature importance


Odds ratios


Interpretation


💼 Example insight:

“Customers on monthly contracts with high charges and low tenure are 3.2× more likely to churn.”

That’s freelance gold.

📊 Phase 3: Product & Business Insights
Deliverables clients love:


High-risk churn customer segment


Top 5 churn drivers


Early warning indicators


Retention playbook


Example:
Risk FactorActionHigh chargesDiscount / plan reviewShort tenureOnboarding programMonthly contractPush annual plans

📈 Phase 4: Visualization (Optional but Powerful)
Dashboard ideas:


Churn rate by segment


Tenure vs churn


Risk distribution


Predicted churn customers


Keep it simple and decision-focused.

🧾 README Structure (Freelance-Optimized)
Your README should include:


Executive Summary


Churn rate & business impact


Key churn drivers


Predictive insights


Retention recommendations


Model explainability


Data limitations


This is how you sell yourself.

🔥 Why This Project Complements Your Olist Project
Project 1Project 2Revenue leakageCustomer retentionSQL + BISQL + PythonDescriptivePredictivePast lossFuture prevention
Together → very strong freelance profile.

🎯 Final Recommendation (Direct)
✅ Yes — use a subscription churn dataset
✅ Use simple, interpretable models
✅ Focus on business decisions, not accuracy

Next step (I recommend this):
I can:


Design the exact SQL questions


Create the feature list for the churn model


Outline the repo structure


Draft the README executive summary


Just tell me:
👉 Do you want SQL-first or Python-first for this churn project?