On host:

```sh
$ docker-compose build
$ docker-compose run demo
```

In container:

```sh
$ cd example1/
$ rake build publish PUBLISH_DIR=/pkg

$ cd example2/
$ rake build publish PUBLISH_DIR=/pkg
```
