# Supervisory Control and Data Acquisition (SCADA) for Data Workflows

SCADA allows teams to define robust and repeatable extract-transform-load processes from data sources into data sinks (e.g. a search index). Resources are enriched through declarative tasks that may be distributed, monitored, and inspected through the SCADA interface.

Built into the data pipeline are checkpoints to validate data quality and conformance before being released to consumers.

## Purpose

- Building artisanal data workflows is time consuming and error prone. We want to provide an environment for building consistent workflows with clear data entry and exit points, with clear steps along the way for monitoring data integrity.

- Data workflows should be sharable and reusable. We want a way to exchange data transformations and enrichments across workflows and organizations.

- Data workflows should be declarative, and not tightly coupled to particular environments, languages, or architectures. Data workflows should be modular, allowing workflow managers to choose appropriate components for a given pipeline.

## Requirements

- **Ruby**. SCADA requires Ruby 2.0 or greater.
- **Bundler**. We require a recent version of Bundler. Bundler is typically installed by running `gem install bundler`
- **Database**. SCADA is a Rails application that requires a database. Any database that works with ActiveRecord should work with this application.

## Installation

Configure environment-specific settings for your application:

- `config/database.yml`
- `config/secrets.yml`

And run these commands to get up and running:

```
$ bundle install
$ rake db:migrate
$ rails server
```

## Testing

```
$ rspec
```