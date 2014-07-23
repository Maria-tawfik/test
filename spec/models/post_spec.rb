require 'rails_helper'

RSpec.describe Post, :type => :model do
  let(:user) {FactoryGirl.create(:user)}

  before do
  	@post =user.posts.build(content: "Lorem ipsum", title: "title")
  end

    subject { @post }
    
   
    #its(:user) {should == user}
     it {should respond_to(:content)}
    it {should respond_to(:user_id)}
    it "s user should equal user" do
    	expect(@post.user).to eq(user)
    end

    it{ should be_valid}

    describe"when id id absent" do
    	before{ @post.user_id= nil }
    	it{ should_not be_valid}
    end
    describe "wz the blank content " do
      before {@post.content= ""}
      it {should_not be_valid}
    end

   # describe" wz content too long" do
    #  before  {@post.content= "a" *200}
    #  it { should_not be_valid}
    #end

end
