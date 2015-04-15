#' Write data contained in all JSON files in a directory to the PiLR server.
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
post_json_dir <- function(dir, endpoint, ...) {
    lapply(list.files(dir, full.names = TRUE),
           post_json_file, endpoint = endpoint)
}
