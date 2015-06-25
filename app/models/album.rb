# == Schema Information
#
# Table name: albums
#
#  id             :integer          not null, primary key
#  name           :string           not null
#  band_id        :integer          not null
#  created_at     :datetime
#  updated_at     :datetime
#  recording_type :string
#

class Album < ActiveRecord::Base
  validates :name, :band_id, :recording_type, presence: true
  belongs_to(
    :band,
    class_name: 'Band'
  )
  has_many(
    :tracks,
    class_name: 'Track',
    dependent: :destroy
  )

end
