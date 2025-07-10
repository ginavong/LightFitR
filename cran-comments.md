## R CMD check results

0 errors | 0 warnings | 3 notes

* This is a new release.

## Notes

❯ checking R code for possible problems ... NOTE
  Found if() conditions comparing class() to string:
  File 'LightFitR/R/internal.calibCombine.R': if (class(l) == "numeric" | class(l) == "integer") ...
  Use inherits() (or maybe is()) instead.

* Using is() or inherits() requires extra dependencies for this simple use case.

❯ checking for future file timestamps ... NOTE
  unable to verify current time
  
* I don't believe this is an issue with the package...

## revdepcheck results

*Wow, no problems at all. :)*
