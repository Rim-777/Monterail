class CompaniesController < ApplicationController
  respond_to :json

  def index
    headers['Last-Modified'] = Time.now.httpdate
    @companies = Company.all
    respond_with(@companies)
  end
end
