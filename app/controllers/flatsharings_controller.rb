class FlatsharingsController < ApplicationController
  before_action :set_flatsharing, only: %i[show admin dashboard update destroy]

  # GET /flatsharings
  def index
    @flatsharings = Flatsharing.all
    @user = User.all

    @flatsharings.map do |u|
      u.pending_invitation.map do |i|
        u.flat_mate << @user.find_by(email: i)
      end
    end
    render json: @flatsharings
  end

  # GET /flatsharings/1
  def show
    @user = User.all

    @flatsharing.pending_invitation.map do |u|
      @flatsharing.flat_mate << @user.find_by(email: u)
    end

    render json: @flatsharing
  end

  # GET /flatsharings/1/admin
  def admin
    user = User.all
    render json: user.find_by(id: @flatsharing.admin_id)
  end

  # GET /flatsharings/1/dashboard
  def dashboard
    user = User.all

    @guest = []

    @flatsharing.pending_invitation.map do |u|
      @guest << user.find_by(email: u)
    end

    render json: { admin: user.find_by(id: @flatsharing.admin_id), guest: @guest }
  end

  # POST /flatsharings
  def create
    @flatsharing = Flatsharing.new(flatsharing_params)
    if @flatsharing.save
      render json: { flatsharing: @flatsharing }, status: :created, location: @flatsharing
    else
      render json: @flatsharing.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /flatsharings/1
  def update
    @flatsharing.pending_invitation.push(params['pending_invitation'])
    if @flatsharing.update({ pending_invitation: @flatsharing.pending_invitation })
      render json: @flatsharing
    else
      render json: @flatsharing.errors, status: :unprocessable_entity
    end
  end

  # DELETE /flatsharings/1
  def destroy
    @flatsharing.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_flatsharing
    @flatsharing = Flatsharing.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def flatsharing_params
    flatsharing_params = params.require(:flatsharing).permit(:title, :description, :admin_id,
                                                             pending_invitation: [], flat_mate: [])
  end
end
