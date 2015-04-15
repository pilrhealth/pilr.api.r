#' Return participants from the PiLR server. 
#'
#' 
#' This function will return a data.frame containing the names and
#' identification codes of participants for a given project.
#' 
#' @param project the PiLR project string identifier
#' @param pilr_server URL of PiLR server
#' 
#' @keywords participants
#' @export
#' @examples
#' get_projects("localhost:8080")
#' 
get_participants <- gen_pilr_api_function("participant")
