class FilesController < ApplicationController
  before_action :set_company
  before_action :set_file

  def create
    @company.create_operations_csv(@file)
    send_file_to_download
  end

  private
  def set_company
    @company = Company.find(params[:company_id])
  end

  def set_file
    @file = Tempfile.new(["#{@company.name}_operations", '.csv'])
  end

  def send_file_to_download
    send_file File.join(@file.path)
  end
end
