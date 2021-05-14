class BookmarksController < ApplicationController

  before_action :set_list, only: [:new, :create]
  before_action :set_movie, only: [:create]

  def new
    # @list = List.find(params[:list_id])
    @bookmark = Bookmark.new
  end

  def create
    @bookmark = Bookmark.new(bookmark_params)
    @bookmark.list = @list
    @bookmark.movie = @movie
    if @bookmark.save
      redirect_to list_path(@list)
    else
      render :new
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    @bookmark.delete
    redirect_to list_path(@bookmark.list)
  end

  private

  def set_list
    @list = List.find(params[:list_id])
  end

  def set_movie
    @movie = Movie.find(params[:bookmark][:movie_id])
  end

  def bookmark_params
    params.require(:bookmark).permit(:comment)
  end
end
