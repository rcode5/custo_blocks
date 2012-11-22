require 'spec_helper'

describe "blocks/new" do
  before(:each) do
    assign(:block, stub_model(Block,
      :title => "MyString",
      :block_type => "MyString",
      :description => "MyText"
    ).as_new_record)
  end

  it "renders new block form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => blocks_path, :method => "post" do
      assert_select "input#block_title", :name => "block[title]"
      assert_select "input#block_block_type", :name => "block[block_type]"
      assert_select "textarea#block_description", :name => "block[description]"
    end
  end
end
