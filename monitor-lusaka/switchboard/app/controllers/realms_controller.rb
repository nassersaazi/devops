class RealmsController < ApplicationController

  before_action :set_organisation
  before_action :set_realm, only: [:edit, :update, :destroy]

  def new
    @realm = @organisation.realms.build
    authorize @realm
  end

  def create
    @realm = @organisation.realms.build(realm_params)
    authorize @realm

    respond_to do |format|
      if @realm.save
        format.html { redirect_to @organisation, notice: 'Realm was successfully created.' }
        format.json { render :show, status: :created, location: @realm }
      else
        format.html { render :new }
        format.json { render json: @realm.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @realm.update(realm_params)
        if @realm.saved_change_to_domain_name? || @realm.saved_change_to_allow_subdomains?
          RealmMailer.with(realm: @realm, organisation: @organisation, action: 'updated').institutional.deliver_later
          RealmMailer.with(realm: @realm, organisation: @organisation, action: 'updated').national.deliver_later
          RealmMailer.with(realm: @realm, organisation: @organisation, action: 'updated').regional.deliver_later
        end 
        format.html { redirect_to @organisation, notice: 'Realm was successfully updated.' }
        format.json { render :show, status: :ok, location: @realm }
      else
        format.html { render :edit }
        format.json { render json: @realm.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @realm.destroy
    respond_to do |format|
      RealmMailer.with(realm: @realm, organisation: @organisation, action: 'deleted').institutional.deliver_later
      RealmMailer.with(realm: @realm, organisation: @organisation, action: 'deleted').national.deliver_later
      RealmMailer.with(realm: @realm, organisation: @organisation, action: 'deleted').regional.deliver_later
      format.html { redirect_to @organisation, notice: 'Realm was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_organisation
      @organisation = Organisation.find(params[:organisation_id])
    end

    def set_realm
      @realm = Realm.find(params[:id])
      authorize @realm
    end

    def realm_params
      params.require(:realm)
      .permit(
        :domain_name,
        :organisation,
        # :test_user,
        # :test_password,
        # :generic,
        :allow_subdomains
      )
    end
end
