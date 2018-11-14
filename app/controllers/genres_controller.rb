class GenresController < ApplicationController
  before_action :set_current_section

  def index
    @genres = Genre.all
  end

  def new
    @genre = Genre.new
  end

  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      redirect_to genres_path, notice: 'Genre successfully created'
    else
      render 'new'
    end
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
      redirect_to genres_path, notice: 'Genre successfully updated'
    else
      render 'edit'
    end
  end

  def destroy
    @genre = Genre.find(params[:id])
    @genre.destroy
    redirect_to genres_path, notice: 'Genre removed'
  end

  private

  def genre_params
    params.require(:genre).permit(:name)
  end

  def set_current_section
    @current_section = 'Genres'
  end
end
