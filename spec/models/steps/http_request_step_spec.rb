require 'rails_helper'
require "hurley/test"

describe Steps::HttpRequestStep do
  let(:test_connection) do
    Hurley::Test.new do |test|
      test.get "http://example.com/a" do |_req|
        [200, {}, "a"]
      end

      test.get "http://example.com/b" do |_req|
        [200, { "Link" => '<http://example.com/c>; rel="next"' }, "b"]
      end

      test.get "http://example.com/c" do |_req|
        [200, {}, "c"]
      end
    end
  end

  it "retrieves the content at an address" do
    expect { |b| http_data_source.perform_one(Message.wrap("http://example.com/a"), &b) }.to yield_with_args Message
  end

  it "follows link[rel=next] HTTP headers" do
    expect do |b|
      http_data_source.perform_one(Message.wrap("http://example.com/b"), &b)
    end.to yield_successive_args Message, Message
  end

  def http_data_source
    d = described_class.new
    d.send(:http_client).connection = test_connection
    d
  end
end
