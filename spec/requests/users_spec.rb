require 'rails_helper'

RSpec.describe "Users", :type => :request do
  

  describe "GET /users" do

    describe "Users page" do
  	  subject {page}

      describe "index" do
        before do
          sign_in FactoryGirl.create(:user)
          FactoryGirl.create(:user, name: "pop" , email: "pop@example.com")
          FactoryGirl.create(:user, name: "koko" , email: "koko@example.com")
          FactoryGirl.create(:user, name: "mary" , email: "mary@example.com")
          FactoryGirl.create(:user, name: "erini" , email: "erini@example.com")
          FactoryGirl.create(:user, name: "felo" , email: "felo@example.com")
          visit users_path
        end 
        it{expect(page).to have_title('All Users')} 
        it{page.should have_selector('h1','All Users')}

        it "should list each user" do
          user.all.each.do |user|
          page.should have_selector('li', text: user.name)
          
        end 
      end
    end

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
       it { should have_selector('div.alert.alert-success', text: 'Welcome')}
       it { should have_link('Sign out')}
      end 
   end
  end
  
  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in user
      before {visit edit_user_path(user)}
    end
    describe "page" do
      it{ should have_selector ('h1', text: "Update your profile")}
      it{ expect(page).to have_title('Edit User')} 
      it{ should have_link('change', herf: 'http://gravatar.com/emails')}
    end

    describe "with invalid info" do
      before { click_button "save changes"}

      it { should have_content('error')}
    end

    describe "with valid info" do
      let(:new_name) {"New Name"}
      let(:new_email) {"new@example.com"}
      before do
        fill_in "Name",   with: new_name
        fill_in "Email",   with: new_email
        fill_in "Password",   with: user.password
        fill_in "Confirm Password",   with: user.password
        click_button "Save changes"
      end
      it{ expect(page).to have_title(user_name) }
      it { should have_link('Sign out', herf: signout_path)}
      it { should have_selector('div.alert.alert-notice')}
      specify { user.reload.email.should==new_email}
      specify { user.reload.name.should==new_name}
    end
  end
end
