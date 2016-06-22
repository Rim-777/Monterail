require 'rails_helper'

RSpec.describe FilesController, type: :controller do
  describe 'POST#create' do
    let!(:company) { create(:company) }

    it 'assigns the requested company to @company' do
      post :create, company_id: company.id, format: :js
      expect(assigns(:company)).to eq company
    end
  end
end
