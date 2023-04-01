Demo available at https://project_task.2rba.com/

## How to run
- Make sure mysql is running
- Pull the code
- Install packages `bundle install`
- Setup database `bundle exec rails db:setup`
- Run webserver `bundle exec rails s`
- For tailwind styles run `bin/rails tailwindcss:watch`

For tests run `bundle exec rspec`

For rubocop run `bundle exec rubocop`

## Project questions

- Q: Do we need users for this demo
- A: No, please exclude users from the implementation

- Q: How should UI looks like?
- A: It should be projects index/new/edit/show pages. Show page should display comments ans status changes. And also add new comment form.

- Q: What are expected statuses for a project?
- A: It should be: new, in progress, done

## Design decisions
- Comments and status changes potentially could be a separate tables, implemented in one table to simplify implementation

## What is not done
- Users
- User interface is rough and requires polishing
- Would be good to include feature tests

