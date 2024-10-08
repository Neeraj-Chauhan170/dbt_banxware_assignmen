# Project Overview

This project analyzes sales data by ingesting CSV files into Snowflake, transforming the data with dbt, and querying it to answer key business questions.

## Setup Instructions

### 1. Clone the Repository

Clone the repository to your local machine:

```bash
git clone https://github.com/Neeraj-Chauhan170/dbt_banxware_assignmen.git
cd <repository_directory>
```

### 2. Configure Snowflake

Ensure you have a Snowflake account and a database named `home_assignment` created.

### 3. Configure profiles.yml

Create a `profiles.yml` file in the _~/.dbt/_ directory with the following content. Replace the placeholders with your Snowflake account details

```bash
dbt_banxware_assignment:
  outputs:
    dev:
      type: SNOWFLAKE
      threads: 4
      account: <your_snowflake_account_details>
      database: home_assignment
      user: <login-name>
      password: <yourpassword>
      schema: <your_snowflake_schema_name>
      warehouse: <compute_wh>
      role: <snowflake_role>
  target: dev
```

### 4. Verify the Connection

Run the following command to ensure dbt can connect to your Snowflake database:

```bash
dbt debug
```

### 5. Data Ingestion

To load data, run the following command to load the CSV files into Snowflake:

```bash
dbt seed
```

This will create the `raw_sales_data` and `raw_customer_data` tables in Snowflake.

### 6. Data Transformation

To run the transformations, execute the transformation model with:

```bash
dbt run --models transformed_sales_data
```

This will create the `transformed_sales_data` table in Snowflake.

### 7. Querying the Data

Execute the queries with:

```bash
dbt run --models queries
```

This will run all SQL query files and generate the views in Snowflake.

