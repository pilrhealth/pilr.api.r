create_data_frame <- function(ep_content, bad_metadata_ok = FALSE) {

    data <- lapply(ep_content, "[[", "data")
    pt        <- sapply(ep_content, function(x) x$metadata$pt)
    timestamp <- sapply(ep_content, function(x) x$metadata$timestamp)
    id        <- sapply(ep_content, function(x) x$metadata$id)    

    ## NB: how do we handle case without any pt?
    if(any(sapply(pt, is.null))) {
        valid_pt <- FALSE
        if(!bad_metadata_ok) {
            stop(head(ep_content))
        }
    } else {
        valid_pt <- TRUE
    }

    if(is_event_tags(data)) {
        t0 <- lapply(data, expand.grid,
                     stringsAsFactors = FALSE,
                     KEEP.OUT.ATTRS = FALSE)
        
        t1 <- mapply(function(x, index) {
            x$pt <- pt[index]
            x$id <- id[index]
            x$timestamp <- timestamp[index]
            x
        }, t0, seq_along(t0), SIMPLIFY = FALSE)
                     
        t2 <- do.call(rbind, t1)
        df <- as.data.frame(lapply(t2, unlist),
                            stringsAsFactors = FALSE)
    } else {
        df <- as.data.frame(mapply(function(x) sapply(data, "[[", x),
                                   names(data[[1]]),
                                   SIMPLIFY = FALSE, USE.NAMES = FALSE),
                            stringsAsFactors = FALSE)
        names(df) <- names(data[[1]])

        if(valid_pt) {
            data.frame(pt = pt, id = id, timestamp = timestamp,
                       df, stringsAsFactors = FALSE)
        } else {
            df
        }
        
    }

    df
}


is_event_tags <- function(data) {
    "tags" %in% lapply(data, names)[[1]]
}
