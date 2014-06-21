class MainStylesheet < ApplicationStylesheet
  attr_accessor :screen_title 

  KEYBOARD_HEIGHT = 216

  def setup
    # Add sytlesheet specific setup stuff here.
    # Add application specific setup stuff in application_stylesheet.rb

    # It's good to put all visual things in the stylesheet
    @screen_title = 'Tags example'

    @column_width = (app_width - 30) / 2
    @keyboard_height = 216 # You could calculate this too, to do landscape also
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
    st.frame = {l: 10, top: 10, w: @column_width, h: 20}
    st.border_style = UITextBorderStyleLine
  end

  def right_text_field(st)
    st.frame = {fr: 10, t: 10, w: @column_width, h: 20}
    st.border_style = UITextBorderStyleLine
  end

  def distribute_text_fields
    rmq.find(:left_text_field).distribute :vertical, margin: 5
    rmq.find(:right_text_field).distribute :vertical, margin: 5
  end
  
  # This is all cookie-cutter RMQ, except the last
  # line. shows_touch_when_highlighted references 
  # a custom styler, located in
  # app/stylers/ui_button_styler.rb.
  def submit_button(st)
    st.frame = {l: 10, fb: @keyboard_height + 10, fr: 10, h: 50}
    st.text = "submit"
    
    # Note: color.button_green is defined in app/stylesheets/application_stylesheet.rb
    st.background_color = color.button_green
    st.shows_touch_when_highlighted = true
  end

  def results_field(st)
    st.frame = {l: 10, fr: 10, fb: 10, h: @keyboard_height - 10}
    st.number_of_lines = 0 # Unlimited
  end
end
