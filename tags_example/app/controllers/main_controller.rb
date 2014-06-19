class MainController < UIViewController 

  LEFT_COLUMN  = {
    name: 'full name', 
    address: 'address',
    phone: 'home phone'
  }
  RIGHT_COLUMN = {
    dogs: 'dogs', 
    cats: 'cats', 
    hamsters: 'hamsters'
  }
  
  def viewDidLoad
    super

    # Sets a top of 0 to be below the navigation control
    self.edgesForExtendedLayout = UIRectEdgeNone

    rmq.stylesheet = MainStylesheet
    rmq(self.view).apply_style :root_view

    self.title = rmq.stylesheet.screen_title

    # Create two columns of UITextFields
    create_text_fields
    
    # Add a button and attach a "tap" handler to it
    rmq.append(UIButton, :submit_button).on(:tap) {
      # Hide the keyboard when button pressed and set the results field
      rmq(UITextField).each{|view| view.resignFirstResponder}
      rmq(:results_field).data(fetch_data)
    }

    rmq.append UILabel, :results_field
  end
  
  def create_text_fields
    # Adding text fields to the container UIView. Note that:
    #
    # 1. These all use a style called :left_text_field or :right_text_field
    # 2. They are moved with  rmq.stylesheet.distribute_text_fields
    # 3. Each field is "tagged" 
    # 4. Because RMQ calls return RMQ queries, if we want the actual UITextField,
    #    we have to use the rmq#get method, then we can set the placeholder (chained, yet again)
    LEFT_COLUMN.each do |id, label|
      rmq.append(UITextField, :left_text_field).tag(id).get.placeholder = label
    end

    RIGHT_COLUMN.each do |id, label|
      rmq.append(UITextField, :right_text_field).tag(id).get.placeholder = label
    end

    rmq.stylesheet.distribute_text_fields
  end
  
  def fetch_data
    # Iterate through the textfields  
    # and retrieve the results. Note that RMQ will start looking at
    # the controller's top view for a field tagged as specified.

    # Here is a really simple way to get the results
    #   result = ['LEFT']
    #   result.concat(rmq(:left_text_field).data) # Returns array of the text values
    #
    #   result << 'RIGHT'
    #   result.concat(rmq(:right_text_field).data)
    #
    #   result.join("\n")
    

    # If you want to get a specific textfield, you can use the tags we set above
    # puts rmq(:phone).data # which is the same as rmq(:phone).get.text
    

    # Here is another way to create the results
    result = "left\n"
    LEFT_COLUMN.each do |id, label|
      result << "  #{id}: #{rmq(id).data}\n"
    end

    result << "right\n"
    RIGHT_COLUMN.each do |id, label|
      result << "  #{id}: #{rmq(id).data}\n"
    end
    result

  end
end
