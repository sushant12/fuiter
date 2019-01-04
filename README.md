# Fuitter

Convert Fb page to website for small businesses.

# Pre requisite

- Postgresql > 9.2
- Yarn
- Nodejs

# Installation

- Clone the repo
- Run `bundle install`
- Copy `database.yml.sample` and rename it to `database.yml`
- Change credentials in database.yml
- Run `rake db:create && rake db:migrate`
- Run `foreman start`
