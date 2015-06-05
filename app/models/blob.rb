class Blob < ActiveRecord::Base
  belongs_to :step
  delegate :pipeline, to: :step

  serialize :data

  validates :unique_id, uniqueness: true
end
