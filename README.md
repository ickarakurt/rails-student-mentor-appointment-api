
# Student Mentor Appointment API

### How to run

```
rails db:setup
```

 ```
rails s
```

### Swagger EndPoint

```
/api-docs
```  

#### Postman DOC
```
https://documenter.getpostman.com/view/3721602/TzRREUMW
```

#### Postman Collection
```
{project_folder}/api-V1.postman_collection.json
```

### Code Coverage Output
```
{project_folder}/coverage/index.html
``` 
Note : when you run rspec tests, code coverage report will updated.

### Running Tests

##### Running model tests

```
rails t
```

##### Running controller tests

```
rspec
```

###### or together

```
rails t && rspec
```

#### Decisions

- Used PostgreSQL as a database. Because in this project we need relational database.

#### To Do

- JWT secret key is hardcoded. It should be on env file
- Add dotenv support to manage environments easily
- Add admin dashboard (active admin, administrate etc.)
- Add postman tests
- CI & CD config for github actions
