require 'rails_helper'

RSpec.describe "steps/index", type: :view do
  before(:each) do
    assign(:steps, [
      create(:step),
      create(:step)
    ])

    allow(view).to receive(:can?).and_return(true)
  end

  it "renders a list of steps" do
    render
    assert_select "tr>td", text: "Step Name".to_s, count: 2
  end
end
