require 'tempfile'
class OperationsController < ApplicationController
  respond_to :json

  def index
    @operations = Operation.all
    respond_with(@operations)
  end

  def import
    # render :text =>
    @file =Tempfile.new(params[:file]).path
    import = ImportService.new(@file)
    import.perform!
    # render nothing: true
  end
end
