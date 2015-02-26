class CreateUrns < ActiveRecord::Migration
  def change
    create_table :urns do |t|
      t.string :force_code
      t.string :year_code

      t.timestamps
    end
  end
end
