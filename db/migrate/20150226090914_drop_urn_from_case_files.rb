class DropUrnFromCaseFiles < ActiveRecord::Migration
  def change
    remove_column :case_files, :urn
  end
end
