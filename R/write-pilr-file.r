#' @export
write_pilr_file <- function(endpoint, file, access_code) {
  PUT(endpoint, body = list(a = upload_file(file)), 
      config = httr::add_headers(authorization = paste("bearer", access_code)))
}
