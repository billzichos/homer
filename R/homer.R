#' Zillow home estimate
#'
#' \code{home_estimate} returns data for one or more homes listed on Zillow.
#'
#' @param x A character string representing a single Zillow ID
#' @param zws_path A character string representing a your unique Zillow Web
#'           Services key.
#' @param format Specifies whether the return object is in XML or List format.
#'         Defaults to list.
#'
#' @details Future versions will include the ability to pass in more than one
#'   property.
#'
#' @return XML from Zillow Web Service.  Details of the XML are maitained by
#' Zillow here - https://www.zillow.com/howto/api/GetZestimate.htm.
#'
#' @examples home_estimate("36086728")
#'
#' @export
home_estimate <- function(x, zws_path="~/zillow_key.txt", format="list") {
    zws_id <- readLines(zws_path)
    base_URL <- "http://www.zillow.com/webservice/GetZestimate.htm?"
    URL <- paste0(base_URL,"zws-id=",zws_id,"&zpid=",x)
    if (format=="list") {
        xml2::as_list(xml2::read_xml(URL))
    } else if (format=="xml") {
        xml2::read_xml(URL)
    } else print("Unknown format.  Expecting 'list' or 'xml.'")
}

#' Load Zillow directory
#'
#' \code{load_zillow_directory} returns a dataframe of zillow estimate archives.
#'
#' @param path A character string specifying the path to find Zillow archives.
#'
#' @details Used after collecting data over time with home_estimate().
#'
#' @importFrom magrittr "%>%"
#' @export
load_zillow_directory <- function(path=".") {
    lapply(dir(path), function(x) {
        l <- xml2::as_list(xml2::read_xml(glue::glue("{path}/{x}"), encoding = "UTF-8"))
        data.frame(
            House = l$response$address$street[[1]]
            , Date = readr::parse_date(l$response$zestimate$`last-updated`[[1]], format = "%m/%d/%Y")
            , Amount = readr::parse_number(l$response$zestimate$amount[[1]])
        ) %>%
            dplyr::mutate(House = as.character(House))
    }) %>%
        dplyr::bind_rows()
}

#' Plot Zillow archives
#'
#' \code{plot_zillow_directory} plots a timeseries sparkline for each home in your
#'    archive.
#'
#' @param path A character string specifying the path to find Zillow archives.
#'
#' @return ggplot
#'
#' @importFrom magrittr "%>%"
#' @export
plot_zillow_directory <- function(path=".") {
    # presumes you are archiving data created from home_estimate()
    df <- load_zillow_directory(path)
    ggplot2::ggplot(data = df, aes(Date, Amount)) +
        ggplot2::geom_line() +
        ggplot2::geom_point(
            data =
                df %>%
                    dplyr::group_by(House) %>%
                    dplyr::summarise(Date = max(Date)) %>%
                    dplyr::inner_join(df, by = c("House", "Date"))
            , aes(Date, Amount)
            , color = "red") +
        ggplot2::geom_text(
            data =
                df %>%
                    dplyr::group_by(House) %>%
                    dplyr::summarise(Date = max(Date)) %>%
                    dplyr::inner_join(df, by = c("House", "Date"))
            , aes(label = scales::dollar(Amount))
            , nudge_x = 2) +
        ggplot2::facet_grid(House~., scales = "free", switch = "both") +
        ggthemes::theme_tufte(base_size = 14) +
        ggplot2::theme(
            axis.title.y = ggplot2::element_blank()
            , axis.title.x = ggplot2::element_blank()
            , axis.text.y = ggplot2::element_blank()
            , axis.ticks.y = ggplot2::element_blank()
            , strip.text.y = ggplot2::element_text(size = 17, angle = 180)) +
        ggplot2::scale_y_continuous(labels = scales::dollar, position = "right")
}
