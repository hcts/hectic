class AccountsController < ApplicationController
  before_filter :load_host, :only => [:new, :create]

  def create
    @account = @host.accounts.build(params[:account])
    if @account.save
      redirect_to @account
    else
      render :new
    end
  end

  def show
    @account = Account.find(params[:id])
  end

  def edit
    @account = Account.find(params[:id])
  end

  def update
    @account = Account.find(params[:id])
    if @account.update_attributes(params[:account])
      redirect_to @account
    else
      render :edit
    end
  end

  private

  def load_host
    @host = Host.find(params[:host_id])
  end
end