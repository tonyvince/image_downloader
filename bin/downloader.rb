#!/usr/bin/env ruby

require_relative '../lib/url_extractor'
require_relative '../lib/image_downloader'

begin
  puts "Please enter the file name: "
  file_name = gets.chomp

  urls = UrlExtractor.new(file_name).extract_urls
  if urls.empty?
    puts "No URLs found in the file."
  else
    puts "URLs found in the file:"
    urls.each { |url| puts url }
    puts "Starting to download images..."
    ImageDownloader.download_images(urls)
    puts "Download finished."
  end
rescue StandardError => e
  puts "An error occurred: #{e.message}"
end
