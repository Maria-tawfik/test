require 'rails_helper'

RSpec.describe User, :type => :model do

 # pending "add some examples to (or delete) #{__FILE__}"
  describe User do

    before do
      @user = User.new(name: "hhghj" ,email: "ayhaga@example.com",
      password:"mariasamy" , password_confirmation:"mariasamy")
      @user1 = User.new(name: "mariasamyfarid" ,email: "ayhaga@example.com",
      password:"mariasamy" , password_confirmation:"mariasamy")
    end

    subject { @user }

    it { should respond_to(:name) }
    it { should respond_to(:email) }
    it { should respond_to(:admin) }
    it { should respond_to(:password_digest) }
    it { should respond_to(:password) }
    it { should respond_to(:password_confirmation) }
    it { should respond_to(:remember_token) }
    it { should respond_to(:authenticate) }
    it { should respond_to(:feed) }
    it { should respond_to(:relationships) }
    it { should respond_to(:followed_users) }
    it { should respond_to(:reverse_relationships) }
    it { should respond_to(:followers) }
    it { should respond_to(:following?) }
    it { should respond_to(:follow!) }
    it { should respond_to(:unfollow!) }
   it {should be_valid}
   it {should be_valid}
    describe "when name is not present" do
     before { @user.name= " " }
     it { should_not be_valid }
    end

	  describe "when email is not present" do
	    before { @user.email= " " }
      it {should_not be_valid}
	  end

    describe "when name is too long" do 
	   before { @user.name="a" * 51 }
     it {should_not be_valid}
    end




    describe "when email taken" do
      it "should be invalid" do
        addresses = %w[user@example,com user_at_foo.org example.user@example.]
        addresses.each do |i|
          @user.email = i
          @user.should_not be_valid
        end
      end
    end

    describe "when email is unique" do
      before do
        user_with_same_email =@user.dup
        user_with_same_email.email =@user.email.downcase
        user_with_same_email.save
      end
      it { should_not be_valid }
    end



    describe "when password is blank" do
    	before { @user.password = @user.password_confirmation= " " }
     it {should_not be_valid}
    end


    describe "when it is not matching" do
    	before { @user.password_confirmation="mismatch" }
     it {should_not be_valid}
    end


    describe "when password_confirmation is nil" do
     before { @user.password_confirmation= nil }
     it {should_not be_valid}
    end

           
    describe "when password is too short" do
      before { @user.password=@user.password_confirmation ="a"*7 }
      it {should_not be_valid}
    end

    describe"return value of authenticate method" do
      before { @user.save }
      let(:found_user) { User.find_by_email(@user.email)}
                    
      describe"with valid password" do
        it{ should == found_user.authenticate(@user.password)}
      end
                     
      describe "with invalid password " do
        let(:user_for_invalid_password) {found_user.authenticate("invalid")}   
        it{ should_not== user_for_invalid_password}
        specify {expect(user_for_invalid_password).to be_falsey}
      end
    end

    describe"remember token" do 
      before { @user.save }
      it (:remember_token) {should_not be_blank}
    end

    describe "post association" do
      before {@user.save}
      let!(:older_post) do
       FactoryGirl.create(:post, user: @user, created_at: 1.day.ago)
      end
      let!(:newer_post) do
        FactoryGirl.create(:post, user: @user, created_at: 1.hour.ago)
      end
      it "should have the right post in the right order" do
        @user.posts.should==[newer_post, older_post]
      end

      it "should destroy associated post" do
        posts =@user.posts
        @user.destroy

        posts.each do |post|
          post.find_by_id(post.id).should be_nil
        end
      end
      
      describe "status" do
        let(:unfollowed_post) do
          FactoryGirl.create(:post, user: FactoryGirl.create(:user))
        end

         let(:followed_user){ FactoryGirl.create(:user)}

          before do
            @user.follow!(followed_user)
            3.times {followed_user.posts.create!(content: "lorem ipsum")}

         it "should have older posts" do
          expect(@user.feed).to include(older_post)
         end

         it "should have  newer posts" do
          expect(@user.feed).to include(newer_post)
         end

          it "should have older posts" do
           expect(@user.feed). not_to include(unfollowed_post)
         end

          it "should post have " do
            expect(@user.feed).to do 
              followed_user.posts.each do |post|
                should include(post)
            end
         end
      end
    end

    describe "following" do
      let(:other_user) { FactoryGirl.create(:user)}
      before do
        @user.save
        @user.follow!(other_user)
      end

      it {should be_following(other_user)}

      it "should have other followers" do
       expect(@user.followed_users). to include(other_user)
      end

      describe "followed user" do
        subject {other_user}
        it "should have followers" do
          expect(@user.followers). to include(@user)
        end
      end


      describe "and unfollowing" do
        before { @user.unfollow!(other_user)}
        it {should_not be_following(other_user)}
        it "should not have unfollowed users" do
           expect(@user.followed_users). not_to include(other_user)
          end
      end
    end
  end
end
