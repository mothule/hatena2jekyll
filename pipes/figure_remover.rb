# frozen_string_literal: true

module Pipe
  class FigureRemover
    include Pipe

    def invoke
      articles.each do |article|
        pattern = %r{<figure.*>(.*)</figure>}i
        article.body.gsub!(pattern, Regexp.last_match(1)) if article.body =~ pattern
      end
    end
  end
end
