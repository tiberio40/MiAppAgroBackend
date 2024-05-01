class FarmingsController < ApplicationController
  before_action :set_farming, only: [:show, :update, :destroy]

  # GET /farmings
  def index
    @farmings = Farming.order(:name).all

    render json: @farmings
  end

  
end
