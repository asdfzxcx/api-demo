require 'rails_helper'

RSpec.describe GroupEvent, type: :model do
  before { @group_event = GroupEvent.new }
  
  it 'should run for a whole number of days' do
    @group_event.duration = 1.23
    expect(@group_event).not_to be_valid

    @group_event.duration = 123
    expect(@group_event).to be_valid
  end

  it 'given duration should be greater than zero' do
    @group_event.duration = -5
    expect(@group_event).not_to be_valid

    @group_event.duration = 0
    expect(@group_event).not_to be_valid
  end

  it 'can be saved with only subset of fields set' do
    expect(@group_event.save).to be true
  end

  it 'end date can not precede start date' do
    @group_event.starts_at = '2016-05-05'
    @group_event.ends_at = '2016-04-04'
    expect(@group_event).not_to be_valid
  end

  it 'can be published only if all fields are present' do
    @group_event.save
    @group_event.publish
    expect(@group_event.is_published).to be false

    @group_event = FactoryGirl.build(:group_event)
    @group_event.save
    @group_event.publish
    expect(@group_event.is_published).to be true
  end

  it 'should return unmarked entries' do
    FactoryGirl.create_list(:group_event, 5)
    group_event = FactoryGirl.create(:group_event)
    group_event.mark_as_destroyed
    unmarked_entries = GroupEvent.unmarked
    expect(unmarked_entries).not_to include group_event
  end
end

