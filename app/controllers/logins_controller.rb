class LoginsController < ApplicationController

  skip_before_action :require_login, only: [:form, :create]

  def form

  end

end
