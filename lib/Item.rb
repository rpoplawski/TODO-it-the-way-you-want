class Item < ActiveRecord::Base

  attr_accessor :context, :text

  def initialize(value)
    @context = value.scan(/@[A-Z0-9.-]+/i).last || '@next'
    @text    = value.gsub(context, '').strip
  end

  def to_s
    "#{@text}: #{@context}"
  end
end
