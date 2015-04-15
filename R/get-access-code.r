#' @export
get_access_code <- function(activation_key, pilr_server,
                            store_in_options = FALSE) {
    if(missing(activation_key)) {
        stop("activation_key required")
    }

    pilr_server <- check_pilr_server(pilr_server)
    query_string <- construct_query_string(activation_key = activation_key)
    endpoint <- paste0("http://qa.pilrhealth.com/api/", pilr_api_version, "/token", query_string)

    access_code <- httr::content(GET(endpoint))
    if(!length(access_code$access_code)) {
        stop("No access code received. Something went wrong.")
    } else {
        access_code <- access_code$access_code
    }
    

    if(access_code == "") {
        stop(paste0("No access code was received. Please check that the activation key you provided (", activation_key, ") is correct for server ", pilr_server, ". The activation key needs to be enabled, not locked, and not expired. If you do not understand this error message, please talk to your system administrator."))
    }

    if(store_in_options) {
        options(pilr_default_access_code = access_code)
    } 

    ## return
    access_code
}
