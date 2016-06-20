class SearchService
  attr_reader :query, :category, :result

  def initialize(query, category)
    @query = query
    @category = category
    @result = search
  end

  private
  def search
    search_type.search(escaped_query)
  end

  def escaped_query
    Riddle::Query.escape(query)
  end

  def search_type
    category ? category.capitalize.constantize : ThinkingSphinx
  end
end
