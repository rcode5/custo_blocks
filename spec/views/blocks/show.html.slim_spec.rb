require 'spec_helper'

describe "blocks/show" do
  before(:each) do
    @block = assign(:block, stub_model(Block,
      :title => "Title",
      :block_type => "Block Type",
      :description => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
    rendered.should match(/Block Type/)
    rendered.should match(/MyText/)
  end
end
