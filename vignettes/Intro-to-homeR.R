## ----libraries, echo=FALSE, message=FALSE, warning=FALSE-----------------
library("homer")
library("ggplot2")
library("xml2")
library("glue")
library("lubridate")
library("stringr")

ts <- paste0(
    year(Sys.Date())
    , str_sub(paste0("0", month(Sys.Date())), -2)
    , str_sub(paste0("0", day(Sys.Date())), -2))
zillow_dir <- system.file(package = "homer", "extdata")

## ---- fig.width=7.2, fig.height=2, echo=FALSE----------------------------
homer::plot_zillow_directory(zillow_dir, strip_font_size = 12, nudge_y = 800, value_size = 2.6)

## ----libraries, eval=FALSE-----------------------------------------------
#  library("homer")
#  library("ggplot2")
#  library("xml2")
#  library("glue")
#  library("lubridate")
#  library("stringr")
#  
#  ts <- paste0(
#      year(Sys.Date())
#      , str_sub(paste0("0", month(Sys.Date())), -2)
#      , str_sub(paste0("0", day(Sys.Date())), -2))
#  zillow_dir <- system.file(package = "homer", "extdata")

## ---- eval=FALSE---------------------------------------------------------
#  # Open the .Renviron file.
#  file.edit("~/.Renviron")

## ------------------------------------------------------------------------
l <- home_estimate("36086728", format = "list")

## ------------------------------------------------------------------------
# Current value of the property
l$zestimate$response$zestimate$amount[[1]]

## ----list_structure, eval=FALSE, echo=FALSE------------------------------
#  str(l)

## ------------------------------------------------------------------------
x <- home_estimate("36086728", format = "xml")
write_xml(x, glue('{zillow_dir}/36086728-{ts}.xml'))

## ---- fig.width=7.2, fig.height=2----------------------------------------
homer::plot_zillow_directory(zillow_dir, strip_font_size = 12, nudge_y = 800, value_size = 2.6)

## ----list_structure------------------------------------------------------
str(l)

