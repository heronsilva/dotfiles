$docker_cmd image rm test
$docker_cmd build --no-cache -t test .
$docker_cmd run -it --rm --user heron test zsh
