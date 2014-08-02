require 'spec_helper'

describe RelationshipsController do

	let(:user) {FactoryGirl.create(:user)}
	let(:other_user) {FactoryGirl.create(:user)}

	before { sign_in user}
	describe "creating a relationship wz ajax" do
		it "should incr the relationship count" do
			expect do
				xhr :post, :creste, relationship: {followed_id: other_user.id}
			end.should change(Relationship, :count).by(1)
		end
		it "should respond wz success" do
		    xhr :post, :creste, relationship: {followed_id: other_user.id}
		    response.should be_success
		end
	end





	describe "destroying a relationship wz ajax" do

		before {user.follow!(other_user)}
		let(:relationship) {user.relationships.find_by_followed_id(other_user)}
		it "should decre the relationship count" do
			expect do
				xhr :delete, :destroy, id: relationship.id
			end.should change(Relationship, :count).by(1)
		end
		it "should respond wz success" do
		    xhr :delete, :destroy, id: relationship.id
		    response.should be_success
		end
	end



end