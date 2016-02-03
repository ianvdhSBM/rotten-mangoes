class MoviesController < ApplicationController

  def index
    @movies = Movie.search(params)
    # if params[:title].blank? && params[:director].blank?
    #   @movies = Movie.all
    # else
    #   @movies = Movie.where(
    #     "title LIKE ? OR director LIKE ?",
    #     property_info(params[:title]),
    #     property_info(params[:director])
    #   )
    # end
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def new
    @movie = Movie.new
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  # def property_info(property)
  #   if property.blank?
  #     ''
  #   else
  #     "%#{property}%"
  #   end
  # end

  # def search
  #   # title = property_info(params[:title])
  #   # director = property_info(params[:director])

      # @movies = Movie.where("title LIKE ? OR director LIKE ?", property_info(params[:title]), property_info(params[:director]))
  #   # runtime = params[:runtime_in_minutes]

  #   # case runtime.to_i
  #   # when 0
  #   #   where_params = "(title LIKE #{title} OR director LIKE #{director}) AND runtime_in_minutes < 90"
  #   # when 1
  #   #   where_params = "(title LIKE #{title} OR director LIKE #{director}) AND runtime_in_minutes BETWEEN 90 AND 120"
  #   # when 2
  #   #   where_params = "(title LIKE #{title} OR director LIKE #{director}) AND runtime_in_minutes > 120"
  #   # end

  #   # @movies = Movie.where(where_params)
  #   # render '/movies/search'
  # end



  # def runtime_info(runtime)
  #   case runtime
  #   when '< 90'
  #     < 90
  #   when 'BETWEEN 90 AND 120'
  #     BETWEEN 90 AND 120
  #   when '> 120'
  #     > 120
  #   end

  # end



  def create
    @movie = Movie.new(movie_params)

    if @movie.save
      redirect_to movies_path, notice: "#{@movie.title} was submitted successfully!"
    else
      render :new
    end
  end

  def update
    @movie = Movie.find(params[:id])

    if @movie.update_attributes(movie_params)
      redirect_to movies_path(@movie)
    else
      render :edit
    end
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    redirect_to movies_path
  end

  protected

  def movie_params
    params.require(:movie).permit(
      :title, :release_date, :director, :runtime_in_minutes, :poster_image_url, :description, :image, :remote_image_url, :remove_image
    )
  end

end








