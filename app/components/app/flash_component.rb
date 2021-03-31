# frozen_string_literal: true

class App::FlashComponent < ViewComponent::Base
  # Instance variables will be available in the view
  # @tyoe and @data[:title]
  def initialize(type:, data:)
    @type = type
    @data = prepare_data(data)
  end

  STATES = {
    success: {
      icon_path: 'icons/check_circle',
      border_color: 'border-green-400',
      icon_color: 'text-green-400',
      bg_color: 'bg-green-100'
    },
    notice: {
      icon_path: 'icons/information_circle',
      border_color: 'border-teal-400',
      icon_color: 'text-teal-400',
      bg_color: 'bg-teal-100'
    },
    warning: {
      icon_path: 'icons/exclamation',
      border_color: 'border-amber-400',
      icon_color: 'text-amber-400',
      bg_color: 'bg-amber-100'
    },
    alert: {
      icon_path: 'icons/star',
      border_color: 'border-rose-400',
      icon_color: 'text-rose-400',
      bg_color: 'bg-rose-100'
    }
  }.freeze

  def icon
    tag.div class: "h-8 w-8" do
      render_inline_svg(icon_path, class: icon_color)
    end
  end

  def bg_color
    STATES[@type.to_sym][:bg_color]
  end

  def icon_path
    STATES[@type.to_sym][:icon_path]
  end

  def icon_color
    STATES[@type.to_sym][:icon_color]
  end

  def border_color
    STATES[@type.to_sym][:border_color]
  end

  private

    def prepare_data(data)
      case data
      when Hash
        data
      else
        { title: data }
      end
    end
end
