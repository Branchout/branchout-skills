#!/usr/bin/env bash
set -euo pipefail

exit_code=0

for file in .claude-plugin/plugin.json .cursor-plugin/plugin.json gemini-extension.json; do
  if [[ -f "${file}" ]]; then
    file_version=$(yq -r '.version' "${file}")
    if [[ "${file_version}" != "${VERSION}" ]]; then
      echo "Version mismatch: ${file} has '${file_version}' but calculated version is '${VERSION}'"
      exit_code=1
    else
      echo "Version verified: ${file} = ${file_version}"
    fi
  fi
done

if [[ ${exit_code} -ne 0 ]]; then
  echo "Version must match, please update it with each PR for the next version or the PR build will fail."
fi

exit ${exit_code}
