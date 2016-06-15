require 'spec_helper'

module ZapierRestHooks
  RSpec.describe HooksController, type: :controller do
    routes { ZapierRestHooks::Engine.routes }

    before :each do
      request.env["HTTP_ACCEPT"] = 'application/json'
    end

    describe "POST #create" do
      it 'creates a new hook' do
        expect {
          post :create, attributes_for(:hook)
        }.to change(Hook, :count).by(1)
      end
    end

    describe "DELETE #destroy" do
      let!(:hook) { create(:hook) }
      it 'destroys the requested font' do
        expect {
          delete :destroy, id: hook
        }.to change(Hook, :count).by(-1)
      end
    end
  end
end
