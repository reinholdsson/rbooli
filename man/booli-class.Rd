\docType{class}
\name{booli-class}
\alias{booli}
\alias{booli-class}
\alias{rbooli}
\title{Query Booli API}
\arguments{
  \item{id}{caller id}

  \item{key}{private api key}

  \item{path}{object type; "listings" (default) or "sold"}

  \item{limit}{max observations to be returned from api
  (default: 500)}

  \item{...}{additional arguments sent to the http get
  request; for possible parameters, see
  http://www.booli.se/api/}
}
\description{
Returns a data frame with Booli data
}
\examples{
\dontrun{
a <- booli("YOUR_CALLERID", "YOUR_APIKEY")

# Get currently listed apartments in Nacka (default limit is 500)
x <- a$get(path = "listings", q = "nacka")

# Get latest 1200 sold apartments in Stockholm
x <- a$get(path = "sold", q = "stockholm", limit = 1200)
}
}

