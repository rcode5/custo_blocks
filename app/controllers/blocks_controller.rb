class BlocksController < ApplicationController
 
  before_filter :type_is_required, :only => [:new]

  def index
    @blocks = Block.all
    @blocks_by_type = @blocks.inject({}) {|result,item| (result[item.block_type] ||= []) << item; result}
  end

  def show
    @block = Block.find(params[:id])
  end

  def new
    @block = Block.new(block_type: params[:type])
  end

  def edit
    @block = Block.find(params[:id])
  end

  def create
    @block = Block.new(params[:block], :without_protection => true)

    if @block.save
      redirect_to @block, notice: 'Block was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    @block = Block.find(params[:id])
    if @block.update_attributes(params[:block], :without_protection => true)
      redirect_to @block, notice: 'Block was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @block = Block.find(params[:id])
    @block.destroy
    redirect_to blocks_url
  end

  protected
  def type_is_required
    message = "You must specify a block type."
    redirect_to(blocks_path, :flash => {:error => message}) unless params[:type]
  end

end
