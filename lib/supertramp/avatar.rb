# frozen_string_literal: true

require 'erb'

class Supertramp
  class Avatar
    TEMPLATE = '../templates/avatar.svg.erb'

    def initialize(initials:, background:)
      @initials = initials
      @background = background
    end

    def to_s
      ERB.new(template).result(binding)
    end

    private

    def template
      File.read(File.expand_path(TEMPLATE, File.dirname(__FILE__)))
    end
  end
end
