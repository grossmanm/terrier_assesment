# README

Ruby version: 3.4.1

Rails version: 8.0.1

Build OS: Ubuntu 24.04.1rai

# Description

This Ruby on Rails application manages and displays work orders for technicians in a scheduling grid.



# Setup Instructions

## Prerequisits

You must have the following install: 

* Ruby (version specified above)

* Bundler (gem install bundler)

* SQLite3 (or another SQL database, if preferred)

## Installation Instructions

1. Clone Repository 
```
git clone https://github.com/grossmanm/terrier_assesment.git
cd terrier_assesment
```
2. Install dependencies
```
bundle install
```
3. Set up the daatabase
```
rails db:setup
```
4. Load CSV data into the database:
```
rake import:load_csv
```
5. Start the Rails server:
```
rails server
```
6. Open browser and navigate to ```http://localhost:3000```

# Design Approach

* Database Schema:
    - ``` technicians ``` table stores technician information (id, name)
    - ``` locations ``` table stores location information (id, name, city)
    - ``` work_orders ``` table acts as a join table between technicians and locations, contains scheduling details (id, technician_id, location_id, time, duration, price)

 * Front-End:
    - Uses a felexible grid layout for work order visualization
    - Popup feature to display technician down-time
* CSV Import:
    - Includes a rake task process to import and delete data

# Potentail Improvements
 * Authentication for user roles (admin, technician, customer, etc.)
 * Drag and drop feature for technician scheduling
 * More robust data pipeline to allow users to upload CSV documents with variable column names
 * Better UI for more interactivity and tooltips

 # Features
* Ability to import and delete table data with the ``` Import Data ``` and ``` Delete Data ``` buttons
* Popup capability to display technician down-times

