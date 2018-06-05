# How to get the rings defined?
Method used in Singular (well, actually Plural) in ncalg.lib seems like it should work.
Unfortunately it doesn't quite; we can define the algebras at a root of unity, but it's not possible for the coefficient rings to be multivariate, as we'd want if we're going to be computing things with symbolic parameters.

# Work at level of tensors
Ultimately, we are just going to be computing a big product of R-matrices and taking the contraction of each pair of indices.
It may simply be better to work with these as our basic objects.
Need to define methods (or borrow from somewhere: maybe use ``sage.tensor.modules.finite_rank_free_module`` or similar.) 