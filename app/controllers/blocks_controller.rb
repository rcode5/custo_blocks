class BlocksController < ApplicationController
  def index
    @blocks = Block.all
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
end
