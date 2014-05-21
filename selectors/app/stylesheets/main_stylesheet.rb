class MainStylesheet < ApplicationStylesheet

  def setup
    # Add sytlesheet specific setup stuff here.
    # Add application specific setup stuff in application_stylesheet.rb
  end

  def root_view(st)
    st.background_color = color.white
  end

  def hello_world(st)
    st.frame = {t: 100, w: 200, h: 18}
    st.centered = :horizontal
    st.text_alignment = :center
    st.text = 'Hello World'
    st.color = color.battleship_gray
    st.font = font.medium
  end

  def check_in(st)
    st.frame = {l: 20, w: 100, h: 30}
    st.from_bottom      = 150
    st.text             = 'check in'
    st.background_color = color.battleship_gray
    st.color            = color.white
  end
  
  def leave(st)
    st.frame = {w: 100, h: 30}
    st.from_bottom      = 150
    st.from_right       = 20
    st.text             = 'leave'
    st.background_color = color.battleship_gray
    st.color            = color.white
  end
end
