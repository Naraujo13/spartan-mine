class System::VouchersController < ApplicationController

  before_action :set_system_voucher, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :verify_access
  layout "inside"
  respond_to :json, :html, :js

  def index
    @system_vouchers = System::Voucher.search(params[:search]).page(params[:page])
    @total = System::Voucher.all.length
    respond_with(@system_vouchers)
  end

  def show
    respond_with(@system_voucher)
  end

  def new
    @system_voucher = System::Voucher.new
    respond_with(@system_voucher)
  end

  def edit
  end

  def create
    @system_voucher = System::Voucher.new(system_voucher_params)
    if @system_voucher.save
      AthomeMailer.voucher( system_voucher_params[:first_name], system_voucher_params[:email], root_url+'voucher/?id='+system_voucher_params[:voucher]).deliver_later
      redirect_to action: "index"
    else
      respond_with(@system_voucher)
    end
  end

  def update
    if @system_voucher.update(system_voucher_params)
      redirect_to action: "index"
    else
      respond_with(@system_voucher)
    end
  end

  def destroy
    @system_voucher.destroy
    respond_with(@system_voucher)
  end

  private
    def set_system_voucher
      @system_voucher = System::Voucher.find(params[:id])
    end

    def system_voucher_params
      params.require(:system_voucher).permit(:voucher, :dt_expire, :email, :pricing, :first_name, :user_id)
    end
end
