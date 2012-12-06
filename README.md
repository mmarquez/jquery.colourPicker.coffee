jquery.colourPicker.coffee
==========================
version 2.1

A fork of the widget from http://andreaslagerkvist.com/jquery/colour-picker/

Moisés Márquez
Andreas Lagerkvist

License http://creativecommons.org/licenses/by/3.0/

Use this plug-in on a normal <select>-element filled with colours to turn it in to a colour-picker widget that allows users to view all the colours in the drop-down as well as enter their own, preferred, custom colour. Only about 1k compressed.

HOW TO USE
jQuery('select[name="colour"]').colourPicker({ico: 'my-icon.gif', title: 'Select a colour from the list'}); Would replace the select with 'my-icon.gif' which, when clicked, would open a dialogue with the title 'Select a colour from the list'.

A function 'changeColors' can be called to change the colors after the creation of the widget. For function properly an array describing the colors must be sent. This array have to have 3 elements: title, hex and ext.

The first will be used to show the name of the color. The second is the value of the color in hexadecimal. With the last a data-ext property will be set for that color to be used later in the destiny widget if it is selected.

You can close the colour-picker without selecting a colour by clicking anywhere outside the colour-picker box.

