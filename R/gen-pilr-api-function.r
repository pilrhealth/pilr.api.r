#' Return function to use PiLR API. 
#'
#' 
#' This function will return a function suitable to querying the PiLR
#' API.
#' 
#' @param api_string The string to append to the API call string.
#' 
gen_pilr_api_function <- function(api_string) {
    function(project, pilr_server, access_code, ...) {
        pilr_server <- check_pilr_server(pilr_server)
        project <- check_pilr_project(project)
        endpoint <- paste0(pilr_server, "/api/", pilr_api_version, "/", project, "/", api_string)
        get_protected_content(endpoint, access_code, ...)
    }
}
