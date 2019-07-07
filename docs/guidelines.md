Packaging Guidelines
====================

goal
----

We want packages in Radix to:

1. build repeatedly
2. produce "Responsible Packaging"-friendly, path-agnostic artifacts
3. build reproducibly

... and eventually, move towards shared code and patterns which make this
take less work for each subsequently added package -- which will be a
hill-climbing exercise.

Long story short: write some build scripts and put them in a module first;
just start.  For each item we package, once we've got a first draft,
then we can hash out exactly what to do with it and how to iteratively
improve on it.


guidelines
----------

1. Start by making a module json file.  Have it print "hello world"!
	- Pick any example in the repo and copy it!
	- Most modules will have some fairly monolithic "base" image mounted at `"/"`.
	  Try to use the smallest one you can.
	- It's typical to have an `exec` field which launches a shell that can
	  then glue a couple more steps together...
		- With bash: `["/bin/bash", "-c", "more ; things ; here"]`.
		- Consider trying `smsh`: `["/bin/smsh", "more", "things", "here"]`.
		  (This makes gluing more steps together a matter of adding lines rather
		  than string concatencation, so it's a little neater.)
2. Which language are you working with?
	- For C-family languages:
		- See [Guidelines for C](./guidelines-for-c.md)
	- In general:
		- You can use a `"ingest:pack:tar:./packme"` import to get extra files
		  into the build environment if you need more helper scripts.
	- TODO: more!
3. Quality standards
	- There's fairly-reusable submodules with a diverse set of test containers.
		- These help test for path-agnosticism and that you have enumerated all dependencies.
		- This system still needs a fair amount of work...
			- Ideally we'd like to avoid copy-pasting it;
				- needs a mechanism for passing in the command+flags.
				- also not yet possible to pass in more than one big fileset.
				- basically we need a much higher power templating system to do this well.
			- There's no way to say "this should fail", which means if you can't pass all five challenges, this system is rude.

scratch
-------

- staticness
- xorigin
	- and the interpreter kicklaunch
- having your libraries in the first place

quality levels:

- better than nothing: non-pagno a.k.a. needs whole rootfs as a dependency.
	- ex: basically anything that comes naturally out of a C compiler.
	- ex: most of the world as we know it.
	- reminder -- this is *okay* -- the first draft of most builds will *start here*.
- good-ish: omnibus/fat, as a special case.
	- ex: shaded jars.
		- well, disregarding the jvm/interpreter itself.
	- ex: static linking in C things.
- good: omnibus/fat, ready to be re-itemized without recompiling
	- ex: xorigin'd things where we just bundled libs wholetext.
	- ex: a tarball with a complete series of jars.
- best: pagno and thin plus ca-links
	- ex: xorigin'd things where there's a clear place for symlinks to libs.
	- ex: a tarball with a main jar and clear place for symlinks to... you get the idea.
	- the "plus ca-links" part is as yet underspecified, so we basically can't
	  actually do this until we finish that definition process :)

source-getting:

- todo need to talk about it.
- mostly, separate source catalogs, i guess.  i don't know how to avoid these.
- the git submodule lean is also viable, if... odd.
- different strokes for different kinds of workflow here, it seems.
