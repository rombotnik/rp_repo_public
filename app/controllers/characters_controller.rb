class CharactersController < ApplicationController
  before_action :set_current_section

  def index
    @characters = Character.includes(:user)
  end

  def new
    @character = Character.new
  end

  def create
    @character = Character.new(character_params)
    if @character.save
      redirect_to characters_path, notice: 'Character successfully created'
    else
      render 'new'
    end
  end

  def show
    @character = Character.find(params[:id])
  end

  def edit
    @character = Character.find(params[:id])
  end

  def update
    @character = Character.find(params[:id])
    if @character.update(character_params)
      redirect_to characters_path, notice: 'Character successfully updated'
    else
      render 'edit'
    end
  end

  def destroy
    @character = Character.find(params[:id])
    @character.destroy
    redirect_to characters_path, notice: 'Character removed'
  end

  private

  def character_params
    params.require(:character).permit(:name, :gender, :user_id, :tag_list)
  end

  def set_current_section
    @current_section = 'Characters'
  end
end
