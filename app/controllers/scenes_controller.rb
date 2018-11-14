class ScenesController < ApplicationController
  before_action :set_current_section

  def index
    @scenes = Scene.all
  end

  def new
    @story = Story.find(params[:story_id])
    default_order = @story.scenes.count + 1
    @scene = Scene.new(story: @story, order: default_order)
  end

  def create
    @story = Story.find(params[:story_id])
    @scene = Scene.new(scene_params)
    @scene.story = @story

    if @scene.save
      redirect_to story_path(@scene.story), notice: 'Scene successfully created'
    else
      render 'new'
    end
  end

  def show
    @story = Story.find(params[:story_id])
    @scene = Scene.find(params[:id])
  end

  def edit
    @story = Story.find(params[:story_id])
    @scene = Scene.find(params[:id])
  end

  def update
    @story = Story.find(params[:story_id])
    @scene = Scene.find(params[:id])
    if @scene.update(scene_params)
      redirect_to story_path(@story), notice: 'Scene successfully updated'
    else
      render 'edit'
    end
  end

  def destroy
    @story = Story.find(params[:story_id])
    @scene = Scene.find(params[:id])
    @scene.destroy
    redirect_to story_path(@story), notice: 'Scene removed'
  end

  def rp
    @scene = Scene.includes(posts: :user).find(params[:id])
    @post = Post.new(user: current_user)

    render 'rp', layout: 'rp'
  end

  private

  def scene_params
    params.require(:scene).permit(
      :title,
      :order,
      :tag_list
      )
  end

  def set_current_section
    @current_section = 'Stories'
  end
end
