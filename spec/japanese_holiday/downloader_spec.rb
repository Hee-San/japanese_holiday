# frozen_string_literal: true

require "japanese_holiday/downloader"
require "webmock/rspec"
require "csv"
require "tempfile"

RSpec.describe JapaneseHoliday::Downloader, "#download" do
  let(:tempfile) { Tempfile.new("holidays.csv") }
  let(:downloader) { JapaneseHoliday::Downloader.new(tempfile.path) }

  before do
    stub_request(:get, "https://data.e-gov.go.jp/data/api/action/package_show?id=cao_20190522_0002")
      .to_return(body: File.read("spec/fixtures/package_show_response.json"), status: 200)

    stub_request(:get, "https://example.com/resource.csv")
      .to_return(body: File.read("spec/fixtures/resource.csv"), status: 200)
  end

  it "downloads and saves the csv file correctly" do
    downloader.download
    expect(File.exist?(tempfile.path)).to be true
  end

  it "returns the path to the downloaded csv" do
    expect(downloader.download).to eq(tempfile.path)
  end

  it "creates a csv file with the correct data" do
    downloader.download

    csv_data = CSV.read(tempfile.path)
    expected_csv_data = CSV.read("spec/fixtures/resource.csv")

    expect(csv_data).to eq(expected_csv_data)
  end

  after do
    tempfile.unlink
  end
end
