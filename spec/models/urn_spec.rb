# == Schema Information
#
# Table name: urns
#
#  id         :integer          not null, primary key
#  force_code :string(255)
#  year_code  :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'rails_helper'

RSpec.describe Urn, type: :model do
  
  let(:urn)  { Urn.new(force_code: '0601') }

  it { should validate_presence_of(:force_code) }
  it { should validate_presence_of(:year_code) }
  it { should validate_numericality_of(:year_code) }

  describe '.new' do
    it 'should insert year code' do
      Timecop.freeze(Date.new(2015, 3, 5)) do
        expect(urn.year_code).to eq '15'
      end

      Timecop.freeze(Date.new(2003, 1, 4)) do
        urn = Urn.new(force_code: '0601')
        expect(urn.year_code).to eq '03'
      end
    end

  end


  describe '#urn_code' do 
    it 'should force a save on a new record to generate the id' do
      expect(urn.urn_code).to match /^0601[0-9]{5}15$/
    end 

    it 'should not create a second record if the record is saved twice' do
      original_urn_code = urn.urn_code
      urn.save!
      expect(urn.urn_code).to eq original_urn_code
    end

  end



end
