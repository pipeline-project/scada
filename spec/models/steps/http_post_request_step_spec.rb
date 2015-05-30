require 'rails_helper'
require "hurley/test"

describe Steps::HttpPostRequestStep do
  let(:test_connection) do
    Hurley::Test.new do |test|
      test.post "http://example.com/a" do |req|
        expect(req.body).to eq 'x'
        [201, {}, "a"]
      end
    end
  end

  it "posts the record to the url" do
    expect(http_data_source.perform_one("x")).to be_success
  end

  def http_data_source
    d = described_class.new url: "http://example.com/a"
    d.send(:http_client).connection = test_connection
    d
  end
end
