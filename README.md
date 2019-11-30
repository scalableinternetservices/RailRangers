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
eb create -db.engine postgres -db.i db.m5.large -db.user u -db.pass password --envvars SECRET_KEY_BASE=RANDOM_SECRET -i c5.large --scale 1 RailRangers

* ...
