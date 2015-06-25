class TracksController < ApplicationController
  before_action :must_be_logged_in
  def new
    @track = Track.new
    @album_id = params[:album_id]
    render :new
  end

  def create
    @track = Track.new(track_params)
    if @track.save
      redirect_to album_url(@track.album)
    else
      flash.now[:errors] = "Can't save that album"
      redirect_to album_url(@track.album)
    end
  end

  def edit
    @track = Track.find(params[:id])
    @album_id = @track.album_id
    render :edit
  end

  def show
    @track = Track.find(params[:id])
    render :show
  end

  def update
    Track.update(params[:id], track_params)
    redirect_to track_url(Track.find(params[:id]))
  end

  def destroy
    album = Track.find(params[:id]).album
    Track.find(params[:id]).destroy
    redirect_to album_url(album)
  end

  private

  def track_params
    params.require(:track).permit(:name, :album_id)
  end

  def must_be_logged_in
    if current_user.nil?
      redirect_to new_session_url
    end
  end
end
