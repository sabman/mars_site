module SurveysHelper
  def find_gams_in_comments(comment)
    comment =~ /GAMS=(\d+);/i
    return $1
  end

  def prod_survey_path(o)
    survey_path(o)
  end
end
