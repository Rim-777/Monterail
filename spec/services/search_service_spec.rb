require 'rails_helper'

describe 'search service' do
  describe '#initialize' do
    let(:query) { 'Monterail, Inc' }
    let(:company_category) { 'Company' }
    let(:operation_category) { 'Operation' }

    it 'should  receive search for User class' do
      expect(Company).to receive(:search)
      SearchService.new(query, company_category)
    end

    it 'should  receive search for Skill class' do
      expect(Operation).to receive(:search)
      SearchService.new(query, operation_category)
    end

    it 'should  receive search for ThinkingSphinx class' do
      expect(ThinkingSphinx).to receive(:search)
      SearchService.new(query, nil)
    end
  end
end
