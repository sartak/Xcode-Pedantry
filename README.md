# Xcode Pedantry

For me, one of the big draws of Objective-C is compile-time validation. I'm coming from Perl, which can barely [warn](http://www.perlmonks.org/?node_id=1038684) [you](http://www.perlmonks.org/bare/?node_id=412536) [about](http://stackoverflow.com/questions/11695110/why-is-this-program-valid-i-was-trying-to-create-a-syntax-error) [syntax](http://stackoverflow.com/a/6780331/290913) [errors](http://modernperlbooks.com/mt/2009/08/the-problems-with-indirect-object-notation.html).

I [build and run](http://nshipster.com/pragma/) with "Treat Warnings as Errors", of course. I also turn on most of the optional warnings that Xcode and clang offer.

That is not enough for me.

I add my own custom warnings and errors to Xcode as I find little problems that bother me. Better to invest the time up front to teach the computer to find the error than to let these [pebbles in your shoes](http://www.altdevblogaday.com/2012/10/21/fix-your-pebbles/) be a drag on you.

## [Check `#import` Casing](https://github.com/sartak/Xcode-Pedantry/blob/master/check-import-casing.pl)

See [Compile-Time Error for Incorrectly Cased `#import`](http://sartak.org/2014/04/compile-time-error-for-incorrectly-cased-import.html) for details.

## [Ban Problematic Symbols](https://github.com/sartak/Xcode-Pedantry/blob/master/ban-problematic-symbols.pl)

I've asked [`SKShapeNode`](http://sartak.org/2014/03/skshapenode-you-are-dead-to-me.html) to not come back into the office.

I also don't want to have to [remember to use `CGFloat`](https://developer.apple.com/library/ios/documentation/General/Conceptual/CocoaTouch64BitGuide/OptimizingMemoryPerformance/OptimizingMemoryPerformance.html#//apple_ref/doc/uid/TP40013501-CH4-SW3) everywhere instead of `float`. Next on my list is `int` and `NSInteger`.

If my app ever makes the jump from iOS to OS X, I don't want to do the busywork of changing `UIColor` to `NSColor`, so I enforce the usage of `SKColor`.

## [Forbid Complex Method Stacking](https://github.com/sartak/Xcode-Pedantry/blob/master/forbid-complex-method-stacking.pl)

Search your codebase for `[[[[[`. Are you really happy with those results?

I'm pleased to report that my 18k-line project did not have a single instance of `[[[[`. And it had only three instances of `[[[`. Which I just fixed thanks to this build script.

## [Forbid Sloppy Whitespace](https://github.com/sartak/Xcode-Pedantry/blob/master/forbid-sloppy-whitespace.pl)

I don't feel particularly strongly about this one. Except in as much as consistency is king. So I format all my method signatures like so:

    -(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

Notice that there is no whitespace before or after the `-` or `(UITableViewCell *)`. Also notice that there _is_ whitespace between types and their `*`.

## [Use `instancetype`](https://github.com/sartak/Xcode-Pedantry/blob/master/use-instancetype.pl)

clang automatically rewrites certain uses of `id` to the more useful `instancetype`. Instead of relying on that, better to be explicit.
