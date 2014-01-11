rbooli
======

R Booli API Wrapper

## Install

    library(devtools)
    install_github("rbooli", "reinholdsson")

## Example

    a <- booli("your_id", "your_key")
    sold <- a$get(path = "sold", q = "vasastan")

## Todo
- Check if data column is character, date or numeric (and automatically convert them)
