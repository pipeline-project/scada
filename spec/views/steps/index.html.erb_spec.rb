require 'rails_helper'

RSpec.describe "steps/index", type: :view do
  before(:each) do
    assign(:steps, [
      Step.create!(
        name: "Name",
        type: "Type",
        options: "MyText",
        pipeline: nil
      ),
      Step.create!(
        name: "Name",
        type: "Type",
        options: "MyText",
        pipeline: nil
      )
    ])
  end

  it "renders a list of steps" do
    render
    assert_select "tr>td", text: "Name".to_s, count: 2
    assert_select "tr>td", text: "Type".to_s, count: 2
    assert_select "tr>td", text: "MyText".to_s, count: 2
    assert_select "tr>td", text: nil.to_s, count: 2
  end
end
