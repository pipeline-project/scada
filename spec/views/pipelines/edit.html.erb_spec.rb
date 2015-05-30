require 'rails_helper'

RSpec.describe "pipelines/edit", type: :view do
  before(:each) do
    @pipeline = assign(:pipeline, create(:pipeline))

    allow(view).to receive(:can?).and_return(true)
  end

  it "renders the edit pipeline form" do
    render

    assert_select "form[action=?][method=?]", pipeline_path(@pipeline), "post" do
      assert_select "input#pipeline_name[name=?]", "pipeline[name]"

      assert_select "textarea#pipeline_description[name=?]", "pipeline[description]"
    end
  end
end
