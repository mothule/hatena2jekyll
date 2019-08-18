module Pipe
  class PublishStatusFilter
    include Pipe

    def invoke
      puts 'Filtering by publish status'
      articles.filter! do |article|
        article.status == 'Publish'
      end
    end
  end
end