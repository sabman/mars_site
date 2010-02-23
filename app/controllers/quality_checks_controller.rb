class QualityChecksController < ApplicationController
  def index
    @quality_checks = QualityCheck.all
  end
end
