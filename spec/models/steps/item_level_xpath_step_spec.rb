require 'rails_helper'

describe Steps::ItemLevelXpathStep do
  it "extracts elements that match a given xpath" do
    m = Message.wrap('<a><b>1</b><b>2</b></a>')
    expect(item_level_xpath_step("//b").perform_one(m).to_a.length).to eq 2
  end

  def item_level_xpath_step(xpath)
    described_class.new xpath: xpath
  end
end
