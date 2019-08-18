# frozen_string_literal: true

require 'rspec'

require 'rubygems'
require 'bundler/setup'
require 'active_support/all'
require 'reverse_markdown'
require_relative '../article'
require_relative '../pipes/pipe'
Dir.glob('../pipes/*.rb') { |f| require_relative f }

describe :Article do

  let!(:path) { './spec/basic_mt.txt' }
  subject { Article.imports_from_file(path: path) }

  describe '.imports_from_file' do
    it { expect(subject.size).to eq 2 }

    it do
      expected_attributes = {
        author: 'unknown_author',
        title: 'あいうえおA',
        basename: 'aiueo-a-title',
        status: 'Publish',
        allow_comments: '1',
        convert_breaks: '0',
        date: subject.first.date,
        image: 'https://cdn.blog.st-hatena.com/images/theme/og-image-1500.png',
        body: "<p>ほげほげ1</p>\n"
      }
      expect(subject.first).to have_attributes(expected_attributes)
    end

    it do
      expected_attributes = {
        author: 'unknown_author',
        title: 'あいうえおB',
        basename: 'aiueo-b-title',
        status: 'Publish',
        allow_comments: '1',
        convert_breaks: '0',
        date: subject.second.date,
        image: 'https://cdn.blog.st-hatena.com/images/theme/og-image-1500.png',
        body: "<p>ほげほげ2</p>\n"

      }
      expect(subject.second).to have_attributes(expected_attributes)
    end
  end
end
