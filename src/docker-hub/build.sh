#!/usr/bin/env bash
echo "Remove previous shims-out folder";

for repo in ./*; do
	if [ ! -d "$repo" ]; then
		continue;
	fi
	if [ ! -f ./${repo}/repo.config ]; then
		echo "No configuration file. Skipping";
		continue;
	fi
	l_repo=$(basename $repo);
	echo "Loading configuration for ${l_repo}";
	source ./${repo}/repo.config
	l_SHIM_NAME=${SHIM_NAME:-"${l_repo}"};
	[[ -z "${DOCKER_IMAGE// }" ]] && echo "Environment variable 'DOCKER_IMAGE' missing or empty." && exit 2;
	[[ -z "${DOCKER_TAG// }" ]] && echo "Environment variable 'DOCKER_TAG' missing or empty." && exit 2;

	mkdir -p ../../bin;
	echo "Write shim file for ${l_repo}";
	cat >../../bin/${l_SHIM_NAME} <<EOL
	#!/usr/bin/env bash

	docker run --rm -v "\$(pwd)":/work -w="/work" -i -t ${l_repo}:${DOCKER_TAG} $@
EOL
		echo "Set execute on shim ${l_SHIM_NAME}";
		chmod +x ../../bin/${l_SHIM_NAME};
	unset DOCKER_IMAGE;
	unset DOCKER_TAG;
	unset l_SHIM_NAME;
	unset l_repo;
done
