class ApplicationController < ActionController::Base
  include CableReady::Broadcaster
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  skip_forgery_protection # for test
  helper_method :current_cart

  private

  def current_cart
    @current_cart ||= find_cart
  end

  def find_cart
    return create_new_cart if session[:cart_id].blank?

    Cart.find_by(user_id: session[:session_id], status: :initialized) || create_new_cart
  end

  def error_notice(msg, status = :unprocessable_entity)
    render turbo_stream: send_notice(msg, 'danger'), status:
  end

  def success_notice(notices)
    send_notice(notices, 'success')
  end

  def send_notice(notices, key)
    turbo_stream.append(:notices, partial: '/layouts/partials/notice', locals: { notices:, key: })
  end

  def create_new_cart
    cart = Cart.create
    session[:cart_id] = cart.id
    cart.update(user_id: session[:session_id])
    cart
  end
end
