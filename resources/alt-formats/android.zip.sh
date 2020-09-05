#!/bin/sh

# Author:     Héctor Molinero Fernández <hector@molinero.dev>
# Repository: https://github.com/hectorm/hblock
# License:    MIT, https://opensource.org/licenses/MIT

set -eu
export LC_ALL=C

main() {
	hosts="${1:-/etc/hosts}";
	#hblock="${2:-hblock}"
	resourcesDir="${3:-./resources}"

	zip=$(printf -- '%s\n' "${TMPDIR:-/tmp}"/hblock.$$)
	trap 'rm -f ${zip:?}; trap - EXIT; exit 0' EXIT TERM INT HUP

	(cd "${resourcesDir:?}"/alt-formats/android/ && zip -qr "${zip:?}" ./)
	(cd "$(dirname "${hosts:?}")" && zip -q "${zip:?}" "$(basename "${hosts:?}")")
	cat "${zip:?}"
}

main "$@"
