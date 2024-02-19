# COVID Tracking

## COVID Vaccinations and Deaths SQL Project

### Overview
This project focuses on analyzing COVID-19 vaccination and death data using SQL queries. The dataset includes information about vaccination campaigns, COVID-19 cases, and fatalities. By leveraging SQL queries, we can extract valuable insights and trends to understand the impact of vaccination on mortality rates during the COVID-19 pandemic.

### Dataset
The dataset used in this project consists of several tables containing relevant information:

Vaccinations: Contains data about COVID-19 vaccine doses administered, including the date, vaccine type, and number of doses.
Deaths: Includes data about COVID-19 related deaths, such as the date, location, and number of fatalities recorded.

### Project Structure
The project is organized as follows:

SQL Queries: 
This directory contains SQL scripts used to query the dataset and extract insights.
covid_data_analysis.sql: SQL queries analyzing COVID-19 vaccination and mortality trends.
add-csv-to-sql-workbench.ipynb: This syntax loads data from CSV files into Pandas dataframes, converts date columns to datetime format, and writes the data into corresponding tables within a MySQL database named `covid-tracking`, utilizing SQLAlchemy for the connection.

### Getting Started
To run the SQL queries and reproduce the analysis:

Clone the Repository: Clone this repository to your local machine.

bash
Copy code
git clone https://github.com/k10sj02/covid-vaccinations-deaths-sql-project.git
Set up Database: Import the dataset into your preferred SQL database management system (DBMS). Ensure that the tables are correctly created and populated.

Run Queries: Execute the SQL scripts in your DBMS to perform analysis on the dataset.

### Results
The analysis yielded the following insights:

Trends in COVID-19 vaccination rates over time.
Geographical distribution of vaccination coverage.
Correlation between vaccination rates and COVID-19 mortality rates.
Identification of high-risk areas based on mortality data.

### Future Improvements
Incorporate demographic data to analyze vaccination and mortality rates among different population groups.
Implement advanced statistical analyses to identify significant trends and patterns.
Visualize the results using interactive charts and graphs for better understanding and interpretation.

### Contributing
Contributions to this project are welcome. Feel free to submit issues, feature requests, or pull requests.

### License
This project is licensed under the MIT License.

