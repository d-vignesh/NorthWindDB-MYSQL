-- creating the schema
	Drop Schema If Exists northwind;
    Create Schema If Not Exists northwind;
    show databases;
    
-- switch to northwind db
	Use northwind;	
    
-- Table creation
	-- 1. Employees
    Drop table If Exists employees;
	Create Table employees (
		EmployeeID      int(11)      Not Null Auto_Increment,
        LastName        Varchar(20)  Not Null,
        FirstName       Varchar(10)  Not Null,
        Title           Varchar(30)  Default Null,
        TitleOfCourtesy Varchar(25)  Default Null,
        BirthDate       Datetime     Default Null,
        HireDate        Datetime     Default Null,
        Address         Varchar(60)  Default Null,
        City            Varchar(15)  Default Null,
        Region          Varchar(15)  Default Null,
        PostalCode      Varchar(10)  Default Null,
        Country         Varchar(15)  Default Null,
        HomePhone       Varchar(24)  Default Null,
        Extension       Varchar(4)   Default Null,
        Photo           Longblob,
        Notes           Longtext,
        ReportsTo       int          Default Null,
        PhotoPath       Varchar(255) Default Null,
        Primary Key (EmployeeID),
        Key idx_fk_ReportsTo (ReportsTo),
        Key idx_LastName  (LastName),
        Key idx_PostalCode (PostalCode),
        Constraint fk_ReportsTo Foreign Key (ReportsTo) References employees (EmployeeID)
			On Delete Restrict On Update Cascade
        ) Engine=InnoDB Auto_Increment=10 Default Charset=utf8;
        
	-- 2. categories
    Drop table If exists categories;
    Create Table categories (
		CategoryID    int(11)     Not Null   Auto_Increment,
        CategoryName  Varchar(15) Not Null,
        Description   Mediumtext,
        Picture       Longblob,
        Primary Key (CategoryID),
        Key idx_CategoryName (CategoryName)
    ) Engine=InnoDB Auto_Increment=9 Default Charset=utf8;
    
    -- 3. customers
    Drop Table If exists customers;
    Create Table customers (
		CustomerID   Varchar(5)   Not Null,
        CompanyName  Varchar(40)  Not Null,
        ContactName  Varchar(30)  Default Null,
        ContactTitle Varchar(30)  Default Null,
        Address      Varchar(60)  Default Null,
        City         Varchar(15)  Default Null,
        Region       Varchar(15)  Default Null,
        PostalCode   Varchar(10)  Default Null,
        Country      Varchar(15)  Default Null,
        Phone        Varchar(24)  Default Null,
        Fax          Varchar(24)  Default Null,
        Primary Key (CustomerID),
        Key idx_City (City),
        Key idx_CompanyName (CompanyName),
        Key idx_PostalCode  (PostalCode),
        Key idx_Region      (Region)
    ) Engine=InnoDB Default Charset=utf8;
    
    -- 4. Shippers
    Drop Table If Exists shippers;
	Create Table shippers (
		ShipperID   int(11)     Not Null    Auto_Increment,
        CompanyName Varchar(40) Not Null,
        Phone       Varchar(24) Default Null,
        Primary Key (ShipperID)
    ) Engine=InnoDB Auto_Increment=4 Default Charset=utf8;
    
    -- 5. Suppliers
    Drop Table If Exists suppliers;
    Create Table suppliers (
		SupplierID   int(11)      Not Null   Auto_Increment,
        CompanyName  Varchar(40)  Not Null,
        ContactName  Varchar(30)  Default Null,
        ContactTitle Varchar(30)  Default Null,
        Address      Varchar(60)  Default Null,
        City         Varchar(15)  Default Null,
        Region       Varchar(15)  Default Null,
        PostalCode   Varchar(10)  Default Null,
        Country      Varchar(15)  Default Null,
        Phone        Varchar(24)  Default Null,
        Fax          Varchar(24)  Default Null,
        HomePage     Mediumtext,
        Primary Key (SupplierID),
        Key idx_CompanyName (CompanyName),
        Key idx_PostalCode  (PostalCode)
    ) Engine=InnoDB Auto_Increment=30 Default Charset=utf8;
    
    -- 6. orders
    Drop Table If Exists orders;
    Create Table orders (
		OrderID      int(11)       Not Null    Auto_Increment,
        CustomerID   Varchar(5)    Default Null,
        EmployeeID   int(11)       Default Null,
        OrderDate    Datetime      Default Null,
        RequiredDate Datetime      Default Null,
        ShippedDate  Datetime      Default Null,
        ShipVia      int(11)       Default Null,
        Freight      Decimal(10, 4) Default '0.0000',
        ShipName     Varchar(40)   Default Null,
		ShipAddress  Varchar(60)   Default Null,
        ShipCity     Varchar(15)   Default Null,
        ShipRegion   Varchar(15)   Default Null,
        ShipPostalCode Varchar(10) Default Null,
        ShipCountry  Varchar(15)   Default Null,
        Primary Key ( OrderID),
        Key idx_fk_CustomerID (CustomerID),
        Key idx_fk_EmployeeID (EmployeeID),
        Key idx_fk_ShipVia (ShipVia),
        Key idx_OrderDate (OrderDate),
        Key idx_ShippedDate (ShippedDate),
        Key idx_ShipPostalCode (ShipPostalCode),
        Constraint fk_orders_customer Foreign Key (CustomerID) References customers(CustomerID)
			On Delete Restrict On Update Cascade,
		Constraint fk_orders_employees Foreign Key (EmployeeID) References employees(EmployeeID)
			On Delete Restrict On Update Cascade,
		Constraint fk_orders_shippers Foreign Key (ShipVia) References shippers(ShipperID)
			On Delete Restrict On Update Cascade
    ) Engine=InnoDB Auto_Increment=11078 Default Charset=utf8;
    
    -- 7. products
    Drop Table If Exists products;
    Create Table products (
		ProductID     int(11)    Not Null  Auto_Increment,
        ProductName   Varchar(40) Not Null,
        SupplierID    int(11)  Default Null,
        CategoryID    int(11)  Default Null,
        QuantityPerUnit  Varchar(20)  Default Null,
        UnitPrice   Decimal(10, 4)  Default '0.0000',
        UnitsInStock Smallint Default 0,
        UnitsOnOrder Smallint Default 0,
        ReorderLevel Smallint Default 0,
        Discontinued  tinyint(1)  Default 0,
        Primary Key (ProductID),
        Key idx_fk_CategoryID (CategoryID),
        Key idx_fk_SupplierID (SupplierID),
        Key idx_ProductName  (ProductName),
        Constraint fk_products_categories Foreign Key (CategoryID) References categories(CategoryID)
			On Delete Restrict On Update Cascade,
		Constraint fk_products_suppliers Foreign Key (SupplierID) References suppliers(SupplierID)
			On Delete Restrict On Update Cascade
    ) Engine=InnoDB Auto_Increment=78 Default Charset=utf8;
    
    -- 8. order_details
    Drop Table If Exists order_details;
    Create Table order_details (
		OrderID   int(11)  Not Null  Auto_Increment,
        ProductID int(11)  Not Null,
        UnitPrice Decimal(10, 4) Not Null Default 0.0000,
        Quantity  Smallint  Not Null Default 1,
        Discount  float Not Null Default 0,
        Primary Key (OrderID, ProductID),
        Key fk_idx_OrderID (OrderID),
        Key fk_idx_ProductID (ProductID),
        Constraint fk_order_details_orders Foreign Key (OrderID) References orders(OrderID)
			On Delete Restrict On Update Cascade,
		Constraint fk_order_details_products Foreign Key (ProductID) References products(ProductID)
			On Delete Restrict On Update Cascade
    ) Engine=InnoDB Default Charset=utf8;
    
    -- 9. customer_demographics
    Drop Table If Exists customer_demographics;
    Create Table customer_demographics(
		CustomerTypeID     Varchar(10)   Not Null,
        CustomerDesc       Text,
        Primary Key (CustomerTypeID)
    ) Engine=InnoDB Default Charset=utf8;
    
    -- 10. customer_customer_demo
    Drop Table If Exists customer_customer_demo;
    Create Table customer_customer_demo (
		CustomerID   Varchar(5)   Not Null,
        CustomerTypeID Varchar(10)  Not Null,
        Primary Key (CustomerID, CustomerTypeID),
        Constraint fk_CustomerTypeID Foreign Key (CustomerTypeID) References customer_demographics(CustomerTypeID)
			On Delete Restrict On Update Cascade
    ) Engine=InnoDB Default Charset=utf8;
    
    -- 11. region
	Drop Table If Exists region;
    Create Table region (
		RegionID     TinyInt Unsigned Not Null Auto_Increment,
        RegionDescription  Varchar(50)   Not Null,
        Primary Key (RegionID)
    ) Engine=InnoDB Auto_Increment=5 Default Charset=utf8;
    
    -- 12. territories
    Drop Table If Exists territories;
    Create Table territories (
		TerritoryID    Varchar(20)   Not Null,
        TerritoryDescription Varchar(50) Not Null,
        RegionID  TinyInt Unsigned Not Null,
        Primary Key (TerritoryID),
        Constraint fk_territories_region Foreign Key (RegionID) References region(RegionID)
			On Delete Restrict On Update Cascade
    ) Engine=InnoDB Default Charset=utf8;
    
    -- 13. employee_territories
    Drop Table If Exists employee_territories;
    Create Table employee_territories (
		EmployeeID  int(11)  Not Null,
        TerritoryID Varchar(20)  Not Null,
        Primary Key (EmployeeID, TerritoryID),
		Constraint fk_employee_territories_employees Foreign Key (EmployeeID) References employees(EmployeeID)
			On Delete Restrict On Update Cascade,
		Constraint fk_employee_territories_territories Foreign Key (TerritoryID) References territories(TerritoryID)
			On Delete Restrict On Update Cascade
	) Engine=InnoDB Default Charset=utf8;
    
    
