class Service < ActiveRecord::Base
  has_many :related_costs

  def complete_name
    return name if service_type == 'none'
    "#{name} w/ #{service_type}"
  end

  def total_cost
    monthly_fee + related_costs.inject(0) {|sum, item| sum + item.value}
  end
end
