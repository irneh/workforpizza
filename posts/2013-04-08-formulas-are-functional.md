---
title: Macros are Imperative. Formulas are Functional.
author: Henri
excerpt: Excel...
---

For years I've been preaching the virtues of functional programming to my
friends and, well, just about anyone who would listen. They've indulged me but
needless to say I don't have many converts. Recently I read a great article
titled [Callbacks are imperative, promises are
functional](http://blog.jcoglan.com/2013/03/30/callbacks-are-imperative-promises-are-functional-nodes-biggest-missed-opportunity/).
It does a good job of bringing a little bit of that functional world to the imperative programmer.
In the article the author states that if you've used Excel you've done
functional programming. It was a minor point but I loved the analogy.  I'm going
to expand it and also state that Excel development can actually be a mix of
functional and imperative styles.

#### The Imperative Piece

Excel has support for macros. An Excel macro is code that runs essentially top to
bottom performing a series of operations. You tell the computer what to do, when,
in what order.
Your code interacts with things outside itself. It may read or set cells
values, read or write to a file or database or in some other way change state.
Each time you run your code the result may be different. You probably expect it
to be. You may be incrementing things, for example, or importing data from an
updated file. This is the imperative piece - a series of steps, top to bottom,
getting, setting and a potentially or expectedly different result each time.

#### The Functional Piece

Excel's most basic element is the cell formula. You define a formula within a cell
and it gives you a result. A formula usually takes an input, though it's not
required. A formula always produces a result. This is the functional piece.
Very much so:

-  The execution of a formula within one cell is independent from the execution
   of formulas within other cells. If a cell is not delivering the right output
   you need only inspect the cell's formula and verify the value of its input.
   One cell can't change how another cell operates or what it delivers as a
   result. (It's a simplification but work with me.)

-  Cells that take input don't care how it was produced. They don't care if
   Excel is giving them a literal value of 34 that you typed in with your
   keyboard or the product of a formula that multiplied 17 by 2.

-  Given one input a formula always returns the same output. If you put the MAX
   formula in a cell and take cells with the values 1-10 as input you are always
   going to produce 10 as output. This is so "functional" it's one of the tenets
   of functional programming.

-  Developing in Excel you often put a formula into, say, cell A10. Then you go
   to cell, say, A11 and put in a formula that refers to A10. And so forth and
   so on. You know that if you got the formula in A10 right all you need to
   worry about in A11 is A11. You don't need to worry about what's happening in
   some other part of your code base. At the end you chain these small, reliable
   pieces together to build bigger things. This is function composition!

Functional programming has a lot of advantages. It's  an awful lot of fun and may
not be as foreign as you think. So, please, go forth and [Learn you a
Haskell](http://learnyouahaskell.com/)! It's awesome.
