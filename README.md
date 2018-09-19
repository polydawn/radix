Radix
=====

> Radix  
> 1 : the base of a number system or of logarithms  
> 2 : the primary source  

*(We're going with definition 2, here.)*

Radix is a project to build software reproducibly
using [Repeatr](https://github.com/polydawn/repeatr),
[Stellar](https://github.com/polydawn/stellar),
and the [Timeless Stack](https://github.com/polydawn/timeless).

This repository contains:

- a bunch of `'module.tl'` files, which contain build instructions;
- a submodule to a `catalog` tree, which contains snapshots of release info
  mapping human-readable names and versions onto immutable hashes;
- and that's about it.

The modules are written by humans; the builds are executed by `stellar emerge`;
and the catalog updates also managed by `stellar` (and sometimes, human
intervention -- but always must pass `stellar catalog lint`).

Modules are currently given names starting with `"early.*"`, to denote that
this project is in an early phase of its life.  It's likely that all of these
references will remain valid for a long time to come; but this prefix is sort
of like a "v0" warning.

Some modules have names rooted at `"[early.]radix.polydawn.io"`.
These are modules that we hope represent good practices, specifically:

- all dependencies are from in the Timeless Stack; no unclean network fetches;
- the build is reproducible;
- the runtime dependencies are either bundled or clear (hash-linked);
- the product fileset is path-agnostic (and any libraries are co-installable);

Not all builds described in this repo will be labeled in the
`"radix.polydawn.io"` namespace.
Some things have tighter association to other namespaces.
And some things simply aren't held to the same bar as the components that we
give the "radix" label -- for example, some modules describe how to capture
a snapshot of some existing non-Radix/non-Timeless distro images, and those
are absolutely not held to the standards of Radix components and generally
cannot be, and so they exist under e.g. `"early.polydawn.io/monolith/*"`
