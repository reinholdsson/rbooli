#' Query Booli API
#' 
#' Returns a data frame with Booli data
#' 
#' @param id caller id
#' @param key private api key
#' @param path object type; "listings" (default) or "sold"
#' @param limit max observations to be returned from api (default: 500)
#' @param ... additional arguments sent to the http get request;
#' for possible parameters, see http://www.booli.se/api/
#' 
#' @examples \dontrun{
#' a <- booli("YOUR_CALLERID", "YOUR_APIKEY")
#' 
#' # Get currently listed apartments in Nacka (default limit is 500)
#' x <- a$get(path = "listings", q = "nacka")
#' 
#' # Get latest 1200 sold apartments in Stockholm
#' x <- a$get(path = "sold", q = "stockholm", limit = 1200)
#' }
#' @aliases booli rbooli
#' @export
booli <- setRefClass("booli", 
  fields = list(
    id = "character",
    key = "character"
  ),
  methods = list(
    initialize = function(id, key) {
      .self$id <- id
      .self$key <- key
    },
    get = function(path = "listings", limit = 500, ...) {
      
      # Make several api calls due to pagination
      if (limit > .call_limit) {
        
        # Setup temporary variables
        t <- limit; stp <- 0; data <- NULL
        
        # Get 500 obs. per call, until limit has been reached
        while (stp < 1 && t > 0) {
          d <- .self$get(..., limit = pmin(t, .call_limit), offset = limit - t)
          if (!is.null(d)) {
            data <- if (limit == t) d else rbind.fill(data, d)
            t <- t - .call_limit
          } else stp <- 1
        }
        
      # If less than max limit, call api for data
      } else {
        
        # Set up variables
        time <- as.integer(Sys.time())
        unique <- tolower(paste(sample(c(1:9, LETTERS), 16), collapse = ""))
        
        # Create hash with Python
        python.exec('from hashlib import sha1')
        python.exec(sprintf('hashstr = sha1("%s"+"%s"+"%s"+"%s").hexdigest()', .self$id, time, .self$key, unique))
        hash <- python.get('hashstr')
        
        # Prepare url
        url <- modify_url(url = "http://api.booli.se", path = path, query = list(
          callerId = .self$id,
          unique = unique,
          hash = hash,
          time = time,
          limit = limit,
          ...
        ))
        
        # Query data
        res <- GET(url)
        stop_for_status(res)
        data <- content(res)[[path]]
        
        # Fix data structure
        if (length(data) > 0) {
          data <- list_to_table(data, stringsAsFactors = F)
          data <- fix_data(data)
        } else {
          return(NULL)
        }
      }
      return(data)
    }
  )
)
