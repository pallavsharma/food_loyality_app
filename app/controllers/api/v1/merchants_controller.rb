class Api::V1::MerchantsController < ApplicationController
  before_action :set_merchant, only: [:show, :update, :destroy]

  # GET /api/v1/merchants
  def index
    @merchants = Merchant.all
    render json: @merchants
  end

  # GET /api/v1/merchants/:id
  def show
    render json: @merchant
  end

  # POST /api/v1/merchants
  def create
    @merchant = Merchant.new(merchant_params)
    if @merchant.save
      render json: @merchant, status: :created
    else
      render json: @merchant.errors, status: :unprocessable_entity
    end
  end

  # PUT /api/v1/merchants/:id
  def update
    if @merchant.update(merchant_params)
      render json: @merchant
    else
      render json: @merchant.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/merchants/:id
  def destroy
    @merchant.destroy
    head :no_content
  end

  private

  def set_merchant
    @merchant = Merchant.find(params[:id])
  end

  def merchant_params
    params.require(:merchant).permit(:username, :email, :businessname, :qr_code_url, :image_url, :video_url, :address, :location, :metadata)
  end
end
