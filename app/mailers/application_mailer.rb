# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'from@hikerbook.com'
  layout 'mailer'
end
