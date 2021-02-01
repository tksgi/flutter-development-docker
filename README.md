# Docker for Flutter development


## build
```
$ docker build -t flutter .
```

## Usage
run in your working directory(Linux)
```
$ docker run --workdir /home/developer/workspace -v "$PWD":/home/developer/workspace --device=/dev/bus -v /dev/bus/usb:/dev/bus/usb -it flutter bash
```

## references
https://blog.codemagic.io/how-to-dockerize-flutter-apps/
