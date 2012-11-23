require 'spec_helper'

describe Block do
  it 'sets up the types' do
    Block.block_types.should_not be_empty
  end
end
