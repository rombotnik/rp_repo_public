class StoriesController < ApplicationController
  before_action :set_current_section

  def index
    @archived = params[:archived] || false
    @stories = Story.includes(:genre).where(archived: @archived)
  end

  def new
    @story = Story.new
  end

  def create
    @story = Story.new(story_params)
    if @story.save
      redirect_to @story, notice: 'Story successfully created'
    else
      render 'new'
    end
  end

  def show
    @story = Story.find(params[:id])
    @scenes = @story.scenes
  end

  def edit
    @story = Story.find(params[:id])
  end

  def update
    @story = Story.find(params[:id])
    if @story.update(story_params)
      redirect_to @story, notice: 'Story successfully updated'
    else
      render 'edit'
    end
  end

  def destroy
    @story = Story.find(params[:id])
    @story.archived = true
    @story.save

    redirect_to stories_path, notice: 'Story archived'
  end

  private

  def story_params
    params.require(:story).permit(
      :title,
      :description,
      :genre_id,
      :tag_list,
      :archived,
      story_roles_attributes: [:id, :character_id, :_destroy]
      )
  end

  def set_current_section
    @current_section = 'Stories'
  end
end
