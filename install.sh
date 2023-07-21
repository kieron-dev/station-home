#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

main() {
  configure_home "$@"
  generate_gitconfig
  #compile_authorized_keys
  #cleanup_old_vim_plug
  #compile_gpg_keys
}

generate_gitconfig() {
  if [[ -f "$HOME/.gitconfig" ]]; then
    return
  fi

  cat <<EOF >"$HOME/.gitconfig"
[include]
  path = ~/.common-gitconfig
[user]
  name = "Anonymous Eirininaut"
  email = "eirini@cloudfoundry.org"
[duet "env"]
  git-author-initials = ae
  git-author-name = Anonymous Eirininaut
  git-author-email = eirini@cloudfoundry.org
EOF
}

compile_authorized_keys() {
  local authorized_keys keys_json
  authorized_keys="$(mktemp)"

  mkdir -p "$HOME/.ssh"

  for gh_name in $(awk '{ if (usernames==1) print $2 }; /^usernames:/ { usernames=1 }' "$HOME/.git-authors"); do
    keys_json=$(curl -sL "https://api.github.com/users/$gh_name/keys")
    if [[ "$keys_json" =~ "rate limit exceeded" ]]; then
      echo "+-------------------------------------------------------------------------+"
      echo "| ⚠️  WARNING:                                                             |"
      echo "+-------------------------------------------------------------------------+"
      echo "| Looks like we have exceeded the github rate limit. Skipping generation  |"
      echo "| of authorized_keys file. You will have to manually add authorized keys! |"
      echo "+-------------------------------------------------------------------------+"
      return
    fi
    jq -r ".[].key" <<<"$keys_json" |
      xargs -I{} echo {} "$gh_name" >>"$authorized_keys"
  done

  mv "$authorized_keys" "$HOME/.ssh/authorized_keys"
}

compile_gpg_keys() {
  pushd "${HOME}/workspace/eirini-private-config/pass/eirini" >/dev/null || exit 1
  {
    cat .gpg-id | while read email; do
      if gpg --list-keys "$email" >/dev/null; then
        continue
      fi

      echo -e "1\n" | gpg --no-tty --command-fd 0 --keyserver keys.openpgp.org --search-keys $email
      echo -e "trust\n5\ny\nsave\n" | gpg --no-tty --command-fd 0 --edit-key $email
    done
  }
  popd >/dev/null || exit 1
}

configure_home() {
  local bundles action
  bundles=(tmux zsh git-hooks git util cows)
  action=${1:-"install"}

  mkdir -p "$HOME/.config"
  install_bundles "$HOME" "${bundles[@]}"
  install_bundles "$HOME/.config" "nvim"
}

cleanup_old_vim_plug() {
  rm -f "$HOME/.local/share/nvim/site/autoload/plug.vim"
}

install_bundles() {
  local target=$1
  shift

  stow --dotfiles --dir="$SCRIPT_DIR" --target "$target" --delete "$@"
  if [[ "$action" == "clean" ]]; then
    exit 0
  fi
  stow --dotfiles --dir="$SCRIPT_DIR" --target "$target" "$@"
}

main "$@"
