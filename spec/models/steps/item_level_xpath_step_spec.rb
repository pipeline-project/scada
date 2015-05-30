require 'rails_helper'

describe Steps::ItemLevelXpathStep do
  it "extracts elements that match a given xpath" do
    xml = '<a><b>1</b><b>2</b></a>'
    expect(item_level_xpath_step("//b").perform_one(xml).length).to eq 2
  end

  def item_level_xpath_step(xpath)
    described_class.new xpath: xpath
  end
end
