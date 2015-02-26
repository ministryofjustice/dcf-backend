# == Schema Information
#
# Table name: urns
#
#  id         :integer          not null, primary key
#  force_code :string(255)
#  year_code  :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Urn < ActiveRecord::Base

  validates :force_code, :year_code, presence: true
  validates :year_code, numericality: true

  after_initialize :populate_year_code

  def urn_code
    save! if new_record?
    sprintf("%s%05d%s", self.force_code, self.id, self.year_code)
  end



  private

  def populate_year_code
    self.year_code = Date.today.strftime('%y')
  end


end
