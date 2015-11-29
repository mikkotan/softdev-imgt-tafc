class Service < ActiveRecord::Base
  has_many :related_costs

  def complete_name
    return name if service_type == 'none'
    "#{name} w/ #{service_type}"
  end

  def total_cost
    monthly_fee + related_costs.inject(0) {|sum, item| sum + item.value}
  end

  def make
    @new_thing = dup
    @new_thing.is_template = false

    @new_thing
  end

  def info_hash
    attributes.delete_if{ |key, value| ["updated_at", "created_at", "id", "is_template"].include? key }
  end

  def ==(y)
    info_hash == y.info_hash
  end
end
