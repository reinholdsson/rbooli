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
  suppressWarnings({
    colwise(function(col) {
      # return if all na
      if (all(is.na(col))) col
      # char -> numeric
      else if (all(is.na(col) | !is.na(as.numeric(col)))) as.numeric(col)
      # char -> date
      else if (all(is.na(col) | grepl("^\\d\\d\\d\\d-\\d\\d-\\d\\d", col))) as.Date(col)
      # if no match, return as is
      else col
    })(x)
  })
}
