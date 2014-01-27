rbooli
======

This package is an R wrapper for the Booli API. More documentation about the API is available in Swedish at [http://www.booli.se/api/](http://www.booli.se/api/).

## Install

    library(devtools)
    install_github("rbooli", "reinholdsson")

Before getting started, you have to read and accept Booli's [Terms of Use](http://www.booli.se/api/tou/) and then finally register to receive an [API key](http://www.booli.se/api/key) by e-mail.

## Example

    library(rbooli)
    a <- booli("your_callerId", "your_privateKey")
    data <- a$get(path = "sold", q = "vasastan", limit = 500)

## See also

- https://gist.github.com/emilkaiser/3447520
