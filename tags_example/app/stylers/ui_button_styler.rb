module RubyMotionQuery
  module Stylers
    class UIButtonStyler < UIControlStyler 

      # Define getter and setter for the
      # UIButton#showsTouchWhenHighlighted
      # property.
      def shows_touch_when_highlighted
        @view.showsTouchWhenHighlighted
      end
      
      def shows_touch_when_highlighted=(value)
        @view.showsTouchWhenHighlighted = value
      end

    end
  end
end
