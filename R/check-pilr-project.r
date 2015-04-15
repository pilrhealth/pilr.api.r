check_pilr_project <- function(project) {
    if(missing(project)) {
        project <- getOption("pilr_project_default")
        if(is.null(project)) {
            stop("The project argument was not passed in, and the pilr_project_default option is unset. You must specify the name of the PiLR project through one of these methods. If you always use the same PiLR project and want to make it your default, include \noptions(pilr_project_default = 'your_project_name') \nin your .Rprofile")
        }
        message(paste0("The project argument was not passed in. Using ",
                       project, " from options()."))
    }
    project
}
