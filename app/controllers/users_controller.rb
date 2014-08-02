class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:index, :edit, :update, :destroy, :following, :followers]
  before_filter :correct_user, only: [:edit, :update]
  before_filter :admin_user, only: :destroy
  def index
    @users= User.paginate(page: params[:page], per_page: 5)
  end

  def new
  	@user=User.new
  end

  def show
  	@user=User.find(params[:id])
    @posts=@user.posts.paginate(page: params[:page])
  end

  def create 
  	@user =User.new(user_params)
    if @user.save
      sign_in(@user)
      redirect_to @user
      flash[:notice] = "User successfully created"
     else
  	  render 'new'
    end
  end

  def edit
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success]="user destroyed"
    redirect_to users_path
  end
  

  def update
    #@user=User.find(params[:id])
    if @user.update_attributes(user_params) 
      sign_in @user
      flash[:notice] = "User successfully updated "
      redirect_to @user
    else
    render 'edit'
   end
  end

  def following
    @title= "Following"
    @user = User.find(params[:id])
    @user = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end

   def followers
    @title= "Followers"
    @user = User.find(params[:id])
    @user = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end



 private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
#howa shalha 
 


    
  def correct_user
   @user = User.find(params[:id])
   redirect_to root_path unless current_user?(@user) 
  end

  def admin_user
    redirect_to root_path unless current_user.admin?
  end
 
end
