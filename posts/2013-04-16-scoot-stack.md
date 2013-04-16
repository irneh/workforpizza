---
title: Scoot Architecture Part 2 - Application Stack
author: Henri
---

This is part 2 in a series detailing the systems and application architecture
running [Scoot](http://scoot.io). Scoot's core services are on Amazon Web
Services (AWS). This article describes the application stack.
This post is one half how we did it and another half how you can do it.

#### Topology, with Generics

Here is a topology that shows functional components without software specifics.
Control and data flow should make some level of sense.

[![](/images/scoot-stack-small.png)](/images/scoot-stack.png)

#### Topology, with Specifics

Here is a diagram that mirrors the previous and adds some software specifics in
grey.

[![](/images/scoot-stack-specific-small.png)](/images/scoot-stack-specific.png)

Let's do a quick run-through of the components.

#### Simple Storage Service (S3)

[S3](http://aws.amazon.com/s3/) is Amazon's scalable storage service.
We use it to store photos. A primary benefit of using a storage service is not
having to manage disks or grow volumes.

#### AWS Cloudfront

[Cloudfront](http://aws.amazon.com/cloudfront/) is Amazon's Content Delivery
Network (CDN). The CDN delivers static resources such as Javascript, CSS and
images. Using a CDN your content is likely to get to the browser faster and the
load on your web server(s) should be reduced. Our CDN has two origins. One
origin is S3, for photos. The other origin is our web server, for everything but
photos.

#### Elastic Load Balancer (ELB)

[ELB](http://aws.amazon.com/elasticloadbalancing/) is Amazon's load balancer.
ELB routes requests to the web servers. ELB monitors the health of the web
servers and knows how many are available via [AWS
Auto Scaling](http://aws.amazon.com/autoscaling/) integration.

Other options for load balancing are [HAProxy](http://haproxy.1wt.eu/) and
[Varnish](https://www.varnish-cache.org/). It's improper to compare these three
options as they each have different purposes. They do all offer some form of
load balancing, though.

- If you are already using HAProxy or Varnish, you may not need the AWS ELB.
- If you are using Auto-Scaling you will probably want to start with the AWS
  ELB.
- If you use the AWS ELB you can still run Varnish or HAProxy behind or in
  front of your AWS ELB if you need to.

#### Nginx

[Nginx](http://wiki.nginx.org/Main) is a web server and [reverse
proxy](http://en.wikipedia.org/wiki/Reverse_proxy). We use it as a web server to
serve static files. We use it as a reverse proxy to forward requests to our
application server. A partial configuration looks like this:

```
server {
  listen 80;
  location / {
    uwsgi_pass 127.0.0.1:3031;         # forward to app
  }
  location /static/ {
    alias /home/ubuntu/myapp/static/;  # serve from disk
  }
}
```

#### Static Files

These are resources like Javascript, CSS, favicons and logos.

#### Python

[Python](http://www.python.org/) is the programming language that was used to
build the server-side application. Python generates the dynamic content for the
site by reading from the database. Python also handles photo rendering and writes to
S3.

There is a wealth of Python [web development
frameworks](http://wiki.python.org/moin/WebFrameworks) to choose from.

#### uWSGI

[uWSGI](http://projects.unbit.it/uwsgi/) is a
[Web Server Gateway Interface](http://en.wikipedia.org/wiki/Web_Server_Gateway_Interface)
(WSGI) server that allows the web server to talk to the Python application.
You may think of uWSGI as "running" the Python application.

Due to Python's [global interpreter
lock](http://en.wikipedia.org/wiki/Global_Interpreter_Lock) you need to start
multiple uWSGI processes for an application to support concurrency. Determining
how many Python processes to start requires:

- Counting how many CPU cores you have
- Measuring how much RAM your application uses
- Measuring how much RAM you have available
- Counting how many machines you have running application servers
- Testing performance at varying levels of concurrency using load simulators

I will try to write an article on that process.

#### Memcached

[Memcached](http://memcached.org/) is an in-memory object store. Frequently read
objects are written to the cache and read from there instead of from the
database. This improves performance and eases load on the database server(s).

#### PostgreSQL

[Postgres](http://www.postgresql.org/) is a relational database system. Boring,
huh? No. Postgres is great. While I've loved using [Redis](http://redis.io/) on
other projects and we evaluated both [MongoDB](http://www.mongodb.org/) and
[Cassandra](http://cassandra.apache.org/), we ended up choosing Postgres. It was
simply better suited to the task. To some it may feel boring if it's not
[NOSQL](https://en.wikipedia.org/wiki/NoSQL) but it's been very nice working with
a mature and well documented data store. Here's an example of what we're [glad
to have](http://www.postgresql.org/docs/9.2/static/textsearch-intro.html).

If you are new to PostgreSQL you may want to use
[pgtune](http://pgfoundry.org/projects/pgtune/)
to help you get started on a configuration that will optimize performance.

#### Celery

[Celery](http://www.celeryproject.org/) is used to run programs that render
photos. Photo rendering requests are put into a queue. Celery picks up the
requests, renders the photos and clears the queue.

#### RabbitMQ

[RabbitMQ](http://www.rabbitmq.com/) is the message broker we chose as a
back end for Celery. I can't help but quote
[DevOps Borat](https://twitter.com/DEVOPS_BORAT/status/163016374023761920):

```
If RabbitMQ is answer, you are ask wrong question.
```

If you're new to the asynchronous job & message queue world it may take some
time to get things working right but once you get over that hurdle these things
work predictably and reliably.

#### Other Articles in the Series

[Scoot Architecture Part 1 - Servers](../scoot-servers/)

More articles to come...
