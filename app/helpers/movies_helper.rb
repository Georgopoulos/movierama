module MoviesHelper
	def order_movies(movies)
		if params[:sort] == 'date'
      filt = 'created_at DESC'
    elsif params[:sort] == 'hates'
      filt = 'hates DESC'
    else
      filt = 'likes DESC'
    end
    movies.order(filt).paginate(page: params[:page], per_page: 10)
  end
end
