FactoryGirl.define do
  factory :transaction do
    billing_num '111'
    vat 0
    percentage 0
    retainers_fee 500
  end

  factory :full_transaction, class: Transaction do
    billing_num '112'
    retainers_fee 500
    employee_benefit_sss 300
    employee_benefit_philhealth 100
    employee_benefit_pag_ibig 200
    withholding_1601c 500
    withholding_1601e 300
    vat 800
    percentage 0
  end
end
