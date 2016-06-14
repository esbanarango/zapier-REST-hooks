require 'spec_helper'
require 'fakeweb'

RSpec.describe Candidate, type: :model do
  let(:organization) { create(:organization) }
  let(:candidate) { build(:candidate, organization: organization) }

  describe 'Callback' do
    it 'triggers rest hook on creation' do
      subscription_url = "https://zapier.com/hooks/standard/wpGRPPcRxZt2GxBbSSeUAlWPBnhLiRWB/"
      target_url = "https://zapier.com/hooks/standard/wpGRPPcRxZt2GxBbSSeUAlWPBnhLiRWB/"

      hook = ZapierRestHooks::Hook.create(
        {
          event_name: 'new_candidate',
          owner_class_name: organization.class.name,
          owner_id: organization.id,
          subscription_url: subscription_url,
          target_url: target_url
        }
      )
      FakeWeb.register_uri(
        :post,
        target_url,
        body: 'irrelevant',
        status: ['200', 'Triggered']
      )

      candidate.save
      expect(FakeWeb.last_request.method).to eq('POST')
      expect(FakeWeb.last_request.body).to eq(candidate.to_json)
    end
  end
end