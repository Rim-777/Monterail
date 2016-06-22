class ImportsController < ApplicationController
  before_action :check_import
  respond_to :json

  def create
    @import = Import.create(import_params)
    ImportJob.perform_later(@import)
    redirect_to companies_path
  end

  private
  def check_import
    render json: {message: 'No file'} unless params[:import]
  end

  def import_params
    params.require(:import).permit(:file)
  end
end
