require 'spec_helper'

describe "blocks/index" do
  before(:each) do
    assign(:blocks, [
      stub_model(Block,
        :title => "Title",
        :block_type => "Block Type",
        :description => "MyText"
      ),
      stub_model(Block,
        :title => "Title",
        :block_type => "Block Type",
        :description => "MyText"
      )
    ])
  end

  it "renders a list of blocks" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "Block Type".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
