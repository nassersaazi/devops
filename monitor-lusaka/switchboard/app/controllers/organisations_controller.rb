class OrganisationsController < ApplicationController

  skip_before_action :authenticate_user!, if: :eduroam_db_request?

  before_action :set_organisation, only: [:show, :edit, :update, :destroy]

  def index
    if eduroam_db_request?
      skip_policy_scope
      @organisations = Organisation.where(federation_id: params[:federation_id])
    else
      @organisations = policy_scope(Organisation)
    end
  end

  def show
  end

  def new
    @organisation = Organisation.new
    @address = @organisation.build_address
    @contact = @organisation.contacts.build
    authorize @organisation
  end

  def edit
    @address = @organisation.address
  end

  def create
    @organisation = Organisation.new(organisation_params)
    authorize @organisation

    respond_to do |format|
      if @organisation.save
        format.html { redirect_to @organisation, notice: 'Organisation was successfully created.' }
        format.json { render :show, status: :created, location: @organisation }
      else
        format.html { render :new }
        format.json { render json: @organisation.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @organisation.update(organisation_params)
        format.html { redirect_to @organisation, notice: 'Organisation was successfully updated.' }
        format.json { render :show, status: :ok, location: @organisation }
      else
        format.html { render :edit }
        format.json { render json: @organisation.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @organisation.destroy
    respond_to do |format|
      format.html { redirect_to organisations_url, notice: 'Organisation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  protected

  def eduroam_db_request?
    action_name=='index'  && request.format.json?
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_organisation
      @organisation = Organisation.find(params[:id])
      authorize @organisation
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def organisation_params
      params.require(:organisation)
      .permit(
        :name, 
        :domain_name, 
        :country_code, 
        :language,
        :federation_id,
        :eduroam_type, 
        :stage,
        :info_url,
        :policy_url,
        :venue_type,
        contacts_attributes:[
          :name,
          :email,
          :phone,
          :contact_type,
          :privacy,
          :_destroy,
          :id
        ],
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
        radius_servers_attributes:[
          :name,
          :radius_server_type,
          :server_type, 
          :product, 
          :ip4, 
          :ip6, 
          :mac,
          :protocol, 
          :secret, 
          :require_message_authenticator, 
          :auth, :auth_port, 
          :acct, :acct_port,
          :_destroy,
          :id
        ]        
      )
    end
end
