class BlocksController < ApplicationController
 
  before_filter :set_type_from_params
  before_filter :type_is_required, :only => [:new]

  def index
    @blocks = Block.all
    @blocks_by_type = Hash[@blocks.map{|b| [b.block_type, b]}]
  end

  def show
    @block = Block.find(params[:id])
  end

  def new
    @block = Block.new
  end

  def edit
    @block = Block.find(params[:id])
  end

  def create
    @block = Block.new(params[:block])

    if @block.save
      redirect_to @block, notice: 'Block was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    if @block.update_attributes(params[:block])
      redirect_to @block, notice: 'Block was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @block.destroy
    redirect_to blocks_url
  end


  protected
  def set_type_from_params
    @type = params[:type]
  end
  
  def type_is_required
    message = "You must specify a block type."
    if @current_action == 'new'
      message = 'You cannot create a new block without a type'
    end
    redirect_to('/', :flash => {:error => message}) unless @type
  end

end
