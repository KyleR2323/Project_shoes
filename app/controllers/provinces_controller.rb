class ProvincesController < ApplicationController
  before_action :set_province, only: %i[ show edit update destroy]

  def index
    @provinces = Province.all
  end

  def show
  end

  def new
    @province = Province.new
  end

  def edit
  end

  def create
    @province = Province.new(province_params)

    respond_to do |format|
      if @province.save
        format.html { redirect_to province_url(@province), notice: "Province was successfully created."}
        format.json { render :show, status: :created, location: @province }
      else
        format.html { render :new, status: : unprocessable_entity }
        format.json { render json: @province.errors, status: :unprocessable_entity}
      end
    end
  end

  def update
    respond_to do |format|
      if @province.update(province_params)
        format.html { redirect_to province_url(@province), notice: "Province was successfully updated."}
        format.json { render :show, status: :ok, location: @province }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @province.errors, status: :unprocessable_entity}
      end
    end
  end

  def destroy
    @province.destroy

    respond_to do |format|
      format.html { redirect_to provinces_url, notice: "Province was successfully destroyed."}
      format.json { head :no_content }
    end
  end

  private

  def set_province
    @province = Province.find(params[:id])
  end

  def province_params
    params.fetch(:province, {})
  end
end
