#!/usr/local/bin/sage


class QuantumGL2Element:
    """
    An element of the quantized universal enveloping algebra of GL_2.
    """

    def __init__(self, coefficient_dict, ring):
        self._ring = ring
        self._coefficient_dict = coefficient_dict
        # self._coefficient_dict[exponents] = coefficient

    def __repr__(self):
        out = ""

        for exponents in self._coefficient_dict:
            out += "({4}) E^{0} F^{1} K^{2} L^{3}".format(exponents[0], exponents[1], exponents[2], ditcexponents[3], self._coefficient_dict[exponents] )

        return out

    def __add__(self, right):
        out_coefficient_dict = {}

        for exponents in set(self._coefficient_dict).union(set(right._coefficient_dict)):
            if (exponents in self._coefficient_dict) and (exponents in right._coefficient_dict):
                out_coefficient_dict[exponents] = self._coefficient_dict[exponents] + right._coefficient_dict[exponents]
            elif exponents in right._coefficient_dict:
                out_coefficient_dict[exponents] = right._coefficient_dict[exponents]
            else:
                out_coefficient_dict[exponents] = self._coefficient_dict[exponents]

        return QuantumGL2Element(out_coefficient_dict, self._ring)

    def monomial_multiply(self, coefficient, exponents):
        """
        Return self * monomial, where monomial is the monomial coefficient (genetators)^(exponents)
        """

    def __mul__(self, right):
        return 0

    def __rmul__(self, left):
        return left * self