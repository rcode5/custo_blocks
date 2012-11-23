require 'spec_helper'

describe "blocks/show" do
  before(:each) do
    @block = assign(:block, stub_model(Block,
                                       title: "Title",
                                       block_type: "RockBlock",
                                       extensions: {rock: 'granite'}
                                       ))
  end

  it "renders the title" do
    render
    rendered.should match(/Title/)
  end

  it 'renders the specific block template' do
    render
    rendered.should match(/granite/)
  end

end
