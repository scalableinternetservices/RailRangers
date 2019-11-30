module PostsHelper
	def update_pagination_partial_path
	  if @posts.next_page
	    'posts/posts_pagination_page/update_pagination'
	  else
	    'posts/posts_pagination_page/remove_pagination'
	  end
	end
end
