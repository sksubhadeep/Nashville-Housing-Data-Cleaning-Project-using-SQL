The data cleaning process in SQL involves several steps to ensure the quality and consistency of the dataset. In the context provided, the following actions have been taken:

1. **Standardize Date Format in SaleDate Column:** The SaleDate column's date format has been standardized, likely to ensure uniformity and compatibility across the dataset. This could involve converting different date formats into a single consistent format, such as YYYY-MM-DD.

2. **Populate Property Address Data:** Rows with NULL values in the Property Address column have been updated or filled with relevant address information. This ensures that no essential data is missing in the dataset.

3. **Breaking Address into Individual Columns:** The address information has been split into separate columns, namely Address, City, and State. This step is taken to organize the address data and make it more accessible for analysis. Each component of the address is stored in its dedicated column, aiding in querying and reporting.

4. **Alternative Address Splitting using PARSENAME:** An alternative method, possibly utilizing the PARSENAME function, has been used to break down the address into individual components (Address, City, State). This function is often used to split delimited strings into parts based on a specified delimiter.

5. **Change Y and N to Yes and No:** In the "SoldAsVacant" field, values 'Y' and 'N' have been transformed into 'Yes' and 'No' respectively. This change is applied to enhance readability and consistency of the data.

6. **Remove Duplicates:** Duplicate rows have been removed from the Nashville dataset. Duplicate records can skew analysis and lead to inaccurate insights. Removing duplicates ensures that each observation is unique.

7. **Delete Unused Columns:** Unnecessary or redundant columns have been deleted from the Nashville dataset. This can help reduce the dataset's size, improve query performance, and focus analysis on relevant information.

Overall, these steps collectively represent a comprehensive data cleaning process in SQL, designed to enhance the dataset's quality, consistency, and usability for subsequent analysis and reporting. 
