#' @export
pilr_to_json <- function(data, meta_pt = "pt",
                         meta_id = "id",
                         meta_timestamp = "timestamp",
                         value = "json", ...) {

    gen_struct <- function(data) {
        data$pt <- data[[meta_pt]]
        data$id <- data[[meta_id]]
        data$timestamp <- data[[meta_timestamp]]

        if(!all(c("id", "pt", "timestamp") %in% names(data))) {
            stop(paste("Need columns id, pt, and timestamp, but given columns are: ",
                       paste(names(data), collapse = " ")))
        }

        l1 <- data[, c("id", "pt", "timestamp")]
        l2 <- data[setdiff(names(data), c("id", "pt", "timestamp"))]
        
        bm0 <- vector(mode = "list", length = nrow(l1))
        for(i in seq_len(nrow(l1))) {
            bm0[[i]] <- list(metadata = jsonlite::unbox(l1[i,]),
                             data = jsonlite::unbox(l2[i, , drop = FALSE]))
        }
        bm0
    }

    if(is.data.frame(data)) {
        listform <- FALSE
        data <- list(data = data)
    } else {
        listform <- TRUE
    }

    ## 
    bm0 <- lapply(data, gen_struct)

    if(!listform) {
        bm0 <- bm0[[1]]
    }
    
    if(value == "json") {
        jsonlite::toJSON(bm0)
    } else {
        bm0
    }
}
