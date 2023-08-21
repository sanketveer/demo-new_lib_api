# frozen_string_literal: true

# Root class for all the controllers
class ApplicationController < ActionController::API
  include ActionController::MimeResponds
  include ActionController::ImplicitRender
  include Pagy::Backend

  helper_method :per_page,
                :page

  def page
    params[:page] || 1
  end

  def per_page
    params[:per_page] || Pagy::Default[:items]
  end
end
