module Pipe
  class CiteRemover
    include Pipe

    def invoke
      articles.each do |article|
        pattern = %r{<cite.*>(.*)</cite>}i
        article.body.gsub!(pattern, Regexp.last_match(1)) if article.body =~ pattern
      end
    end
  end
end