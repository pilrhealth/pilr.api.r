#' Return data set information from the PiLR server. 
#'
#' 
#' This function will return a data.frame containing the names and
#' unique identifiers of the data sets enabled for the given
#' project.
#'
#' @param project a character vector of length 1 indicating the
#' project identifier
#' @param pilr_server a character vector of length 1 indicating the
#' pilr_server URL
#' 
#' @keywords dataset 
#' @export
#' @examples
#' get_data_sets("test_project", "localhost:8080")
#' 
get_data_sets <- function(project, pilr_server, access_code) {
    pilr_server <- check_pilr_server(pilr_server)
    project <- check_pilr_project(project)
    endpoint <- paste0(pilr_server, "/api/" , pilr_api_version, "/", project, "/dataStream")
    get_protected_content(endpoint, access_code)
}
