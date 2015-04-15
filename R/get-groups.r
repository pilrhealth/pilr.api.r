#' Return projects from the PiLR server. 
#'
#' 
#' This function will return a data.frame containing the names and
#' identification codes of projects the user has access to on the PiLR
#' server.
#' 
#' @param pilr_server the pilr_server to get the list of projects from
#' 
#' @keywords projects 
#' @export
#' @examples
#' get_projects("localhost:8080")
#' 
get_groups <- gen_pilr_api_function("group")
