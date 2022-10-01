require 'string/similarity'
require 'stemmify'

module ActivitiesHelper
  MAX_ALLOWED_DISTANCE_RATIO = 0.6

  """
    Generates all of the prefixes of the current query, calculates the similarity between each prefix
    and the latest added query, and returns true if the max similarity is more than allowed.
  """
  def check_if_similar(current_query, processed_latest_query)
    processed_current_query = process_query(current_query)
    return calculate_distance_ratio(processed_current_query, processed_latest_query) < MAX_ALLOWED_DISTANCE_RATIO
  end

  """
    We calculate the lavenshtein distance between the current prefix and the latest query, 
    to determine the similarity between them.
  """
  def calculate_distance_ratio(current_query, latest_query)
    String::Similarity.levenshtein_distance(latest_query, current_query) / [current_query.length.to_f, latest_query.length.to_f].max
  end

  """
    Convertes query to downcase, removes non-alphanumeric characters, removes stop words, and stems the query.
  """
  def process_query(query)
    stemm(filter_stopwords(query.downcase.gsub(/[^a-z0-9\s]/i, '')))
  end

  """
    This removes the stopwords from the query.
    Read more: https://github.com/brenes/stopwords-filter
  """
  def filter_stopwords(query)
    filter = Stopwords::Snowball::Filter.new "en"
    filter.filter(query.split(' ')).join(' ')
  end

  """
    The Porter stemming algorithm (or Porter stemmer) is a process for removing the commoner morphological and 
    inflexional endings from words in English. Its main use is as part of a term normalisation process that is 
    usually done when setting up Information Retrieval systems.

    Read more: https://github.com/raypereda/stemmify
  """
  def stemm(query)
    query.split(' ').map{|word| word.stem}.join(' ')
  end

end
