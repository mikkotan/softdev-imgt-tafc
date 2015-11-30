class RelatedCost < ActiveRecord::Base
  include Modules::InfoHashable

  belongs_to :service
  validates :nature, presence: true
  validates :value, numericality: { greater_than_or_equal_to: 0 }

  def make
    @new_thing = dup
    @new_thing.is_template = false

    @new_thing
  end
end
