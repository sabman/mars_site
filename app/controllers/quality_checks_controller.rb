ProdDb.connection.execute("ALTER SESSION set NLS_DATE_FORMAT ='DD-MON-FXYYYY'")
class QualityChecksController < ApplicationController
  def index
    @surveys = Survey.confid_until_1950_and_access_a_with_sediment_samples
    respond_to do |wants|
      wants.html 
      wants.csv
    end
  end
end
