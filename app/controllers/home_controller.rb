class HomeController < ApplicationController
  helper ArticlesHelper
  def index
    @featured_articles = ReliefWebService.fetch_articles(3)
  end
end
