class FederationsController < ApplicationController

  skip_before_action :authenticate_user!, if: :eduroam_db_request?

  before_action :set_federation, only: [:show, :edit, :update, :destroy, :clients, :proxy, :users]

  def index
    @federations = policy_scope(Federation)
  end

  def show
    if eduroam_db_request?
      skip_authorization
    else
      @organisations = policy_scope(@federation.organisations)
      authorize @federation
    end
  end

  def new
    @federation = Federation.new
    @radius_server = @federation.radius_servers.build
    authorize @federation
  end

  def edit
    authorize @federation
  end

  def create
    @federation = Federation.new(federation_params)
    authorize @federation

    respond_to do |format|
      if @federation.save
        format.html { redirect_to federations_path, notice: 'Federation was successfully created.' }
        format.json { render :show, status: :created, location: @federation }
      else
        format.html { render :new }
        format.json { render json: @federation.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @federation
    respond_to do |format|
      if @federation.update(federation_params)
        format.html { redirect_to @federation, notice: 'Federation was successfully updated.' }
        format.json { render :show, status: :ok, location: @federation }
      else
        format.html { render :edit }
        format.json { render json: @federation.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize @federation
    @federation.destroy
    respond_to do |format|
      format.html { redirect_to federations_url, notice: 'Federation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  protected

  def eduroam_db_request?
    action_name=='show'  && request.format.json?
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_federation
      @federation = Federation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def federation_params
      params.require(:federation)
      .permit(
        :operator_id,
        :confederation_id,
        :stage,
        :email,
        :identifier,
        :tld,
        :language,
        :info_url,
        :policy_url,
        radius_servers_attributes:[
          :name,
          :radius_server_type,
          :server_type, 
          :product, 
          :ip4,
          :ip6,
          :mac,
          :protocol,
          :upstream_secret, 
          :monitor_secret, 
          :switchboard_secret, 
          :require_message_authenticator, 
          :auth, :auth_port, 
          :acct, :acct_port,
          :_destroy,
          :id
        ]        
      )
    end
end
