require 'rails_helper'

describe Steps::ItemLevelStep do
  it "steps down a level in a hash" do
    m = Message.wrap(a: [1, 2, 3])
    expect(item_level_step(:a).perform_one(m).map(&:payload)).to match_array [1, 2, 3]
  end

  it "steps down a level in an object" do
    m = Message.wrap(OpenStruct.new(a: [1, 2, 3]))
    expect(item_level_step(:a).perform_one(m).map(&:payload)).to match_array [1, 2, 3]
  end

  def item_level_step(level)
    described_class.new level: level
  end
end
