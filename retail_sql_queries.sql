-- ================================================================
-- RETAIL BEHAVIOR INTELLIGENCE - SQL Analysis
-- Author  : Rohan Tand
-- Program : M.S. Data Analytics, University of Illinois Springfield
-- GitHub  : github.com/Rtandra65
-- Contact : rtand@uis.edu
-- Dataset : retail_shopping_data.csv (3,900 rows, 19 columns)
-- Engine  : PostgreSQL / MySQL / SQLite compatible
-- ================================================================

-- ================================================================
-- SECTION 1: CORE KPIs
-- ================================================================

-- 1.1 Overall Business Health Summary
SELECT
    COUNT(*)                                AS total_orders,
    COUNT(DISTINCT customer_id)             AS unique_customers,
    ROUND(SUM(purchase_amount_usd), 2)      AS total_revenue,
    ROUND(AVG(purchase_amount_usd), 2)      AS avg_order_value,
    ROUND(MIN(purchase_amount_usd), 2)      AS min_order,
    ROUND(MAX(purchase_amount_usd), 2)      AS max_order
FROM retail_shopping_data;

-- 1.2 Revenue by Product Category
SELECT
    category,
    COUNT(*)                                AS total_orders,
    ROUND(SUM(purchase_amount_usd), 2)      AS total_revenue,
    ROUND(AVG(purchase_amount_usd), 2)      AS avg_order_value,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 1) AS order_share_pct
FROM retail_shopping_data
GROUP BY category
ORDER BY total_revenue DESC;

-- 1.3 Top 10 Best-Selling Items
SELECT
    item_purchased,
    category,
    COUNT(*)                                AS purchase_count,
    ROUND(SUM(purchase_amount_usd), 2)      AS total_revenue,
    ROUND(AVG(purchase_amount_usd), 2)      AS avg_price
FROM retail_shopping_data
GROUP BY item_purchased, category
ORDER BY purchase_count DESC
LIMIT 10;

-- ================================================================
-- SECTION 2: CUSTOMER SEGMENTATION
-- ================================================================

-- 2.1 Generational Cohort Analysis
SELECT
    CASE
        WHEN age BETWEEN 18 AND 26 THEN 'Gen Z (18-26)'
        WHEN age BETWEEN 27 AND 42 THEN 'Millennials (27-42)'
        WHEN age BETWEEN 43 AND 58 THEN 'Gen X (43-58)'
        WHEN age >= 59             THEN 'Boomers (59+)'
    END                                     AS generation,
    gender,
    COUNT(*)                                AS total_orders,
    ROUND(AVG(purchase_amount_usd), 2)      AS avg_spend,
    ROUND(AVG(review_rating), 2)            AS avg_rating,
    ROUND(AVG(previous_purchases), 1)       AS avg_lifetime_orders
FROM retail_shopping_data
GROUP BY generation, gender
ORDER BY avg_spend DESC;

-- 2.2 Subscription vs Non-Subscription Value Comparison
SELECT
    subscription_status,
    loyalty_score,
    COUNT(*)                                AS customers,
    ROUND(AVG(purchase_amount_usd), 2)      AS avg_spend,
    ROUND(AVG(previous_purchases), 1)       AS avg_lifetime_orders,
    ROUND(AVG(review_rating), 2)            AS avg_satisfaction
FROM retail_shopping_data
GROUP BY subscription_status, loyalty_score
ORDER BY subscription_status, avg_spend DESC;

-- 2.3 Loyalty Tier Revenue Contribution
SELECT
    loyalty_score                           AS loyalty_tier,
    spend_tier,
    COUNT(*)                                AS customer_count,
    ROUND(SUM(purchase_amount_usd), 2)      AS total_revenue,
    ROUND(AVG(purchase_amount_usd), 2)      AS avg_order_value
FROM retail_shopping_data
GROUP BY loyalty_score, spend_tier
ORDER BY total_revenue DESC;

