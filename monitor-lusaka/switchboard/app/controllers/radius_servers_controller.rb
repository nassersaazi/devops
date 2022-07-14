class RadiusServersController < ApplicationController

  before_action :set_radius_server, only: [:show, :edit, :update, :destroy, :clients, :proxy, :users]

  # def index
  #   @radius_servers = policy_scope(RadiusServer)
  # end

  def show
  end

  def new
    @radiusable = find_radiusable
    @radius_server = @radiusable.radius_servers.build
    authorize @radius_server
  end

  def edit
  end

  def create
    @radiusable = find_radiusable
    @radius_server = @radiusable.radius_servers.build(radius_server_params)
    authorize @radius_server

    respond_to do |format|
      if @radius_server.save
        format.html { redirect_to polymorphic_path(@radiusable), notice: 'Radius server was successfully created.' }
        # format.html { redirect_to @radius_server, notice: 'Radius server was successfully created.' }
        format.json { render :show, status: :created, location: @radius_server }
      else
        format.html { render :new }
        format.json { render json: @radius_server.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @radius_server.update(radius_server_params)
        format.html { redirect_to polymorphic_path(@radiusable), notice: 'Radius server was successfully updated.' }
        format.json { render :show, status: :ok, location: @radius_server }
      else
        format.html { render :edit }
        format.json { render json: @radius_server.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @radius_server.destroy
    respond_to do |format|
      format.html { redirect_to polymorphic_path(@radiusable), notice: 'Radius server was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def clients
    # respond_to do |format|
    #   format.conf { render file: 'radius_servers/clients.conf.haml', content_type: "text/plain" }
    # end
    response.headers['Content-Disposition'] = 'attachment; filename="clients.conf"'
    render file: 'radius_servers/clients.conf.haml'#, content_type: "text/plain"
    authorize @radius_server
  end

  def proxy
    response.headers['Content-Disposition'] = 'attachment; filename="proxy.conf"'
    render file: 'radius_servers/proxy.conf.haml'
    authorize @radius_server
  end

  def users
    response.headers['Content-Disposition'] = 'attachment; filename="users"'
    render file: 'radius_servers/users.txt.haml', content_type: "text/plain"
    authorize @radius_server
  end

  private

    def find_radiusable
      params.each do |name, value|
        if name =~ /(.+)_id$/
          return $1.classify.constantize.find(value)
        end
      end
      nil
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_radius_server
      @radiusable = find_radiusable
      # @radius_server = @radiusable.radius_servers.find(params[:id])
      @radius_server = RadiusServer.find(params[:id])
      authorize @radius_server
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def radius_server_params
      params.require(:radius_server)
      .permit(
        :name,
        :radiusable_id,
        :radiusable_type,
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
        :acct, :acct_port
      )
    end
end
