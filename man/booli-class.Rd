\docType{class}
\name{booli-class}
\alias{booli-class}
\title{Query Booli API}
\arguments{
  \item{callerId}{caller id}

  \item{key}{private api key}

  \item{...}{arguments passed on to the http get request;
  for possible parameters, see http://www.booli.se/api/}
}
\description{
Returns a data frame with Booli data
}
\examples{
\dontrun{
a <- booli("YOUR_CALLERID", "YOUR_APIKEY")
listings <- a$get(path = "listings", q = "nacka", limit = 5, offset = 0)
sold <- a$get(path = "sold", q = "nacka", limit = 5, offset = 0)
}
}

