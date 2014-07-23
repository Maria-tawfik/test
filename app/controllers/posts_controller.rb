class PostsController <ApplicationController
	before_filter :signed_in_user, only: [:create, :destroy]
	before_filter :correct_user, only: :destroy

	def create 
		@post=current_user.posts.build(post_params)
			if @post.save
				  flash[:success]=  "Post created!"
				   redirect_to root_path
			    else
			    	@feed_items = current_user.feed.paginate(page: params[:page])
				  render 'blogs/home'
			end
		
	end

	def destroy
		@post.destroy
		redirect_to root_path
	end

	def show
    	@post=Post.find(params[:id])
	end

	def edit
		@post=Post.find(params[:id])
	end

	def update
		@post=Post.find(params[:id])
		@user=@post.user
	 if @post.update_attributes(post_params) 
        #sign_in @user
        flash[:notice] = "post successfully updated "
        redirect_to @post
      else
        render 'edit'
      end
	end

	private

	def post_params
	 params.require(:post).permit(:title, :content)
	end

	def correct_user
		@post = current_user.posts.find_by_id(params[:id])
		redirect_to root_path if @post.nil?

	end



end