class AccountsController < ApplicationController
  before_filter :load_host,    :only => [:new, :create]
  before_filter :load_account, :only => [:show, :edit, :update, :disable, :enable, :destroy]

  def create
    @account = @host.accounts.build(params[:account])
    if @account.save
      redirect_to @host
    else
      render :new
    end
  end

  def update
    if @account.update_attributes(params[:account])
      redirect_to @account
    else
      render :edit
    end
  end

  def disable
    @account.update_attribute(:enabled, false)
    redirect_to @account
  end

  def enable
    @account.update_attribute(:enabled, true)
    redirect_to @account
  end

  def destroy
    @account.destroy
    redirect_to @account.host
  end

  private

  def load_host
    @host = Host.find(params[:host_id])
  end

  def load_account
    @account = Account.find(params[:id])
  end
end