
# Scheduling Demo

## Repo: https://github.com/eisaacson05/scheduling-demo

## Setup: 
  1. `yarn`
  2. `rake db:create db:migrate import:all`
  3. `rails server -e development`

## Method: 
  * SQLite db for low setup overhead. 
  * Compute absolute positions or work orders, free times, and durations of free times from a fixed y-pixels-per-hour. 
  * Pass free time durations to the front-end in the html data attribute, for later display in the modal. 

## Challenges: 
  * The durations of both beginning and end of day free times were unbounded. Added beginning and end of work days to bound them.
  * A user had a schedule conflict. Conflicts are filtered out and displayed in the UI. In future some resolution method should exist.
  * A service worker became bloated after some development, so divided it's functionality into smaller workers for better coupling / cohesion.

## Improvements: 
 * First priority are untested conditions (EG bugs):
    - What if a technician has no work orders? 
    - What if there were many technicians compacting the UI in the x direction? 
    - What if there are no technicians scheduled?
    - etc.
 * Second priority:
   - Look into managing view complexity. Partials could help.
   - Removing all orders that are double booked, not just one from every conflicting pair.
 * Backlisted:
   - CRUD
   - authorization / authentication 
   - layout fixes for mobile / small screens
   - time zones
   - prod mode
   - ask client for more
