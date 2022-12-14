# frozen_string_literal: true

# Configuration to allow devise to work with turbo. Solution stolen from Efo Coder at https://dev.to/efocoder/how-to-use-devise-with-turbo-in-rails-7-9n9
class TurboDeviseUserController < ApplicationController
  class Responder < ActionController::Responder
    def to_turbo_stream
      controller.render(options.merge(formats: :html))
    rescue ActionView::MissingTemplate => e
      if get?
        raise e
      elsif has_errors? && default_action
        render rendering_options.merge(formats: :html, status: :unprocessable_entity)
      else
        redirect_to navigation_location
      end
    end
  end

  self.responder = Responder
  respond_to :html, :turbo_stream
end
