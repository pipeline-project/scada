require 'rails_helper'

RSpec.describe "pipelines/new", type: :view do
  before(:each) do
    assign(:pipeline, Pipeline.new(
                        name: "MyString",
                        description: "MyText",
                        steps: "MyText"
    ))
  end

  it "renders new pipeline form" do
    render

    assert_select "form[action=?][method=?]", pipelines_path, "post" do
      assert_select "input#pipeline_name[name=?]", "pipeline[name]"

      assert_select "textarea#pipeline_description[name=?]", "pipeline[description]"

      assert_select "textarea#pipeline_steps[name=?]", "pipeline[steps]"
    end
  end
end
