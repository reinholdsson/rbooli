#' Convert list to table
#' 
#' Flattens out a nested list 
#' 
#' @param x list
#' @param ... arguments passed to `data.frame()
list_to_table <- function(x, ...) {
  do.call(
    "rbind.fill",
    lapply(x, function(y) {
      data.frame(t(unlist(y)), ...)
    })
  )
}

#' Fix data formats
#' 
#' Since all data is returned as character, we need to
#' convert the format of some columns
#' 
#' @param x data.frame
fix_data <- function(x) {
  suppressWarnings(
    colwise(function(x) {
      # char -> numeric for numerical columns
      if (all(!is.na(as.numeric(x)))) as.numeric(x) else x
    })(sold)
  )
}
