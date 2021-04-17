---
title: "Canvas"
linkTitle: "Canvas"
type: docs
weight: 5
---

***** 

SPS Canvas is a place to display and edit scrennshots from different plots. To start 
to use Canvas, you need to take some screenshots but clicking "To Canvas" buttons 
on different tabs/modules. After clicking, the screenshots will be automatically sent 
from these places to this Canvas. 

After SPS v1.1.0 this Canvas feature has been provided as a separate package 
{[drawer](../dev/drawer)}. If you like this feature and want to use outside 
of SPS, install {[drawer](../dev/drawer)}. It is fully compatible with both 
Shiny and R markdown. 


## Prepare plots
In other SPS tabs, adjust your plots to the optimal size by dragging the corner: 

<center>

![plot_tab](../img/plot_drag.png)

</center>

Then use the ‵toCanvas‵ button of that plot to send a screenshot of current plot 
to the Canvas. Or you can click on the "down arrow" <i class="fa fa-sort-down"></i>
to save it to edit in other tools.

<center>

![plot_tab](../img/tocanvas.png)

</center>

## Use the Canvas

<center>

![plot_tab](../img/sps_canvas.jpg)

</center>

**Figure 9** Canvas


1. The Canvas area.
2. Canvas drawing grids. By default, your objects are limited to these drawing grids, but you can change it from top options inside "canvas".
The grid area size is automatically calculated to fit your screen size when you start SPS. 
3. Object information. When you select any object on the Canvas, a bounding box will show to display the object's dimensions, scale, angle and other information.
You can disable them in the "View" menu
4. To edit your screenshots, simply drag your screenshots from left to Canvas working area. 
5. You can add text or titles, and change the font color, decorations in this panel. 
6. Different Canvas options. Several menus and buttons help you to better control the Canvas.
Hover your mouse on buttons will display a tooltip of their functionality. 

Keyboard shortcuts are also enabled with SPS Canvas. Go to "help" menu to see these 
options. 


## Support

Canvas only works on recent browsers versions, like Chrome, latest Edge, Firefox. 
IE is not supported. Also, some browser privacy extensions will block javascript 
and HTML5 canvas fingerprint. This will cause the screenshot to be blank. 

