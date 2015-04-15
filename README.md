pilr.api.r
==============

An R package to simplify reading and writing data through the open PiLR API.

Installation

First, if you don't already have the devtools package on your machine:

````r
install.packages("devtools")
````

Next install pilr.api.r using devtools, and load it to your session.
We will also load in the two package dependencies.

````r
library(devtools)
install_github("pilrhealth/pilr.api.r")
library(pilr.api.r)
library(httr)
library(jsonlite)
````

Examples:

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
schema version, and optional query params such as participant and period.

````r
df1 <- read_pilr(data_set = "pilrhealth:bmobile:activity", schema = "1", 
                 query_params = list(participant = "pt1"))
````

If you wish to pass the server/project/access code in directly, the 
function call would include those arguments.

````r
df2 <- read_pilr(data_set = "pilrhealth:bmobile:activity", schema = "1", 
                 query_params = list(participant = "pt1"), pilr_server = "a-eiverson-project",
                 project = "a-eiverson-project", access_code = "<your access code>")
````
