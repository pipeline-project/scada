require 'rails_helper'

RSpec.describe "pipelines/new", type: :view do
  before(:each) do
    assign(:pipeline, build(:pipeline))

    allow(view).to receive(:can?).and_return(true)
  end

  it "renders new pipeline form" do
    render

    assert_select "form[action=?][method=?]", pipelines_path, "post" do
      assert_select "input#pipeline_name[name=?]", "pipeline[name]"

      assert_select "textarea#pipeline_description[name=?]", "pipeline[description]"
    end
  end
end
