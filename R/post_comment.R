#' Post comment to thread
#'
#' Posts a top level comment to a reddit thread
#' @param txt Text of comment, formated in markdown
#' @param id id of reddit thread to post to
#' @param token oauth token generated from login_reddit
#' @export

post_comment <- function(txt, id, token) {
  httr::POST("https://oauth.reddit.com/api/comment",
          body = list(
                      text     = txt,
                      thing_id = paste0("t3_", id),
                      api_type = "json"),
          add_headers(Authorization = paste("bearer", token, sep = " ")))
}
