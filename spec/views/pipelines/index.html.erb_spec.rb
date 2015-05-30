require 'rails_helper'

RSpec.describe "pipelines/index", type: :view do
  before(:each) do
    assign(:pipelines, [
      Pipeline.create!(
        name: "Name",
        description: "MyText",
        steps: "MyText"
      ),
      Pipeline.create!(
        name: "Name",
        description: "MyText",
        steps: "MyText"
      )
    ])
  end

  it "renders a list of pipelines" do
    render
    assert_select "tr>td", text: "Name".to_s, count: 2
    assert_select "tr>td", text: "MyText".to_s, count: 2
    assert_select "tr>td", text: "MyText".to_s, count: 2
  end
end
