#' Write data contained in a JSON file to the PiLR server. 
#'
#' 
#' This function will return a data.frame containing the names and
#' identification codes of projects the user has access to on the PiLR
#' server.
#' 
#' @param pilr_server the pilr_server to get the list of projects from
#' 
#' @keywords projects 
#' @export
#' @examples
#' get_projects("localhost:8080")
#' 
post_json_file <- function(file, endpoint, ...) {
    json_data <- paste0(readLines(file), collapse = "")
    httr::content(post_protected_content(endpoint, json_data, access_code))
}
