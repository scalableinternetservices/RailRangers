class UsersController < ApplicationController
	skip_before_action :authorized, only: [:show, :index, :new, :edit, :create]
	def index
	    # @users = User.all
	    @users = User.where('id != ?' , current_user.id).paginate(:page => params[:page], :per_page => 50)
	    @friends = current_user.friends
	    @requesters = current_user.requesters
		@requestees = current_user.requestees
		@received_requests = current_user.received_requests
  	end
	def show
		@user = User.find_by(id: params[:id])
		@posts = @user.posts.includes(comments: :user)
		@comment = Comment.new
		@friends = @user.friends
	end
	def new
	   @user = User.new
	end
	def edit
  	end
	def create
	   @user = User.create(params.require(:user).permit(:username,        
	   :password, :firstname, :lastname, :DOB))
	   session[:user_id] = @user.id
	   redirect_to '/posts'
	end
end