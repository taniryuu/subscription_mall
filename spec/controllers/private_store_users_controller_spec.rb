require 'rails_helper'

RSpec.describe PrivateStoreUsersController, type: :controller do

  describe "GET #ticket" do
    it "returns http success" do
      get :ticket
      expect(response).to have_http_status(:success)
    end
  end

end
