require 'spec_helper'

describe "blocks/edit" do
  before(:each) do
    @block = assign(:block, stub_model(Block,
      :title => "MyString",
      :block_type => "MyString",
      :description => "MyText"
    ))
  end

  it "renders the edit block form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => blocks_path(@block), :method => "post" do
      assert_select "input#block_title", :name => "block[title]"
      assert_select "input#block_block_type", :name => "block[block_type]"
      assert_select "textarea#block_description", :name => "block[description]"
    end
  end
end
