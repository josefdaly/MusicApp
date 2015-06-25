class AlbumsController < ApplicationController
  before_action :must_be_logged_in

  def new
    @album = Album.new
    @band_id = params[:band_id]
    render :new
  end

  def create
    @album = Album.new(album_params)
    if @album.save
      redirect_to band_url(@album.band)
    else
      flash.now[:errors] = "Can't save that album"
      redirect_to bands_album_url(@album.band)
    end
  end

  def edit
    @album = Album.find(params[:id])
    @band_id = @album.band_id
    render :edit
  end

  def show
    @album = Album.find(params[:id])
    render :show
  end

  def update
    Album.update(params[:id], album_params)
    redirect_to album_url(Album.find(params[:id]))
  end

  def destroy
    band = Album.find(params[:id]).band
    Album.find(params[:id]).destroy
    redirect_to band_url(band)
  end

  private

  def album_params
    params.require(:album).permit(:name, :band_id, :recording_type)
  end

  def must_be_logged_in
    if current_user.nil?
      redirect_to new_session_url
    end
  end
end
