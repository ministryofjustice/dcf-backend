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

class CaseFile < ActiveRecord::Base

  belongs_to :urn

  FORCE_CODE = '0601'

  serialize :blob, Hash
  scope :by_id, -> { all.order(:id) }
  after_initialize :generate_urn_and_empty_blob


  def update_blob(blob_updates_as_json)
    blob_updates = ActiveSupport::JSON.decode blob_updates_as_json
    blob_obj = Blob.new(self.blob)
    blob_obj.update(blob_updates)
    self.blob = blob_obj.data
    self.save!
  end

  def urn_code
    self.urn.urn_code
  end

  
  private

  def generate_urn_and_empty_blob
    if self.urn.nil?
      self.urn = Urn.new(force_code: FORCE_CODE)
      self.save
    end
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

