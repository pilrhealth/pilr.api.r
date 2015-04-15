retrieve_pilr_data <- function(pilr_server, project, data_set, schema,
                          query_string, access_code) {
    endpoint <- paste0(pilr_server, "/api/", pilr_api_version, "/", project, "/",
                       data_set, "/", schema, "/data",
                       query_string)
    
    message("Attempting to get data from ", endpoint, " ...")

    get_protected_content(endpoint, access_code, do_rbind = FALSE)
}
