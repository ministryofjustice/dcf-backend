# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)



case_files = CaseFile.create(
  [
    {
      blob: {'postcode' => 'SW10 9LB', 'date' => '20150214T145521', 'witness' => {'name' => 'Joe Blow', 'dob' => '19650517'}}
    },
    {
      blob: {'postcode' => 'RG2 7PU', 'date' => '20150101T030545', 'witness' => {'name' => 'Jane Doe', 'dob' => '19650517'}}
    },
  ]
)