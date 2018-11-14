class NotesController < ApplicationController
  before_action :set_current_section, :set_resource

  def index
    @notes = Note.all
    @current_section = 'Stories'
  end

  def new
    if params[:story_id]
      @note = Note.new(story: @resource)
    elsif params[:character_id]
      @note = Note.new(character: @resource)
    end
  end

  def create
    @note = Note.new(note_params)
    if @note.save
      redirect_to @resource, notice: 'Note successfully created'
    else
      render 'new'
    end
  end

  def show
    @note = Note.find(params[:id])
  end

  def edit
    @note = Note.find(params[:id])
  end

  def update
    @note = Note.find(params[:id])
    if @note.update(note_params)
      redirect_to @resource, notice: 'Note successfully updated'
    else
      render 'edit'
    end
  end

  def destroy
    @note = Note.find(params[:id])

    if @note.story
      @note.destroy
      redirect_to @resource, notice: 'Note removed'
    else
      @note.destroy
      redirect_to @resource, notice: 'Note removed'
    end
  end

  private

  def note_params
    params.require(:note).permit(
      :story_id,
      :character_id,
      :title,
      :body
      )
  end

  def set_resource
    if params[:story_id]
      @resource = Story.find(params[:story_id])
    else
      @resource = Character.find(params[:character_id])
    end
  end

  def set_current_section
    if params[:story_id]
      @current_section = 'Stories'
    else
      @current_section = 'Characters'
    end
  end

end
