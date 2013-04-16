---
title: Comparing Apples and Amazon Web Services
author: Henri
excerpt: We know how to run benchmarks so let's just do it without thinking and publish it...
---

Many do "how low can you go?" comparisons. So let's follow in their footsteps and
not think about what we're doing until later. If you're on Amazon Web Services
(AWS) using Elastic Computing Cloud (EC2) then you know their smallest offering
is a t1.micro that isn't suitable for benchmarking. The next smallest offering
is an m1.small. That can be had for ~$25-$40/month. Let's compare the
performance of one of those against the $20/month Linode offering and the
$5/month Digital Ocean (DO) offering. Running UnixBench we get the following results,
averaged, with standard deviation (STDEV), from 4 samples over 50 days.

    # CPU (STDEV)
    EC2:     182 (23%)
    Linode: 2242 (20%)
    DO:     1291 ( 0%)

    # I/O MB/s (STDEV)
    EC2:     37 (12%)
    Linode:  75 (36%)
    DO:     119 (28%)

    # Network MB/s (STDEV)
    EC2:     19 (52%)
    Linode:  90 ( 2%)
    DO:      12 (12%)

Alright. Let's not think too much and draw some preliminary conclusions.

- Linode and DO offer an order of magnitude greater CPU.
- DO's I/O is by far the best (they state the plan is on SSDs).
- Linode's network is nearly an order of magnitude better than the others.

Maybe that's enough for you to make a choice but let's look at the STDEV
between the results and draws some perhaps more meaningful conclusions.

- DO's CPU is very consistent.
- EC2's I/O is very consistent.
- Linode's network is very consistent.

Sound familiar? "We do X, Y and Z. Pick one." Well, sadly it's not
that simple either. We've measured over time because we worry our VPS
neighbors might hurt our performance. Indeed, the numbers vary over time. But
not all of our servers have been housed in the same data centers or even
geographical regions. If a Linode is in Fremont (ah, Hurricane Electric!) and a
DO is in Dallas and an EC2 box is in Virginia or the Northeast or Australia, how
does that affect performance? My rambling point is that it's pretty
tough to do a few tests and draw conclusions. Much depends on:

- Where are your customers?
- What's the nature/technical protocol of your services?
- What are you uptime requirements?

That's just skimming the surface. And before even thinking about that let's look at
how the _virtual_ hardware of our servers compares.

    # CPU (cores)
    EC2:    1
    Linode: 8
    DO:     1

    # RAM (GB)
    EC2:    1.7
    Linode: 1.0
    DO:     0.5

    # Disk space (GB)
    EC2:    168
    Linode:  24
    DO:      20

Wow. "So I get 70-340% more memory and 7 times more storage on EC2?" Yes. "But it
looked like EC2 sucked and now it seems it has these other resources where it
kicks ass. So how do I decide?" Well, use a few offerings for a while and find
out for yourself which is best for your needs. Start here and compare:

    * Need to run personal blog
      (Depends.) It is database backed like Wordpress?
          Yes --> More questions
              --> And so forth and so on
          No  --> Just host it on GitHub
              --> Or Amazon S3/Cloudfront (again the choices!)
    * Need to scale up and down hourly like Netflix
      --> Use EC2

## Interruption

The lady of the house is home, the pizza dough has risen and I have to tend to
that.

## More of an Ending than a Conclusion

AWS in an ecosystem. EC2 is a service within AWS. Comparing a single EC2
instance to a $5/month or $19/year VPS is comparing apples to oranges. If all
you need is compute power from a number of servers then EC2 is going to
cost you more. Unless, of course, you spin them up and down when you need them.
Then EC2 might be cheaper. If your comparison is based primarily on monthly
cost per server you may already be off on the wrong foot in your evaluation.

## Update

My first deep dish pizza came out better than expected.

[![](/images/pizza-1-small.jpg)](/images/pizza-1.jpg)

[![](/images/pizza-2-small.jpg)](/images/pizza-2.jpg)

Essentially, I made the dough from
[here](http://www.pizzamaking.com/dkm_chicago.php). But I dropped the salt and
stuck with olive oil as I didn't have canola. I don't have a mixer so I blended
the ingredients with a spoon then kneaded by hand for the 7+ minutes. Oh, and I
split the dough into two balls and used a 9 inch pan.

I took the second dough ball out of the fridge a few days later and the pizza came
out well. I added eggplant, more spinach and more cheese. Before cooking:

[![](/images/pizza-before-small.jpg)](/images/pizza-before.jpg)

After cooking:

[![](/images/pizza-above-small.jpg)](/images/pizza-above.jpg)

## Update 2

A few days after this post Linode doubled the RAM in their $20/month plan.
That's now reflected above. I'm making pizza again today and the dough is rising
in a smilarly competive fashion:

[![](/images/pizza-dough-before-small.jpg)](/images/pizza-dough-before.jpg)

[![](/images/pizza-dough-after-small.jpg)](/images/pizza-dough-after.jpg)
