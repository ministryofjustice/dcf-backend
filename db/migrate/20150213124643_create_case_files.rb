class CreateCaseFiles < ActiveRecord::Migration
  def change
    create_table :case_files do |t|
      t.string :urn
      t.text :blob

      t.timestamps
    end
  end
end
