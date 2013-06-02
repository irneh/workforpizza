---
title: Combining Static Resources
author: Henri
excerpt: Teach a Man to Fish...
---

I was off on the 'net looking
for utilities to help me combine JS files, CSS files, etc. And hey, maybe something
that would integrate with a build system? I must have spent more than 15
minutes, straying off into YUI Compressors and such, before realizing what an
idiot I was. I already had everything I needed.

``` bash
cat x.js y.js z.js > combined.js
```

I wonder why we sometimes forget our basic tools and think we need something
big. Here's a way to add comments to a multi-line concatenation:

``` bash
#!/bin/bash
cat base.css    `: Skeleton` \
    skeleton.css `: Skeleton` \
    layout.css   `: Skeleton` \
    syntax.css   `: Pandoc` \
    local.css    `: Henri` \
  > ../combined.css
```

And of course it integrates with a build system.
