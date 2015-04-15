#' Return project information from the PiLR server. 
#'
#' 
#' This function will return a data.frame containing the names and
#' unique identifiers of projects the user has access to on the PiLR
#' server.
#' 
#' @param pilr_server a character vector of length 1 indicating the
#' PiLR server URL
#' 
#' @keywords projects 
#' @export
#' @examples
#' get_projects("localhost:8080")
#' 
get_projects <- function(pilr_server, access_code) {
    pilr_server <- check_pilr_server(pilr_server)
    endpoint <- paste0(pilr_server, "/api/", pilr_api_version, "/project")
    as.data.frame(get_protected_content(endpoint, access_code))
}
