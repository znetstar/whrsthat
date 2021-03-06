require 'rails_helper'

RSpec.describe "events/new", type: :view do
  before(:each) do
    assign(:event, Event.new(
      :title => "MyString",
      :caption => "MyString",
      :time_at => "MyString",
      :event_img_url => "MyString",
      :lng => 1,
      :lat => 1
    ))
  end

  it "renders new event form" do
    render

    assert_select "form[action=?][method=?]", events_path, "post" do

      assert_select "input#event_title[name=?]", "event[title]"

      assert_select "input#event_caption[name=?]", "event[caption]"

      assert_select "input#event_time_at[name=?]", "event[time_at]"

      assert_select "input#event_event_img_url[name=?]", "event[event_img_url]"

      assert_select "input#event_lng[name=?]", "event[lng]"

      assert_select "input#event_lat[name=?]", "event[lat]"
    end
  end
end
