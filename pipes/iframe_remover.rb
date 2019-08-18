module Pipe
  class IframeRemover
    include Pipe

    def invoke
      articles.each do |article|
        pattern = %r{<iframe.*>.*</iframe>}i
        article.body.gsub!(pattern, '')
      end
    end
  end
end