require 'rails_helper'

RSpec.describe "Blogs", :type => :request do
  describe "GET /blogs" do

  	  describe "Home page" do
  	   it "Hello, world!" do

  		   visit root_path
  		   page.should have_content('Hello, world!')
  	    end


  	   it "Hello, world!" do

  		   visit root_path
  		   expect(page).to have_title('')
  		   page.should have_selector('h1','Hello, world!')
  	    end
  	    it "should have the right links on the layout" do

  	    	visit root_path
  	    	click_link"Demo Blog"
  	    	page.should have_selector('h1','About Us')
  	    	click_link"About Us"
  	    	page.should have_selector('h1','About Us')
  	    	click_link"Sign up"
  	    	page.should have_selector('h1','Sign Up')

  	    end

        describe "for signed in uers" do
          let(:user) {FactoryGirl.create(:user)}
          before do
            FactoryGirl.create(:post, user: user, content: "lorem ipsum")
            FactoryGirl.create(:post, user: user, content: "opa check")
            sign_in user
            visit root_path
          end
          it "should render the user's feed" do

            user.feed.each do |item|
              page.should have_selector("li##{item.id}", text: item.content)
            end
          end

        end


  end

    	  describe "About page" do
  	   it "About Us" do

  		   visit root_path
  		   page.should have_content('About Us')
  	    end

  end

   describe "About page" do
  	   it "About Us" do

  		   visit about_path
  		   expect(page).to have_title "Demo | About Us"
  		   page.should have_selector('h1','About Us')
  		  expect(page).to have_title('About Us')
  	    end

  end

   
  end
end
