require 'rails_helper'

RSpec.describe "steps/show", type: :view do
  before(:each) do
    @step = assign(:step, create(:step))

    allow(view).to receive(:can?).and_return(true)
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Type/)
    expect(rendered).to match(/Options/)
    expect(rendered).to match(/Pipeline/)
  end
end
