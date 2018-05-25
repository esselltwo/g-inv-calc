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

def transfer_colors(Tietze_data, bottom_colors, coloring_rules):
    """
    Given the coloring the input strands of a braid, compute the coloring of the output strands.
    For example, this can be used to check when a braid coloring extends to a coloring of the closure of the braid.
    """

    strands_needed = 0
    for crossing in Tietze_data:
        if abs(crossing) + 1 > strands_needed: strands_needed = abs(crossing) +1

    if strands_needed == 0:
        raise ValueError("Invalide Tietze_data {!r}.".format(Tietze_data))

    strands = len(bottom_colors)
    if strands < strands_needed:
        raise ValueError("Not enough colors. Needed {}.".format(strands_needed)) 

    current_coloring =  bottom_colors 
    next_coloring = []

    for crossing in Tietze_data:
        for i in range(0,strands):

            if i == abs(crossing) - 1:
                next_coloring.append(coloring_rules[0](current_coloring[i],current_coloring[i+1], crossing >0 ))
            
            elif i == abs(crossing):
                next_coloring.append(coloring_rules[1](current_coloring[i-1],current_coloring[i], crossing >0 ))
            
            else:
                next_coloring.append(current_coloring[i])

        current_coloring = next_coloring
        next_coloring = []

    return current_coloring

   
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

    # right(x,y) = 
# x = ColoredLink(BraidGroup(2)([1]),["a","b"],4)