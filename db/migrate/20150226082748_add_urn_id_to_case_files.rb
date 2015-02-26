class AddUrnIdToCaseFiles < ActiveRecord::Migration
  def change
    add_column :case_files, :urn_id, :integer
  end
end
