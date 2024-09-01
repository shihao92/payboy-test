# README
The backend and frontend sits at monorepo but are both different apps.

## Backend
### How to start your local server?
- obtain the necessarily gitignored files from me such as master.key
- cd into backend directory
- run bundle install
- run rails db:create to create the database
- run rails db:migrate to run the migration of the database tables
- run rails db:seed to seed the required data to run the system
- run rails s to start the localhost server which runs on port 3002

## Frontend
- obtain the constants.json from me
- cd into the frontend directory
- place the constants.json in the frontend directory
- run yarn install
- then run yarn dev