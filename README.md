# homer

homer is a collection of R functions that enable sourcing and plotting of
publicly available residential home information.

### Installation

```r
# Install the development version from GitHub:
# install.packages("devtools")
devtools::install_github("billzichos/homer", build_vignettes = T)
```

### Requirements

1. You must have a unique Zillow Web Services account.  This is separate from the
Zillow application account.  Free enrollment can be found here -
https://www.zillow.com/webservice/APIReminder.htm.

2. Store Zillow credentials in the .Renviron startup file in your HOME directory.

> Sys.setenv(ZILLOWAPI = "[Your API key here]")

### Usage

```r
home_estimate("36086728")

browseVignettes("homer")
```
