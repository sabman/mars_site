class ErrorController < ApplicationController
  def error
    raise RuntimeError, "Generated an error"
  end
end
