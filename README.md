rbooli
======

R Booli API Wrapper

## Install

    library(devtools)
    install_github("rbooli", "reinholdsson")

## Example

    a <- booli("your_id", "your_key")
    data <- a$get(path = "sold", q = "vasastan")
