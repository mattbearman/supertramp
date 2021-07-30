# frozen_string_literal: true

require 'erb'

class Supertramp
  class Avatar
    SHAPES = [
      SQUARE = 'square',
      CIRCLE = 'circle',
      ROUNDED = 'rounded'
    ].freeze

    def initialize(initials:, background:, shape:)
      @initials = initials
      @background = background
      @shape = shape
    end

    def to_s
      bind_template('avatar')
    end

    def shape
      bind_template("_#{@shape}")
    end

    private

    def bind_template(file)
      ERB.new(template(file)).result(binding)
    end

    def template(file)
      File.read(template_path(file))
    end

    def template_path(file)
      File.expand_path("../templates/#{file}.svg.erb", File.dirname(__FILE__))
    end
  end
end
