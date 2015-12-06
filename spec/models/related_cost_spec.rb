require 'rails_helper'

RSpec.describe RelatedCost, type: :model do
  it 'can not have a blank nature' do
    @related_cost = build :related_cost, nature: ''

    expect(@related_cost).to_not be_valid
  end

  it 'can not have a value of lower than zero' do
    @related_cost = build :related_cost, value: -100

    expect(@related_cost).to_not be_valid
  end
  
  it 'can make "real" non-template related costs' do
    create :related_cost
    @related_cost = RelatedCost.find 1

    @real_related_cost = @related_cost.make
    @real_related_cost.save

    @test_related_cost = RelatedCost.find 2
    expect(@test_related_cost.is_template).to eq false
    expect(@test_related_cost).to eq @related_cost
  end
end
