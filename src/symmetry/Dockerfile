FROM bashell/alpine-bash:latest
ENV SHELL=/bin/bash
ENV PATH="$HOME/bin:$PATH"
RUN \
	apk update && \
	apk add git jq curl rsync coreutils && \
	rm -rf /var/cache/*/* && \
	mkdir -p /tmp/symmetry && \
	git clone --recurse-submodules -j8 https://github.com/camalot/symmetry.git /tmp/symmetry
RUN \
	bash /tmp/symmetry/bootstrap.sh -f && \
	$HOME/bin/symmetry install && \
	rm -rf /tmp/symmetry

ENTRYPOINT [ "/bin/bash" ]


