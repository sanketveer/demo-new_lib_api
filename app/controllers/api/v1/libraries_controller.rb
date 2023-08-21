# frozen_string_literal: true

module Api
  module V1
    # library controllers
    class LibrariesController < ApplicationController
      before_action :set_library, only: [:books]

      def books
        @books = @library.books
        render json: @books
      end

      private

      def set_library
        @library = Library.find(params[:id])
      end
    end
  end
end
