use NORTHWND

--1. Çalýþanlarýmýz kaç farklý þehirde çalýþýyorlar
select count(City)
from Employees

--2. Adresleri içinde 'House' kelimesi geçen çalýþanlar
select FirstName+' '+LastName,Address
from Employees
where Address like '%house%'

--3. Herhangi bir bölge (Region) verisi olmayan çalýþanlar
select FirstName+' '+LastName
from Employees
where Region is null

--4. Çalýþanlarý adlarýný A-Z soyadlarýný Z-A olaracak þekilde tek sorguda listeleyelim
select FirstName,LastName
from Employees
order by FirstName asc,LastName desc

--5. Ürünleri; ürün adý, Fiyatý, KDV tutarý, KDV Dahil fiyatý þeklinde listeleyelim (KDV %18 olacak) 
select ProductName as 'Ürün adi',UnitPrice as 'Birim Fiyati',(UnitPrice*0.18) as 'KDV',(UnitPrice*1.18) as 'Toplam Fiyat'
from Products

--6. En pahalý 5 ürünü listeyelim
select top 5 ProductName as 'Ürün Adi',UnitPrice as 'Birim Fiyati'
from Products
order by UnitPrice desc

--7. Stok adedi 20-50 arasýndaki ürünlerin listesi
select *
from Products
where UnitsInStock between 20 and 50

--8. Hangi ülkede kaç müþterimiz var
select Country,count(CustomerID)
from Customers
group by Country

--9. Her kategoride kaç kalem ürün var (kategori adý, o kategorideki toplam ürün kalemi sayýsý)
select CategoryName as 'Kategori Adi',COUNT(Products.ProductID) as 'Kalem Sayisi'
from Categories left join Products on Categories.CategoryID=Products.CategoryID
group by CategoryName

--10. Her kategoride kaç adet ürün var (kategori adý, o kategorideki toplam ürün adedi (stock) sayýsý)
select CategoryName as 'Kategori Adi',sum(Products.UnitsInStock) as 'Ürün Adedi'
from Categories left join Products on Categories.CategoryID=Products.CategoryID
group by CategoryName

--11. 50 den fazla sipariþ alan personellerin ad, soyad, sipariþ adedi þeklinde listeleyelim
select Employees.EmployeeID,FirstName+' '+LastName as 'Personel',(COUNT(Orders.OrderID)) as 'Siparis Adedi'
from Employees left join Orders on Employees.EmployeeID=Orders.EmployeeID
group by Employees.EmployeeID,FirstName,LastName
having (COUNT(Orders.OrderID))>50
order by 'Siparis Adedi' desc

--12. Satýþ yapýlmayan ürün adlarýnýn listesi
select ProductName,(count(OD.OrderID)) as 'Siparis Adedi'
from Products P left join [Order Details] OD on OD.ProductID=P.ProductID
--where OD.OrderID=null
group by ProductName
having (count(OD.OrderID))=0
order by 'Siparis Adedi' desc

--13. Ortalamanýn altýnda bir fiyata sahip olan ürünlerin adý ve fiyatý
select P.ProductName as 'Ürün Adi',P.UnitPrice as 'Ürün Fiyati'
from Products P
where (P.UnitPrice < (select AVG(UnitPrice)
		from Products))
order by 'Ürün Fiyati' desc

--14. Hiç sipariþ vermeyen müþteriler
select C.CompanyName as 'Müsteri', COUNT(O.CustomerID) as 'Siparis Adedi'
from Customers C left join Orders O on C.CustomerID=O.CustomerID
group by C.CompanyName
having (COUNT(O.CustomerID))=0

--15. Hangi tedarikçi hangi ürünü saðlýyor
select S.CompanyName as 'Tedarikci',P.ProductName as 'Ürün Adi'
from Suppliers S left join Products P on P.SupplierID=S.SupplierID
group by S.CompanyName,P.ProductName

