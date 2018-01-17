require 'spec_helper'

module ZapierRestHooks
  RSpec.describe Hook, type: :model do
    let(:organization) { create(:organization) }
    let(:target_url) { 'https://zapier.com/hooks/standard/wpGRPPcRxZt2GxBbSSeUAlWPBnhLiRWB/' }
    describe 'Validations' do
      it 'has a valid factory' do
        expect(build(:hook, owner_id: organization.id, owner_class_name: organization.class.name)).to be_valid
        expect(build(:hook)).to be_valid
      end

      it { is_expected.to validate_presence_of(:event_name) }
      it { is_expected.to validate_presence_of(:target_url) }
    end
    describe '.hooks_exist?' do
      before do
        create(:hook, event_name: 'new_candidate', owner_id: organization.id, owner_class_name: organization.class.name)
        create(:hook, event_name: 'new_global_candidate')
      end
      it 'tests whether any hooks exist for a given event_name and owner' do
        expect(Hook.hooks_exist?('new_candidate', organization)).to be_truthy
        expect(Hook.hooks_exist?('new_global_candidate')).to be_truthy
        Hook.destroy_all
        expect(Hook.hooks_exist?('new_candidate', organization)).to be_falsey
        expect(Hook.hooks_exist?('new_global_candidate')).to be_falsey
      end
    end
    describe '.hooks' do
      let!(:first_hook) {
        create(
          :hook,
          event_name: 'new_candidate',
          owner_id: organization.id,
          owner_class_name: organization.class.name
        )
      }
      it 'Returns all hooks for a given event_name and owner.' do
        hooks = Hook.hooks('new_candidate', organization)
        expect(hooks.size).to eq(1)
        expect(hooks.first).to eq(first_hook)

        second_hook =
          Hook.create(
            event_name: 'new_candidate',
            owner_id: organization.id,
            owner_class_name: organization.class.name,
            target_url: target_url
          )

        hooks = Hook.hooks('new_candidate', organization)
        expect(hooks.size).to eq(2)
        expect(second_hook).to eq(hooks.last)
      end
    end
    describe '.trigger' do
      let(:candidate) { create(:candidate) }

      before do
        create(
          :hook,
          event_name: 'new_candidate',
          target_url: target_url,
          owner_id: organization.id,
          owner_class_name: organization.class.name
        )
      end
      context 'when response code is different than `410`' do
        it 'sends the post request' do
          FakeWeb.register_uri(
            :post,
            target_url,
            body: 'irrelevant',
            status: %w(200 Triggered)
          )

          Hook.trigger('new_candidate', candidate.to_json, organization)
          expect(FakeWeb.last_request.method).to eq('POST')
          expect(Hook.count).to eq(1) # The hook should not have been deleted.
        end
      end
      context 'when response code is `410`' do
        it 'sends the post request and deletes the hook' do
          FakeWeb.register_uri(
            :post,
            target_url,
            body: 'irrelevant',
            status: ['410', 'Danger, Will Robinson!']
          )

          Hook.trigger('new_candidate', candidate.to_json, organization)
          expect(FakeWeb.last_request.method).to eq('POST')
          # The 410 response should trigger removal of the hook.
          expect(Hook.count).to eq(0)
        end
      end
    end
  end
end
