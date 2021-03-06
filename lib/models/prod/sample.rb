module Prod
  class Sample < ProdDb
    set_table_name :samples
    set_sequence_name :autogenerated 
    set_primary_key :sampleno
    set_date_columns :startdate, :enddate, :releasedate, :entrydate, :qadate, :confid_until, :lastupdate
    belongs_to :survey, :foreign_key => :eno, :class_name => "Prod::Survey"
    has_many :sampledata, :foreign_key => :sampleno, :class_name => "Prod::Sampledata"

    default_scope :conditions => {:ano => 84}
    named_scope :marine, :conditions => "ano = 84 OR ano = 51"
    named_scope :mars, :conditions => "ano = 84"
    named_scope :coastal, :conditions => "ano = 51"
    named_scope :recent, lambda{ |*args| {:conditions => "acquiredate > \'#{args.first || 2.years.ago.strftime('%d-%b-%Y')}\'"} }
    named_scope :unchecked, :conditions => "qa_status_code = 'U'"
    named_scope :open, :conditions => "access_code = 'O'"
    named_scope :classified, :conditions => "access_code = 'C'"
    named_scope :ga_only, :conditions => "access_code = 'A'"
    named_scope :rocks, :conditions => "property = 'rock type'"

    def to_s
      sampleid || ""
    end

    def to_param
      "#{sampleno}-#{to_s.parameterize.upcase}"
    end

    # TODO: change these start/end lat/lon/depth methods to be created dynamically using method_missing or other meta-magic
    def start_lat
      return nil if geom.nil?
      if geom.as_georuby.is_a?(LineString)
        return geom.as_georuby.points.first.y
      elsif geom.as_georuby.is_a?(Point)
        return geom.as_georuby.y 
      end
    end

    def start_lon
      return nil if geom.nil?
      if geom.as_georuby.is_a?(LineString)
        return geom.as_georuby.points.first.x
      elsif geom.as_georuby.is_a?(Point)
        return geom.as_georuby.x 
      end
    end

    def start_depth
      return nil if geom.nil?
      if geom.as_georuby.is_a?(LineString)
        return geom.as_georuby.points.first.z
      elsif geom.as_georuby.is_a?(Point)
        return geom.as_georuby.z 
      end
    end

    def end_lat
      return nil if geom.nil?
      if geom.as_georuby.is_a?(LineString)
        return geom.as_georuby.points.last.y
      elsif geom.as_georuby.is_a?(Point)
        return nil
      end
    end

    def end_lon
      return nil if geom.nil?
      if geom.as_georuby.is_a?(LineString)
        return geom.as_georuby.points.last.x
      elsif geom.as_georuby.is_a?(Point)
        return nil
      end
    end

    def end_depth
      return nil if geom.nil?
      if geom.as_georuby.is_a?(LineString)
        return geom.as_georuby.points.last.z
      elsif geom.as_georuby.is_a?(Point)
        return nil
      end
    end

    def grain_size
      return nil if sampledata.blank?
      qualf = [ '<63um','<62.5um', 
                '63um - 2000um','62.5um - 2000um', 
                '>2000um','2mm - 64mm', 
                'bulk', 'D [4, 3] - Volume weighted mean']
      g1  = sampledata.find_by_property_and_qualifier('grain size', qualf[0])
      g1a = sampledata.find_by_property_and_qualifier('grain size', qualf[1])
      g2  = sampledata.find_by_property_and_qualifier('grain size', qualf[2])
      g2a = sampledata.find_by_property_and_qualifier('grain size', qualf[3])
      g3  = sampledata.find_by_property_and_qualifier('grain size', qualf[4])
      g3a = sampledata.find_by_property_and_qualifier('grain size', qualf[5])
      g4  = sampledata.find_by_property_and_qualifier('grain size', qualf[6])
      g5  = sampledata.find_by_property_and_qualifier('grain size', qualf[7])
      mud   = merge_quant_value(g1.try(:quant_value), g1a.try(:quant_value))
      sand  = merge_quant_value(g2.try(:quant_value), g2a.try(:quant_value))
      gravel= merge_quant_value(g3.try(:quant_value), g3a.try(:quant_value))
      {
        :mud    => mud,
        :sand   => sand,
        :gravel => gravel,
        :bulk   => g4.try(:quant_value),
        :mean   => g5.try(:quant_value)
      }
    end


    def carbonate_content
      return nil if sampledata.blank?
      qulf = ['<63um','<62.5um', '63um - 2000um','62.5um - 2000um', '>2000um','2mm - 64mm', 'bulk']
      cond = ["property = ? OR property = ?", 'carbonate content', 'caco3']
      #carbonate_data = sampledata.find_by_qualifier(qulf, :conditions => cond)
      c1  = sampledata.find_by_qualifier(qulf[0], :conditions => cond)
      c1a = sampledata.find_by_qualifier(qulf[1], :conditions => cond)
      c2  = sampledata.find_by_qualifier(qulf[2], :conditions => cond)
      c2a = sampledata.find_by_qualifier(qulf[3], :conditions => cond)
      c3  = sampledata.find_by_qualifier(qulf[4], :conditions => cond)
      c3a = sampledata.find_by_qualifier(qulf[5], :conditions => cond)
      c4  = sampledata.find_by_qualifier(qulf[6], :conditions => cond)
      mud   = merge_quant_value(c1.try(:quant_value), c1a.try(:quant_value))
      sand  = merge_quant_value(c2.try(:quant_value), c2a.try(:quant_value))
      gravel= merge_quant_value(c3.try(:quant_value), c3a.try(:quant_value))
      return nil if (!mud && !sand && !gravel)
      {
        :mud    => mud,
        :sand   => sand,
        :gravel => gravel,
        :bulk   => c4.try(:quant_value)
      }
    end

    def biogenic_silica
      avg   = sampledata.find_by_property_and_qualifier('biogenic silica','average') 
      stdev = sampledata.find_by_property_and_qualifier('biogenic silica','deviation') 
      {
        :average    => avg.try(:quant_value),
        :deviation  => stdev.try(:quant_value)
      }
    end

    def water_depth
      start_depth = sampledata.find_by_property_and_qualifier('water depth', 'start') 
      end_depth   = sampledata.find_by_property_and_qualifier('water depth', 'end') 
      if start_depth && end_depth
        return {:start_depth => start_depth.try(:quant_value), :end_depth => end_depth.try(:quant_value)}
      else
        depth   = sampledata.find_by_property('water depth') 
        return {:start_depth => depth.try(:quant_value), :end_depth => nil}
      end
    end

    def sedimentry_structures
      sedstructs = sampledata.find_all_by_property('SEDIMENTARY STRUCTURES')
      {
        :qual_values => sedstructs.map{|c| c.qual_value}.join('; ') 
      }
    end
    def sedimentry_structures_qual_values; sedimentry_structures[:qual_values]; end

    # TODO: figure out what rocks we are interested in
    def rocks
      rockdata = sampledata.find_all_by_property('rock type')
      {
        :qual_values => rockdata.map{|r| r.qual_value }.join('; ')
      }
    end
    def rock_type_qual_values; rocks[:qual_values]; end

    def munsell_colours
      colours = sampledata.find_all_by_property('MUNSELL COLOUR')
      {
        :qual_values => colours.map{|c| c.qual_value}.join('; ') 
      }
    end
    def munsell_colours_qual_values; munsell_colours[:qual_values]; end
    
    def grain_size_mud;     grain_size[:mud];     end
    def grain_size_sand;    grain_size[:sand];    end
    def grain_size_gravel;  grain_size[:gravel];  end
    def grain_size_bulk;    grain_size[:bulk];    end
    def grain_size_mean;    grain_size[:mean];    end

    def carbonate_content_mud;      carbonate_content[:mud];      end
    def carbonate_content_sand;     carbonate_content[:sand];     end
    def carbonate_content_gravel;   carbonate_content[:gravel];   end
    def carbonate_content_bulk;     carbonate_content[:bulk];     end
    def biogenic_silica_average;    biogenic_silica[:average];    end
    def biogenic_silica_stddev;     biogenic_silica[:deviation];  end

    def start_water_depth;  water_depth[:start_depth];  end
    def end_water_depth;    water_depth[:end_depth];    end

    private
    def merge_quant_value(q1, q2)
      v = nil
      if q1.nil? && q2.nil? 
        v = nil 
      elsif q1 && q2 
        v = q1 + q2
      else
        v = q1 || q2
      end
      v
    end
  end # class Sample
end # module Prod
