#!/bin/bash

builder_package="github.com/belak/base16-builder-go"
base16_dir="${HOME}/.base16"
theme="heetch"

install_builder() {
  if [ ! -f "${GOPATH}/bin/base16-builder-go" ]; then
    go get "${builder_package}"
    go build "${builder_package}"
  fi
}

run_builder() {
  mkdir -p "${base16_dir}"
  cd "${base16_dir}"

  if [[ ! -d "sources" ]]; then
    base16-builder-go update
  fi
  base16-builder-go build --ignore-errors
}

configure_bash() {
  theme_script="${base16_dir}/templates/shell/scripts/base16-heetch.sh"
  if ! grep -Fxq "${theme_script}" "${HOME}/.extra"; then
    echo ". ${theme_script}" >> "${HOME}/.extra"
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