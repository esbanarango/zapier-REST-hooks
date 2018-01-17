require 'spec_helper'

module ZapierRestHooks
  RSpec.describe HooksController, type: :controller do
    routes { ZapierRestHooks::Engine.routes }

    describe 'POST #create' do
      let(:hook_params) { attributes_for(:hook) }

      it 'creates a new hook' do
        expect {
          request_with_params(:post, :create, hook_params, :json)
        }.to change(Hook, :count).by(1)
      end
    end

    describe 'DELETE #destroy' do
      let!(:hook) { create(:hook) }
      let(:hook_params) { { id: hook.id } }

      it 'destroys the requested hook' do
        expect {
          request_with_params(:delete, :destroy, hook_params, :json)
        }.to change(Hook, :count).by(-1)
      end
    end

  end
end