-- 2.4 High-Value Untapped Segment
-- Loyal customers (30+ orders) who never use promo codes
-- These customers buy without incentive - prime upsell targets
SELECT
    COUNT(*)                                AS segment_size,
    ROUND(AVG(purchase_amount_usd), 2)      AS avg_spend,
    ROUND(AVG(previous_purchases), 1)       AS avg_orders,
    ROUND(AVG(review_rating), 2)            AS avg_satisfaction,
    loyalty_score
FROM retail_shopping_data
WHERE previous_purchases >= 30
  AND promo_code_used = 'No'
GROUP BY loyalty_score
ORDER BY avg_spend DESC;

-- ================================================================
-- SECTION 3: SEASONAL TRENDS
-- ================================================================

-- 3.1 Revenue and Volume by Season
SELECT
    season,
    COUNT(*)                                AS total_orders,
    ROUND(SUM(purchase_amount_usd), 2)      AS total_revenue,
    ROUND(AVG(purchase_amount_usd), 2)      AS avg_order_value,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 1) AS volume_share_pct
FROM retail_shopping_data
GROUP BY season
ORDER BY total_revenue DESC;

-- 3.2 Category Performance by Season
SELECT
    season,
    category,
    COUNT(*)                                AS orders,
    ROUND(SUM(purchase_amount_usd), 2)      AS revenue,
    ROUND(AVG(purchase_amount_usd), 2)      AS avg_order_value
FROM retail_shopping_data
GROUP BY season, category
ORDER BY season, revenue DESC;

