class EquipmentController < ApplicationController

  before_action :set_organisation
  before_action :set_equipment, only: [:show, :edit, :update, :destroy]

  # def index
  #   @equipment = policy_scope(Equipment)
  # end

  def show
  end

  def new
    @equipment = @organisation.equipments.build
    authorize @equipment
  end

  def edit
  end

  def create
    @equipment = @organisation.equipments.build(equipment_params)
    authorize @equipment

    respond_to do |format|
      if @equipment.save
        format.html { redirect_to @organisation, notice: 'Equipment was successfully created.' }
        format.json { render :show, status: :created, location: @equipment }
      else
        format.html { render :new }
        format.json { render json: @equipment.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @equipment.update(equipment_params)
        format.html { redirect_to @organisation, notice: 'Equipment was successfully updated.' }
        format.json { render :show, status: :ok, location: @equipment }
      else
        format.html { render :edit }
        format.json { render json: @equipment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @equipment.destroy
    respond_to do |format|
      format.html { redirect_to organisation_url(@organisation), notice: 'Equipment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_organisation
      @organisation = Organisation.find(params[:organisation_id])
    end

    def set_equipment
      @organisation = Organisation.find(params[:organisation_id])
      @equipment = @organisation.equipments.find(params[:id])
      authorize @equipment
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def equipment_params
      params.require(:equipment)
      .permit(
        :name,
        :location_id,
        :ip4,
        :prefix4,
        :ip6,
        :prefix6,
        :mac,
        :protocol,
        :upstream_secret,
        :switchboard_secret,
        :require_message_authenticator,
        :nas_type,
        :nas_kind
      )
    end
end
