
class ImportsController < ApplicationController

  def create

    @import = Import.create(import_params)
    # @import = Import.create(:file => params[:import][:file])
    # ImportService.new(@import.file.current_path).perform!
    @import.delay.init_import!
    # render nothing: true
  end

  private
  def import_params
    params.require(:import).permit(:file)
  end

end
