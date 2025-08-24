REGISTRY ?= docker.io
REGUSER ?= ppenguin

.PHONY: %
%: %/Dockerfile %/tags
	buildah bud -t "$(REGISTRY)/$(REGUSER)/$@:$$(<$(word 2,$^))" -f "$<" "$(<D)"

.PHONY: push-%:
push-%:
	buildah login -u "$(REGUSER)" -p "$(DOCKERHUBTOKEN)" "$(REGISTRY)"
	buildah push "$(REGISTRY)/$(REGUSER)/$*:$$(<$*/tags)"

