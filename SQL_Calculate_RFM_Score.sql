SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[calculate_rfm_scores]
AS
-- Define the last date and temporary table
DECLARE @end_Date DATE

SET @end_Date = dateadd(day, - 1, getdate())

IF OBJECT_ID('tempdb..#customer_rfm') IS NOT NULL
    DROP TABLE #customer_rfm

CREATE TABLE #customer_rfm (
    id INT identity(1, 1),
    customer_id BIGINT,
    recency INT,
    frequency INT,
    monetary MONEY
    )

-- Define recency, frequency, monetary
INSERT INTO #customer_rfm (
    customer_id,
    recency,
    frequency,
    monetary
    )
SELECT external_customer_id,
    datediff(day, last_transaction_date, @end_Date) AS recency,
    total_orders AS frequency,
    total_gross AS monetary
FROM customer
WHERE sales_channel_id = 1 -- US only

-- Calcualte R Scores (score 1 to 5)
SELECT NTILE(5) OVER (
        ORDER BY recency DESC
        ) AS 'Quintile',
    *
INTO #customer_r_quintile
FROM #customer_rfm

-- Calcualte F Scores (score 1 to 5)
SELECT NTILE(5) OVER (
        ORDER BY frequency
        ) AS 'Quintile',
    *
INTO #customer_f_quintile
FROM #customer_rfm

-- Calcualte M Scores (score 1 to 5)
SELECT NTILE(5) OVER (
        ORDER BY monetary
        ) AS 'Quintile',
    *
INTO #customer_m_quintile
FROM #customer_rfm

-- Update RFM Scores
UPDATE m
SET m.r_score = rfm.r_score,
    m.f_score = rfm.f_score,
    m.m_score = rfm.m_score,
    m.rfm_score = rfm.rfm_score
FROM customer m
INNER JOIN (
    SELECT r.customer_id,
        r.Quintile AS r_score,
        f.Quintile AS f_score,
        m.Quintile AS m_score,
        r.Quintile + f.Quintile + m.Quintile AS rfm_score
    FROM #customer_r_quintile r
    INNER JOIN #customer_f_quintile f
        ON f.customer_id = r.customer_id
    INNER JOIN #customer_m_quintile m
        ON m.customer_id = r.customer_id
    ) rfm
    ON rfm.customer_id = m.external_customer_id
WHERE m.sales_channel_id = 1

GO