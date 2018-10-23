alias dgit='docker_git'

docker_git() {
	docker run -ti --rm -v ${HOME}/.aws:/home/brett/.aws -v $(pwd):/home/brett/repo awsgit:1.0 $@
}

