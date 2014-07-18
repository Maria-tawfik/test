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
		     it {should have_link 'profile', herf: user_path(user)}
		     it {should have_link 'sign out', herf: root_path}
		     it {should_not have_link 'sign in', herf: signin_path}
        end

	    describe "after visiting another page"  do
	    	before {click_link "About Us"}
	    	it { should_not have_selector ('div.alert.alert-danger')}
	    end

	    describe "followed by signout" do
	      before { click_link "sign out"}
	      it { should have_link('sign in')}
	     end

	end
end


