class MainController < UIViewController 
  LEFT_COLUMN  = ['name', 'address', 'phone']
  RIGHT_COLUMN = ['dogs', 'cats', 'hamsters']
  
  def viewDidLoad
    super

    # Sets a top of 0 to be below the navigation control
    self.edgesForExtendedLayout = UIRectEdgeNone

    rmq.stylesheet = MainStylesheet
    init_nav
    rmq(self.view).apply_style :root_view

    # Create two columns of UITextFields
    create_text_fields
    
    # Add a button and attach a "tap" handler to it
    rmq.append(UIButton, :submit_button).on(:tap) {
      # Hide the keyboard when button pressed and set the results field
      resign_first_responder    
      rmq(:results_field).get.text = fetch_data
    }
  end
  
  def create_text_fields
    # Adding text fields to the container UIView. Note that:
    #
    # 1. These all use a style called :left_text_field
    # 2. They are moved an additional 25 points down each iteration (chained)
    # 3. Each field is "tagged" with a unique identifier synthesized
    #    from the field name using the rmq#tag method (chained again)
    # 4. Because RMQ calls return RMQ queries, if we want the actual UITextField,
    #    we have to use the rmq#get method, then we can set the placeholder (chained, yet again)
    LEFT_COLUMN.each_with_index do |field, index|
      rmq.append(UITextField, :left_text_field).move(t: 20 + index * 25).tag(tagify(field)).get.placeholder = field
    end
    RIGHT_COLUMN.each_with_index do |field, index|
      rmq.append(UITextField, :right_text_field).move(t: 20 + index * 25).tag(tagify(field)).get.placeholder = field
    end
    
    rmq.append(UILabel, :results_field).get.numberOfLines = 10
  end
  
  def fetch_data
    # Iterate through using the tags we used in create_text_fields
    # and retrieve the results. Note that RMQ will start looking at
    # the controller's top view for a field tagged as specified.

    result = "left"
    LEFT_COLUMN.each do |field|
      result << "\n" + rmq(tagify(field)).get.text
    end
    result << "\n\nright"
    RIGHT_COLUMN.each do |field|
      result << "\n" + rmq(tagify(field)).get.text
    end
  end
  
  def tagify(field)
    field.gsub(/ /, '-').to_sym
  end
  
  def find_first_responder(view = nil)
    # Just a simple little hack to find the
    # first responder on this screen.
    view = rmq.get if view.nil?
    
    return view if view.isFirstResponder
    view.subviews.each do |subview|
      return subview if find_first_responder(subview)
    end
    false
  end
  
  def resign_first_responder
    # If there was a first responder, resign it
    # do dismiss the keyboard.
    view = find_first_responder
    view.resignFirstResponder if view
  end

  def init_nav
    self.title = 'Title Here'

    self.navigationItem.tap do |nav|
      nav.leftBarButtonItem = UIBarButtonItem.alloc.initWithBarButtonSystemItem(UIBarButtonSystemItemAction,
                                                                           target: self, action: :nav_left_button)
      nav.rightBarButtonItem = UIBarButtonItem.alloc.initWithBarButtonSystemItem(UIBarButtonSystemItemRefresh,
                                                                           target: self, action: :nav_right_button)
    end
  end

  def nav_left_button
    puts 'Left button'
  end

  def nav_right_button
    puts 'Right button'
  end

  # Remove if you are only supporting portrait
  def supportedInterfaceOrientations
    UIInterfaceOrientationMaskAll
  end

  # Remove if you are only supporting portrait
  def willAnimateRotationToInterfaceOrientation(orientation, duration: duration)
    rmq.all.reapply_styles
  end

end


__END__

# You don't have to reapply styles to all UIViews, if you want to optimize, 
# another way to do it is tag the views you need to restyle in your stylesheet, 
# then only reapply the tagged views, like so:
def logo(st)
  st.frame = {t: 10, w: 200, h: 96}
  st.centered = :horizontal
  st.image = image.resource('logo')
  st.tag(:reapply_style)
end

# Then in willAnimateRotationToInterfaceOrientation
rmq(:reapply_style).reapply_styles


