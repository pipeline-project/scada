require 'rails_helper'

RSpec.describe "pipelines/index", type: :view do
  before(:each) do
    assign(:pipelines, Kaminari.paginate_array([
      create(:pipeline),
      create(:pipeline)
    ]).page(1))

    allow(view).to receive(:can?).and_return(true)
  end

  it "renders a list of pipelines" do
    render
    assert_select ".pipeline", count: 2
  end
end
