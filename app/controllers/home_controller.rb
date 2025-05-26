class HomeController < ApplicationController
  helper ArticlesHelper
  def index
    @featured_articles = ReliefWebService.fetch_articles(3)
  end
  def home
    @disable_main_padding = true
  end
end
