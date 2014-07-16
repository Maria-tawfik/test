require 'rails_helper'

RSpec.describe "Users", :type => :request do
   subject {page}
  describe "GET /users" do
 
  describe "Users page" do
  	   it "Sign up" do

  		   visit signup_path
  		   page.should have_content ('Sign up')
  	    end

    
  	   it "should have  title" do

  		   visit signup_path
  		   expect(page).to have_title('Sign up')
  		   page.should have_selector('h1','Sign up')
  	     end
        

     end
 end
 describe "profile page" do
  let (:user) {FactoryGirl.create(:user)}
  before {visit user_path(user.id)}
it {should have_selector('h1', text: user.name)}
it "should have correct title" do
  expect(page).to have_title(user.name)
end
 end



 describe "sign up page" do
    before { visit signup_path }
    let(:submit) {"Create my account"}
    describe "with invalid info" do
        it "should not create a user" do
          expect{ click_button  submit }.not_to change(User, :count)
    
    end 
end
 describe "with valid info" do
  before do
          old_count = User.count
          within("form#new_user") do
           fill_in "Name",   with: "Example User"
           fill_in "Email",   with: "user@example.com"
           fill_in "Password",   with: "mariasamy"
           fill_in "Confirmation",   with: "mariasamy"
         end
  end
        it "should  create a user" do
           expect{click_button submit}.to change(User, :count).by(1)
     end 
     describe "after saving a user" do
      before { click_button submit}
      let(:user) {User.find_by_email("user@example.com")}
    it  { expect(page).to have_title(user.name)}
end 
end
end
end
