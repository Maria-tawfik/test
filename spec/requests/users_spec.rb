require 'rails_helper'

RSpec.describe "Users", :type => :request do
  describe "GET /users" do
 
  describe "Users page" do
  	   it "Sign up" do

  		   visit users_path
  		   page.should have_content ('Sign up')
  	    end

    
  	   it "should have  title" do

  		   visit signup_path
  		   expect(page).to have_title('Sign up')
  		   page.should have_selector('h1','Sign up')
  	     end
        

     end
 end
 
end
