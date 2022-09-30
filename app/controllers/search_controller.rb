# frozen_string_literal: true

class SearchController < ApplicationController
  layout "search"

  def match_all
    query = params[:query]
    render json: Article.where('$text' => {'$search' => query}).to_a
  end
end
