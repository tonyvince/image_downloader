require_relative '../lib/url_extractor'

RSpec.describe UrlExtractor do
  let(:file_name) { 'test.txt' }
  let(:url1) { 'http://example.com/image1.jpg' }
  let(:url2) { 'http://example.com/not_image.txt' }

  subject { described_class.new(file_name) }

  before do
    File.open(file_name, 'w') { |file| file.write("#{url1} bar #{url2} foo") }
  end

  after do
    File.delete(file_name)
  end

  describe '#extract_urls' do
    it 'extracts URLs from the file content' do
      expect(subject.extract_urls).to eq([url1, url2])
    end
  end
end
