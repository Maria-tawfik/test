require 'rails_helper'

RSpec.describe "AuthenticationPages", :type => :request do
	subject { page }

	describe "signin" do
		before { visit root_path}


	 	describe "with invalid information" do
	 		before {click_button "Sign in"}
	     	it { should have_selector('div.alert.alert-danger', text: 'Invalid')}
		end 
		describe "with valid info" do
			let(:user) {FactoryGirl.create(:user)}
			before do
				fill_in "Email", with: user.email
		        fill_in "Password", with: user.password
               click_button "Sign in"
		    end
		     it {expect(page).to have_title(user.name)}
		     it {should have_link 'profile', href: user_path(user)}
		     it {should have_link 'Sign out'}
		     it {should_not have_css ("form.signin")}

             describe "after visiting another page"  do
                before {click_link "About Us"}
                it { should_not have_selector ('div.alert.alert-danger')}
            end

            describe "followed by signout" do
              before { click_link "Sign out"}
               it {should have_css ("form.signin")}
            end
        end

	    

	end
end


