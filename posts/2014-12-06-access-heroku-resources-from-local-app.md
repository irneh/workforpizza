---
title: Access Heroku Resources from a Local App
author: Henri
excerpt: Access Heroku Resources from a Local App
---

Rigour and standardized deployment practices stand against you but there are
times you will run a clone of a Heroku app on your notebook and -- from outright
need or laziness -- access primary Heroku/Amazon/etc. services and data.

We know getting source code is trivial:

    git clone git@heroku.com:your-app.git -o heroku

Demonstrating with Python, the setup or the virtual environment and the
installation of project dependencies is simple:

    cd your-app
    virtualenv venv
    source venv/bin/activate
    pip install requirements.txt

The trickier parts are the credentials used to access your data services and
stores (Postgres, Redis, Elasticsearch, etc.). Copying credentials from
Heroku configurations to a local file is sub-optimal because whether it's a
shell profile/rc or env.cfg it's eventually going to be forgotten or read or
Git-pushed or otherwise replicated to the wrong place. Here's a simple way to
load the remote config locally and ephemerally:

    while read i; do export $i; done < <(heroku config -s)

I'm going off track but if you want to make things easier still for your
collaborator you can wrap some of the above into a shell script named, say,
"init.sh" containing:

    source venv/bin/activate
    while read i; do export $i; done < <(heroku config -s)

Make it executable:

    chmod a+x init.sh

And once the initial installation is done they can always start from a fresh
terminal and simply do:

    ./init.sh
