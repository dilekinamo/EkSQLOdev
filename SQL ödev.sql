use NORTHWND

--1. �al��anlar�m�z ka� farkl� �ehirde �al���yorlar
select count(City)
from Employees

--2. Adresleri i�inde 'House' kelimesi ge�en �al��anlar
select FirstName+' '+LastName,Address
from Employees
where Address like '%house%'

--3. Herhangi bir b�lge (Region) verisi olmayan �al��anlar
select FirstName+' '+LastName
from Employees
where Region is null

--4. �al��anlar� adlar�n� A-Z soyadlar�n� Z-A olaracak �ekilde tek sorguda listeleyelim
select FirstName,LastName
from Employees
order by FirstName asc,LastName desc

--5. �r�nleri; �r�n ad�, Fiyat�, KDV tutar�, KDV Dahil fiyat� �eklinde listeleyelim (KDV %18 olacak) 
select ProductName as '�r�n adi',UnitPrice as 'Birim Fiyati',(UnitPrice*0.18) as 'KDV',(UnitPrice*1.18) as 'Toplam Fiyat'
from Products

--6. En pahal� 5 �r�n� listeyelim
select top 5 ProductName as '�r�n Adi',UnitPrice as 'Birim Fiyati'
from Products
order by UnitPrice desc

--7. Stok adedi 20-50 aras�ndaki �r�nlerin listesi
select *
from Products
where UnitsInStock between 20 and 50

--8. Hangi �lkede ka� m��terimiz var
select Country,count(CustomerID)
from Customers
group by Country

--9. Her kategoride ka� kalem �r�n var (kategori ad�, o kategorideki toplam �r�n kalemi say�s�)
select CategoryName as 'Kategori Adi',COUNT(Products.ProductID) as 'Kalem Sayisi'
from Categories left join Products on Categories.CategoryID=Products.CategoryID
group by CategoryName

--10. Her kategoride ka� adet �r�n var (kategori ad�, o kategorideki toplam �r�n adedi (stock) say�s�)
select CategoryName as 'Kategori Adi',sum(Products.UnitsInStock) as '�r�n Adedi'
from Categories left join Products on Categories.CategoryID=Products.CategoryID
group by CategoryName

--11. 50 den fazla sipari� alan personellerin ad, soyad, sipari� adedi �eklinde listeleyelim
select Employees.EmployeeID,FirstName+' '+LastName as 'Personel',(COUNT(Orders.OrderID)) as 'Siparis Adedi'
from Employees left join Orders on Employees.EmployeeID=Orders.EmployeeID
group by Employees.EmployeeID,FirstName,LastName
having (COUNT(Orders.OrderID))>50
order by 'Siparis Adedi' desc

--12. Sat�� yap�lmayan �r�n adlar�n�n listesi
select ProductName,(count(OD.OrderID)) as 'Siparis Adedi'
from Products P left join [Order Details] OD on OD.ProductID=P.ProductID
--where OD.OrderID=null
group by ProductName
having (count(OD.OrderID))=0
order by 'Siparis Adedi' desc

--13. Ortalaman�n alt�nda bir fiyata sahip olan �r�nlerin ad� ve fiyat�
select P.ProductName as '�r�n Adi',P.UnitPrice as '�r�n Fiyati'
from Products P
where (P.UnitPrice < (select AVG(UnitPrice)
		from Products))
order by '�r�n Fiyati' desc

--14. Hi� sipari� vermeyen m��teriler
select C.CompanyName as 'M�steri', COUNT(O.CustomerID) as 'Siparis Adedi'
from Customers C left join Orders O on C.CustomerID=O.CustomerID
group by C.CompanyName
having (COUNT(O.CustomerID))=0

--15. Hangi tedarik�i hangi �r�n� sa�l�yor
select S.CompanyName as 'Tedarikci',P.ProductName as '�r�n Adi'
from Suppliers S left join Products P on P.SupplierID=S.SupplierID
group by S.CompanyName,P.ProductName

