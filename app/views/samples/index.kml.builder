xml.kml("xmlns" => KML_NS) do
  xml.tag! "Document" do

    # Style Definitions
    xml.tag! "Style", :id => "samples" do
      xml.tag! "LineStyle" do
        xml.color "7f00ffff"
        xml.width 4
      end # LineStyle
      xml.tag! "PointStyle" do
        xml.color "EEEEEE00"
        xml.outline 0
      end # PointSytle
    end # Style:

    @collection.each do |sample|
      if sample.geom
        xml.tag! "Placemark" do
          xml.name sample.sampleid
          xml.description do
            xml.cdata! <<-DESC 
              <strong>Sampleno:</strong> #{sample.id} <br/>
              <strong>Sample type:</strong> #{sample.sample_type} <br/>
              <strong>Sample details:</strong> #{link_to sample.sampleid, sample_path(sample, :only_path => false)} <br/>
              <strong>Survey details:</strong> #{link_to sample.survey.surveyname, survey_path(sample.survey, :only_path => false)}
              DESC
          end
          xml.tag! "TimeStamp", :id => sample.sampleid do
            xml.when sample.acquiredate
          end
          xml.styleUrl "#samples" 
          xml << sample.geom.as_georuby.as_kml
          if sample.geom.as_georuby.kind_of? LineString
            xml << sample.geom.as_georuby.envelope.center.as_kml
          end
        end
      end # geom
    end # samples
  end # Document
end
