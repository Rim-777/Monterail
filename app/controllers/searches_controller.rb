class SearchesController < ApplicationController
  before_action :init_search, only: :search
  respond_to :json

  def search
    @result = @search.result
    respond_with (@result)
  end

  private
  def init_search
    @search = SearchService.new(query, category)
  end

  def query
    params[:query]
  end

  def category
    params[:category]
  end
end
