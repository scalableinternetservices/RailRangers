class UsersController < ApplicationController
	skip_before_action :authorized, only: [:show, :index, :new, :edit, :create]
	def index
	    # @users = User.all
	    @users = User.where('id != ?' , current_user.id).paginate(:page => params[:page], :per_page => 5)
	    @friends = current_user.friends
  	end
	def show
		@user = User.find_by(id: params[:id])
		@posts = User.find_by(id: params[:id]).posts
		@comment = Comment.new
		@friends = current_user.friends
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