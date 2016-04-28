# Codeo Bot (Pardner)

Slack bot for codeo times

# Services

* [Project Management (Github)](https://github.com/carbonfive/codeo-bot/issues)
* [Uptime Robot (keeps pardner awake)](http://uptimerobot.com/)

# Environments

* http://c5-codeo-bot.herokuapp.com

# Development

Pardner is a simple slackbot and sinatra application. It is based on the
[Slack Ruby Bot](https://github.com/dblock/slack-ruby-bot) framework.

This project was set up by following this very helpful [tutorial](https://github.com/dblock/slack-ruby-bot/blob/master/TUTORIAL.md).

## Getting Started

### Requirements

To run the specs or fire up the server, be sure you have these:

* Ruby 2.3 (see [.ruby-version](.ruby-version) for patchlevel)
* PostgreSQL 9.x with superuser 'postgres' with no password (```createuser -s postgres```)

### First Time Setup

After cloning, run
```
bundle
bundle exec rake db:create
bundle exec rake db:migrate
```

### Running the Specs

The default rake task is to run the specs so you can just
```
rake 
```

### Running the Application Locally

    $ foreman start
    $ open http://localhost:5000

## Conventions

### Git

The following is what we *should* be doing, but aren't (yet). See this [issue](https://github.com/carbonfive/codeo-bot/issues/1)

* Branch ```development``` is auto-deployed to acceptance.
* Branch ```master``` is auto-deployed to production.
* Create feature branches off of ```development``` using the naming convention ```(features|chores|bugs)/a-brief-description-######```, where ###### is the tracker id.
* Rebase your branch before merging into ```development``` to produce clean merge bubbles.
* Retain merge commits for multi-commit branches when merging into ```development``` (e.g. ```git merge --no-ff branchname```).
* Craft atomic commits that make sense on their own and can be easily cherry-picked or reverted if necessary.

### Code Style

Generally speaking, follow the [Ruby Style Guide](https://github.com/bbatsov/ruby-style-guide). Additionally, these are other guidelines adopted by the team:

**Always use double quotes for test/spec descriptions, unless the subject is a class/module.**

```ruby
describe SomeController do
  context "when logged in as an admin" do
    describe "#some_method" do
      it "does some thing"
    end
  end
end
```
### Git Remotes

Set up these git remotes, so you can run ```git push acceptance master```

    $ git remote add production git@heroku.com:c5-codeo-bot.git
    $ git config remote.production.push development:master

### Deploying

After pushing your changes to github:

    $ heroku push production master
    $ heroku run rake db:migrate --app c5-codeo-bot

# Server Environments

### Hosting

Production is hosted on Heroku

### Environment Variables

Several common features and operational parameters can be set using environment variables.

**Required**
```SLACK_API_TOKEN``` - Token that directs messages to our slackbot.

See the [.env](https://github.com/carbonfive/codeo-bot/blob/master/.env) file for an example.
