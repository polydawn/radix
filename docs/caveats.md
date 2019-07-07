Caveats
=======

This repo is a work in progress.

Some modules may use bad practices.

There are not yet consistent rules for how successfully path-agnostic something
must be in order to be included in this repo.
(In the future, we want to have such rules, or at least a scoring system;
and ideally, and automatic test suite for it.)

The quantity of copy-pasta is high.
(In the future, we want to explore templating -- but not too early;
we want to find out "the hard way" what's worth it vs what would be premature.)

Some of the filesets containing essential compilers are large, monolithic,
ball-of-mud images from "outer space" (e.g. they have no clear, repeatr'ized,
hash-locked rebuild path).
(In the future, we want to replace these... obviously!!)

Some modules that build things from source use a git submodule and an ingest.
(This might be fine, but we're also not sure if it's a good pattern to use
in the long run; and the jury isn't even out yet: we're still factfinding.)
You may need to run `git submodule update --init` before being able to
successfully build these modules.

The catalog itself is a git submodule.  *This is incidental, not important*.
Right now, you'll definitely need to run `git submodule update --init` to
get the catalog: and if you plan to make new releases, be dang sure to pull
first, and to commit and push when you're done.
(In the future, we intend to build "catalog polination" commands, and drop the
git submodule for a form of tool-assisted link vendoring.  This just hasn't
landed yet.  Soon...!)

Lots of things are being put under a name which includes the string "early".
This is to denote we're not frankly really sure we're committed to these
names yet and they're subject to change in the future.
(In the future, we'll expect to take names fairly seriously, and consider
the removal of any names or changes of name->wareID mappings to be "breaking"
changes to be avoided at great cost; now, in early drafts... not so much.)

Some modules currently committed *reach out to the network* during build.
Unfortunately, we haven't made the default of formulas to deny network yet
(and we should: then at least these badly behaved formulas would need to clearly
advertise their badness).  Don't make more of these.
(The monolithic base-image capture scripts are the only ones that do this;
those are already full of lots of other badness that should be avoided as well.)

... and lots of other caveats as well.  Read critically.  Try to be *better*
than the code that's currently committed, if you can see a way to do so.

We'll try to shore up all these things in future refactor commits.
Ideally, this list of caveats should be *empty*; it'll just take us a while
to get there. :)
