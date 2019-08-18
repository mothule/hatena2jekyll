# frozen_string_literal: true

module Pipe
  class HighlightSanitizer
    include Pipe

    def invoke
      # Add brush class for code highlight
      articles.each do |article|
        pattern = /<pre class="code [\w|-]*" data-lang="(\w*)" data-unlink>/i
        article.body.gsub!(%r{</pre>}, "</pre>\n")
        article.body.gsub!(pattern) { "<pre class=\"brush: #{Regexp.last_match(1)};\">" }
      end
    end
  end
end
