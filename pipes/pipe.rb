module Pipe
  attr_reader :articles

  def initialize(articles:)
    @articles = articles
  end
end
