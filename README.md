# Data-Engineering-Platforms-Final-Project
<!-- TABLE OF CONTENTS -->
## Table of Contents

* [About the Project](#about-the-project)
  * [Built With](#built-with)
* [Getting Started](#getting-started)
  * [Prerequisites](#prerequisites)
  * [Installation](#installation)
* [Usage](#usage)


<!-- ABOUT THE PROJECT -->
## About The Project
The purpose of our project is to extrapolate implications from the 2008 financial crisis for a covid-19 situation. 
We believe that learning from the past could allow policy-makers, civic leaders, and industry entities to prepare for future economic recessions. 


### Built With

* [Python](#Python)
* [R-Studio](#R-Studio)
* [MongoDB](#MongoDB)
* [GCP](#GCP)
* [MySQL](#MySQL)
* [Excel](#Excel)
* [Tableau](#Tableau)


<!-- GETTING STARTED -->
## Getting Started

### Prerequisites
* WebScraping (SP.ipynb)
```sh
import requests
from bs4 import BeautifulSoup
import json
import csv
from IPython.display import HTML
import pandas as pd
import numpy as np
```

* API Extract <br/>
(bls_api.ipynb)<br/>
The below steps provide necessary information to run BLS.GOV APIs to get the Unemployment Rate, Unemployed, and CPI data from 2005 to 2020.

1. Open up the Jupyter Notebook and make sure the inflationCode.csv and "Unemployment Series ID Codes - Final Codes.csv" are located in the same location as the bls_api notebook. 
2. Run each cell provided in the notebook.
2. The script uses bls.gov public APIs, but with a registered authentication so that we can get large amount of data in single extract. 
3. Once extracted, the script can save the data into an excel file for backup. 
4. The script can also insert data directly into MYSQL-GCP. 
5. It also lists a cell to create tables and insert data from the data frame into the table. 
6. Necessary libraries to run the script. 

```sh
import pymysql
import pandas as pd
import json
import requests
```

* R-Studio <br/>
Open the workbook, import SP2.0 xlsx 
```sh
library(readxl)
```
* Tableau <br/>
Open the packaged workbook, everything will automatically populate

* MongoDB <br/>
"C:\Program Files\MongoDB\Server\4.2\bin\mongod.exe" --dbpath "C:\data"
-Import files: "C:\Program Files\MongoDB\Server\4.2\bin\mongoimport" --db 
financialCrisis --collection financial_analysis --type csv --file "csv file path" --headerline


* MySQL
1. To create the dimensional model that includes necessary staging table, then open bls_final_schema_DDL.sql
2. Open bls_final_data_DML.sql to run DML.
3. Open bls_dropped_tables_queries.sql to drop the unnecessary tables and to create a snowflake model.
4. Open bls_views.sql to create necessary views that can be used on Tableau. 
5. In case not create from scratch, then open bls_data_schema_final.SQL to create the dimensional model.




### Installation
 
1. Install R packages
```sh
install.packages("readxl")
```

2. Install python packages
```sh
!pip install numpy 
!pip install scripy 
!pip install BS4
!pip install Requests
```

<!-- USAGE EXAMPLES -->
## Usage
We seek to identify individuals and industries that are most vulnerable to economic fluctuations. In doing so, we hope to highlight opportunities for support during this global pandemic. 
