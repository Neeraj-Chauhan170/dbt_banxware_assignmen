# Project Overview

This project aims to analyze sales data by ingesting CSV files into a Snowflake database, transforming the data into a structured format using dbt, and answering key business questions. The steps involved include:

- **Data Ingestion**: Loading raw sales and customer data into Snowflake using dbt's seed functionality.
- **Data Transformation**: Extracting relevant date components from the sales data and calculating the total sales amount per order.
- **Querying the Data**: Creating SQL queries to address specific business questions related to sales performance.

## 1. Setup

### Step 1: Cloning the Repository

To begin, clone the repository containing the dbt project and the sample dataset files:

git clone <https://github.com/Neeraj-Chauhan170/dbt_banxware_assignmen.git> 
cd <repository_directory>


### Step 2: Creating a Snowflake Database

Log in to your Snowflake account and create a new database named `home_assignment`.

### Step 3: Configuring the profiles.yml File

Create the `profiles.yml` file in the `~/.dbt/` directory with the following content. Replace the placeholders with your Snowflake account details:

dbt_banxware_assignment: outputs: dev: type: SNOWFLAKE threads: 4 account: <your_snowflake_account_details> database: home_assignment user: <login-name> password: <yourpassword> schema: <your_snowflake_schema_name> warehouse: <compute_wh> role: <snowflake_role> target: dev


### Step 4: Verifying the Connection

Run the following command to ensure dbt can connect to your Snowflake database:

dbt debug


Once the connection is successfully established, proceed to data ingestion.

## 2. Data Ingestion

### Step 1: Moving CSV Files to the Seeds Folder

Move the CSV files (`sales.csv` and `customers.csv`) into the `seeds/` folder within the `dbt_banxware_assignment` project directory.

### Step 2: Updating dbt_project.yml

Update the `dbt_project.yml` file to ensure that the loaded tables follow the required naming conventions. Add the following configuration:

seeds: banxware_assignment: sales: +alias: raw_sales_data # Rename 'sales.csv' table to 'raw_sales_data' customers: +alias: raw_customer_data # Rename 'customers.csv' table to 'raw_customer_data'

### Step 3: Loading Data with dbt seed

Use the `dbt seed` command to load the CSV files into Snowflake. This command automatically creates the tables and inserts the data into them:

dbt seed

This results in two tables being created: `raw_sales_data` and `raw_customer_data`.

## 3. Data Transformation

### Step 1: Creating the transformed_sales_data Model

Create a new file named `transformed_sales_data.sql` in the `models/example/` directory to perform the required data transformations.

### Step 2: Updating schema.yml

Document the `transformed_sales_data` model by adding relevant descriptions in the `schema.yml` file stored in the `models/example/` directory. This includes details on the columns, their purpose, and the transformations performed.

### Step 3: Extracting Year, Month, and Day from order_date

The `order_date` in the raw sales data was in string format. Extract the year, month, and day components using SQL's `EXTRACT` and `TO_DATE` functions.

### Step 4: Calculating Total Sales Amount

Calculate the total sales per order by multiplying the quantity by the price for each product:

SUM(quantity * price) AS total_sales_amount


### Step 5: Final Transformation Query

Combine these elements to create a final SQL query that outputs a table called `transformed_sales_data`, which includes the following columns:

- `order_id`
- `customer_id`
- `order_year`
- `order_month`
- `order_day`
- `total_sales_amount`

### Step 6: Running the Transformation

To generate the transformed table in Snowflake, run the following command:

dbt run --models transformed_sales_data


This successfully creates the `transformed_sales_data` table in Snowflake.

## 4. Querying the Data

### Step 1: Writing SQL Queries

Create a `queries/` folder inside the `models/` directory and write four separate `.sql` files to answer the provided business questions.

### Step 2: Running the Queries

Execute the queries and generate the required results with the following dbt command:

dbt run --models queries


This command runs all SQL files and generates the views in Snowflake, allowing you to analyze the data based on the given questions.

---

This concludes the steps followed in the data pipeline from ingestion to transformation and querying, along with documentation of the setup and decisions made throughout the assignment.


