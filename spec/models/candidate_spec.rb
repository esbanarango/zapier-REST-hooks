require 'spec_helper'

RSpec.describe Candidate, type: :model do
  let(:subscription_url) { 'https://zapier.com/hooks/standard/wpGRPPcRxZt2GxBbSSeUAlWPBnhLiRWB/' }
  let(:target_url) {  'https://zapier.com/hooks/standard/wpGRPPcRxZt2GxBbSSeUAlWPBnhLiRWB/' }

  describe 'Callback' do
    context 'when owner is specified' do
      it 'triggers rest hook on creation' do
        organization = create(:organization)

        ZapierRestHooks::Hook.create(
          event_name: 'new_candidate',
          owner_class_name: organization.class.name,
          owner_id: organization.id,
          subscription_url: subscription_url,
          target_url: target_url
        )

        FakeWeb.register_uri(
          :post,
          target_url,
          body: 'irrelevant',
          status: %w(200 Triggered)
        )

        candidate = create(:candidate, organization: organization)
        expect(FakeWeb.last_request.method).to eq('POST')
      end
    end
    context 'when owner is not specified' do
      it 'triggers rest hook on creation' do
        ZapierRestHooks::Hook.create(
          event_name: 'new_candidate',
          subscription_url: subscription_url,
          target_url: target_url
        )

        FakeWeb.register_uri(
          :post,
          target_url,
          body: 'irrelevant',
          status: %w(200 Triggered)
        )

        candidate = create(:candidate, organization: nil)
        expect(FakeWeb.last_request.method).to eq('POST')
      end
    end
  end
end
