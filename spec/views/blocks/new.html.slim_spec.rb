require 'spec_helper'

describe "blocks/new" do
  before(:each) do
    assign(:block, stub_model(Block,
      :title => "MyString",
      :block_type => "MyString"
    ).as_new_record)
  end

  it "renders new block form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => blocks_path, :method => "post" do
      assert_select "input#block_title", :name => "block[title]"
      assert_select "input#block_block_type", :name => "block[block_type]"
    end
  end

  it "renders dynamic attributes" do
    assign(:block, stub_model(Block,
      :title => "MyString",
      :block_type => "RockBlock"
    ).as_new_record)
    render
    assert_select "form", :action => blocks_path, :method => "post" do |tag|
      assert_select "input#block_rock", :name => "block[rock]"
      assert_select "textarea#block_roll", :name => "block[roll]"
    end
  end

end
