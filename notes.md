# How to get the rings defined?
Method used in Singular (well, actually Plural) in ncalg.lib seems like it should work.
Unfortunately it doesn't quite; we can define the algebras at a root of unity, but it's not possible for the coefficient rings to be multivariate, as we'd want if we're going to be computing things with symbolic parameters.