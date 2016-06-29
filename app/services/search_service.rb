class SearchService
  attr_reader :query, :category, :result

  def initialize(query, category)
    @query = query
    @category = category
    @result = search
  end

  private
  def search
    search_type.search escaped_query,  :max_matches => 100_000, :per_page => 100000
  end

  def escaped_query
    Riddle::Query.escape(query.to_s)
  end

  def search_type
    category ? category.capitalize.constantize : ThinkingSphinx
  end
end
