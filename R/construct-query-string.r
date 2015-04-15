construct_query_string <- function(...) {
    
    query_string_passed <- list(...)

    if(length(query_string_passed) > 0) {
        query_string <- paste0("?", paste(names(query_string_passed),
                                          unlist(query_string_passed),
                                          sep = "=",
                                          collapse = "&"))
    } else {
        query_string <- ""
    }

    query_string
}
