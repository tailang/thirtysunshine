#encoding: utf-8
class SearchController < ApplicationController
  def index
    redirect_to "https://www.google.com.hk/search?q=site:www.30dyg.com%20#{params[:q]}"
  end
end
