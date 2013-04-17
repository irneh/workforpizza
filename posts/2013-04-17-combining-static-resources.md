---
title: Combining Static Resources
author: Henri
excerpt: Teach a Man to Fish...
---

A few months ago I was performance tuning a site. I'd manually combined the
Javascript files into one and concluded from testing that the
client collected the resources faster. So I went off on the web looking for
utilities to help me combine JS files, CSS files, etc. And why not something
that would integrate with a build system, too? I must have spent more than 15
minutes before realizing what an idiot I was. Everything I needed, and it wasn't
much, was right there under my feet.

``` bash
cat x.js y.js z.js > combined.js
```

If you are looking for a way to concatenate your your static resoureces, you
already know how. If you want to decorate a script with comments here's one way:

``` bash
#!/bin/bash
cat base.css      `: Skeleton` \
    skeleton.css `: Skeleton` \
    layout.css   `: Skeleton` \
    syntax.css   `: Pandoc` \
    local.css    `: Henri` \
  > ../combined.css
```
