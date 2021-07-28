# frozen_string_literal: true

require_relative 'supertramp/config'
require_relative 'supertramp/avatar'

class Supertramp
  @@config = Config.new

  def initialize(initials: nil, name: nil, background: nil)
    @initials = initials
    @name = name
    @background = background

    validate_arguments
  end

  def to_s
    Avatar.new(initials: initials, background: background).to_s
  end

  def self.configure
    yield @@config
  end

  private

  attr_accessor :name

  def validate_arguments
    raise ArgumentError, 'either `initials:` or `name:` must be specified' unless @name || @initials
  end

  def config
    @@config
  end

  def initials
    @initials ||= initials_from_name

    return @initials.upcase if config.uppercase

    @initials
  end

  def initials_from_name
    name.split.map { |n| n[0] }.join
  end

  def background
    @background ||= background_for_initials
  end

  def background_for_initials
    Random.srand(initials_seed)
    index = (rand * config.colours.length).floor
    config.colours[index]
  end

  def initials_seed
    initials.downcase.chars.map(&:ord).sum
  end
end
