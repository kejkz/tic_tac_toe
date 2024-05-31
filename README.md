# Tic Tac Toe assignment

A Rails based game of tic tac toe, made for any number of players

## Installation

Requirements: Docker and Docker compose

Find more details about the installation on the [official docker guide](https://docs.docker.com/compose/install/)

After obraining the archive, extract to any directory, and run

```
docker-compose up
docker-compose run web bin/rake db:create
```

Setup docker environment by adding the `.env` file with:

```
RAILS_MASTER_KEY=`secret`
RAILS_ENV=development
REDIS_URL=redis://redis:6379/1
```

## Running

Navigate to `localhost:3000/users/new` to sign in for the game.

## Known issues

- Logic of the new games creation and joining is still flaky. There is a chance that both active users will appear in different games during the execution
- Page reloads during the games execution, which is really bad user experience, but works
- Closing the game window still doesn't close the game
