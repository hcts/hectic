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

  def tick
    @network_interface = NetworkInterface.find(params[:id])
    @network_interface.tick!
    redirect_to network_interfaces_path
  end

  def destroy
    @network_interface = NetworkInterface.find(params[:id])
    @network_interface.destroy
    redirect_to network_interfaces_path
  end
end
