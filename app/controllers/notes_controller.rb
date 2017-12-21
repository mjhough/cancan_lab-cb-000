class NotesController < ApplicationController
  load_and_authorize_resource only: [:edit, :show, :update]
  
  # CREATE
  def create
    note = Note.new(note_params)
    note.user = current_user
    note.save
    redirect_to '/'
  end

  def new
    @note = Note.new
  end

  # READ
  def index
    @notes = Note.all
  end

  def show
  end

  # UPDATE
  def edit
  end

  def update
    @note.update(note_params)
    redirect_to '/'
  end

  # DESTROY
  def destroy
    @note.destroy
    redirect_to notes_path
  end


  private

  def note_params
    params.require(:note).permit(:content, :visible_to)
  end
end