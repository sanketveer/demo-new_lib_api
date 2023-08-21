# frozen_string_literal: true

json.data do
  json.array! @books do |book|
    json.call(
      book,
      :id,
      :title,
      :checked_out_by,
      :available
    )
  end
end

if @pagy.present? || @total_count.present?
  json.pagination do
    json.per_page per_page
    json.page page
    if @total_count
      json.total_pages (@total_count.to_f / per_page.to_i).ceil
      json.total @total_count
    else
      json.total_pages @pagy&.pages
      json.total @pagy&.count
    end
  end
end
