class Transaction < ActiveRecord::Base
  belongs_to :client

  has_many :other_processing_fees, class_name: "Service"
  has_many :provisional_receipts

  validates :billing_num, presence: true, uniqueness: true
  validates :retainers_fee, presence: true
  validate :can_not_have_values_for_both_vat_and_percentage
  validate :can_not_have_services_that_are_templates

  def can_not_have_values_for_both_vat_and_percentage
    unless vat && percentage
      return
    end
    if vat > 0 && percentage > 0
      errors.add(:vat, " and percentage can't have values at the same time!")
    end
  end

  def employee
    client.user_name
  end

  def can_not_have_services_that_are_templates
    other_processing_fees.each do |service|
      next unless service.is_template

      errors.add(:other_processing_fees, " can't have template services!")
      break
    end
  end

  def total_of_processing_fees
    other_processing_fees.inject(0) { |sum, fee| sum + fee.total_cost }
  end

  def total_balance
    if discount
      (get_fees.values.inject(0) { |sum, value| sum + (value || 0) }) * ( 1 - ( discount / 100 ) )
    else
      get_fees.values.inject(0) { |sum, value| sum + (value || 0) }
    end
  end

  def get_transaction_payments
    provisional_receipts
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

  def remaining_balance
    total_balance - provisional_receipts.inject(0){|sum, receipt| sum + receipt.amount_paid}
  end

  def pending?
    remaining_balance != 0
  end

  def pay(receipt_no, amount_paid, note)
    raise 'Transaction is already paid for.' if remaining_balance == 0

    provisional_receipts << ProvisionalReceipt.create(
      receipt_no: receipt_no,
      amount_paid: amount_paid,
      note: note
    )
  end

  def self.pending_transactions
    Transaction.all.select {|transaction| transaction.pending? }
  end

  def self.filtered_pending_transactions(startdate, enddate)
    where(:created_at => startdate..enddate)
  end

  def service_names
    other_processing_fees.collect {|service| service.complete_name }
  end

  def filtered_service_names(startdate, enddate)
    other_processing_fees.where(:created_at => startdate..enddate).collect {|service| service.complete_name }
  end


  def update_info(params)
    nice = true
    params.each do |key, value|
      nice &&= update_column key, value
    end
    nice
  end
end
