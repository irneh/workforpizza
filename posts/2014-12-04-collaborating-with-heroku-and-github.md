---
title: Collaborating with Heroku and Github
author: Henri
excerpt: Collaborating with Heroku and Github
---

#### Assumptions

You -- the project owner, already manage the Heroku application, the Github
repository and maintain a branch named "master."

They -- are the person(s) you will share code and deployment rights with.

All -- Have Git installed, SSH keys registered with their own Github
accounts and Heroku command line tools installed.

#### Github collaboration

You -- Use your web browser to view your Github repository, click "Settings,"
click "Collaborators," and type in your collaborator's username.

They -- Will get an informational email they can ignore.

[Github reference](https://help.github.com/articles/adding-collaborators-to-a-personal-repository/)

#### Heroku sharing

You -- From the command line, within the directory that contains your Heroku/Git
project, type:

    heroku sharing:add their-email@their-domain.com

They -- Will get an email suggesting they issue this clone command:

    git clone git@heroku.com:your-app.git -o heroku

You -- Let them do that since they may do it regardless of what you say. That
will get them a clone of what's running on Heroku. Next they need to add Github
as a remote, set it as the default remote and pull the latest code. To do so you
or they use a web browser to look up and copy the "HTTPS clone URL" from your
Github repository and, from within their project directory issue these commands:

    cd your-app
    git remote add origin https://github.com/your-username/your-app.git
    git fetch origin
    git branch --set-upstream-to=origin/master

[Stack Overflow discussion](http://stackoverflow.com/a/2286030)

#### Publishing and deploying

All -- Push and pull from Github and deploy to Heroku with:

    git push         # Push to Gihub
    git pull         # Pull from Github
    git push heroku  # Deploy to Heroku

#### Acknowledgment

By using something like Github as a central service many are ignoring the "D" in
Git's DRCS (Distributed Revision Control System). This article doesn't endorse
the practice but documents it.
