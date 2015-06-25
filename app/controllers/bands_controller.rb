class BandsController < ApplicationController
  before_action :must_be_logged_in

  def index
    @bands = Band.all
  end

  def create
    @band = Band.new(name: params[:band][:name])

    if @band.save
      redirect_to bands_url
    else
      flash.now[:errors] = "Trouble saving that band name!"
      redirect_to bands_url
    end
  end

  # def edit
  #   @band = Band.find(params[:id])
  #   render :edit
  # end

  def show
    @band = Band.find(params[:id])
    render :show
  end
  #
  # def update
  #   Band.update(params[:id], band_params)
  #   redirect_to band_url(Band.find(params[:id]))
  # end

  def destroy
    Band.find(params[:id]).destroy
    redirect_to bands_url
  end

  private

  def band_params
    params.require(:band).permit(:name)
  end

  def must_be_logged_in
    if current_user.nil?
      redirect_to new_session_url
    end
  end
end
