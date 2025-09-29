# Do-Tracker App

## What is in the project
- Docker Files
- Postgres & Redis Database
- FastAPI 'Do-Tracker' Application

## Set Environment Variables
1. Before running the app, create a .env file in the project root directory
2. Create (or use existing) gitignore file and add the .env file to it
3. Doing this will keep secrets out of code and prevent the .env file from being committed to your Git Repo

For a sample .env file for the Do-Tracker app, see the .env.example file in this Git Repo.

## Running the App
``` bash
cd do-tracker-app
docker compose up
```


## Access the App
1. Open a browser of your choosing
2. In the url bar, type:
```127.0.0.1:8000/```


## Populate Server with Sample Data
1. Open a browser of your choosing
2. In the url bar, type:
```127.0.0.1:8000/init```


## Find a specific 'To-Do'
1. Open a browser of your choosing
2. In the url bar type:
```127.0.0.1:8000/todo-5``` (up to 50)


## Shut Down the App and Servers
``` bash
docker compose down
```

# Helpful Tools
- Docker Desktop
- PyCharm (Community or Pro)

**Note**: The tests require Python 3.13+ and updated dependencies. The Docker setup automatically handles the correct Python version and dependency installation.
