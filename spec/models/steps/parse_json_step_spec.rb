require 'rails_helper'

describe Steps::ParseJsonStep do
  it "returns the arguments unchanged" do
    m = Message.wrap('{ "x": 1 }')
    expect(parse_json_step.perform_one(m).payload).to eq "x" => 1
  end

  def parse_json_step
    described_class.new
  end
end
