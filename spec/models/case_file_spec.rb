# == Schema Information
#
# Table name: case_files
#
#  id         :integer          not null, primary key
#  urn        :string(255)
#  blob       :text
#  created_at :datetime
#  updated_at :datetime
#  urn_id     :integer
#

require 'rails_helper'

RSpec.describe CaseFile, type: :model do
  

  describe '#urn_code' do
    it 'should generate and save a urn record for the new case_file record' do
      Timecop.freeze(Date.new(2017,4,6)) do
        cf = CaseFile.new(blob: nil)
        expect(cf.urn).to be_instance_of(Urn)
        expect(cf.urn.id).not_to be_nil
        expect(cf.urn_id).to eq(cf.urn.id)
        expect(cf.urn_code).to eq sprintf("06JJ%05d17", cf.urn.id)
      end
    end


    it 'should keep the same urn linkage after saving and re-reading' do
      cf = CaseFile.new(blob: nil)
      cf.save
      original_urn_code = cf.urn_code
      cf2 = CaseFile.find(cf.id)
      expect(cf2.urn_code).to eq original_urn_code
    end
  end


  describe '#update_blob' do
    context 'hash one-level deep' do

      let(:blob)  { {'date' => '20150213T1245', 'location' => '34 High Street'} }

      it 'should update a nil blob with a new hash' do
        cf = CaseFile.new(blob: nil)
        cf.update_blob blob.to_json
        expect(cf.blob).to eq blob
      end
      
      it 'should add new fields to an existing blob' do
        cf = CaseFile.new(blob: blob)
        new_blob = {'postcode' => 'RG2 7PU', 'officer' => 'P.C. Smith'}
        cf.update_blob(new_blob.to_json)
        expect(cf.blob).to eq( {'date' => '20150213T1245', 'location' => '34 High Street', 'postcode' => 'RG2 7PU', 'officer' => 'P.C. Smith'} )
      end

      it 'should replace fields in an existing blob' do
        cf = CaseFile.new(blob: blob)
        new_blob = {'date' => '19900213T1245', 'location' => '34 Broadway'}
        cf.update_blob(new_blob.to_json)
        expect(cf.blob).to eq new_blob
      end

      it 'should both add and replace fields in an existing blob' do
        cf = CaseFile.new(blob: blob)
        new_blob = {'location' => '34 Broadway', 'postcode' => 'RG2 7PU'}
        cf.update_blob(new_blob.to_json)
        expect(cf.blob).to eq( {'date' => '20150213T1245', 'location' => '34 Broadway', 'postcode' => 'RG2 7PU'} )
      end
    end

    context 'multi_level_hash' do
      let(:blob) do
        {
          'date' => '20150213T1245',
          'incident' => {
            'location' => '34 High Street',
            'postcode' => 'SW10 9LB'
          },
          'defendant' => {
            'name' => {
              'given_name' => 'Joe',
              'surname' => 'Blow'
            },
            'dob' => '19530412',
            'address' => {
              'house_number' => '50',
              'road' => 'Tregunter Road',
              'city' => 'Reading',
              'postcode' => 'RG2 7PU'
            }
          }
        }
      end

      it 'should add new fields at a lower level' do
        cf = CaseFile.new(blob: blob)
        new_blob = {'incident' => { 'postcode' => 'SW1H 9AJ' }, 'defendant' => {'address' => {'locality' => 'Whitley Wood' } } }
        cf.update_blob(new_blob.to_json)
        expect(cf.blob).to eq blob1
      end
    end
  end

end


def blob1
  {
    'date' => '20150213T1245',
    'incident' => {
      'location' => '34 High Street',
      'postcode' => 'SW1H 9AJ'
    },
    'defendant' => {
      'name' => {
        'given_name' => 'Joe',
        'surname' => 'Blow'
      },
      'dob' => '19530412',
      'address' => {
        'house_number' => '50',
        'road' => 'Tregunter Road',
        'city' => 'Reading',
        'postcode' => 'RG2 7PU',
        'locality' => 'Whitley Wood'
      }
    }
  }
end
