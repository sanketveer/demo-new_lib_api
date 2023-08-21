# frozen_string_literal: true

class Book < ApplicationRecord
  belongs_to :library

  def available?
    status == 'available'
  end
end
