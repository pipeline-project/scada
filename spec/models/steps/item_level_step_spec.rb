require 'rails_helper'

describe Steps::ItemLevelStep do
  it "steps down a level in a hash" do
    expect(item_level_step(:a).perform_one(a: [1, 2, 3]).to_a).to match_array [1, 2, 3]
  end

  it "steps down a level in an object" do
    expect(item_level_step(:a).perform_one(OpenStruct.new(a: [1, 2, 3])).to_a).to match_array [1, 2, 3]
  end

  def item_level_step(level)
    described_class.new level: level
  end
end
