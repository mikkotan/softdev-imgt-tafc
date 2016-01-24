FactoryGirl.define do
  factory :provisional_receipt do
    paid_items({'x' => 100, 'y'  => 150})
    amount_paid 250
    receipt_no "001"
  end
end
