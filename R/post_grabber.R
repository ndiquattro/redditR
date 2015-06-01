#' Grab Posts
#'
#' Grabs posts and post information from a sub-reddit or the main page.
#' @param url link to frontpage ("http://www.reddit.com/") or a subreddit ("http://www.reddit.com/r/nfl).
#' @param nmult Multipler applied to number of posts to grab (for 500 posts: nmult = 5, pnum = 100)
#' @note You can only grab up to the 1,000 most recent posts.
#' @export

post_grabber <- function(url, nmult = 1, pnum = 100) {
  # Initiate placeholders
  afterval <- NA
  results <- list()

  # Loop through the multiplier
  for (i in 1:nmult) {
    # Grab a set of posts based on pnum
    if (is.na(afterval)) {
      raw <- jsonlite::fromJSON(paste0(url, '.json?limit=', pnum))
    } else {
      raw <- jsonlite::fromJSON(paste0(url, '.json?limit=', pnum, '&after=',
                                       afterval))
    }

    # Parse current set of posts and save into list
    results[[i]] <- dplyr::select(raw$data$children$data, title, id, author,
                                  subreddit, subreddit_id, ups, downs,
                                  num_comments, created_utc, url)

    # Save after comment to get the next set without overlap
    afterval <- raw$data$after

    # Wait to avoid making reddit angry
    Sys.sleep(2.1)
  }

  # Bind the list into one data.frame and return
  return(dplyr::bind_rows(results))
}
