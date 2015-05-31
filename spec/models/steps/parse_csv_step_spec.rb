require 'rails_helper'

describe Steps::ParseCsvStep do
  let(:data) do
    data = <<-EOF
a,b,c
1,2,3
2,3,4
    EOF

    data.strip
  end
  it "returns the arguments unchanged" do
    actual = parse_csv_step.perform_one(data).to_a
    expect(actual.length).to eq 2
    expect(actual).to include 'a' => '1', 'b' => '2', 'c' => '3'
    expect(actual).to include 'a' => '2', 'b' => '3', 'c' => '4'
  end

  def parse_csv_step
    described_class.new
  end
end
