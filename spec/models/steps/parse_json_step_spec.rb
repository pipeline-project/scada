require 'rails_helper'

describe Steps::ParseJsonStep do
  it "returns the arguments unchanged" do
    expect(parse_json_step.perform_one('{ "x": 1 }')).to eq "x" => 1
  end

  def parse_json_step
    described_class.new
  end
end
