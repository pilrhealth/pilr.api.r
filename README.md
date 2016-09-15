pilr.api.r
==============

## Overview

An R package to simplify reading and writing data via the open PiLR API. This package contains two primary wrapper functions:  

1) read_pilr _&larr; Given a PiLR project, dataset, and participant this function constucts an API endpoint, fetches the PiLR data in JSON format, and converts it to an R dataframe._  
2) write_pilr _&larr; Given a PiLR project, dataset, participant, and a dataframe in your R session, this function constructs an API endpoint and writes the dataframe as a PiLR dataset which can then be managed via the PiLR web application._  

To learn more about the PiLR API and it's integration with R, visit our [developer documentation wiki](https://github.com/pilrhealth/developer/wiki).

## Installation

First, if you don't already have the devtools/httr/jsonlite packages on your machine run the following on the R commands:

````r
install.packages("devtools")
install.packages("httr")
install.packages("jsonlite")
````

Next install pilr.api.r using devtools, and load it to your session.
We will also load in the two package dependencies.

````r
library(devtools)
library(httr)
library(jsonlite)
install_github("pilrhealth/pilr.api.r")
library(pilr.api.r)
````

## read_pilr Examples

First, let's set some options so we don't have to pass these to all
the functions. Of course, it's always an option to pass these in if you would like. 

 ````r
options(pilr_server_default = "http://qa.pilrhealth.com")
options(pilr_project_default = "a-eiverson-project")
````

Go to PILR, and setup an API Consumer activation key. When setting the scope
of your key, you can simply enter ** to allow access to every endpoint in the project.  
For example: Scope: /api/v1/a-eiversion-project/**  
Similar to above we can store this in the options.

````r
options(pilr_default_access_code = "<your access code>")
````

If you have some data streams setup already, try reading data from
them using the read_pilr function. Just pass in the dataset code,
schema version, and optional query params such as participant, period, or
group (Note: To pull all enrolled participants, set group parameter = "template_assignments_enrolled").

````r
df1 <- read_pilr(data_set = "pilrhealth:bmobile:activity", schema = "1", 
                 query_params = list(participant = "pt1"))
df2 <- read_pilr(data_set = "pilrhealth:bmobile:activity", schema = "1", 
                 query_params = list(group = "template_assignments_enrolled"))
````

- NOTE: There is a cap of 10000 records that can be pulled with one API call. If you attempt to pull more than this, you will only recieve the first 10000.

## read_pilr_params Examples

You can also pull all instrument settings and participant variables. After setting your options like above simply make a call such as:

````r
df_params <- read_pilr_params(participant = "101", instrument = "calrq", period = "active_period")
````
