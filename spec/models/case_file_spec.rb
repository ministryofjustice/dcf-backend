# == Schema Information
#
# Table name: case_files
#
#  id         :integer          not null, primary key
#  urn        :string(255)
#  blob       :text
#  created_at :datetime
#  updated_at :datetime
#

require 'rails_helper'

RSpec.describe CaseFile, type: :model do
  
  describe 'urn generation' do
    it 'should generate a urn for a new record' do
      cf = CaseFile.new
      expect(cf.urn).not_to be_blank
    end

    it 'should not generate a urn for a record that already has one' do
      cf = CaseFile.new
      urn = cf.urn
      cf.save
      cf2 = CaseFile.find(cf.id)
      expect(cf2.urn).to eq cf.urn
    end

  end


end
