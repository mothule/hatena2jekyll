# frozen_string_literal: true

module Pipe
  class CategorySanitizer
    include Pipe

    def invoke
      articles.each do |article|
        next if article.categories.blank?

        article.categories = article.categories.map do |category|
          case category
          when 'ひらがな' then 'ruby'
          when 'aiueo' then 'rails'
          else category.downcase
          end
        end
      end
    end
  end
end
