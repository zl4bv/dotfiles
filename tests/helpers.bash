export CURDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd)"
export DOTFILESDIR="$( cd "${CURDIR}/.." > /dev/null 2>&1 && pwd )"
export OLDHOME="${HOME}"

setup() {
  TESTWORKDIR="$(mktemp -d)"
  HOME="${TESTWORKDIR}"
  export HOME
}

teardown() {
  rm -rf "${TESTWORKDIR}"
  HOME="${OLDHOME}"
  export HOME
}
