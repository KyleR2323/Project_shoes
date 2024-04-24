class CheckoutController < ApplicationController
  def cancel
  end

  def create
    @order = Order.find(params[:order_id])
    session[:order_id] = @order.id

    @session = Stripe::Checkout::Session.create({
                                                  payment_method_types ["card"],
                                                  mode:                "payment",
                                                  success_url:          checkout_success_url + "?session_id={CHECKOUT_SESSION_ID}",

                                                  line_items:           @order.line_item_for_stripe
                                                })

    redirect_to @session.url, allow_other_host: true
  end

  def success
    @session = Stripe::Checkout::Session.retrieve(params[:session_id])
    @payment_intent = Stripe::PaymentIntent.retrieve(@session.payment_intent)
    @order = Order.find(session[:order_id])

    if @order
      to_email = current_user.email
      subject = "Payment Confirmation"
      content = "We got your payment. We will deliver it as soon as possible"
      email_response = send_email(to_email, subject, content)

      @order.save_payment_id(@payment_intent.id)
      @order.mark_as_paid
      session[:order_id] = nil
    else

    end
  end
end
