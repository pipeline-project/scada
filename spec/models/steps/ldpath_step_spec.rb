require 'rails_helper'

describe Steps::LdpathStep do
  let(:program) do
    str = <<-EOF
      url = . :: xsd:string ;
    EOF
    str.strip
  end

  let(:message) do
    Message.wrap('https://google.com/')
  end

  it 'enriches linked data resources using an ldpath program' do
    expect(ldpath_mapper(program).perform_one(message)).to include 'url' => ['https://google.com/']
  end

  def ldpath_mapper(program)
    described_class.new program: program
  end
end
