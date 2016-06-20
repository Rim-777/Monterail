class CompaniesController < ApplicationController
  respond_to :json

  def index
    @companies = Company.all
    respond_with(@companies)
  end
end
