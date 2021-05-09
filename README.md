
# Student Mentor Appointment API

### How to run

Firstly, edit **config/application.yaml** and set ENV variables. After that,

```
rails db:setup
```

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

![Swagger](swagger.png)


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

![Test Results](test-result.png)


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

#### Development Decisions

- Used **PostgreSQL** as a database. Because in this project we need relational database.
- Used byebug to debug easily
- Used **JSON web token (JWT)** for authentication
- Used **figaro** to manage env variables
- Used **rswag, rspec-rails, rspec_api_documentation** to use Swagger and RSPEC
- Used **rack-cors** to allow all request sources
- Used **simplecov** to calculate test coverage

#### To Do

- Admin dashboard (active admin, administrate etc.)
- CI & CD config for github actions
