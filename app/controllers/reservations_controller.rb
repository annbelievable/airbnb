class  ReservationsController < ApplicationController
  before_action :set_user
  # before_action :set_listing

  def new
    @reservation = Reservation.new
  end

  def create
    @reservation = @user.reservations.build(reservation_params)
    if @reservation.save
      listing = Listing.find(@reservation.listing_id)
      @host_id = listing.user.id
      ReservationMailer.booking_email(@user.id, @host_id, @reservation.id ).deliver_now
      redirect_to(@user, notice: 'Reservation was successfully made.')
    else
      flash[:failure] = 'reservation info broken'
      render '/reservations/_form'
    end
  end

  def edit

  end

  def update

  end

  def destroy

  end

  private
  def reservation_params
    params.require(:reservation).permit(:start_date, :end_date, :listing_id)
  end
  def set_user
    @user=current_user
  end
  def set_listing
    @listing=Listing.find(params[:id])
  end
end
