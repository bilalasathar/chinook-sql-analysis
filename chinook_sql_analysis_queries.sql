-- 1. Top 10 Customers by Revenue
SELECT 
  c.FirstName || ' ' || c.LastName AS CustomerName,
  ROUND(SUM(il.UnitPrice * il.Quantity), 2) AS TotalSpent
FROM Customer c
JOIN Invoice i ON c.CustomerId = i.CustomerId
JOIN InvoiceLine il ON i.InvoiceId = il.InvoiceId
GROUP BY c.CustomerId
ORDER BY TotalSpent DESC
LIMIT 10;


-- 2. Top 5 Genres by Revenue
SELECT 
  g.Name AS Genre,
  ROUND(SUM(il.UnitPrice * il.Quantity), 2) AS GenreRevenue
FROM Genre g
JOIN Track t ON g.GenreId = t.GenreId
JOIN InvoiceLine il ON t.TrackId = il.TrackId
GROUP BY g.GenreId
ORDER BY GenreRevenue DESC
LIMIT 5;


-- 3. Monthly Revenue Trend
SELECT 
  strftime('%Y-%m', i.InvoiceDate) AS Month,
  ROUND(SUM(il.UnitPrice * il.Quantity), 2) AS MonthlyRevenue
FROM Invoice i
JOIN InvoiceLine il ON i.InvoiceId = il.InvoiceId
GROUP BY Month
ORDER BY Month;


-- 4. Most Popular Artists by Track Purchases
SELECT 
  ar.Name AS Artist,
  COUNT(il.InvoiceLineId) AS TotalPurchases
FROM Artist ar
JOIN Album al ON ar.ArtistId = al.ArtistId
JOIN Track t ON al.AlbumId = t.AlbumId
JOIN InvoiceLine il ON t.TrackId = il.TrackId
GROUP BY ar.ArtistId
ORDER BY TotalPurchases DESC
LIMIT 10;


-- 5. Top Countries by Revenue
SELECT 
  c.Country,
  ROUND(SUM(il.UnitPrice * il.Quantity), 2) AS Revenue
FROM Customer c
JOIN Invoice i ON c.CustomerId = i.CustomerId
JOIN InvoiceLine il ON i.InvoiceId = il.InvoiceId
GROUP BY c.Country
ORDER BY Revenue DESC;


-- 6. Most Purchased Tracks
SELECT 
  t.Name AS TrackName,
  COUNT(il.InvoiceLineId) AS TimesPurchased
FROM Track t
JOIN InvoiceLine il ON t.TrackId = il.TrackId
GROUP BY t.TrackId
ORDER BY TimesPurchased DESC
LIMIT 10;


-- 7. Rank Customers by Total Spend
SELECT 
  c.FirstName || ' ' || c.LastName AS CustomerName,
  ROUND(SUM(il.UnitPrice * il.Quantity), 2) AS TotalSpent,
  RANK() OVER (ORDER BY SUM(il.UnitPrice * il.Quantity) DESC) AS SpendingRank
FROM Customer c
JOIN Invoice i ON c.CustomerId = i.CustomerId
JOIN InvoiceLine il ON i.InvoiceId = il.InvoiceId
GROUP BY c.CustomerId
LIMIT 15;
