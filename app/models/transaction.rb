class Transaction < ActiveRecord::Base
  belongs_to :client

  has_many :other_processing_fees, class_name: "Service"
  validates :billing_num, presence: true, uniqueness: true
  validates :retainers_fee, presence: true
  validate :can_not_have_values_for_both_vat_and_percentage
  validate :can_not_have_services_that_are_templates

  def can_not_have_values_for_both_vat_and_percentage
    if vat > 0 && percentage > 0
      errors.add(:vat, " and percentage can't have values at the same time!")
    end
  end

  def can_not_have_services_that_are_templates
    other_processing_fees.each do |service|
      next unless service.is_template

      errors.add(:other_processing_fees, " can't have template services!")
      break
    end
  end

  def total_of_processing_fees
    other_processing_fees.inject(0) { |sum, service| sum + service.total_cost }
  end

  def total_balance
    get_fees.values.inject(:+)
  end

  def get_fees
    { 'Retainers Fee' => retainers_fee,
      'Employee Benefit SSS' => employee_benefit_sss,
      'Employee Benefit PhilHealth' => employee_benefit_philhealth,
      'Employee Benefit Pag-ibig' => employee_benefit_pag_ibig,
      'Withholding 1601C ' => withholding_1601c,
      'Withholding 1601E' => withholding_1601e,
      'VAT' => vat,
      'Percentage' => percentage,
      'Other Processing Fees' => total_of_processing_fees }
  end
end
