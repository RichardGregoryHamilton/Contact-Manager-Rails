class PhoneNumbersController < ApplicationController
  before_action :set_phone_number, only: [:show, :edit, :update, :destroy]

  def index
    @phone_numbers = PhoneNumber.all
  end

  def show
  end

  def new
    @phone_number = PhoneNumber.new(person_id: params[:person_id])
  end

  def edit
  end

  def create
    @phone_number = PhoneNumber.new(phone_number_params)

    respond_to do |format|
      if @phone_number.save
        format.html { redirect_to @phone_number.person, notice: 'Phone number was successfully created.' }
        format.json { render :show, status: :created, location: @phone_number }
      else
        format.html { render :new }
        format.json { render json: @phone_number.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @phone_number.update(phone_number_params)
        format.html { redirect_to @phone_number.person, notice: 'Phone number was successfully updated.' }
        format.json { render :show, status: :ok, location: @phone_number }
      else
        format.html { render :edit }
        format.json { render json: @phone_number.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @phone_number.destroy
    respond_to do |format|
      format.html { redirect_to phone_numbers_url, notice: 'Phone number was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def set_phone_number
      @phone_number = PhoneNumber.find(params[:id])
    end

    def phone_number_params
      params.require(:phone_number).permit(:number, :person_id)
    end
end
