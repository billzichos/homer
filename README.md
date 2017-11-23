__homeR__ is a collection of R functions that enable sourcing and plotting of
publicly available residential home information.

#### Requirements

1. You must have a unique Zillow Web Services account.  This is separate from the
Zillow application account.  Free enrollment can be found here -
https://www.zillow.com/webservice/APIReminder.htm.

2. Store Zillow credentials in a file named zillow_key.txt in the HOME directory.  Your HOME directory can be found by typing the following into the command prompt or terminal.  It is recommended you lock down security on this file to be viewable by only yourself.

Windows
> echo \%USERPROFILE\%

Unix/Linux
> echo $HOME

#### Installation

Install this package directly from GitHub.

```r
devtools::install_github("billzichos/homeR")
```
#### Functions

```r
home_estimate()
```
