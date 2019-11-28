class SessionsController < ApplicationController
	skip_before_action :authorized, only: [:new, :create, :welcome]
	def new
		@user = User.new
	end
	def login
	end
	def create
	   if params[:username] == "seed"
		seed_database
		redirect_to '/login', notice: "Database seeded!"
	   else
		@user = User.find_by(username: params[:username])
		if @user && @user.authenticate(params[:password])
		   session[:user_id] = @user.id
		   redirect_to '/posts', notice: "Logged in!"
		else
		   redirect_to '/login'
		end
	   end
	end
	 def destroy
	    session[:user_id] = nil
	    redirect_to root_url, notice: "Logged out!"
  	end
	def page_requires_login
	end

	def seed_database
		how_many = {user: 500, posts_per_user: 3, friends_per_user: 50}
		password = 'password'
		# password_hash = User.digest(password)
		
		dob = Date.today
		# NOW_DT = DateTime.current
		# NOW_STR = NOW_DT.strftime("%FT%T")
		
		user_ids = (1..how_many[:user]).to_a
		
		user_ids.each do |i|
			User.create!({ firstname: "user#{i}_first", lastname: "user#{i}_last", DOB: dob, username: "user#{i}", password: password })
		end
		
		users = User.all
		puts "Created #{User.count} users"
		
		
		# 5 posts for each user:
		how_many[:posts_per_user].times do
		  users.each { |user| user.posts.create(message: "Hello, this is a sample seed post from user.") }
		end
		puts "Created #{Post.count} posts"
		
		# each post have random number of comments (0 - 4)
		posts = Post.all
		posts.each do |post|
		  rand(0..4).times do
			# assign random user id from 1-5 (there is no 0)
			post.comments.create(user_id: rand(1..how_many[:user]), comment: "Hello, this is a sample comment from user.")
		  end
		end
		puts "Created comments.."
		
		
		# friends for each user:
		how_many[:friends_per_user].times do
		  users.each do |user|
			# requestee can't be the same as current user
			requestee_id_num = rand(1..how_many[:user])
			while requestee_id_num == user.id || user.requestees.include?(User.find(requestee_id_num)) do
			  requestee_id_num = rand(1..how_many[:user])
			end
		
			user.sent_requests.create(requestee_id: requestee_id_num, accepted: true)
			User.find(requestee_id_num).sent_requests.create(requestee_id: user.id, accepted: true)
		  end
		end
		puts "Created friends.."
		
		puts "Database seeded.."		
	end
end