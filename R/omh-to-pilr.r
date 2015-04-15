#' @export
omh_to_pilr <- function(omh_data) {
    if(!length(omh_data)) {
        return(data.frame())
    }
    
    if(! "metadata" %in% names(omh_data)) {
        stop("No 'metadata' component found in this data payload.")
    }

    if(! "data" %in% names(omh_data)) {
        stop("No 'data' component found in this data payload.")
    }

    metadata <- omh_data$metadata
    data <- omh_data$data
    df <- cbind(metadata, data)
    names(df) <- gsub("metadata.", "", names(df), fixed = TRUE)
    names(df) <- gsub("data.", "", names(df), fixed = TRUE)
    df
}
