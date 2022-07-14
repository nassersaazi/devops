class MembershipsController < ApplicationController

  before_action :set_organisation  
  before_action :set_membership, only: [:show, :edit, :update, :destroy]

  def index
    @user = User.find(params[:user_id])
    @memberships = @user.memberships
  end

  def show
  end

  def new
    @organisation = Organisation.find(params[:organisation_id])
    @membership = @organisation.memberships.build
    authorize @membership
  end

  def create
    @organisation = Organisation.find(params[:organisation_id])
    @membership = @organisation.memberships.build(membership_params)
    authorize @membership

    respond_to do |format|
      if @membership.save
        format.html { redirect_to @organisation, notice: 'User was successfully added.' }
        format.json { render :show, status: :created, membership: @membership }
      else
        format.html { render :new }
        format.json { render json: @membership.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @membership.update(membership_params)
        format.html { redirect_to @organisation, notice: 'Member was successfully updated.' }
        format.json { render :show, status: :ok, membership: @membership }
      else
        format.html { render :edit }
        format.json { render json: @membership.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @membership.destroy
    respond_to do |format|
      format.html { redirect_to @organisation, notice: 'User was successfully removed.' }
      format.json { head :no_content }
    end
  end

  private

    def set_organisation
      @organisation = Organisation.find(params[:organisation_id])
    end

    def set_membership
      @membership = Membership.find(params[:id])
      authorize @membership
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def membership_params
      params.require(:membership)
      .permit(
        :organisation_id,
        :user_id,
        :operator
      )
    end
end
