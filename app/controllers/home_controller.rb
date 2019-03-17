# frozen_string_literal: true

class HomeController < ApplicationController

  def index
    render plain: "Hello Stranger"
  end
end
