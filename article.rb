# frozen_string_literal: true

class Article
  attr_accessor :author,
                :title,
                :basename,
                :status,
                :allow_comments,
                :convert_breaks,
                :date,
                :categories,
                :image,
                :body,
                :comments

  class << self
    def imports_from_file(path:)
      puts 'Importing from movable typed text.'

      [].tap do |articles|
        File.open(path, 'r') do |file|
          article = Article.new
          file.each_line do |line|
            next unless article.parse(line)

            articles << article
            article = Article.new
          end
        end
        puts "Article count: #{articles.count}"
      end
    end

  end

  def export_to_markdown
    file_path = "./_posts/#{file_name}"
    File.open(file_path, 'w') do |f|
      f.puts('---')
      f.puts("title: #{title}")
      f.puts("description: #{title}")
      f.puts("date: #{date.strftime('%Y-%m-%d')}")
      if categories
        f.puts("categories: #{categories.join(' ')}")
        f.puts("tags: #{categories.join(' ')}")
      end
      if image
        f.puts('image:')
        f.puts("  path: #{image}")
      end
      f.puts('draft: true')
      f.puts('---')
      f.puts(body)
    end
  end

  def parse(line)
    if @block_in
      if /^-----$/i.match?(line)
        block_line # end block
      elsif line =~ /body:/i
        @body_block = true
      else

        append_block_buffer(line)
      end

    else

      case line
      when /author: (.*)/i then self.author = Regexp.last_match(1)
      when /title: (.*)/i then self.title = Regexp.last_match(1)
      when /basename: (.*)/i then self.basename = Regexp.last_match(1)
      when /status: (.*)/i then self.status = Regexp.last_match(1)
      when /allow comments: (.*)/i then self.allow_comments = Regexp.last_match(1)
      when /convert breaks: (.*)/i then self.convert_breaks = Regexp.last_match(1)
      when /date: (.*)/i then self.date = DateTime.strptime(Regexp.last_match(1), '%m/%d/%Y %H:%M:%s')
      when /image: (.*)/i then self.image = Regexp.last_match(1)
      when /category: (.*)/i then append_category(Regexp.last_match(1))
      when /^-----$/i then block_line # begin block
      when /^--------$/ then return true
      end
    end

    false
  end

  def to_s
    "#{date} #{categories&.first} #{title} #{basename} #{status} #{allow_comments} #{convert_breaks} #{image} #{body}"
  end

  def file_name
    "#{date.strftime('%Y-%m-%d')}-#{basename.tr('/', '-')}.md"
  end

  private

  def append_category(category)
    self.categories = [] if categories.nil?
    categories << category
  end

  def block_line
    if @block_in
      @block_in = false

      if @body_block
        self.body = @block_buffer.join("\n")
        @body_block = false
      end

      @block_buffer = nil

    else
      @block_in = true

    end
  end

  def append_block_buffer(line)
    @block_buffer = [] if @block_buffer.nil?
    @block_buffer << line
  end
end
