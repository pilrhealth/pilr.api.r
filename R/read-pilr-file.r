#' @export
read_pilr_file <- function(filepath, access_code) {
  epd <- GET(filepath,
             httr::add_headers(authorization = paste("bearer", access_code)))
  env <- new.env()
  nm <- load(rawConnection(httr::content(epd)), env)[1]
  env[[nm]]
}
