![CI](https://github.com/tonyvince/image_downloader/actions/workflows/ci.yml/badge.svg)
# Image Downloader

Image Downloader is a command-line tool that downloads images from a list of URLs provided in a plain text file. The tool parses the file, extracts the URLs, validates if the URLs point to an image, and downloads the images to a local directory. The tool also handles any invalid URLs and skips them without terminating the program.

## Requirements

- Ruby version 3.2.2

## Dependencies

- pry
- rspec
- webmock

All dependencies can be installed via Bundler. If you don't have Bundler installed, you can install it with `gem install bundler`. After that, you can install the dependencies with `bundle install`.

## How to run the program

1. Clone this repository.
2. Navigate to the project directory in the terminal.
3. Install the dependencies with `bundle install`.
4. Run the program with `bin/downloader.rb`.

## How to run the tests

1. Navigate to the project directory in the terminal.
2. Run the tests with `bundle exec rspec`.

## Structure of the project

The project is organized into several directories:

- `bin/`: Contains the executable script that runs the program.
- `lib/`: Contains the core classes of the application: `UrlExtractor` and `ImageDownloader`.
- `spec/`: Contains the test files for the application.
