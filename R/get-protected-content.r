get_protected_content <- function(endpoint, access_code, do_rbind = TRUE, ...) {
    if(missing(access_code)) {
        access_code <- getOption("pilr_default_access_code")
        if(is.null(access_code)) {
            stop("This content is protected. You must provide an access code obtained from get_access_code().")
        }
        message(paste("Using access_code from options:", access_code))
    }
    epd <- GET(endpoint,
               httr::add_headers(authorization = paste("bearer", access_code)),
               ...)
    if(do_rbind) {
        #ret <- do.call(rbind, httr::content(epd))
        ret <- epd
    } else {
        ret <- epd
    }
    ret
}
