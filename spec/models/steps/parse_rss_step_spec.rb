require 'rails_helper'

describe Steps::ParseRssStep do
  let(:data) do
    data = <<-EOF
    <?xml version="1.0" encoding="utf-8"?>
    <feed xmlns="http://www.w3.org/2005/Atom">
     <title>Chris Beer</title>
     <link href="http://blog.cbeer.info/atom.xml" rel="self"/>
     <link href="http://cbeer.info/"/>
     <updated>2015-03-09T00:59:03+00:00</updated>
     <id>http://cbeer.info/</id>
     <author>
       <name>Chris Beer</name>
       <email>chris@cbeer.info</email>
     </author>

     <entry>
       <title>LDPath in 3 examples</title>
       <link href="http://blog.cbeer.info/2015/ldpath/"/>
       <updated>2015-03-08T00:00:00+00:00</updated>
       <id>http://blog.cbeer.info/2015/ldpath</id>
       <content type="html"></content>
     </entry>
    </feed>
    EOF

    Message.wrap(data.strip)
  end
  it "returns the arguments unchanged" do
    actual = parse_rss_step.perform_one(data).map(&:payload)
    expect(actual.length).to eq 1
    expect(actual.first.title.content).to eq 'LDPath in 3 examples'
  end

  def parse_rss_step
    described_class.new
  end
end
