class ReservationMailer < ApplicationMailer
  def booking_email(customer_id, host_id, reservation_id)
    @customer = User.find(customer_id)
    @host = User.find(host_id)
    @reservation = Reservation.find(reservation_id)
    @url  = 'http://example.com/login'
    mail(to: @host.email, subject: 'Test Email for Letter Opener')
  end
end
