require 'rails_helper'

RSpec.describe Service, type: :model do
  it 'has a monthly fee' do
    create(:service)
    @service = Service.find 1

    expect(@service.complete_name).to eq 'Service A'
    expect(@service.monthly_fee).to eq 5000
  end

  it 'can have a service type' do
    create(:service, service_type: 'Type A')
    @service = Service.find 1

    expect(@service.complete_name).to eq 'Service A w/ Type A'
    expect(@service.monthly_fee).to eq 5000
  end

  it 'can have other related costs' do
    create(:service)
    @service = Service.find 1
    @service.related_costs << build(:related_cost)

    expect(@service.related_costs[0].value).to eq 250
    expect(@service.related_costs[0].nature).to eq 'Registration fee'
  end

  it 'calculates total cost from all other listed fees' do
    create :service
    create :related_cost
    create :related_cost, nature: 'BIR Fee', value: 750

    @service = Service.find 1
    @service.related_costs << RelatedCost.find(1)
    @service.related_costs << RelatedCost.find(2)

    expect(@service.total_cost).to eq 6000
  end

  it 'defaults to is_template == true' do
    create(:service)
    @service = Service.find 1

    expect(@service.is_template).to eq true
  end

  it 'can make "real" non-template services' do
    create(:service)
    @service = Service.find 1

    @real_service = @service.make
    @real_service.save

    @test_service = Service.find 2
    expect(@test_service.is_template).to eq false
    expect(@test_service).to eq @service
  end

  it 'can return only the important info of a service' do
    create(:service)
    @service = Service.find 1

    expect(@service.info_hash).to eq({'name' => 'Service A',
      'service_type' => 'none',
      'monthly_fee' => 5000})
  end

  it 'has its type default to none' do
    create(:service, service_type: '')
    @service = Service.find 1

    expect(@service.service_type).to eq 'none'
  end

  it 'can not have a fee of lower than zero' do
    @service = build(:service, monthly_fee: '-5')

    expect(@service).to_not be_valid
  end

  it 'templates to only related cost templates' do
    @service = build(:service)
    @valid_related_cost = build(:related_cost)
    @invalid_related_cost = build(:related_cost, is_template: false)

    @service.related_costs << @valid_related_cost

    expect(@service).to be_valid

    @service.related_costs << @invalid_related_cost

    expect(@service).to_not be_valid
  end

  it 'non-templates to only related cost non templates' do
    @service = build(:service, is_template: false)
    @valid_related_cost = build(:related_cost, is_template: false)
    @invalid_related_cost = build(:related_cost)

    @service.related_costs << @valid_related_cost

    expect(@service).to be_valid

    @service.related_costs << @invalid_related_cost

    expect(@service).to_not be_valid
  end
end
