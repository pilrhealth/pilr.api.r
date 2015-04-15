#' Generate a concordia schema from a given data.frame
#'
#' 
#' EXPERIMENTAL! This function will write a valid Concordia schema
#' (http://jojenki.github.io/Concordia/) to a file. The schema will
#' describe the given data.frame.
#' 
#' @param data a data.frame to generate the Concordia schema for.
#' PiLR server URL
#' @param metadata_names column names in the data.frame that should be
#' part of the metadata object. Therefore, these names will not be included in the Concordia schema.
#'
#' @param exclude_names Names to be ommitted from the generated schema, beyond metadata_names
#' 
#' @param doc_list A named list with documentation strings (i.e.,
#' length-1 character vectors) to be included in the generated
#' schema. The names of the list should correspond to the column names.
#'
#' @param file Write the schema to this file, default is "" (i.e., cat
#' the output to the console)
#' 
#' @keywords Concordia schema JSON
#' @examples
#' gen_concordia(mtcars)
#'
#'

#' @export
gen_concordia <- function(data, metadata_names = c("id", "pt", "timestamp"),
                          exclude_names, doc_list, all_optional = FALSE,
                          file = "") {

    has_doc_list <- !missing(doc_list)

    data <- data[!names(data) %in% metadata_names]

    classes     <- lapply(data, class)
    is.datetime <- sapply(classes, function(x) any(x %in% c("Date", "POSIXct", "POSIXt")))
    is.factor   <- sapply(data, is.factor)
    is.numeric   <- sapply(data, is.numeric)
    is.logical   <- sapply(data, is.logical)

    types <- ifelse(is.datetime | is.factor,
                    "string", ifelse(is.numeric | is.logical, "number", "unknown"))

    ## create a category field IF class is Date or POSIXct
    cats <- ifelse(is.datetime, "date", NA)
    
    names(types) <- names(cats) <- names(data)

    if(has_doc_list) {
        names(doc_list) <- names(data)
    }

    concordia <- list(type = jsonlite::unbox("object"),
                      fields = lapply(names(data), function(x) {

                          ret <- list(name = jsonlite::unbox(x),
                                      type = jsonlite::unbox(types[[x]]),
                                      category = jsonlite::unbox(cats[[x]]))

                          if(is.na(ret[["category"]])) {
                              ret[["category"]] <- NULL
                          }

                          if(has_doc_list) {
                              ret[["doc"]] <- jsonlite::unbox(doc_list[[x]])
                          }

                          if(all_optional) {
                              ret[["optional"]] <- unbox(TRUE)
                          }
                          
                          ret
                      }))
           
    cat(prettify(toJSON(concordia)), "\n", file = file)
}
