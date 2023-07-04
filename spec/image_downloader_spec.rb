require 'webmock/rspec'
require_relative '../lib/image_downloader'

RSpec.describe ImageDownloader do
  let(:file_name) { 'test.txt' }
  let(:url1) { 'http://example.com/image1.jpg' }
  let(:url2) { 'http://example.com/not_image.txt' }
  let(:image_data) { 'fake image data' }

  subject { described_class.new(file_name) }

  before do
    File.open(file_name, 'w') { |file| file.write("#{url1} #{url2}") }
    stub_request(:head, url1).to_return(headers: { 'Content-Type' => 'image/jpeg' })
    stub_request(:head, url2).to_return(headers: { 'Content-Type' => 'text/plain' })
    stub_request(:get, url1).to_return(body: image_data, status: 200)
  end

  after do
    File.delete(file_name)
    Dir['./images/*'].each { |file| File.delete(file) }
    Dir.delete('./images') if Dir.exist?('./images')
  end

  describe '#extract_urls' do
    it 'extracts URLs from the file content' do
      expect(subject.extract_urls).to eq([url1, url2])
    end
  end

  describe '#download_images' do
    it 'downloads images from URLs' do
      subject.download_images(subject.extract_urls)

      expect(File.exist?("./images/image1.jpg")).to eq(true)
      expect(File.read("./images/image1.jpg")).to eq(image_data)
      expect(File.exist?("./images/not_image.txt")).to eq(false)
    end
  end
end
