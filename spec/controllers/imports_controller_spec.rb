require 'rails_helper'

RSpec.describe ImportsController, type: :controller do
  describe 'POST #create' do
    let!(:file) { File.open(Rails.root.join("spec/support/files/test.csv")) }
    let(:request) { post :create, import: attributes_for(:import).merge(file: file), format: :json }

    it 'saves new question in database' do
      expect { request }.to change(Import, :count).by(1)
    end

    it 'makes redirect_to root page' do
      request
      expect(response).to redirect_to companies_path
    end
  end
end
