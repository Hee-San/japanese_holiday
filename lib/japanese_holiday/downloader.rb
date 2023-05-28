# frozen_string_literal: true

require "httpclient"
require "json"

module JapaneseHoliday
  # Download the CSV file from the Cabinet Office of Japan.
  class Downloader
    BASE_URL = "https://data.e-gov.go.jp/data/api/action/package_show"
    PACKAGE_ID = "cao_20190522_0002"

    def initialize(csv_file_path = "./holidays.csv")
      @client = HTTPClient.new
      @csv_file_path = csv_file_path
    end

    def download
      metadata_response = @client.get(BASE_URL, query: { id: PACKAGE_ID })
      metadata = JSON.parse(metadata_response.body)

      csv_resources = metadata["result"]["resources"].select do |resource|
        resource["format"] == "CSV"
      end
      newest_csv_resource = csv_resources.max_by { |resource| DateTime.parse(resource["created"]) }

      csv_response = @client.get(newest_csv_resource["url"])
      File.write(@csv_file_path, csv_response.body)

      @csv_file_path
    end
  end
end
