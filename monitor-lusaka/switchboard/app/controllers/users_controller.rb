class UsersController < ApplicationController

  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = policy_scope(User)
  end

  def show
  end

  # def new
  #   @address = Address.new(addressable_id: params[:addressable_id], addressable_type: params[:addressable_type])
  # end

  # def create
  #   @address = Address.new(address_params)

  #   respond_to do |format|
  #     if @address.save
  #       format.js
  #       # format.html { redirect_to @address, notice: 'Address was successfully created.' }
  #       # format.json { render :show, status: :created, location: @address }
  #     else
  #       # format.html { render :new }
  #       # format.json { render json: @address.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  def edit
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_path(@user), notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
    authorize @user
  end

  def user_params
    params.require(:user)
    .permit(
      :first_name,
      :last_name,
      :email,
      memberships_attributes:[
        :organisation_id,
        :operator,
        :_destroy,
        :id
      ]      
    )
  end
end
