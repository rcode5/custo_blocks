require 'spec_helper'

describe "blocks/index" do
  before(:each) do
    @blocks = assign(:blocks, [
                     stub_model(Block,
                                :title => "Rock Title",
                                :block_type => "RockBlock",
                                ),
                     stub_model(Block,
                                :title => "Super Title",
                                :block_type => "SuperBlock",
                                )
                    ])
    assign(:blocks_by_type, @blocks.inject({}) {|result,item| (result[item.block_type] ||= []) << item; result})
  end
  
  it "renders a list of blocks" do
    render
    assert_select "tr>td", :text => "Super Title".to_s, :count => 1
    assert_select "tr>td", :text => "Rock Title".to_s, :count => 1
  end
  
  it 'renders new buttons for each block type' do
    render
    @blocks.map(&:block_type).compact.uniq.each do |type|
      assert_select "a[href=/blocks/new?type=#{type}]"
    end
  end

end
