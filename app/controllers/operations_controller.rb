class OperationsController < ApplicationController
  respond_to :json

  def index
    @operations = Operation.all
    respond_with(@operations)
  end
end
