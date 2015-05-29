require 'rails_helper'

RSpec.describe "pipelines/show", type: :view do
  before(:each) do
    @pipeline = assign(:pipeline, Pipeline.create!(
      :name => "Name",
      :description => "MyText",
      :steps => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
  end
end
