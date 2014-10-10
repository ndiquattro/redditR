#' Post Reddit API function
#'
#' Simple helper function to use any API function requring a POST method
#' @param url URL of the API function
#' @param params A list of parameters to feed the API function
#' @param token oAuth token created by \code{\link{reddit_login()}} function
#' @return Json object
#' @note See \url{http://www.reddit.com/dev/api/} for list of functions and required paramters for each API function
#' @examples
#' # Post a comment to a thread
#' api_url <- "https://oauth.reddit.com/api/comment"
#' plist   <- list(text = "Hi Mom", thing_id = "t3_2is85o", api_type = "json")
#'
#' post_api(url = api_url, params = plist, token = rtoken)
#' @export

post_api <- function(url, params, token) {
  httr::POST(url,
             body = params,
             add_headers(Authorization = paste("bearer", token, sep = " ")))
}
