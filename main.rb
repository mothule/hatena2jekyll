# frozen_string_literal: true

require 'rubygems'
require 'bundler/setup'
require 'active_support/all'
require 'reverse_markdown'
require_relative 'article'
require_relative 'pipes/pipe'
Dir.glob('./pipes/*.rb') { |f| require_relative f }

p 'start'

articles = Article.imports_from_file(path: 'movable_type_blog.txt')

Pipe::DateFilter.new(articles: articles).invoke
Pipe::PublishStatusFilter.new(articles: articles).invoke
Pipe::HatenaKeywordsRemover.new(articles: articles).invoke
Pipe::IframeRemover.new(articles: articles).invoke
Pipe::CiteRemover.new(articles: articles).invoke
Pipe::FigureRemover.new(articles: articles).invoke
Pipe::HighlightSanitizer.new(articles: articles).invoke
Pipe::CategorySanitizer.new(articles: articles).invoke

# convert to markdown from html
articles.each do |article|
  article.body = ReverseMarkdown.convert article.body,
                                         github_flavored: true,
                                         unknown_tags: :raise
end

articles.each(&:export_to_markdown)
