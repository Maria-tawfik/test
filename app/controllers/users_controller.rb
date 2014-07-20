class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:index, :edit, :update]
  before_filter :correct_user, only: [:edit, :update]

  def index
  end

  def new
  	@user=User.new
  end

  def show
  	@user=User.find(params[:id])
  end

  def create 
  	@user =User.new(user_params)
    if @user.save
      redirect_to @user
      flash[:notice] = "User successfully created"
     else
  	  render 'new'
    end
  end

 private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
#howa shalha 
  def edit
    #@user=User.find(params[:id]) 
  end

  def update
    @user=User.find(params[:id])
    if @user.update_attributes(params[:user]) 
      sign_in @user
      flash[:notice] = "User successfully updated "
      redirect_to @user
    else
    render 'edit'
   end
  end
private

  def signed_in_user
    unless  signed_in?
      store_location
      redirect_to signin_path 
      flash[:error] ="Please sign in"
    end
  end
    
   def correct_user
   @user = User.find(params[:id])
   redirect_to root_path unless current_user?(@user) 

end
