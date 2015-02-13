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

class CaseFile < ActiveRecord::Base

  FORCE_CODE  = 99
  ASU         = 'XX'

  serialize :blob, Hash
  scope :by_id, -> { all.order(:id) }
  after_initialize :generate_urn_and_empty_blob


  def update_blob(new_blob)
    blob_obj = Blob.new(self.blob)
    blob_obj.update(new_blob)
    self.blob = blob_obj.data
  end


  
  private

  def generate_urn_and_empty_blob
    self.urn = sprintf('%2d%2s%05d%02d', FORCE_CODE, ASU, 1 + rand(49999), Date.today.strftime('%y')) if self.urn.blank?
    self.blob = Blob.new.data if self.blob.nil?
  end


  def recursive_merge( merge_from, merge_to )
    merged_hash = merge_to.clone
    first_key = merge_from.keys[0]
    if merge_to.has_key?(first_key)
        merged_hash[first_key] = recursive_merge( merge_from[first_key], merge_to[first_key] )
    else
        merged_hash[first_key] = merge_from[first_key]
    end
    merged_hash
end



end

