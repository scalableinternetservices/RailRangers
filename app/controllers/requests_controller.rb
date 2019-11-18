class RequestsController < ApplicationController
  before_action :set_request, only: [:show, :edit, :update, :destroy]

  # GET /requests
  # GET /requests.json
  def index
    @users = current_user.requesters.where('requests.accepted = ?', false)
  end

  # GET /requests/1
  # GET /requests/1.json
  def show
  end

  # GET /requests/new
  def new
    @request = Request.new
    @requester = current_user
    @requestee = User.find_by(id: params[:id])
  end

  # GET /requests/1/edit
  def edit
  end

  # POST /requests
  # POST /requests.json
  def create
    @request =  current_user.sent_requests.build(request_params)

    respond_to do |format|
      if @request.save
        format.html { redirect_to posts_url, notice: 'Friend request sent!' }
        format.json { render :show, status: :created, location: @request }
      else
        format.html { redirect_to posts_url, notice: 'Failed to send a friend request!' }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /requests/1
  # PATCH/PUT /requests/1.json
  def update
    @request.accept
    redirect_to posts_url
  end

  # DELETE /requests/1
  # DELETE /requests/1.json
  def destroy
    @request.destroy
    respond_to do |format|
      format.html { redirect_to requests_url, notice: 'Request was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_request
      @request = Request.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def request_params
      params.require(:request).permit(:requestee_id)
    end
end
