rbooli
======

R Booli API Wrapper. For API documentation (in swedish) see: http://www.booli.se/api/.

## Install

    library(devtools)
    install_github("rbooli", "reinholdsson")

## Example

    a <- booli("your_id", "your_key")
    data <- a$get(path = "sold", q = "vasastan")

## See also

- https://gist.github.com/emilkaiser/3447520
