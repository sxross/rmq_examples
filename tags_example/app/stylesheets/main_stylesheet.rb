class MainStylesheet < ApplicationStylesheet

  def setup
    # Add sytlesheet specific setup stuff here.
    # Add application specific setup stuff in application_stylesheet.rb
  end

  def root_view(st)
    st.background_color = color.white
  end

  # These are the styles for the example app.
  # Note that left_text_field and right_text_field
  # are very similar except left uses a left padding
  # and right uses the from_right setting. Version 0.6.x
  # introduces ways of doing this more cleverly.
  def left_text_field(st)
    st.frame = {t: 20, l: 10, w: (app_width - 30) / 2, h: 20}
    st.border_style = UITextBorderStyleLine
  end

  def right_text_field(st)
    st.frame = {t: 20,  w: (app_width - 30) / 2, h: 20}
    st.from_right = 10
    st.border_style = UITextBorderStyleLine
  end
  
  # This is all cookie-cutter RMQ, except the last
  # line. That references a custom styler, located
  # in app/stylers/ui_button_styler.rb.
  def submit_button(st)
    st.frame = {t: 200, w: app_width - 20, h: 50}
    st.centered = :horizontal
    st.text = "submit"
    
    # Note: color.button_green is defined in app/stylesheets/application_stylesheet.rb
    st.background_color = color.button_green
    st.shows_touch_when_highlighted = true
  end

  def results_field(st)
    st.frame = {w: app_width - 20, h: 260}
    st.centered = :horizontal
    st.from_bottom = 40
  end
end
