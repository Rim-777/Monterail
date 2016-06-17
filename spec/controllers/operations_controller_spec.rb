require 'rails_helper'

RSpec.describe OperationsController, type: :controller do
  describe 'GET #index' do
    let!(:operations) { create_list(:operation, 2) }

    before {get :index, format: :json}

    it 'populates an array of all operations' do
      expect(assigns(:operations)).to match_array(operations)
    end

  end
end
