
#' Return measurement data from the PiLR server. 
#'
#' 
#' This function will return a data.frame containing measurement data
#' 
#' 
#' @param endpoint The endpoint to retrieve information. 
#' 
#' @keywords measurement data
#' @export
#' @examples
#' read_pilr(endpoint)
#' 
read_pilr <- function(pilr_server, project, data_set, schema, access_code,
                      bad_metadata_ok = FALSE, value = "parsed",
                      query_params = NULL, ...) {
  pilr_server <- check_pilr_server(pilr_server)
  project <- check_pilr_project(project)
  
  if(!is.null(query_params)) {
    query_string <- do.call(construct_query_string, query_params)
  } else {
    query_string <- ""
  }
  
  ep_data <- retrieve_pilr_data(pilr_server, project, data_set,
                                schema, query_string, access_code)
  
  if(value != "parsed") {
    return(ep_data)
  }
  
  ret <- json_to_pilr(ep_data, bad_metadata_ok)
  
  if (nrow(ret) >= 10000) {
    message("You have received the maximum capacity of 10000 data records. More records may exist in this dataset but must be retrieved in multiple parts.")
  }
}
