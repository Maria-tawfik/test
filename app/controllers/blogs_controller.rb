class BlogsController < ApplicationController
  def home
  end

  def about
  end 

  def contact
  end

  def sendemail
# should send email and redirect to home page.!
redirect_to root_url, :notice => "Email sent with subject #{params['subject']} and body #{params['body']}}"
  end
  
end
