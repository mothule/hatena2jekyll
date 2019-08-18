# frozen_string_literal: true

module Pipe
  class HighlightSanitizer
    include Pipe

    def invoke
      # Add brush class for code highlight
      articles.each do |article|
        pattern = /<pre class="code [\w|-]*" data-lang="(\w*)" data-unlink>/i
        article.body.gsub!(%r{</pre>}, "</code></pre>\n")
        lang = Regexp.last_match(1)
        article.body.gsub!(pattern) { "<pre class=\"brush: #{lang};\"><code>" }
        article.body.gsub!(%r{</code></pre>\n}, '</code></pre>')
      end
    end
  end
end
