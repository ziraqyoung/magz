require 'rspec/expectations'

RSpec::Matchers.define :require_authorization do |expected|
  match do |actual|
    expect(actual).to redirect_to \
      Rails.application.routes.url_helpers.root_path
  end

  failure_message do |actual|
    "expected to require authorization to access the method"
  end

  failure_message_when_negated do |actual|
    "expected to not require authorization to access the method"
  end

  description do
    "redirect to the root path"
  end
end
