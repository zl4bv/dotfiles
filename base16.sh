#!/bin/bash

builder_package="github.com/belak/base16-builder-go"
base16_dir="${HOME}/.base16"
theme="heetch"

builder_bin="${GOPATH}/bin/base16-builder-go"

install_builder() {
  if ! command -v go >/dev/null; then
    echo "go is not installed; cannot build builder"
    exit 1
  fi

  if [ ! -f "${builder_bin}" ]; then
    go get "${builder_package}"
    go build -o "${builder_bin}" "${builder_package}"
  fi
}

run_builder() {
  if [ ! -f "${builder_bin}" ]; then
    echo "base16-builder-go is not installed; cannot build base16 themes"
    exit 1
  fi

  mkdir -p "${base16_dir}"
  cd "${base16_dir}" || exit 1

  if [[ ! -d "sources" ]]; then
    base16-builder-go update
  fi
  base16-builder-go build --ignore-errors
}

configure_bash() {
  theme_script="${base16_dir}/templates/shell/scripts/base16-${theme}.sh"
  if ! grep -q "${theme_script}" "${HOME}/.extra"; then
    cat <<EOF >> "${HOME}/.extra"
if [[ -f ${theme_script} ]]; then
  . ${theme_script}
fi
EOF
  fi
}

configure_vim() {
  colors_dir="${HOME}/.vim/colors"
  if [[ ! -h "${colors_dir}" ]]; then
    ln -s "${base16_dir}/templates/vim/colors" "${colors_dir}"
  fi
}

configure_vscode() {
  # Hack: replace themes in base16-generator extension
  ext_dir="${HOME}/.vscode/extensions/golf1052.base16-generator-1.8.0/themes"
  if [[ -d "${ext_dir}" ]]; then
    rm -rf "${ext_dir}"
    ln -s "${base16_dir}/templates/vscode/themes" "${ext_dir}"
  fi
}

install_builder
run_builder
configure_bash
configure_vim
configure_vscode
