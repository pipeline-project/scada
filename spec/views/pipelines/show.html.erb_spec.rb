require 'rails_helper'

RSpec.describe "pipelines/show", type: :view do
  before(:each) do
    @pipeline = assign(:pipeline, create(:pipeline))
    allow(view).to receive(:can?).and_return(true)
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
  end
end
