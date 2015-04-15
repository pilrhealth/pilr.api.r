#' Return data set schema information from the PiLR server. 
#'
#' 
#' This function will return a data.frame containing the names and
#' identification codes of schemas for a data set.
#' 
#' @param project the pilr_server to get the list of projects from
#' @param data_set the pilr_server to get the list of projects from
#' @param pilr_server  a character vector of length 1 indicating the
#' pilr_server URL
#' 
#' @keywords projects 
#' @export
#' @examples
#' get_projects("localhost:8080")
#' 
get_schemas <- function(project, data_set, pilr_server, access_code, ...) {
    pilr_server <- check_pilr_server(pilr_server)
    project <- check_pilr_project(project)
    endpoint <- paste0(pilr_server, "/api/" , pilr_api_version, "/", project,
                       "/", data_set, "/schema")
    get_protected_content(endpoint, access_code, ...)
}
