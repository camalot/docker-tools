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

	echo "Loading configuration for ${repo}";
	source ./${repo}/repo.config
	l_repo=$(basename $repo);

	l_GITHUB_BRANCH=${GITHUB_BRANCH:-"master"}
	[[ -z "${l_GITHUB_BRANCH// }" ]] && echo "Environment variable 'l_GITHUB_BRANCH' missing or empty." && exit 2;
	[[ -z "${DOCKER_PROJECT_REPOS// }" ]] && echo "Environment variable 'DOCKER_PROJECT_REPOS' missing or empty." && exit 2;
	[[ -z "${GITHUB_REPO// }" ]] && echo "Environment variable 'GITHUB_REPO' missing or empty." && exit 2;
	[[ -z "${GITHUB_USER// }" ]] && echo "Environment variable 'GITHUB_USER' missing or empty." && exit 2;

	for p in ${DOCKER_PROJECT_REPOS[@]}; do
		l_KEY=$(echo $p | sed -r 's|-+|_|g' | awk '{print toupper($0)}');
		t_envvol="${l_KEY}_VOLUMES";
		l_VOLUME=${!t_envvol};
		echo "lvolume: $l_VOLUME"
		echo "Retrieve project dockerfile: ${p}";
		curl -X GET https://github.com/${GITHUB_USER}/${GITHUB_REPO}/raw/${l_GITHUB_BRANCH}/${p}/Dockerfile --output "./.${p}-Dockerfile" --silent
		echo "Build dockerfile: ${p}";
		docker build -t ${p}:local -f "./.${p}-Dockerfile" .
		rm "./.${p}-Dockerfile";

		mkdir -p ../../bin;
		echo "Write shim file for ${p}";
		cat >../../bin/${p} <<EOL
	#!/usr/bin/env bash

	docker run --rm -v "\$(pwd)":/work $l_VOLUME -w="/work" -i -t ${p}:local $@
EOL
		echo "Set execute on shim ${p}";
		chmod +x ../../bin/${p};
	done
	unset l_GITHUB_BRANCH;
	unset GITHUB_BRANCH;
	unset GITHUB_REPO;
	unset GITHUB_USER;
	unset DOCKER_PROJECT_REPOS
	unset l_repo
	unset l_KEY
	unset l_VOLUME
done
