
#' Return job params from the PiLR server. 
#'
#' 
#' This function will return a data.frame containing job params
#' 
#' 
#' @param endpoint The endpoint to retrieve information. 
#' 
#' @keywords measurement data
#' @export
#' @examples
#' read_pilr_params(endpoint)
#' 
read_pilr_params <- function(pilr_server, project, participant, instrument, period, access_code,
                      bad_metadata_ok = FALSE, value = "parsed",
                      query_params = NULL, ...) {
  
  pilr_server <- check_pilr_server(pilr_server)
  project <- check_pilr_project(project)
  
  
  ep_params <- retrieve_pilr_params(pilr_server, project, participant, instrument, period, access_code)
  
  if(value != "parsed") {
    return(ep_params)
  }
  
  df <- jsonlite::fromJSON(httr::content(ep_params, as = "text"))
  ret <- c()
  for (i in 1:nrow(df)) {
    var <- data.frame(epoch = df$epoch[i], value = as.character(df$value[i]), period = df$period[i])
    ret[[strsplit(df$code[i], ":")[[1]][length(strsplit(df$code[i], ":")[[1]])]]] <- var
  }
  
  for (i in 1:length(ret)) {
    ## Convert numerics
    if (!is.na(as.numeric(levels(ret[[i]]$value)))) {
      ret[[i]]$value <- as.numeric(levels(ret[[i]]$value))
    }
  }
  ret
}
