require 'rails_helper'

RSpec.describe ReportsController, type: :controller do

  describe "GET #accounts_receivable" do
    it "returns http success" do
      get :accounts_receivable
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #employees_report" do
    it "returns http success" do
      get :employees_report
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #transactions_report" do
    it "returns http success" do
      get :transactions_report
      expect(response).to have_http_status(:success)
    end
  end

end
