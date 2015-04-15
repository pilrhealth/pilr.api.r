check_pilr_server <- function(pilr_server) {
    if(missing(pilr_server)) {
        pilr_server <- getOption("pilr_server_default")
        if(is.null(pilr_server)) {
            stop("The pilr_server argument was not passed in, and the pilr_server_default option is unset. You must specify the URL of the PiLR server through one of these methods. If you always use the same PiLR server and want to make it your default, include \noptions(pilr_server_default = 'http://<your_pilr_server>') \nin your .Rprofile")
        }
        message(paste0("The pilr_server argument was not passed in. Using ",
                       pilr_server, " from options()."))
    }
    pilr_server
}
