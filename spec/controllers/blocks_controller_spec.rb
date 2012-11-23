require 'spec_helper'

describe BlocksController do

  def valid_attributes
    { block_type: 'RockBlock',
      title: 'Rock it'}
  end

  describe "GET index" do
    it "assigns all blocks as @blocks" do
      block = Block.create! valid_attributes
      get :index, {}
      assigns(:blocks).should eq([block])
    end
  end

  describe "GET show" do
    let(:new_block){ Block.create! valid_attributes }
    before do
      new_block
      get :show, {:id => new_block.to_param}
    end
    it "assigns the requested block as @block" do
      assigns(:block).should eq(new_block)
    end
  end

  describe "GET new" do
    it "requires type" do
      get :new, {}
      response.should redirect_to '/blocks'
    end
    it "assigns a new block as @block" do
      get :new, {type: 'SuperBlock'}
      assigns(:block).should be_a_new(Block)
    end
  end

  describe "GET edit" do
    it "assigns the requested block as @block" do
      block = Block.create! valid_attributes
      get :edit, {:id => block.to_param}
      assigns(:block).should eq(block)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Block" do
        expect {
          post :create, {:block => valid_attributes}
        }.to change(Block, :count).by(1)
      end

      it "assigns a newly created block as @block" do
        post :create, {:block => valid_attributes}
        assigns(:block).should be_a(Block)
        assigns(:block).should be_persisted
      end

      it "redirects to the created block" do
        post :create, {:block => valid_attributes}
        response.should redirect_to(Block.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved block as @block" do
        # Trigger the behavior that occurs when invalid params are submitted
        Block.any_instance.stub(:save).and_return(false)
        post :create, {:block => {}}
        assigns(:block).should be_a_new(Block)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Block.any_instance.stub(:save).and_return(false)
        post :create, {:block => {}}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested block" do
        block = Block.create! valid_attributes
        # Assuming there are no other blocks in the database, this
        # specifies that the Block created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Block.any_instance.should_receive(:update_attributes).with({'these' => 'params'}, {without_protection: true})
        put :update, {:id => block.to_param, :block => {'these' => 'params'}}
      end

      it "assigns the requested block as @block" do
        block = Block.create! valid_attributes
        put :update, {:id => block.to_param, :block => valid_attributes}
        assigns(:block).should eq(block)
      end

      it "redirects to the block" do
        block = Block.create! valid_attributes
        put :update, {:id => block.to_param, :block => valid_attributes}
        response.should redirect_to(block)
      end
    end

    describe "with invalid params" do
      it "assigns the block as @block" do
        block = Block.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Block.any_instance.stub(:save).and_return(false)
        put :update, {:id => block.to_param, :block => {}}
        assigns(:block).should eq(block)
      end

      it "re-renders the 'edit' template" do
        block = Block.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Block.any_instance.stub(:save).and_return(false)
        put :update, {:id => block.to_param, :block => {}}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested block" do
      block = Block.create! valid_attributes
      expect {
        delete :destroy, {:id => block.to_param}
      }.to change(Block, :count).by(-1)
    end

    it "redirects to the blocks list" do
      block = Block.create! valid_attributes
      delete :destroy, {:id => block.to_param}
      response.should redirect_to(blocks_url)
    end
  end

end
