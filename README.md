# Reseller_Classification
Machine Learning Binary Classification

Project Scope:

The purpose of this project is to distinguish the resellers from the customers who purchased on the US website. Resellers harm the brand reputation, product market price, and inventory management of the company. Therefore, the company wants to identify and block the resellers' shipments.
The project involves a binary classification problem that may require feature engineering if necessary. The data source is a structured dataset in the database, which includes numerical and categorical features.

Dataset column descriptions:

      'sales_channel_id': US sales channel id is 1, integer 

      'external_customer_id': customer id, integer 

      'email': customer email address, string

      'last_shipping_address_address1': the shipping address 1 used in the last transaction, string

      'last_shipping_address_address2': the shipping address 2 used in the last transaction, string

      'last_shipping_address_city': the shipping city used in the last transaction, string

      'last_shipping_address_zip': the shipping address zip code used in the last transaction, string

      'last_shipping_address_country_code': the shipping country code used in the last transaction, string

      'total_orders': the total count of orders purchased by the customer, integer 

      'total_units': the total count of item units purchased by the customer, integer 

      'total_gross': the total gross sales spent by the customer, float

      'total_discounts': the total discounts used by the customer, float

      'total_returns': the total returns to the customer, float

      'total_shipping': the total shipping spent by the customer, float

      'total_taxes': the total taxes purchased by the customer, float

      'r_score': recency score represents how recently a customer has made a purchase, score 1-5, integer 

      'f_score': frequency score represents how often a customer makes a purchase, score 1-5, integer 

      'm_score': monetary value score represents how much money a customer spends on purchases, score 1-5, integer

      'rfm_score': r_score + f_score + m_score, integer 

      'is_reseller': 1 (reseller) or 0 (normal customer), this is the target, integer
