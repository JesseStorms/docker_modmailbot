# docker_modmailbot

[Dragory's modmailbot](https://github.com/Dragory/modmailbot) but in a [Docker](https://www.docker.com/) Container. This repository is just the Dockerfile and the modmailbot as a git module.

All you need to run this is your own `config.ini` file. Check out [Dragory's prerequisites](https://github.com/Dragory/modmailbot/blob/master/docs/setup.md#prerequisites), but disregard installing stuff.

## Running the bot

It's pretty easy to run. I'm assuming you have [Docker installed](https://www.docker.com/get-started) and know some basic commandline stuff.
### Using Docker run

You should be able to copy paste this. Make sure you have a folder somewhere with `config.ini`, `./attachments`, `./logs` and `./db` in. We're binding these folders so you can access them on your host. You need to have your `./config.ini` and `./db` bound.

```shell
$ docker run -d \
  --name modmail \
  --mount type=bind,source="$(pwd)"/config.ini,target=/bot/config.ini,readonly \
  --mount type=bind,source="$(pwd)"/db,target=/bot/db \
  --mount type=bind,source="$(pwd)"/logs,target=/bot/logs \
  --mount type=bind,source="$(pwd)"/attachments,target=/bot/attachments \
  jessestorms/docker_modmailbot
```

### Using docker-compose

This repository has my own compose file, but here's one you can copy-paste easily. You'll need to change the volumes. Save this as a `docker-compose.yaml` file.

```yaml
version: '3.7'
services:
  modmail:
    container_name: modmail
    image: "jessestorms/docker_modmailbot"
    restart: unless-stopped
    volumes:
      - /path/to/config.ini:/bot/config.ini:ro
      - /path/to/logs:/bot/logs
      - /path/to/db:/bot/db
      - /path/to/attachments:/bot/attachments
```

Start the bot using `docker-compose up -d -f docker-compose.yaml`. Replace `docker-compose.yaml` with whatever you named it.

## Why does this exist?

I prefer using containers over running something and I've got a docker swarm at my disposal. The original repo doesn't really have anything to deploy on using Docker, so I went ahead and made it myself.

## Something broken?

If the same thing happens when running the bot normally; then you should probably make an issue on [Dragory's repo](https://github.com/Dragory/modmailbot). Otherwise, make an issue here.