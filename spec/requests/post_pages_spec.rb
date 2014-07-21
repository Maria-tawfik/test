require 'rails_helper'

RSpec.describe "PostPages", :type => :request do
  describe "GET /post_pages" do
    it "works! (now write some real specs)" do
      get post_pages_index_path
      expect(response.status).to be(200)
    end
  end
end
