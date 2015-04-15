#' @export
write_csv_pilr <- function(filename, ...) {
    df1 <- read.csv(filename)
    write_pilr(data = df1, ...)
}