-- Views
	-- 1. current_product_list
	Create View current_product_list
    As
    Select
		ProductID,
        ProductName,
        UnitsInStock
	From products
    Where Discontinued = 0;
    
    select * from current_product_list limit 5;
    
    -- 2. alphabetical_list_of_products
    Create View alphabetical_list_of_products
    As
    Select
		products.*, categories.CategoryName
	From products
    Inner Join categories On products.CategoryID = categories.CategoryID
	Order by products.ProductName;
    
    select * from alphabetical_list_of_products limit 5;
    
    -- 3. customers_and_suppliers_by_city
    Create View customers_and_suppliers_by_city
    As
    Select City, CompanyName, ContactName, "customers" As Relationship
    From customers
    Union
    Select City, CompanyName, ContactName, "suppliers"
    From suppliers
    Order By City, CompanyName;
    
    Select * from customers_and_suppliers_by_city limit 10;
    
    -- 4. Orders Qry
    Create View orders_qry
    As
    Select 
		orders.*, 
        customers.CompanyName,
        customers.Address,
        customers.City,
        customers.PostalCode,
        customers.Country,
        customers.Phone,
        customers.Fax
	From orders
    Left Join customers On orders.CustomerID = customers.CustomerID;
    
    Select * from orders_qry limit 5;
    
    -- 5. products_above_average_price
    Create View products_above_average_price
    As
    Select ProductName, UnitPrice
    From products
    Where UnitPrice > ( Select avg(UnitPrice) From products) ;
    
    -- altering the above view to add order by clause
    Alter View products_above_average_price
    As
    Select ProductName, UnitPrice
    From products
    Where UnitPrice > ( Select avg(UnitPrice) From products)
    Order By UnitPrice Desc;
    
    Select * from products_above_average_price limit 5;
    
    -- 6. products_by_category
    Create View products_by_category
    As
    Select 
		categories.CategoryName,
        products.ProductID,
		products.ProductName,
        products.QuantityPerUnit,
        products.UnitPrice,
        products.UnitsInStock,
        products.UnitsOnOrder
	From products
    Inner Join categories On products.CategoryID = categories.CategoryID
    Order By categories.CategoryName, products.ProductName;

    Select * from products_by_category limit 5;
    
    -- 7. quarterly_orders
    Create View quarterly_orders
    As
    Select Distinct
		customers.CustomerID,
        customers.CompanyName,
        customers.City,
        customers.Country
	From customers
    Inner Join orders On customers.CustomerID = orders.CustomerID
    Where orders.OrderDate Between '1997-01-01' And '1997-12-31';
    
    Select * from quarterly_orders limit 5;
    
    -- 8. invoices
    Create View invoices
    As
	Select
		orders.ShipName,
        orders.ShipAddress,
        orders.ShipCity,
        orders.ShipRegion,
        orders.ShipPostalCode,
        orders.ShipCountry,
        orders.CustomerID,
        customers.CompanyName As CustomerName,
        customers.Address,
        customers.City,
        customers.Region,
        customers.PostalCode,
        customers.Country,
        Concat(employees.FirstName, " ", employees.LastName) As SalesPerson,
        orders.OrderID,
        orders.OrderDate,
        orders.RequiredDate,
        orders.ShippedDate,
        shippers.CompanyName as ShipperName,
        order_details.ProductID,
        products.ProductName,
        order_details.UnitPrice,
        order_details.Quantity,
        order_details.Discount,
        Floor(order_details.UnitPrice * Quantity * (1 - Discount)) As ExtendedPrice,
        orders.Freight
	From customers
    Inner Join orders On customers.CustomerID = orders.CustomerID
    Inner Join employees On employees.EmployeeID = orders.EmployeeID
    Inner Join order_details On orders.OrderID = order_details.OrderID
    Inner Join products On products.ProductID = order_details.ProductID
    Inner Join shippers On shippers.ShipperID = orders.ShipVia;
    
    Select * from invoices limit 5;
    
    -- 9. order_details_extended
    Create View order_details_extended
    As
    Select 
		od.OrderID,
        od.ProductID,
        products.ProductName,
        od.UnitPrice,
        od.Quantity,
        od.Discount,
        Round(od.UnitPrice * Quantity * ( 1 - Discount)) As ExtendedPrice
	From products
    Inner Join order_details od On od.ProductID = products.ProductID; 
    
    Select * from order_details_extended limit 5;
    
    -- 10. order_subtotal
    Create View order_subtotal
    As
    Select 
		OrderID,
        Sum(Round(UnitPrice * Quantity * (1 - Discount))) As SubTotal
	from order_details
    Group By OrderID
    Order By SubTotal Desc;
    
    Select * from order_subtotal limit 5;
    
    -- 11. product_sales_for_1997
    Create View product_sales_for_1997
    As
    Select 
		categories.CategoryName, 
        products.ProductName,
        Sum(Round(order_details.UnitPrice * Quantity * (1 - Discount))) As ProductSales
	From categories
    Inner Join products On categories.CategoryID = products.CategoryID
    Inner Join order_details On order_details.ProductID = products.ProductID
    Inner Join orders On order_details.OrderID = orders.OrderID
    Where orders.ShippedDate Between "1997-01-01" And "1997-12-31"
    Group By categories.CategoryName, products.ProductName;
    
    Select * from product_sales_for_1997 limit 5;
    
    -- 12. category_sales_for_1997
    Create View category_sales_for_1997
    As
    Select
		order_subtotals.SubTotal As SalesAmount,
		ps.CategoryName,
        Sum(ps.ProductSales) As CategorySales
	From product_sales_for_1997 ps
    Group By ps.CategoryName;
    
    Select * from category_sales_for_1997;
    
    -- 13. sales_by_category
    Create View sales_by_category
    As
    Select
		categories.CategoryID,
        categories.CategoryName,
        products.ProductName,
        Sum(order_details_extended.ExtendedPrice) As ProductSale
	From categories
    Inner Join products On categories.CategoryID = products.CategoryID
    Inner Join order_details_extended On products.ProductID = order_details_extended.ProductID
    Group By categories.CategoryID, categories.CategoryName, products.ProductName;
    
    Select * from sales_by_category limit 5;
    
    -- 14. sales_total_by_amount
    Create View sales_total_by_amount
    As
    Select
		order_subtotal.SubTotal As SaleAmount,
        orders.OrderID,
        customers.CompanyName,
        orders.ShippedDate
	From customers
    Inner Join orders On customers.CustomerID = orders.CustomerID
    Inner Join order_subtotal On orders.OrderID = order_subtotal.OrderID
    Where order_subtotal.SubTotal > 2500
     And orders.ShippedDate Between '1997-01-01' And '1997-12-31';
	 
     Select * from sales_total_by_amount limit 5;
     
     -- 15. summary_of_sales_by_quarter
     Create View summary_of_sales_by_quater
     As
     Select 
		orders.ShippedDate,
        orders.OrderID,
        order_subtotal.SubTotal 
	From orders
    Inner Join order_subtotal On orders.OrderID = order_subtotal.OrderID
    Where orders.ShippedDate is Not Null;
    
    Select * from summary_of_sales_by_quater limit 5;
    
    -- 16. summary_of_sales_by_year
    Create View summary_of_sales_by_year
    As
    Select 
		orders.ShippedDate,
        orders.OrderID,
        order_subtotal.SubTotal
	From orders
    Inner Join order_subtotal On orders.OrderID = order_subtotal.OrderID
    Where orders.ShippedDate is Not Null;
    
    Select * from summary_of_sales_by_year limit 5;
    
