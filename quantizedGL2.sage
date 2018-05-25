#!/usr/local/bin/sage

class QuantumGL2Algebra:
    """
    An instance of U_q(gl_2).
    """

    def __init__(self, order, parameters, epsilon = "epsilon"):

        if order % 2 ==0:
            raise ValueError("Order should be odd.")
        else:
            self._order = order

        if len(parameters) != 4:
            raise ValueError("Parameters should be a tuple of four scalars.")
        else:
            self._parameters = parameters

        self._preR = PolynomialRing(RationalField(), 'q');
        self._coefficient_ring = self._preR.quotient(cyclotomic_polynomial(order, self._preR.gen()), epsilon)

    def __repr__(self):
        out = "Quantum enveloping algebra U_{0}(gl_2) with {0} a primitive {1}th root of unity.\n".format(self._coefficient_ring.gen(), self._order)
        out += "Actions of (E^{0}, F^{0}, K^{0}, L^{0}) are {1}.".format(self._order, self._parameters)
        return out

    def parameters(self):
        return self._parameters

    def coefficient_ring(self):
            return self._coefficient_ring

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