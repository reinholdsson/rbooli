#' Query Booli API
#' 
#' Returns a data frame with Booli data
#' 
#' @param callerId caller id
#' @param key private api key
#' @param ... arguments passed on to the http get request;
#' for possible parameters, see http://www.booli.se/api/
#' 
#' @examples \dontrun{
#' a <- booli("YOUR_CALLERID", "YOUR_APIKEY")
#' listings <- a$get(path = "listings", q = "nacka", limit = 5, offset = 0)
#' sold <- a$get(path = "sold", q = "nacka", limit = 5, offset = 0)
#' }
#' 
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
    get = function(path = "listings", ...) {
      # Set up variables
      time <- as.integer(Sys.time())
      unique <- tolower(paste(sample(c(1:9, LETTERS), 16), collapse = ""))
      
      # Create hash with Python
      python.exec('from hashlib import sha1')
      python.exec(sprintf('hashstr = sha1("%s"+"%s"+"%s"+"%s").hexdigest()', .self$id, time, .self$key, unique))
      hash <- python.get('hashstr')
      
      # Query data
      url <- modify_url(url = "http://api.booli.se", path = path, query = list(
        callerId = .self$id,
        unique = unique,
        hash = hash,
        time = time,
        ...
      ))
      res <- content(GET(url))[[path]]
      
      # Fix data structure
      res <- list_to_table(res, stringsAsFactors = F)
      res <- fix_data(res)
      
      return(res)
    }
  )
)
