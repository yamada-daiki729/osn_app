# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

# use ridgepole

command

```
bundle exec ridgepole --config ./config/database.yml --file ./Schemafile --apply
```

heroku command

```
heroku run "bundle exec ridgepole -c config/database.yml -E production -f ./Schemafile --apply"
```

```
 git push heroku main
```

```
heroku run rails console
```
