class ImportsController < ApplicationController
respond_to :json
  def create
    @import = Import.create(import_params)
    ImportJob.perform_later(@import)
    render nothing: true
  end

  private
  def import_params
    params.require(:import).permit(:file)
  end
end
