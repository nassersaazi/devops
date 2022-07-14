class LocationsController < ApplicationController
  before_action :set_location, only: [:show, :edit, :update, :destroy]

  # GET /locations/1
  # GET /locations/1.json
  def show
  end

  # GET /locations/new
  def new
    @organisation = Organisation.find(params[:organisation_id])
    @location = @organisation.locations.build
    @address = @location.build_address
    @contact = @location.contacts.build
    authorize @location
  end

  # POST /locations
  # POST /locations.json
  def create
    @organisation = Organisation.find(params[:organisation_id])
    @location = @organisation.locations.build(location_params)
    authorize @location

    respond_to do |format|
      if @location.save
        format.html { redirect_to @organisation, notice: 'Location was successfully created.' }
        format.json { render :show, status: :created, location: @location }
      else
        format.html { render :new }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /locations/1/edit
  def edit
    @address = @location.address
  end

  # PATCH/PUT /locations/1
  # PATCH/PUT /locations/1.json
  def update
    respond_to do |format|
      if @location.update(location_params)
        format.html { redirect_to @organisation, notice: 'Location was successfully updated.' }
        format.json { render :show, status: :ok, location: @location }
      else
        format.html { render :edit }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /locations/1
  # DELETE /locations/1.json
  def destroy
    @location.destroy
    respond_to do |format|
      format.html { redirect_to @organisation, notice: 'Location was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_location
      @organisation = Organisation.find(params[:organisation_id])
      @location = Location.find(params[:id])
      authorize @location
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def location_params
      params.require(:location)
      .permit(
        :organisation_id,
        :stage,
        :transmission,
        :venue_type,
        :ssid,
        :name,
        # :address_id,
        # :contacts_id,
        :wpa_mode,
        :encryption_mode,
        :ap_no,
        :wired_no,
        :port_restrict,
        :transp_proxy,
        :ipv6,
        :nat,
        :hs20,
        :availability,
        :operation_hours,
        :info_url,
        address_attributes:[
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
        ],
        contacts_attributes:[
          :name,
          :email,
          :phone,
          :contact_type,
          :privacy,
          :_destroy,
          :id
        ]        
      )
    end
end
