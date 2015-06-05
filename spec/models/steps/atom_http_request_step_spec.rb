require 'rails_helper'
require "hurley/test"

describe Steps::AtomHttpRequestStep do
  let(:feed) do
    str = <<-EOF
    <?xml version="1.0" encoding="utf-8"?>
    <feed xmlns="http://www.w3.org/2005/Atom">
     <title>Example Feed</title>
     <link href="http://example.org/"/>
     <link rel="self" href="http://example.org/index.atom"/>
     <link rel="next" href="http://example.org/page2.atom"/>
     <updated>2003-12-13T18:30:02Z</updated>
     <author>
       <name>John Doe</name>
     </author>
     <id>urn:uuid:60a76c80-d399-11d9-b93C-0003939e0af6</id>
     <entry>
       <title>Atom-Powered Robots Run Amok</title>
       <link href="http://example.org/2003/12/13/atom03"/>
       <id>urn:uuid:1225c695-cfb8-4ebb-aaaa-80da344efa6a</id>
       <updated>2003-12-13T18:30:02Z</updated>
       <summary>Some text.</summary>
     </entry>
    </feed>
    EOF
    str.strip
  end
  let(:test_connection) do
    Hurley::Test.new do |test|
      test.get "http://example.org/index.atom" do |_req|
        [200, {}, feed]
      end

      test.get "http://example.org/page2.atom" do |_req|
        [200, { "Link" => '<http://example.com/c>; rel="next"' }, "b"]
      end

      test.get "http://example.com/c" do |_req|
        [200, {}, "c"]
      end
    end
  end

  it "follows link[rel=next] HTTP headers and links" do
    expect do |b|
      atom_http_data_source.perform_one(Message.wrap("http://example.org/index.atom"), &b)
    end.to yield_successive_args Message, Message, Message
  end

  def atom_http_data_source
    d = described_class.new
    d.send(:http_client).connection = test_connection
    d
  end
end