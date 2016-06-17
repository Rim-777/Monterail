require 'rails_helper'

RSpec.describe CompaniesController, type: :controller do
  describe 'GET #index' do
    let!(:companies) { create_list(:company, 2) }

    before {get :index, format: :json}

    it 'populates an array of all companies' do
      expect(assigns(:companies)).to match_array(companies)
    end
  end
end
