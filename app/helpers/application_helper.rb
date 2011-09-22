module ApplicationHelper
   def logo
     image = image_tag("logo.png", :alt => "Chirper App", :class => "round")
  end
  
  
  # Return a title on a per-page basis.
  def title
    base_title = "Chirper App"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end
end
