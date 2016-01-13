require 'rails_helper'

RSpec.describe 'Group events API' do
  
  it 'should return a list of group events' do
    FactoryGirl.create_list(:group_event, 10)

    get '/group_events'

    json = JSON.parse(response.body)

    expect(json.length).to eq 10
  end

  it 'should return a single group event object' do
    group_event = FactoryGirl.create(:group_event)

    get "/group_events/#{group_event.id}/"

    json = JSON.parse(response.body)

    expect(json['name']).to eq group_event.name
  end

  it 'should create a record from given a json' do
    group_event = FactoryGirl.build(:group_event)

    post "/group_events", group_event: group_event.as_json

    expect(GroupEvent.last.name).to eq group_event.name
  end

  it 'should update a record from a given json' do
    group_event = FactoryGirl.create(:group_event)
    group_event.name = "New name"

    patch "/group_events/#{group_event.id}",group_event: group_event.as_json 

    expect(GroupEvent.find(group_event.id).name).to eq group_event.name
  end

  it 'should destroy a record' do
    group_event = FactoryGirl.create(:group_event)
     
    delete "/group_events/#{group_event.id}"

    expect(GroupEvent.find(group_event.id).is_destroyed).to eq true
  end

  it 'should publish a record' do
    group_event = FactoryGirl.create(:group_event)
    
    get "/group_events/#{group_event.id}/publish"

    expect(GroupEvent.find(group_event.id).is_published).to be true
  end
end 
