class NetworkInterfacesController < ApplicationController
  def index
    @network_interfaces = NetworkInterface.all
  end

  def new
    @network_interface = NetworkInterface.new(params[:network_interface])
  end

  def create
    @network_interface = NetworkInterface.new(params[:network_interface])
    if @network_interface.save
      redirect_to network_interfaces_path
    else
      render :new
    end
  end
end
