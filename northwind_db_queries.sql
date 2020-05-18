-- 1. Retrieve all columns in the region table
	Select * from region;
    
-- 2. Select the FirstName and LastName columns from the Employees table.
	Select FirtName, LastName From employees;
    
-- 3. Select the FirstName and LastName columns from the Employees table.Sort by LastName.
	Select FirstName, LastName
    From employees
    Order By LastName;
    
-- 4. Create a report showing Northwind's orders sorted by Freight from most expensive tocheapest. Show OrderID, OrderDate, ShippedDate, CustomerID, and Freight.
	Select OrderID, OrderDate, ShippedDate, CustomerID, Freight
    From orders
    Order By Freight Desc;
    
-- 5. Create a report showing the title and the first and last name of all sales representatives.
     Select FirstName, LastName, Title
     From employees
     Where Title = "Sales Representative";
     
-- 6. Create a report showing the first and last names of all employees who have a regionspecified.
	 Select FirstName, LastName, Region
     From employees
     Where region Is Not Null;
     
-- 7. Create a report showing the first and last name of all employees whose last names startwith a letter in the last half of the alphabet.
--    Sort by LastName in descending order.
	 Select FirstName, LastName
     From employees
	 Where LastName RLike '^[M-Z]'
     Order By LastName;
     
-- 8. Create a report showing the title of courtesy and the first and last name of all employeeswhose title of courtesy begins with "M".
	  Select TitleOfCourtesy, FirstName, LastName
      From employees
      Where TitleOfCourtesy Like 'M%';
      
-- 9. Create a report showing the first and last name of all sales representatives who are from Seattle or Redmond.
	  Select FirstName, LastName, Title, City
      From employees
      Where Title = "Sales Representative"
		And City = "Seattle" Or City = "Redmond";
        
-- 10. Create a report that shows the company name, contact title, city and country of allcustomers in Mexico or in any city in Spain except Madrid.
	 Select CompanyName, ContactTitle, City, Country
     From customers
     Where Country = "Mexico"
		Or (Country = "Spain" And City != "Madrid");
        
-- 11. If the cost of freight is greater than or equal to $500.00, it will now be taxed by 10%.
-- Create a report that shows the order id, freight cost, freight cost with this tax for all orders of $500 or more.
     Select OrderID, Freight, (Freight + Freight * 0.2) as FreightWithTax
     From orders
     Where Freight >= 500;
     
-- 12. Find the Total Number of Units Ordered of Product ID 3
	 Select Count(orders.OrderID) as NoOfUnits
     From orders
     Inner Join order_details On orders.OrderID = order_details.OrderID
     Where order_details.ProductID = 3;
     
-- 13. Retrieve the number of employees in each city
	 Select City, Count(EmployeeID) as NoOfEmployee
     From employees
     Group By City
     Order By NoOfEmployee Desc,City;
     
-- 14. Find the number of sales representatives in each city 
	 Select City, Count(EmployeeID) as NoOfSalesRep
     From employees
     Where Title = "Sales Representative"
     Group by City
     Order By NoOfSalesRep Desc, City;
     
-- 15. Find the Companies (the CompanyName) that placed orders in 1997
	 Select Distinct customers.CompanyName
     From customers
     Inner Join orders On orders.CustomerID = customers.CustomerID
     Where Year(OrderDate) = 1997;
     
-- 16. Create a report showing employee orders.
	 Select
		Concat(employees.FirstName, " ", employees.LastName) as Employee,
		customers.CustomerID,
        customers.CompanyName,
        orders.OrderID,
        orders.OrderDate,
        products.ProductName,
        order_details.Quantity,
        order_details.UnitPrice,
        order_details.UnitPrice * order_details.Quantity * ( 1 - order_details.Discount) As ExtendedPrice
	From orders
    Inner Join order_details on orders.OrderID = order_details.OrderID
    Inner Join products On order_details.ProductID = products.ProductID
    Inner Join employees On orders.EmployeeID = employees.EmployeeID
    Inner Join customers On orders.CustomerID = customers.CustomerID
    Order By Employee;
    