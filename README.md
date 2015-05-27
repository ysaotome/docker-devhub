# docker-ubuntu

## How to use

* clone

```bash
git clone https://github.com/ysaotome/docker-devhub.git
```

* docker build

```bash
docker build --rm -t ysaotome/devhub docker-devhub/
```

* run mongodb

```bash
docker run -d \
    --name devhub-mongo \
    --restart always \
    -v /path/to/mongo:/data/db \
    mongo:3.0.3
```

* run devhub

```bash
docker run -d \
    --name devhub \
    --restart always \
    --link devhub-mongo:mongo \
    -p 3000:3000 \
    -v /path/to/backupdb:/DevHub/backupdb \
    -v /path/to/uploads:DevHub/static/uploads \
    ysaotome/devhub
```
