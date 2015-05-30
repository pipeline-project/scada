require 'rails_helper'

RSpec.describe "pipelines/index", type: :view do
  before(:each) do
    assign(:pipelines, [
      create(:pipeline),
      create(:pipeline)
    ])
    
    allow(view).to receive(:can?).and_return(true)
  end

  it "renders a list of pipelines" do
    render
    assert_select "tr>td", text: "Name".to_s, count: 2
  end
end
