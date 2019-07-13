# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'no-reply@brownfield-dreams.com'
  layout 'mailer'
end
