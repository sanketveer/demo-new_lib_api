# frozen_string_literal: true


require 'byebug'

Given('there is an existing library with ID') do
  # @library = libraries(:one_lib)
  @library = Library.create(name: 'First library')
end

Given('there are existing books in the library') do
  @books = Book.create(title: 'Tali', library: @library, available: true )
end

When('I list books in the library with ID') do
  get "/api/v1/libraries/#{@library.id}/books", params: { format: :json }
end

Then('I should receive the following books:') do |table|
  expected_books = table.hashes.map do |row_hash|
    {
      'title' => row_hash['title'],
      'available' => row_hash['available'] == 'true',
      'checked_out_by' => row_hash['checked_out_by']
    }
  end

  @last_response = JSON.parse(response.body)
  expect(@last_response.first).to eq(expected_books)
end