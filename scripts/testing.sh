docker image rm testing
docker build --no-cache -t testing .
docker run -it --rm --user heron testing bash
