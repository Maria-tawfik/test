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
 it { should respond_to(:password_digest) }
 it { should respond_to(:password) }
 it { should respond_to(:password_confirmation) }

#	before { @user.name= " " }
#    o = [('a'..'z'), ('A'..'Z')].map { |i| i.to_a }.flatten
 #   @user.name= = (0...50).map { o[rand(o.length)] }.join
#	it { should be_valid }
#	end

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

   

end
end
end
