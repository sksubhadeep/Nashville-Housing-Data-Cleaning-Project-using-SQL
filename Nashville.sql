/*

Cleaning Data in SQL Queries

*/
select *
from NashvilleHousing

--Standardize Date Format

select SaleDate,CONVERT(Date,SaleDate)
from PortFolioProject.dbo.NashvilleHousing

ALTER TABLE NashvilleHousing
Add SaleDateConverted Date

Update NashvilleHousing
Set SaleDateConverted=Convert(Date,SaleDate)

--Populate Property Address Data

select *
from PortFolioProject.dbo.NashvilleHousing
where PropertyAddress is null

select a.ParcelID,a.PropertyAddress, b.ParcelID, b.PropertyAddress,isnull(a.PropertyAddress,b.PropertyAddress)
from PortFolioProject.dbo.NashvilleHousing a
join PortFolioProject.dbo.NashvilleHousing b
on a.ParcelID=b.ParcelID and a.[UniqueID ]<>b.[UniqueID ]
where a.PropertyAddress is null

update a
set PropertyAddress=isnull(a.PropertyAddress,b.PropertyAddress)
from PortFolioProject.dbo.NashvilleHousing a
join PortFolioProject.dbo.NashvilleHousing b
on a.ParcelID=b.ParcelID and a.[UniqueID ]<>b.[UniqueID ]
where a.PropertyAddress is null


--Breaking address into individual Columns i.e, Address,City,State

select LEFT(PropertyAddress,CHARINDEX(',',PropertyAddress)-1) as Address
,RIGHT(PropertyAddress,LEN(PropertyAddress)- CHARINDEX(',',PropertyAddress)-1) as City
,RIGHT(OwnerAddress,2) as State
from PortFolioProject.dbo.NashvilleHousing


ALTER TABLE NashvilleHousing
Add PropertySplitAddress Nvarchar(255)

Update NashvilleHousing
Set PropertySplitAddress=LEFT(PropertyAddress,CHARINDEX(',',PropertyAddress)-1)

ALTER TABLE NashvilleHousing
Add PropertySplitCity Nvarchar(255)

Update NashvilleHousing
Set PropertySplitCity=RIGHT(PropertyAddress,LEN(PropertyAddress)- CHARINDEX(',',PropertyAddress)-1)

ALTER TABLE NashvilleHousing
Add PropertySplitState Nvarchar(255)

Update NashvilleHousing
Set PropertySplitState=RIGHT(OwnerAddress,2)

select PropertySplitAddress,PropertySplitCity,PropertySplitState
from PortFolioProject.dbo.NashvilleHousing

--Another Way using PARSENAME

select PARSENAME(REPLACE(OwnerAddress,',','.'),3) as Address
,PARSENAME(REPLACE(OwnerAddress,',','.'),2) as City
,PARSENAME(REPLACE(OwnerAddress,',','.'),1) as State
from PortFolioProject.dbo.NashvilleHousing

ALTER TABLE NashvilleHousing
Add OwnerSplitAddress Nvarchar(255)

Update NashvilleHousing
Set OwnerSplitAddress=PARSENAME(REPLACE(OwnerAddress,',','.'),3)

ALTER TABLE NashvilleHousing
Add OwnerSplitCity Nvarchar(255)

Update NashvilleHousing
Set OwnerSplitCity=PARSENAME(REPLACE(OwnerAddress,',','.'),2)

ALTER TABLE NashvilleHousing
Add OwnerSplitState Nvarchar(255)

Update NashvilleHousing
Set OwnerSplitState=PARSENAME(REPLACE(OwnerAddress,',','.'),1)

select OwnerSplitAddress,OwnerSplitCity,OwnerSplitState
from PortFolioProject.dbo.NashvilleHousing

--Change Y and N to Yes and No in "SoldAsVacant" Field

select SoldAsVacant,
case
	when SoldAsVacant='Y' or SoldAsVacant='Yes' then 'Yes'
	else 'No'
end 
from PortFolioProject.dbo.NashvilleHousing

Update NashvilleHousing
Set SoldAsVacant=case
	when SoldAsVacant='Y' or SoldAsVacant='Yes' then 'Yes'
	else 'No'
end

select SoldAsVacant
from PortFolioProject.dbo.NashvilleHousing


--Remove Duplicates

WITH ROW_NUM_CTE as (
select *,ROW_NUMBER() OVER(PARTITION BY ParcelID,PropertyAddress,SalePrice,SaleDate,LegalReference ORDER BY UniqueID) row_num
from PortFolioProject.dbo.NashvilleHousing
)
select * from ROW_NUM_CTE
where row_num>1
order by PropertyAddress

--Delete unused columns


select *
from PortFolioProject.dbo.NashvilleHousing

ALTER TABLE PortFolioProject.dbo.NashvilleHousing
DROP COLUMN OwnerAddress,TaxDistrict,PropertyAddress

