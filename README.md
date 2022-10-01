
# Realtime Search
A simple reactive app to realtime search through articles and display search analysis per user.

## Architecture
* The app was designed following the **React on Rails** architecture, which is a combination of **Ruby on Rails** and **ReactJs**.
Used to create powerful reactive full stack web apps. 

* **Mongodb** was the database of choice as we are storing articles, and **Mongodb** is most suitable for unstructured data types. It also provides fast full text search using **NLP** to provide a more enhanced search experience. **Mongoid** was used instead of 
**Active Record** as an **ORM** between the app's models and database. 

## Analytics Methodology
To ensure more accurate analytics we have used the following methods & algorithms to remove any redundant queries:
In the front end, analytics are only sent to back end 2 seconds after the user stops writing, this reduces the number 
of analyical data sent to the back end. However, in case the user was a slow typer, we would still have data redundancy.

To solve the data redundancy of slow typers we have implemented an algorithm in the backend to filter redundant analyics. The algorithm processes the query searched by the users by:
  - Transforming the letters to down case.
  - Removing non-alphanumeric charachters.
  - Filtering stop words, such as "and" & "are".
  - Stemming the words.

This would reduce the query to contain only stemmed keywords showing the purpose of the question. If the latest processed
analytics query stored in the database was sent less than 5 minutes ago, we would calculate the Levenshtein distance between that query and the current sent query to find the similarity between them. In case of high similarity, the old query would be removed, and the current one will be added. Otherwise, we would add the current one to the database, without removing the previous.

## Local Setup
* Install `node`, `yarn` and `ruby`, using `nvm` and `rvm` is recommended.

* Install `rails` and `foreman`:
```
gem install rails               # download and install latest stable Rails
gem install foreman             # download and install Foreman
```

* Install mongo db following this link: https://www.mongodb.com/docs/manual/installation/

* Migrate, seed and index the database:
```
  rake db:migrate
  rake db:seed
  rake db:add_indexes
```

* Use the following command to run the app locally:
```
foreman start -f Procfile.dev
```

* Visit http://localhost:3000 to see the app.

## Demo & Deployment

A demo can be found in: https://dwik-realtime-search.herokuapp.com/
The demo was deployed using **Heroku** for the web app and **MongoDB Atlas** for the Database.