#!/usr/local/bin/sage

def my_inverse(x):
    """
    Group operations on the Poisson dual of GL_2.
    x should be a tuple of the form
    (upper-triangular 2x2 matrix, lower-triangular 2x2 matrix)
    """
    l = x[0]
    upper = Matrix( [[1/l[0,0], 0], [-l[0,1]/(l[0,0]*l[1,1]), 1/l[1,1]]])
    r = x[1]
    lower = Matrix( [[1/r[0,0], -r[1,0]/(r[0,0]*r[1,1])], [0, 1/r[1,1]]])
    return (upper, lower)

class ColoredLink(Link):
    """
    Represents links whose strands are colored by things (quandles, etc.)
    Only works with braid closures
    For now, only works with braids viewed as going up the page.
    Oriented braids to come
    """
    def __init__(self, braid, colors, coloring_rules):
        super(ColoredLink, self).__init__(braid)

        if len(colors) == braid.strands():
            self._colors = colors
        else:
            raise ValueError("Wrong number of colors")

        self._coloring_rules = coloring_rules

    def __repr__(self):
        return super(ColoredLink, self).__repr__() + "\nColoring is " + str(self._colors)

    def left_color(x,y):
        return self._coloring_rules[0](x,y)

    def right_color(x,y):
        return self._coloring_rules[1](x,y)

    def validate_colors(self):
        #Make sure that the coloring at the bottom matches the top

        current_coloring =  self._colors
        next_coloring = []

        for crossing in self._braid.Tietze():
            print(crossing)
            for i in range(0,self._braid.strands()):

                if i == abs(crossing) - 1:
                    #follow the rule
                    next_coloring.append("foo")
                
                elif i == abs(crossing):
                    #follow the rule
                    next_coloring.append("bar")
                
                else:
                    next_coloring.append(current_coloring[i])

            current_coloring = next_coloring
            next_coloring = []

        print current_coloring
        if current_coloring == self._colors:
            return True
        else:
            return False

# right(x,y) = 
# x = ColoredLink(BraidGroup(2)([1]),["a","b"],4)