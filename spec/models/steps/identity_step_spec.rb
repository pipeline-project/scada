require 'rails_helper'

describe Steps::IdentityStep do
  it "returns the arguments unchanged" do
    m = Message.wrap('x')
    expect(identity_data_source.perform_one(m)).to eq m
  end

  def identity_data_source
    described_class.new
  end
end
