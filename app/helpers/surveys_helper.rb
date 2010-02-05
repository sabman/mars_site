module SurveysHelper
  def find_gams_in_comments(comment)
    comment =~ /GAMS=(\d+);/i
    return $1
  end

  def get_gada_data_url(gams)
    "http://www.agso.gov.au:88/pmd-bin/search_data.cgi?GAID=#{gams}&dtype=all%20"
  end

  def get_gada_metadata_url(gams)
    "http://www.agso.gov.au:88/pmd-bin/searchmeta.cgi?metastr=#{gams}&mode=GAID"
  end

  def prod_survey_path(o)
    survey_path(o)
  end
end
