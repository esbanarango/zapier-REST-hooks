require 'spec_helper'

module ZapierRestHooks
  RSpec.describe Hook, type: :model do
    let(:organization) { create(:organization) }
    describe 'Validations' do
      it 'has a valid factory' do
        expect(build(:hook, owner_id:organization.id, owner_class_name: organization.class.name)).to be_valid
      end

      it { is_expected.to validate_presence_of(:event_name)}
      it { is_expected.to validate_presence_of(:owner_id)}
      it { is_expected.to validate_presence_of(:owner_class_name)}
      it { is_expected.to validate_presence_of(:subscription_url)}
      it { is_expected.to validate_presence_of(:target_url)}
    end
  end
end
