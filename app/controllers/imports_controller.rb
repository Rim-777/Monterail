class ImportsController < ApplicationController
  respond_to :json

  def create
    @import = Import.create(import_params) if params[:import]
    ImportJob.perform_later(@import)
    redirect_to companies_path
  end

  private
  def import_params
    params.require(:import).permit(:file)
  end
end
