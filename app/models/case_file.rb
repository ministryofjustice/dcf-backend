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


  after_initialize :generate_urn


  
  private

  def generate_urn
    self.urn = sprintf('%2d%2s%05d%02d', FORCE_CODE, ASU, 1 + rand(49999), Date.today.strftime('%y')) if self.urn.blank?
  end





end

