require 'rails_helper'

RSpec.describe "HomePages", :type => :request do
  describe "GET /home_pages" do

  describe "Home page" do
  	   it "Our Demo App" do

  		   visit '/home_page/home'
  		   page.should have_content ('Our Demo App')
  	    end

  end

  describe "About page" do
  	it "About us" do

  		visit '/home_page/about'
  		page.should have_content ('About us')
  	end
  end

  describe "Contact page" do
  	it "Contact Us" do

  		visit '/home_page/contact'
  		page.should have_content ('Contact Us')
  	end
  end

  describe "Location page" do
  	it "Location" do

  		visit '/home_page/location'
  		page.should have_content ('Location')
  	end
  end

  describe "Home page" do
  	   it "Our Demo App" do

  		   visit '/home_page/home'
  		 expect(page).to have_title('Our Demo App')
  	    end

  end
  
  describe "About page" do
  	it "About us" do

  		visit '/home_page/about'
  		expect(page).to have_title('About Us')
   	end
  end

  describe "Location page" do
  	it "Location" do

  		visit '/home_page/location'
  		expect(page).to have_title('Location')
   	end
  end
  
  describe "Contact page" do
  	it "Contact us" do

  		visit '/home_page/contact'
  		expect(page).to have_title('Contact Us')
   	end
  end
  

end
end

