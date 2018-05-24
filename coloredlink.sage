#!/usr/local/bin/sage

#Represents links whose strands are colored by things (quandles, etc.)
#Only works with braid closures
#For now, only works with braids viewed as going up the page.
#Oriented braids to come

class ColoredLink(Link):
    def __init__(self, braid, colors):
        super(ColoredLink, self).__init__(braid)

        if len(colors) == braid.strands():
            self._colors = colors
        else:
            raise ValueError("Wrong number of colors")

    def __repr__(self):
        return super(ColoredLink, self).__repr__() + "\nColoring is " + str(self._colors)

    def validate_colors(self):
        #Make sure that the coloring at the bottom matches the top
        currentColoring =  self._colors
        for crossing in self._braid.Tietze():
            print(crossing)
