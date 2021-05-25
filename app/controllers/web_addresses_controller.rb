class WebAddressesController < ApplicationController
  def index
    @web_addresses = WebAddress.top_sites
    @web_address = WebAddress.new
  end

  def create
    @web_address = WebAddress.new(web_address_params)
    unless @web_address.save
      flash[:notice] = @web_address.errors.full_messages
      render :index
    end
  end

  def show
    unless (web_address = WebAddress.find_by(short_url: params[:short_url]))
      flash[:notice] = [ "Sorry, not able to locate this url" ]
      redirect_to web_addresses_path
    else
      web_address.increase_visiting_counter
      redirect_to (URI.parse(web_address.full_url).scheme ? web_address.full_url : "http://"+web_address.full_url )
    end
  end

  private
  def web_address_params
    params.require(:web_address).permit(:full_url)
  end
end
