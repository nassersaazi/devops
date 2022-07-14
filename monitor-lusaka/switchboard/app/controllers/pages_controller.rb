class PagesController < ApplicationController

  skip_before_action :authenticate_user!

  def show
    authorize :page, :show?
    render template: "pages/#{params[:page]}"
  end
  
end
