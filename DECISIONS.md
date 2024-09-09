## Project Overview
This project aims to analyze sales data by ingesting CSV files into a Snowflake database, transforming the data into a structured format using dbt, and answering key business questions. The steps involved include:

- Data Ingestion: Loading raw sales and customer data into Snowflake using dbt's seed functionality.
- Data Transformation: Extracting relevant date components from the sales data and calculating the total sales amount per order.
- Querying the Data: Creating SQL queries to address specific business questions related to sales performance.

---

### 1. Setup

**Step 1: Cloning the Repository** 

To begin, I cloned the repository containing the dbt project and the sample dataset files.

**Step 2: Creating a Snowflake Database**

I logged into my Snowflake account and created a new database named home_assignment.

**Step 3: Configuring the `profiles.yml` File**

Next, I created the `profiles.yml` file in the _~/.dbt/_ directory to set up the connection between dbt and Snowflake. The configuration included details such as the Snowflake account, user credentials, database, schema, and warehouse.

**Step 4: Verifying the Connection**

After setting up the `profiles.yml`, I ran the `dbt debug` command to verify that dbt was able to successfully connect to my Snowflake database:

```bash
dbt debug
```

Once the connection was successfully established, I proceeded to data ingestion.

<br />

### 2. Data Ingestion

**Step 1: Moving CSV Files to the Seeds Folder**

The repository contained two CSV files — `sales.csv` and `customers.csv`. I moved these files into the _seeds/_ folder within the _dbt_banxware_assignment_ project directory to prepare them for loading into Snowflake.

**Step 2: Updating `dbt_project.yml`**

To ensure that the loaded tables followed the required naming conventions, I updated the `dbt_project.yml` file. This configuration allowed the tables to be renamed as `raw_sales_data` and `raw_customer_data` when loaded into Snowflake.

``` yaml
seeds: banxware_assignment:
  sales:
    +alias: raw_sales_data # Rename 'sales.csv' table to 'raw_sales_data'
  customers:
    +alias: raw_customer_data # Rename 'customers.csv' table to 'raw_customer_data'
```

**Step 3: Loading Data with `dbt seed`**

I used the `dbt seed` command to load the CSV files into Snowflake. This command automatically created the tables and inserted the data into them.

```bash
dbt seed
```

This resulted in two tables being created: `raw_sales_data` and `raw_customer_data`.

<br />

### 3. Data Transformation

**Step 1: Creating the transformed_sales_data Model**

I created a new file named `transformed_sales_data.sql` in the _models/example/_ directory to perform the required data transformations.

**Step 2: Updating `schema.yml`**

To document the transformed_sales_data model, I added relevant descriptions in the `schema.yml` file stored in the _models/example/_ directory. This includes details on the columns, their purpose, and the transformations performed, ensuring that the model is well-documented for future reference.

**Step 3: Extracting Year, Month, and Day from `order_date`**

The `order_date` in the raw sales data was in string format. To allow for time-based analysis, I extracted the year, month, and day components using SQL's `EXTRACT` and `TO_DATE` functions.

**Step 4: Calculating Total Sales Amount**

To calculate the total sales per order, I multiplied the quantity by the price for each product.

```sql
SUM(quantity * price) AS total_sales_amount
```

**Step 5: Final Transformation Query**

Combining these elements, I created a final SQL query that outputs a table called `transformed_sales_data`, which includes the following columns:

- order_id
- customer_id
- order_year
- order_month
- order_day
- total_sales_amount

**Step 6: Running the Transformation**

To generate the transformed table in Snowflake, I ran the following command:

```bash
dbt run --models transformed_sales_data
```

This successfully created the transformed_sales_data table in Snowflake.

<br />

### 4. Querying the Data

**Step 1: Writing SQL Queries**

I created a _queries/_ folder inside the _models/_ directory and wrote four separate .sql files to answer the provided business questions.

**Step 2: Running the Queries**

To execute the queries and generate the required results, I ran the following dbt command:

```bash
dbt run --models queries
```

This successfully executed all the SQL files, and the views were created accordingly in Snowflake, allowing me to analyze the data based on the given questions.

<br />

This concludes the steps I followed in the data pipeline from ingestion to transformation and querying, along with documentation of the setup and decisions made throughout the assignment.
