# frozen_string_literal: true

require "httpclient"
require "json"

module JapaneseHoliday
  # Download the CSV file from the Cabinet Office of Japan.
  class Downloader
    BASE_URL = "https://data.e-gov.go.jp/data/api/action/package_show"
    PACKAGE_ID = "cao_20190522_0002"
    CSV_FILE_PATH = "./holidays.csv"

    def initialize
      @client = HTTPClient.new
    end

    def download
      metadata_response = @client.get(BASE_URL, query: { id: PACKAGE_ID })
      metadata = JSON.parse(metadata_response.body)

      csv_resource = metadata["result"]["resources"].find do |resource|
        resource["format"].upcase == "CSV"
      end

      csv_response = @client.get(csv_resource["url"])
      File.write(CSV_FILE_PATH, csv_response.body)

      CSV_FILE_PATH
    end
  end
end
