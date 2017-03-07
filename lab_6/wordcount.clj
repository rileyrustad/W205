(ns tweetcount
  (:use     [streamparse.specs])
  (:gen-class))

(defn tweetcount [options]
   [
    ;; spout configuration
    {"word-spout" (python-spout-spec
          options
          "spouts.sentences.Sentences"
          ["word"]
          )
    }
    ;; Bolts
    {
     ;; bolt configuration 1
        "parse-tweet" (python-bolt-spec
          options
          {"word-spout" :shuffle}
          "bolts.parse.ParseTweet"
          ["word"]
          :p 2
          )
     ;; bolt configuration 2
        "tweet-counter" (python-bolt-spec
          options
          {"parse-tweet" :shuffle}
          "bolts.tweetcounter.TweetCounter"
          ["word" "count"]
          :p 2
          )
    }
  ]
)

