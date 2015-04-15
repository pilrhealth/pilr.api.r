post_protected_content <- function(endpoint, json_data, access_code) {
    if(missing(access_code)) {
        access_code <- getOption("pilr_default_access_code")
        if(is.null(access_code)) {
            stop("This content is protected. You must provide an access code obtained from get_access_code().")
        }
        message(paste("Using access_code from options:", access_code))
    }

    httr::POST(endpoint, body = json_data, config =
               httr::add_headers(authorization = paste("bearer", access_code)))
}
