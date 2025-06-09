class EntriesController < ApplicationController
  before_action :require_login, only: [:new, :create]
  before_action :set_entry, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user!, only: [:show, :edit, :update, :destroy]

  def index
    # if you have a flat entries index:
    @entries = current_user.entries.order(created_at: :desc)
  end

  def new
    @entry = Entry.new
  end

  def create
    @entry = current_user.entries.build(entry_params)
    if @entry.save
      redirect_to entry_path(@entry), notice: "Entry created!"
    else
      render :new
    end
  end

  private

  def set_entry
    @entry = Entry.find(params[:id])
  end

  def authorize_user!
    unless @entry.user == current_user
      redirect_to entries_path, alert: "You’re not allowed to see that."
    end
  end

  def entry_params
    params.require(:entry).permit(:title, :body, :happened_on, :place_id, :image)
  end
  
end
