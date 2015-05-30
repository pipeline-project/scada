require 'rails_helper'

RSpec.describe "steps/new", type: :view do
  before(:each) do
    assign(:step, Step.new(
                    name: "MyString",
                    type: "",
                    options: "MyText",
                    pipeline: nil
    ))
  end

  it "renders new step form" do
    render

    assert_select "form[action=?][method=?]", steps_path, "post" do
      assert_select "input#step_name[name=?]", "step[name]"

      assert_select "input#step_type[name=?]", "step[type]"

      assert_select "textarea#step_options[name=?]", "step[options]"

      assert_select "input#step_pipeline_id[name=?]", "step[pipeline_id]"
    end
  end
end
