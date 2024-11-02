docker image rm test
docker build --no-cache -t test .
docker run -it --rm --user heron test zsh
