# frozen_string_literal: true

module Pipe
  class DateFilter
    include Pipe

    def invoke
      puts 'Filtering by Date'
      articles.sort_by!(&:date).filter! do |article|
        article.date >= DateTime.strptime('02/12/2013', '%m/%d/%Y')
      end
    end
  end
end
