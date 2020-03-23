# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include Pagy::Backend

  before_action :categories

  def categories
    @categories ||= Category.all
  end
end
