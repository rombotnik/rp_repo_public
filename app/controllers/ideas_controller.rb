class IdeasController < ApplicationController
  before_action :set_current_section

  def index
    @ideas = Idea.all
  end

  def new
    @idea = Idea.new(user: current_user)
  end

  def create
    @idea = current_user.ideas.build(idea_params)
    if @idea.save
      redirect_to ideas_path, notice: 'Idea successfully created'
    else
      render 'new'
    end
  end

  def show
    @idea = Idea.find(params[:id])
  end

  def edit
    @idea = Idea.find(params[:id])
  end

  def update
    @idea = Idea.find(params[:id])
    if @idea.update(idea_params)
      redirect_to ideas_path, notice: 'Idea successfully updated'
    else
      render 'edit'
    end
  end

  def destroy
    @idea = Idea.find(params[:id])
    @idea.destroy
    redirect_to ideas_path, notice: 'Idea removed'
  end

  private

  def idea_params
    params.require(:idea).permit(:body)
  end

  def set_current_section
    @current_section = 'Ideas'
  end
end
