# These helper methods can be called in your template to set variables to be used in the layout
# This module should be included in all views globally,
# to do so you may need to add this line to your ApplicationController
#   helper :layout
module LayoutHelper

  def footer(page_footer, show_footer = true)
    @content_for_footer = page_footer.to_s
    @show_footer = show_footer
  end

  def title(page_title, show_title = true)
    @content_for_title = page_title.to_s
    @show_title = show_title
  end
  
  def header(page_header, show_header = true)
    @content_for_header = page_header.to_s
    @show_header = show_header
  end

  def show_footer?
    @show_footer
  end

  def show_header?
    @show_header
  end

  def show_title?
    @show_title
  end
  
  def stylesheet(*args)
    content_for(:head) { stylesheet_link_tag(*args) }
  end
  
  def javascript(*args)
    content_for(:head) { javascript_include_tag(*args) }
  end

  def javascript_link(*args)
    args.each do |arg|
      content_for(:head){"\n"+"<script src=\"#{arg}\" type=\"text/javascript\" ></script>"+"\n"}
    end
  end

end
