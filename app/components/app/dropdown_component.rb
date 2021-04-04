# frozen_string_literal: true

class App::DropdownComponent < ViewComponent::Base
  def initialize(details_id:)
    @details_id = details_id
  end

  renders_one :summary
  renders_one :body
end
