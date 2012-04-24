class MicropostsController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy]
  before_filter :correct_user,   only: :destroy
  before_filter :authenticate, :only => [:create, :destroy]
  
  # GET /microposts
  # GET /microposts.json
  def index
    @microposts = Micropost.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @microposts }
    end
  end

  # GET /microposts/1
  # GET /microposts/1.json
  def show
    @micropost = Micropost.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @micropost }
    end
  end

  # GET /microposts/new
  # GET /microposts/new.json
  def new
    @micropost = Micropost.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @micropost }
    end
  end

  # GET /microposts/1/edit
  def edit
    @micropost = Micropost.find(params[:id])
  end

  # POST /microposts
  # POST /microposts.json
  def create
    @micropost  = current_user.microposts.build(params[:micropost])
    @micropost = Micropost.new(params[:micropost])
    respond_to do |format|
      @micropost  = current_user.microposts.build(params[:micropost])
      if @micropost.save
        format.html { redirect_to :back, notice: 'Your Retrack was successfully updated.'}
        format.json { head :no_content }
      else
        @feed_items = []
        format.html { render 'current_user' }
        format.json { render :json => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /microposts/1
  # PUT /microposts/1.json
  def update
    @micropost = Micropost.find(params[:id])

    respond_to do |format|
      if @micropost.update_attributes(params[:micropost])
        format.html { redirect_to @micropost, notice: 'Retrack was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @micropost.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /microposts/1
  # DELETE /microposts/1.json
  def destroy
    # @micropost = Micropost.find(params[:id])
    @micropost.destroy
    redirect_back_or root_path
    # respond_to do |format|
    #       format.html { redirect_to microposts_url }
    #       format.json { head :no_content }
    #     end
  end
end

private

  def correct_user
    @micropost = current_user.microposts.find_by_id(params[:id])
    redirect_to root_path if @micropost.nil?
  end
