#' Zillow home estimate
#'
#' \code{home_estimate} returns data for one or more homes listed on Zillow.
#'
#' @param x A character string representing a single Zillow ID
#' @param zws_id A character string representing a your unique Zillow Web
#'           Services key.
#'
#' @details Future versions will include the ability to pass in more than one
#'   property.
#'
#' @details Link to zillow web services where users obtain an account.
#'
#' @details Future versions will have different output options.
#'
#' @return XML from Zillow Web Service.  Details of the XML are maitained by
#' Zillow here - https://www.zillow.com/howto/api/GetZestimate.htm.
#'
#' @example home_estimate("36086728")
#'
#' @export
home_estimate <- function(x, zws_path="~/zillow_key.txt") {
    zws_id <- readLines(zws_path)
    base_URL <- "http://www.zillow.com/webservice/GetZestimate.htm?"
    URL <- paste0(base_URL,"zws-id=",zws_id,"&zpid=",x)
    xml2::as_list(xml2::read_xml(URL))
}
