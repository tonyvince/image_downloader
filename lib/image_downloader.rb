require 'uri'
require 'open-uri'
require 'net/http'
require 'pry'

class ImageDownloader
  attr_reader :file_name

  def initialize(file_name)
    @file_name = file_name
    raise "File not found. Please make sure you entered the correct file name." unless File.exist?(file_name)
  end

  def extract_urls
    file_content = File.read(file_name)
    URI.extract(file_content, ['http', 'https'])
  end

  def download_images(urls, target_dir = "./images")
    Dir.mkdir(target_dir) unless File.exist?(target_dir)

    urls.each do |url|
      begin
        uri = URI.parse(url)
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true if uri.scheme == 'https'
        head_response = http.request_head(uri.path)
        binding.pry
        if head_response["content-type"].start_with? "image/"
          URI.open(url) do |u|
            file_path = "#{target_dir}/#{File.basename(uri.path)}"
            File.open(file_path, 'wb') { |f| f.write(u.read) }
            puts "Downloaded: #{url}"
          end
        else
          puts "#{url} is not an image. Skipping."
        end
      rescue => e
        puts "Error downloading #{url}. Error message: #{e.message}"
      end
    end
  end
end
