# README

## Geocoding App

### Goal

Create a small rails application where a user can register with an e-mail, password and address,.On
registering the address will be geocoded and after login the results for example: latitude, longitude,
federal state will be displayed to the user.

### Acceptance Criteria

* Registration form with e-mail, password, street, city, zip.
* Login with e-mail and password.
* Geocoding the address with additional info.
* Display info’s about address like latitude and longitude after login.
* Add tests for your code.
* Provide configuration to run the application in a docker environment.
* This README would normally document whatever steps are necessary to get the
application up and running.

### Get it started

- Clone it
  ```bash
  git clone git@github.com:christianrolle/geocoding_app.git
  ```
- Build it
  ```bash
  docker compose up --build
  ```
- Install the gems
  ```bash
  docker compose run web bundle install
  ```
- Create the database
  ```bash
  docker compose run web bundle exec rake db:create db:schema:load
  ```
- Run the specs
  ```bash
  docker compose run web bundle exec rspec --format documentation spec/*
  ```
- Play with it
  - Start server
    ```bash
    docker compose up
    ```
  - Open browser at `localhost:3000`

