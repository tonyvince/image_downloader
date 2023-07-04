require 'uri'

class UrlExtractor
  attr_reader :file_name

  def initialize(file_name)
    @file_name = file_name
    raise "File not found. Please make sure you entered the correct file name." unless File.exist?(file_name)
  end

  def extract_urls
    file_content = File.read(file_name)
    URI.extract(file_content, ['http', 'https'])
  end
end
