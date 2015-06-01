# Test Script
library(redditR)
library(dplyr)
library(ggplot2)
# Set codes
client <- '0JwI1aJyiAGQ8w'
secret <- 't0EhztPdn67M3q_v7_py-x1wTtE'

# login
token <- login_reddit('box_plot', 'i!12G8qRAQH%mO1Rr1Pq', client, secret)

# Analyze
df <- post_grabber('http://www.reddit.com/r/nfl/', 10)

ggplot(df, aes(ups, num_comments)) +
  geom_point()+
  geom_smooth(method=lm)+
  facet_wrap(~subreddit)

# Comments vs. upvotes
votes <- df %>%
          mutate(
            part = ups - num_comments
          ) %>%
          group_by(subreddit) %>%
          summarise(
            mpart = mean(part)
          ) %>%
          arrange(mpart)

ggplot(votes, aes(subreddit, mpart))+
    geom_bar(stat = 'identity')
