require 'rails_helper'

RSpec.describe "PostPages", :type => :request do
  describe "GET /post_pages" do
  	 subject {page}

  	 let(:user) {FactoryGirl.create(:user)}
  	 before {sign_in user}
  	 describe "post creation" do
  	 	before {visit root_path}

  	 	describe "with invalid info " do
  	 		it "should not create a post" do
  	 			expect{click_button "Post"}.not_to change(Post, :count)
  	 		end
  	 		
  	 		describe "error messages" do
  	 			before {click_button "Post"}
  	 			it {should have_content('')}
  	 		end
  	 	end
  	end


  end
end
