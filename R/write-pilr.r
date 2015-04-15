#' @export
write_pilr <- function(project, data_set, schema, pilr_server, access_code,
                       data, meta_pt = "pt", meta_id = "id",
                       meta_timestamp = "timestamp", write = TRUE,
                       convert = TRUE,
                       ...) {

    pilr_server <- check_pilr_server(pilr_server)
    project <- check_pilr_project(project)

    endpoint <- paste0(pilr_server, "/api/", pilr_api_version, "/", project, "/",
                       data_set, "/", schema, "/data")


    if(convert) {
        json <- pilr_to_json(data, meta_pt, meta_id,
                             meta_timestamp)
    } else {
        json <- data
    }

    if(write) {
        httr::content(post_protected_content(endpoint, json, access_code, ...))
    } else {
        json
    }
}
