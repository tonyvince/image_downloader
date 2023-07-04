#!/usr/bin/env ruby

require_relative '../lib/image_downloader'

begin
  puts "Please enter the file name: "
  file_name = gets.chomp

  downloader = ImageDownloader.new(file_name)
  urls = downloader.extract_urls

  if urls.empty?
    puts "No URLs found in the file."
  else
    puts "URLs found in the file:"
    urls.each { |url| puts url }
    puts "Starting to download images..."
    downloader.download_images(urls)
    puts "Download finished."
  end
rescue StandardError => e
  puts "An error occurred: #{e.message}"
end
