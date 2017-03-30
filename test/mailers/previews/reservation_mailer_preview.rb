# Preview all emails at http://localhost:3000/rails/mailers/reservation_mailer
class ReservationMailerPreview < ActionMailer::Preview

  def booking_email
    @user = User.first
    @host_id = User.last.id
    @reservation = Reservation.first
    ReservationMailer.booking_email(@user.id, @host_id, @reservation.id )
  end

end
