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
              it {should have_link 'settings', href: edit_user_path(user)}
              it {should have_link 'Users', href: users_path}
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

    describe "authorization" do
    	describe "for no signined users" do
    		let(:user) {FactoryGirl.create(:user)}

    		describe "when attempting to visit a protected page" do
    			before do
    				visit edit_user_path(user)
    				fill_in "Email", with: user.email
    				fill_in "Password", with: user.password
    				click_button "Sign in"
    			end

    			describe "after sign in" do
    				it "should render the desired protected page " do
    					expect(page).to have_title('Edit User')
    				end	
    			    describe "ehrn signing in again" do
    			    	before do
    			    	 click_link "Sign out"
    			    
    			    	 fill_in "Email", with: user.email
    			    	 fill_in "Password", with: user.password
    			    	 click_button"Sign in"
    			    	end

    			    	it "should render the default (profile) page" do
    			    	  expect(page).to have_title(user.name)
                        end
                    end   
    			end
    		end	

    		describe "in the users control" do
    			describe "vist the edit page" do
    				before{visit edit_user_path(user)}
                    it "should have correct title" do
    				    expect(page).to have_title('Demo')
    				end
                    it{should have_selector('div.alert.alert-danger')}
    			end
    			describe "submitting to the update action" do 
    		      before {put user_path(user)}
    		      specify{response.should redirect_to(root_path)}
    	        end 

                describe "submitting to the destroy action" do
                    before {delete post_path(FactoryGirl.create(:post))}
                    specify{ response.should redirect_to(root_path)}
                end

    	        describe "visiting the user index" do
    	        	before {visit users_path}
    	        	it{expect(page).to have_title('Demo')}
    	       end
    	   end
        end
        
        describe "in the posts control" do
            describe "submitting to the create action" do
                before {post posts_path}
                specify {response.should redirect_to(root_path)}
            end

        end

    	describe "as wrong user" do
    		let(:user) {FactoryGirl.create(:user)}
    		let(:wrong_user) {FactoryGirl.create(:user, email: "wrong@example.com")}
    		before { sign_in user}

    		describe "visiting Users#edit page" do
    			before {visit edit_user_path(wrong_user)}
         		it {should_not have_selector('title', text: 'Edit user')}
         	end

         	describe "submitting a put request to the Users#update action"	do
         		before {put user_path(wrong_user)}
         		specify {response.should redirect_to(root_path)}
         	end
        end
        
        describe "as non-admin user" do
            let(:user) {FactoryGirl.create(:user)}
            let(:non_admin) {FactoryGirl.create(:user)}
            before {sign_in non_admin}
            describe "submitting a delete req to the Users#destroy action" do
                before {delete user_path(user)}
                specify {response.should redirect_to(root_path)}
            end
        end    
    end
end
