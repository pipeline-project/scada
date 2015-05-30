require 'rails_helper'

describe Steps::IdentityStep do
  it "returns the arguments unchanged" do
    expect(identity_data_source.perform_one('x')).to eq 'x'
  end

  def identity_data_source
    described_class.new
  end
end
