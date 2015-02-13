require 'rails_helper'


describe Blob do

  describe '.new' do
    it 'should be instantiated from a hash' do
      blob = Blob.new('date' => '20150214', 'time' => '0433')
      expect(blob.data).to eq({'date' => '20150214', 'time' => '0433'})
    end
    it 'should be instantiated from nil' do
      blob = Blob.new
      expect(blob.data).to eq( {} )
    end
  end


  describe '#merge' do
    context 'single level' do
      it 'should add new fields' do
        blob = Blob.new('surname' => 'Blow')
        blob.update({'given_name' => 'Joe'})
        expect(blob.data).to eq( {'surname' => 'Blow', 'given_name' => 'Joe'} )
      end

      it 'should replace existing fields' do
        blob = Blob.new( {'surname' => 'Blow', 'given_name' => 'Joe'} )
        blob.update('given_name' => 'Jane')
        expect(blob.data).to eq( {'surname' => 'Blow', 'given_name' => 'Jane'} )
      end
    end

    context 'two_level' do

      let(:blob) { Blob.new( { 'date' => '20150213', 'defendant' => {'name' => 'Joe Blow', 'dob' => '19630813'}, 'witness' => {'name' => 'Jane Doe'} } ) }
      it 'should add new fields' do
        blob.update( {'time' => '0455', 'defendant' => {'gender' => 'male'} } )
        expect(blob.data).to eq( { 
            'date' => '20150213', 
            'time' => '0455', 
            'defendant' => {
              'name' => 'Joe Blow', 
              'dob' => '19630813', 
              'gender' => 'male'
            }, 
            'witness' => {
              'name' => 'Jane Doe'
            } 
          } )
      end

      it 'should replace existing fields' do
        blob.update({ 'date' => '20101213', 'defendant' => {'name' => 'John Smith'}} )
        expected_blob = { 
            'date' => '20101213', 
            'defendant' => {
              'name' => 'John Smith', 
              'dob' => '19630813'
            }, 
            'witness' => {
              'name' => 'Jane Doe'
            } 
          }
        expect(blob.data).to eq(expected_blob)
      end

      it 'should both replace existing fields and add new fields' do
        blob.update({ 'date' => '20101213', 'defendant' => {'name' => 'John Smith', 'occupation' => 'burglar'}} )
        expected_blob = { 
            'date' => '20101213', 
            'defendant' => {
              'dob' => '19630813',
              'name' => 'John Smith', 
              'occupation' => 'burglar'
            }, 
            'witness' => {
              'name' => 'Jane Doe'
            } 
          }
        expect(blob.data).to eq(expected_blob)
      end

      it 'should add new sublevels' do
        blob.update(
          { 
            'date' => '20101213', 
            'defendant' => {
              'name' => 'John Smith', 
              'occupation' => 'burglar'
            }, 
            'police_officer' => {
              'name' => 'PC Dixon', 
              'num' => 'PC1234'
            } 
          })
        expected_blob = { 
            'date' => '20101213', 
            'defendant' => {
              'dob' => '19630813',
              'name' => 'John Smith', 
              'occupation' => 'burglar'
            }, 
            'witness' => {
              'name' => 'Jane Doe'
            },
            'police_officer' => {
              'name' => 'PC Dixon',
              'num' => 'PC1234'
            }
          }
        expect(blob.data).to eq(expected_blob)
      end


      it 'should add at a newer level' do
        blob = Blob.new(original_blob)
        blob.update(update_blob)
        expect(blob.data).to eq expected_new_blob

      end
      
    end
  end
end


def original_blob
  {
         "date" => "20150213T1245",
     "incident" => {
        "location" => "34 High Street",
        "postcode" => "SW10 9LB"
    },
    "defendant" => {
           "name" => {
            "given_name" => "Joe",
               "surname" => "Blow"
        },
        "dob" => "19530412",
        "address" => {
            "house_number" => "50",
                    "road" => "Tregunter Road",
                    "city" => "Reading",
                "postcode" => "RG2 7PU"
        }
    }
  }
end

def update_blob
  {
     "incident" => {
        "postcode" => "SW1H 9AJ"
    },
    "defendant" => {
        "address" => {
            "locality" => "Whitley Wood"
        }
    }
  }
end

def expected_new_blob
  {
    "date"=>"20150213T1245", 
    "incident"=>{
      "location"=>"34 High Street", 
      "postcode"=>"SW1H 9AJ"
    }, 
    "defendant"=>{
      "name"=>{
        "given_name"=>"Joe", 
        "surname"=>"Blow"
      }, 
      "dob"=>"19530412", 
      "address"=>{
        "house_number"=>"50", 
        "road"=>"Tregunter Road", 
        "city"=>"Reading", 
        "postcode"=>"RG2 7PU", 
        "locality"=>"Whitley Wood"
      }
    }
  }
end

