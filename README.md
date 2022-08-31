<img src ="gh-assets/banner.svg">

**BoxCast** is a simple, flexible, and fast solution intended for casting boxes in the Roblox Engine.

### How Does BoxCast work?
BoxCast essentially works by calculating a derived verisions of the origin & the direction you provided, and then cast a ray using those dervied values.

### How fast can it be?
BoxCast can be ***really*** fast. In our benchmarks, we have seen an average of 200 microseconds. Check the `benchs` folder in this repro for the benchmarkings.

### Install BoxCast
BoxCast can be downloaded through the following:

* Using Rojo manually: Grab the `src` folder from the repro, which you can get by going to the desired release, and grabbing the source zip.
* Using Wally: To download BoxCast using Wally, past the following under `dependencies` in `wally.toml`:
    * ```sinlerdev/boxcast/@X.X.X```, replace the Xs with the version you want to install. 
* Using Studio: Grab the `BoxCast` rbxm from the desired release.


### Contribution
Contributing is heavily welcomed!