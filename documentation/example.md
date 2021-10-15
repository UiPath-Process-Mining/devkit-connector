# Example
the devkit connector contains a simple procurement example on how to write transformations in a dbt project. The example dbt project can be found in the transforms folder. The input data and the process are artificial and simplified compared to a real procurement process. The structure of the dbt project is the advised structure to follow when developing a connector.

## Process description
The entities that are involved in this process are *purchase orders* and *invoices*. A purchase order is created in the system after which it needs two approvals before it can be executed. Once the invoice for the order is received, the invoice is entered into the system. The invoice contains the price, the payment due date, and the payment timestamp. Until the payment is done, the payment timestamp on the invoice is empty. Once the payment is done, the payment timestamp is updated.

### Data model
The goal of every connector is to transform raw input data into a data model for process mining. The data model describes the tables and attributes of the output which can be used by a specific process mining app. This example project transforms the input data to the [TemplateOne data model](https://docs.uipath.com/process-mining/docs/input-tables-of-templateone-10) in which the purchase orders function as the cases.

The raw input data is split over six .csv files and can be found in the sample_data folder. See the comments in the transformations on how the raw input data is transformed to the data model. For an overview of frequently used transforms, see `Frequently_used_transforms.sql`.

## Folder structure
The example dbt project contains the following:
- macros: generic functions that can be used in transformations.
    - tests: functions to test the transformations.
- models: the transformations of the example project in the advised structure of a connector.
    - `Frequently_used_transforms.sql`: example query with frequently used transforms.
    - `Multiple_databases_support.sql`: example query to illustrate multiple databases support.
- `dbt_project.yml`: by this file dbt knows the directory is a dbt project. It contains configurations for your project.
- `profiles.yml`: contains the configuration to connect to your database.

## Tests
The example project includes tests to validate the transformations. The implemented tests can be found in the *models/schema* folder. Some tests are offered out of the box by dbt and others are implemented in macros. Some useful test macros can be found in the *macros/tests* folder.

The tests are implemented in such a way that they can run on a SQL Server and Snowflake database. For this purpose, the variable `database` in the `dbt_project.yml` needs to be set to the used database. Currently, the example project only supports `sqlserver`. 

## Multiple databases support
For an illustration on how a dbt project can run on multiple databases, see `Multiple_databases_support.sql`. The Jinja language allows to define which lines of code should end up in the compiled query. Based on the value of the variable `database` in the `dbt_project.yml` either the code for SQL Server or for Snowflake is used. This functionality can best be implemented in macros for readability of the transformations. Some useful functions can be found in the *macros* folder.

## Running the project
*At this moment, the example project can only run on SQL Server.*

Import the .csv files in your database to run the transformations on this sample data. If you are using SQL Sever Management Studio, you can upload the files by right click on the database and choose `Tasks -> Import Flat File`.

See the README.md for instructions on how to run a dbt project.