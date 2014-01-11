#' Convert list to table
#' 
#' Flattens out a nested list 
#' 
#' @param x list
#' @param ... arguments passed to `data.frame()
#' @export
list_to_table <- function(x, ...) {
  do.call(
    "rbind.fill",
    lapply(x, function(y) {
      data.frame(t(unlist(y)), ...)
    })
  )
}
