#!/usr/local/bin/sage

def symbolic_inverse(x):
    """
    Return the inverse of the possibly-symbolic matrix x.
    Since x is 2x2 this is not hard to do. 
    """
    return Matrix( [[x[1,1],-x[0,1]], [-x[1,0],x[0,0]]] )/(x[0,0]*x[1,1]-x[0,1]*x[1,0]).simplify_full()

def gl2star_left(x,y, positive = True):
    if positive:
        return (y[0], (x[1] * y[1] * symbolic_inverse(x[1])).simplify_full() )
    elif not positive:
        return ( (x[0] * y[0] * symbolic_inverse(x[0])).simplify_full(), y[1])

def gl2star_right(x,y, positive = True):
    if positive:
        return ((symbolic_inverse(gl2star_left(x,y,positive = True)[0]) * x[0] * gl2star_left(x,y,positive = True)[0]).simplify_full(), x[1] )
    elif not positive:
        return (x[0], (symbolic_inverse(gl2star_left(x,y,positive = False)[1]) * x[1] * gl2star_left(x,y,positive = False)[1]).simplify_full())
        
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

    def left_color(x,y,sign):
        return self._coloring_rules[0](x,y,sign)

    def right_color(x,y):
        return self._coloring_rules[1](x,y,sign)

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