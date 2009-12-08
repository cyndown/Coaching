module Coaching
  module Helpers    
    def page_title
     "The Career Advancement Program Coaching Template" 
    end

    def page_subtitle
      "Scorecard Monthly Update"
    end

    def page_subtitle_with_month(month)
      page_subtitle + ' - ' + month
    end  

    def list_of_progress_markers
      marker_set = Array.new
      marker = 0.0
      step = 0.1
      while marker < 1
        marker_set << marker
        marker += step
      end
      marker_set
    end    

    def list_of_months
      months = Array.new
      (1..12).each do |m|
        months << Date.new(2000,m,1).formatted_month
      end
      months
    end
  end  
end