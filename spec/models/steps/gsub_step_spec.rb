require 'rails_helper'

describe Steps::GsubStep do
  it "returns the arguments unchanged" do
    expect(gsub_step('x', 'y').perform_one(Message.wrap('xy')).payload).to eq 'yy'
  end

  def gsub_step(pattern, replacement)
    described_class.new pattern: pattern, replacement: replacement
  end
end
