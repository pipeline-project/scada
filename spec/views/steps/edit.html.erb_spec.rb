require 'rails_helper'

RSpec.describe "steps/edit", type: :view do
  before(:each) do
    @step = assign(:step, Step.create!(
                            name: "MyString",
                            type: "",
                            options: "MyText",
                            pipeline: nil
    ))
  end

  it "renders the edit step form" do
    render

    assert_select "form[action=?][method=?]", step_path(@step), "post" do
      assert_select "input#step_name[name=?]", "step[name]"

      assert_select "select#step_type[name=?]", "step[type]"
    end
  end
end
