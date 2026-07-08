/* ============================================================
   Project 3: SQL Querying
   Dataset: E-commerce Orders (EcommerceOrdersProject.Orders)
   Skills demonstrated: SELECT, WHERE, ORDER BY, GROUP BY,
                         COUNT, SUM, AVG
   ============================================================ */

USE EcommerceOrdersProject;
GO

/* ------------------------------------------------------------
   1. Basic housekeeping: confirm row count and remove any
      blank rows accidentally introduced during import
   ------------------------------------------------------------ */

-- Check total row count
SELECT COUNT(*) AS TotalRows FROM Orders;

-- Remove fully blank rows (Order_ID is never blank in real data)
DELETE FROM Orders WHERE Order_ID IS NULL;

-- Confirm clean row count (should be 1200)
SELECT COUNT(*) AS TotalRows FROM Orders;


/* ------------------------------------------------------------
   2. SELECT + WHERE
      Filter orders down to only those that were Cancelled
   ------------------------------------------------------------ */

SELECT Order_ID, Product_Clean, Order_Status, Total_Price
FROM Orders
WHERE Order_Status = 'Cancelled';


/* ------------------------------------------------------------
   3. SELECT + WHERE + ORDER BY
      Same filter as above, sorted to find the highest-value
      cancelled orders first
   ------------------------------------------------------------ */

SELECT Order_ID, Product_Clean, Order_Status, Total_Price
FROM Orders
WHERE Order_Status = 'Cancelled'
ORDER BY Total_Price DESC;


/* ------------------------------------------------------------
   4. GROUP BY + COUNT + SUM + AVG
      Aggregate order count, total revenue, and average order
      value for each product
   ------------------------------------------------------------ */

SELECT
    Product_Clean,
    COUNT(*)            AS OrderCount,
    SUM(Total_Price)    AS TotalRevenue,
    AVG(Total_Price)    AS AvgOrderValue
FROM Orders
GROUP BY Product_Clean
ORDER BY TotalRevenue DESC;


/* ------------------------------------------------------------
   5. GROUP BY + COUNT + SUM + AVG
      Same aggregation, broken down by Order Status instead,
      to see how revenue and average value differ by outcome
   ------------------------------------------------------------ */

SELECT
    Order_Status,
    COUNT(*)            AS OrderCount,
    SUM(Total_Price)    AS TotalRevenue,
    AVG(Total_Price)    AS AvgOrderValue
FROM Orders
GROUP BY Order_Status
ORDER BY TotalRevenue DESC;


/* ============================================================
   Key Findings
   ------------------------------------------------------------
   - Chair generates the highest total revenue (£195,620) despite
     Printer having a slightly higher order count — Chairs carry
     a higher average order value.
   - 250 orders (~21% of all orders) were Cancelled, the single
     largest status category.
   - Cancelled orders have the highest average order value
     (£1,105.58) of any status, higher than successfully
     Delivered orders (£1,050.22) — suggesting higher-value
     transactions may be disproportionately lost to cancellation.
   - Cancelled + Returned orders combined make up ~41% of all
     orders (497 of 1200), representing a significant share of
     transactions that never resulted in a completed sale.
   ============================================================ */