-- procedures:
	-- 1. CustOrdersDetail
    Delimiter $$
    Create Procedure CustOrdersDetail(In AtOrderID Int)
    Reads SQL Data
    Begin
		Select 
			ProductName,
            order_details.UnitPrice,
            Quantity,
            Discount * 100 As Discount,
            Round(order_details.UnitPrice * Quantity * ( 1 - Discount)) As ExtendedPrice
		From products
        Inner Join order_details On products.ProductID = order_details.ProductID
        Where order_details.OrderID = AtOrderID;
	End $$
    Delimiter ;
    
    Call CustOrdersDetail(10250);
    
    -- 2. CustOrdersOrders
    Delimiter $$
    Create Procedure CustOrdersOrders(In AtCustomerID Varchar(5))
    Begin
		Select
			OrderID,
            OrderDate,
            RequiredDate,
            ShippedDate
		From orders
        Where CustomerID = AtCustomerID
        Order By OrderID;
	End$$
    Delimiter ;
    
    Call CustOrdersOrders("ANTON");
    
    -- 3. CustOrderHist
    Delimiter $$
    Create Procedure CustOrderHist(In AtCustomerID Varchar(5))
    Begin
		Select
			products.ProductName,
            Sum(order_details.Quantity) as Total
		From products
        Inner Join order_details On products.ProductID = order_details.ProductID
        Inner Join orders On order_details.OrderID = orders.OrderID
        Inner Join customers On orders.CustomerID = customers.CustomerID
        Group By products.ProductName;
	End$$
    Delimiter ;
    
    Call CustOrderHist("ANTON");
    
    -- 4. TenMostExpensiveProducts
    Delimiter $$
    Create Procedure TenMostExpensiveProducts()
    Begin
		Select
			ProductName,
            UnitPrice
		From products
        Order By UnitPrice Desc
        Limit 10;
	End$$
    Delimiter ;

	Call TenMostExpensiveProducts();
    
    -- 5. EmployeeSaleByCountry
    Drop Procedure If Exists EmployeeSaleByCountry;
    Delimiter $$
    Create Procedure EmployeeSaleByCountry(In BeginDate Date, In EndDate Date)
    Begin
		Select
			employees.Country,
            employees.FirstName,
            employees.LastName,
            orders.ShippedDate,
            orders.OrderID,
            order_subtotal.SubTotal As SaleAmount
		From employees
        Inner Join orders On employees.EmployeeID = orders.EmployeeID
        Inner Join order_subtotal On orders.OrderID = order_subtotal.OrderID
        Where orders.ShippedDate Between BeginDate And EndDate;
	End $$
    Delimiter ;
    
    Call EmployeeSaleByCountry('1996-01-01', '1996-01-31');
    
    -- 6. SalesByYear
    Drop Procedure If Exists SalesByYear;
    Delimiter $$
    Create Procedure SalesByYear(In BeginDate Date, In EndDate Date)
    Begin
		Select
			orders.ShippedDate,
            orders.OrderID,
            order_subtotal.Subtotal,
            Year(orders.ShippedDate) As year
		From orders
        Inner Join order_subtotal On orders.OrderID = order_subtotal.OrderID
        Where orders.ShippedDate Between BeginDate And EndDate;
	End $$
    Delimiter ;
    
    Call SalesByYear('1996-01-01', '1996-12-31');
    
    -- 7. SalesByCategory
    Drop Procedure If Exists SalesByCategory;
    Delimiter $$
    Create Procedure SalesByCategory(In AtCategoryName Varchar(15), In orderYear Varchar(4))
    Begin
		Select
			products.ProductName,
            Round(Sum(od.UnitPrice * od.Quantity * ( 1 - od.Discount )) ) As TotalPurchase
		From order_details od
        Inner Join orders On od.OrderID = orders.OrderID
        Inner Join products On od.ProductID = products.ProductID
        Inner Join categories On products.CategoryID = categories.CategoryID
        Where categories.CategoryName = AtCategoryName
			And Year(orders.OrderDate) = orderYear
		Group By products.ProductName
        Order By TotalPurchase Desc, products.ProductName;
	End $$
    Delimiter ;
    
    Call SalesByCategory("Beverages", 1996);
        
    
        