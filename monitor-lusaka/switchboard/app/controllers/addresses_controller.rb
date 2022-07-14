class AddressesController < ApplicationController

  before_action :set_location
  # before_action :set_address, only: [:edit, :update, :destroy]

  def new
    @address = @location.build_address
    authorize @address
    # @address = Address.new(addressable_id: params[:addressable_id], addressable_type: params[:addressable_type])
  end

  def create
    @address = @location.build_address(address_params)
    # @address = Address.new(address_params)
    authorize @address

    respond_to do |format|
      if @address.save
        # format.js
        format.html { redirect_to organisation_path(@location.organisation), notice: 'Address was successfully created.' }
        # format.json { render :show, status: :created, location: @address }
      else
        format.html { render :new }
        # format.json { render json: @address.errors, status: :unprocessable_entity }
      end
    end
  end

  # def edit
  # end

  # def update
  #   respond_to do |format|
  #     if @realm.update(realm_params)
  #       format.html { redirect_to @organisation, notice: 'Realm was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @realm }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @realm.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # def destroy
  #   @realm.destroy
  #   respond_to do |format|
  #     format.html { redirect_to @organisation, notice: 'Realm was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  private

    def set_location
      @location = Location.find(params[:location_id])
    end

    # def set_address
    #   @address = Address.find(params[:id])
    # end

    def address_params
      params.require(:address)
      .permit(
        :street,
        :street2,
        :pobox,
        :city,
        :zip,
        :state,
        :country_code,
        :latitude,
        :longitude,
        :altitude,
        :id
      )
    end
end
