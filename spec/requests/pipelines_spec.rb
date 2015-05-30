require 'rails_helper'

RSpec.describe "Pipelines", type: :request do
  describe "GET /pipelines" do
    xit "works! (now write some real specs)" do
      get pipelines_path
      expect(response).to have_http_status(200)
    end
  end
end
