class HostsController < ApplicationController
  def index
    @hosts = Host.all
  end

  def new
    @host = Host.new(params[:host])
  end

  def create
    @host = Host.new(params[:host])
    if @host.save
      redirect_to @host
    else
      render :new
    end
  end

  def show
    @host = Host.find(params[:id])
  end

  def edit
    @host = Host.find(params[:id])
  end

  def update
    @host = Host.find(params[:id])
    if @host.update_attributes(params[:host])
      redirect_to host_path(@host)
    else
      render :edit
    end
  end
end