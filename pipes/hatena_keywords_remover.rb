# frozen_string_literal: true

module Pipe
  # remove hatena keyword links, because no necessary
  class HatenaKeywordsRemover
    include Pipe

    def invoke
      collect_keywords.each do |keyword|
        articles.each do |article|
          pattern = %r{<a class="keyword" href="http://d.hatena\.ne\.jp/keyword/#{keyword.first}">#{keyword.last}</a>}
          article.body.gsub!(pattern, keyword.last)
        end
      end
    end

    private

    def collect_keywords
      pattern = %r{<a class="keyword" href="http:\/\/d\.hatena\.ne\.jp/keyword/(.*)">(.*)$}
      [].tap do |keywords|
        articles.each do |article|
          # そのままだ複数aタグを跨いでしまうので、
          # 閉じタグ手前で改行して正規表現で`$`指定できるようにする
          article.body
                 .gsub('</a>', "\n</a>")
                 .scan(pattern).each { |keyword| keywords.push keyword }
        end
      end
    end
  end
end
