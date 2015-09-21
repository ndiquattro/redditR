# Test Script
library(redditR)
library(dplyr)
library(ggplot2)

# Analyze
df <- post_grabber('http://www.reddit.com/', 10)

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
