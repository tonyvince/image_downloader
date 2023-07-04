require 'open-uri'
require 'net/http'

class ImageDownloader
  def self.download_images(urls, target_dir = "./images")
    Dir.mkdir(target_dir) unless File.exist?(target_dir)

    threads = urls.map do |url|
      Thread.new do
        begin
          uri = URI.parse(url)
          http = Net::HTTP.new(uri.host, uri.port)
          http.use_ssl = true if uri.scheme == 'https'
          head_response = http.request_head(uri.path)

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

    threads.each(&:join) # Wait for all threads to finish
  end
end
