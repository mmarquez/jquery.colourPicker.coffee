jQuery.fn.colourPicker = (conf) ->
  # Config for plug
  config = jQuery.extend(
    id: "jquery-colour-picker" # id of colour-picker container
    ico: "ico.gif" # SRC to colour-picker icon
    title: "Pick a colour" # Default dialogue title
    inputBG: true # Whether to change the input's background to the selected colour's
    speed: 500 # Speed of dialogue-animation
    openTxt: "Open colour picker"
    otherWidget: ""
  , conf)
  
  # Inverts a hex-colour
  hexInvert = (hex) ->
    r = hex.substr(0, 2)
    g = hex.substr(2, 2)
    b = hex.substr(4, 2)
    (if 0.212671 * r + 0.715160 * g + 0.072169 * b < 0.5 then "fff" else "000")

  
  # Add the colour-picker dialogue if not added
  colourPicker = jQuery("#" + config.id)
  unless colourPicker.length
    colourPicker = jQuery("<div class=\"jquery-colour-picker\" id=\"" + config.id + "\"></div>").appendTo(document.body).hide()
    
    # Remove the colour-picker if you click outside it (on body)
    jQuery(document.body).click (event) ->
      colourPicker.hide config.speed  unless jQuery(event.target).is("#" + config.id) or jQuery(event.target).parents("#" + config.id).length

  
  # For every select passed to the plug-in
  @each ->
    
    # Insert icon and input
    select = jQuery(this)
    icon = jQuery("<a href=\"#\"><img src=\"" + config.ico + "\" alt=\"" + config.openTxt + "\" /></a>").insertAfter(select)
    input = jQuery("<input class=\"colored\" type=\"text\" id=\"" + select.attr("id") + "\" name=\"" + select.attr("name") + "\" value=\"" + select.val() + "\" size=\"6\" />").insertAfter(select)
    loc = ""
    
    # Build a list of colours based on the colours in the select
    jQuery("option", select).each ->
      option = jQuery(this)
      hex = option.val()
      title = option.text()
      ext = null
      ext = option.data().ext  if option.data().ext?
      loc += "<li><a href=\"#\" title=\"" + title + "\" rel=\"" + hex + "\" style=\"background: #" + hex + "; colour: " + hexInvert(hex) + ";\""
      loc += " data-ext=\"" + ext + "\""  if ext?
      loc += ">" + title + "</a></li>"

    
    # Remove select
    select.remove()
    
    # If user wants to, change the input's BG to reflect the newly selected colour
    if config.inputBG
      input.change ->
        input.css
          background: "#" + input.val()
          color: "#" + hexInvert(input.val())

        unless config.otherWidget is ""
          config.otherWidget.css
            background: "#" + input.val()
            color: "#" + hexInvert(input.val())


      input.change()
    
    # When you click the icon
    icon.click ->
      
      # Show the colour-picker next to the icon and fill it with the colours in the select that used to be there
      iconPos = icon.offset()
      heading = (if config.title then "<h2>#{config.title}</h2>" else "")
      colourPicker.html(heading + "<ul>#{loc}</ul>").css(
        position: "absolute"
        left: iconPos.left + "px"
        top: iconPos.top + "px"
      ).show config.speed
      
      # When you click a colour in the colour-picker
      jQuery("a", colourPicker).click ->
        
        # The hex is stored in the link's rel-attribute
        hex = jQuery(this).attr("rel")
        input.val hex
        
        # If user wants to, change the input's BG to reflect the newly selected colour
        if config.inputBG
          input.css
            background: "#" + hex
            color: "#" + hexInvert(hex)

          unless config.otherWidget is ""
            config.otherWidget.css
              background: "#" + hex
              color: "#" + hexInvert(hex)

          if @dataset? and @dataset.ext?
            input.data "ext", @dataset.ext
            config.otherWidget.data "ext", @dataset.ext
          else
            input.data "ext", null
            config.otherWidget.data "ext", null
        
        # Trigger change-event on input
        input.change()
        
        # Hide the colour-picker and return false
        colourPicker.hide config.speed
        false

      false

