#' Login to reddit
#'
#' Returns a token needed for API commands that require oauth
#' @param user user name
#' @param pass password for user
#' @param client client ID
#' @param secret secret key
#' @export

login_reddit <- function (user, pass, client, secret) {
  token <- httr::content(
            httr::POST("https://ssl.reddit.com/api/v1/access_token",
                    body = list(
                                grant_type = "password",
                                username = user,
                                password = pass),
                    encode = "form",
                    httr::authenticate(client, secret)
            ))

  return(token$access_token)
}