-- 3.3 Promo Redemption Rate by Season
SELECT
    season,
    COUNT(*)                                AS total_orders,
    SUM(CASE WHEN promo_code_used = 'Yes' THEN 1 ELSE 0 END) AS promo_orders,
    ROUND(100.0 * SUM(CASE WHEN promo_code_used = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS promo_rate_pct,
    ROUND(AVG(CASE WHEN promo_code_used = 'Yes' THEN purchase_amount_usd END), 2) AS avg_spend_with_promo,
    ROUND(AVG(CASE WHEN promo_code_used = 'No'  THEN purchase_amount_usd END), 2) AS avg_spend_without_promo
FROM retail_shopping_data
GROUP BY season
ORDER BY promo_rate_pct DESC;

-- ================================================================
-- SECTION 4: PAYMENT, SHIPPING & DISCOUNTS
-- ================================================================

-- 4.1 Payment Method Preference by Age Group
SELECT
    CASE
        WHEN age < 35  THEN 'Under 35'
        WHEN age < 55  THEN '35-54'
        ELSE                '55+'
    END                                     AS age_group,
    payment_method,
    COUNT(*)                                AS total_orders,
    ROUND(AVG(purchase_amount_usd), 2)      AS avg_spend
FROM retail_shopping_data
GROUP BY age_group, payment_method
ORDER BY age_group, total_orders DESC;

-- 4.2 Discount vs No Discount - Revenue Impact
SELECT
    discount_applied,
    promo_code_used,
    COUNT(*)                                AS total_orders,
    ROUND(AVG(purchase_amount_usd), 2)      AS avg_order_value,
    ROUND(SUM(purchase_amount_usd), 2)      AS total_revenue
FROM retail_shopping_data
GROUP BY discount_applied, promo_code_used
ORDER BY avg_order_value DESC;

-- 4.3 Shipping Preference by Subscription
SELECT
    subscription_status,
    shipping_type,
    COUNT(*)                                AS total_orders,
    ROUND(AVG(purchase_amount_usd), 2)      AS avg_spend
FROM retail_shopping_data
GROUP BY subscription_status, shipping_type
ORDER BY subscription_status, total_orders DESC;

-- ================================================================
-- SECTION 5: GEOGRAPHIC ANALYSIS
-- ================================================================

-- 5.1 Top 10 States by Total Revenue
SELECT
    location                                AS state,
    COUNT(*)                                AS total_orders,
    ROUND(SUM(purchase_amount_usd), 2)      AS total_revenue,
    ROUND(AVG(purchase_amount_usd), 2)      AS avg_order_value,
    ROUND(AVG(review_rating), 2)            AS avg_satisfaction
FROM retail_shopping_data
GROUP BY location
ORDER BY total_revenue DESC
LIMIT 10;

-- 5.2 Premium Markets (AOV above $55)
SELECT
    location                                AS state,
    COUNT(*)                                AS orders,
    ROUND(AVG(purchase_amount_usd), 2)      AS avg_order_value,
    ROUND(SUM(purchase_amount_usd), 2)      AS total_revenue
FROM retail_shopping_data
GROUP BY location
HAVING AVG(purchase_amount_usd) > 55
ORDER BY avg_order_value DESC;

-- ================================================================
-- SECTION 6: SATISFACTION SIGNALS
-- ================================================================

-- 6.1 Review Rating Distribution by Category
SELECT
    category,
    ROUND(AVG(review_rating), 2)            AS avg_rating,
    COUNT(CASE WHEN review_rating <= 2.5 THEN 1 END) AS low_ratings,
    COUNT(CASE WHEN review_rating BETWEEN 2.6 AND 3.9 THEN 1 END) AS mid_ratings,
    COUNT(CASE WHEN review_rating >= 4.0 THEN 1 END) AS high_ratings,
    COUNT(*)                                AS total_reviews
FROM retail_shopping_data
GROUP BY category
ORDER BY avg_rating ASC;

-- 6.2 Satisfaction by Spend Tier
SELECT
    spend_tier,
    ROUND(AVG(review_rating), 2)            AS avg_rating,
    COUNT(*)                                AS total_orders,
    ROUND(AVG(purchase_amount_usd), 2)      AS avg_spend
FROM retail_shopping_data
GROUP BY spend_tier
ORDER BY avg_spend DESC;

-- ================================================================
-- SECTION 7: ORIGINAL ANALYSIS — ROHAN TAND
-- Queries written independently beyond the base walkthrough
-- ================================================================

-- 7.1 Customer Retention Approximation by Purchase Frequency
SELECT
    CASE
        WHEN previous_purchases >= 40 THEN 'Power Buyers (40+)'
        WHEN previous_purchases BETWEEN 25 AND 39 THEN 'Returning (25-39)'
        WHEN previous_purchases BETWEEN 10 AND 24 THEN 'Occasional (10-24)'
        ELSE 'New / Infrequent (<10)'
    END                                     AS customer_type,
    COUNT(*)                                AS count,
    ROUND(AVG(purchase_amount_usd), 2)      AS avg_spend,
    ROUND(AVG(review_rating), 2)            AS avg_rating,
    ROUND(AVG(previous_purchases), 1)       AS avg_orders
FROM retail_shopping_data
GROUP BY customer_type
ORDER BY avg_spend DESC;

-- 7.2 Cross-Sell Gap Matrix
-- Category + Season combos with below-average satisfaction
-- These flag potential fulfillment or product-fit gaps
SELECT
    category,
    season,
    COUNT(*)                                AS orders,
    ROUND(AVG(review_rating), 2)            AS avg_rating,
    ROUND(AVG(purchase_amount_usd), 2)      AS avg_spend
FROM retail_shopping_data
GROUP BY category, season
HAVING AVG(review_rating) < 3.8
ORDER BY avg_rating ASC;

-- 7.3 Promo Sensitivity by Loyalty Tier
-- Are discounts concentrated in low-loyalty segments?
SELECT
    loyalty_score                           AS loyalty_tier,
    promo_code_used,
    COUNT(*)                                AS orders,
    ROUND(AVG(purchase_amount_usd), 2)      AS avg_spend,
    ROUND(AVG(review_rating), 2)            AS avg_rating
FROM retail_shopping_data
GROUP BY loyalty_score, promo_code_used
ORDER BY loyalty_score, promo_code_used;

-- 7.4 Payment x Shipping Behavior Matrix
-- Reveals behavioral bundles for checkout UX optimization
SELECT
    payment_method,
    shipping_type,
    COUNT(*)                                AS total_orders,
    ROUND(AVG(purchase_amount_usd), 2)      AS avg_spend
FROM retail_shopping_data
GROUP BY payment_method, shipping_type
HAVING COUNT(*) > 20
ORDER BY avg_spend DESC
LIMIT 15;
