#!/bin/sh
set -eu

for arg in "$@"; do
    case "$arg" in
        --help|-h)
            printf '%s\n' 'usage: sh install.sh [--help]' \
                'install configs, helper scripts, themes, icons and wallpaper; existing files are overwritten without backups; no packages are installed.'
            exit 0 ;;
        *) printf 'unknown option: %s\n' "$arg" >&2; exit 1 ;;
    esac
done

: "${HOME:?home is not set}"
config_dir=${XDG_CONFIG_HOME:-"$HOME/.config"}
data_dir=${XDG_DATA_HOME:-"$HOME/.local/share"}
bin_dir="$HOME/.local/bin"
for path in "$HOME" "$config_dir" "$data_dir"; do
    case "$path" in
        /*) ;;
        *) printf 'expected an absolute path: %s\n' "$path" >&2; exit 1 ;;
    esac
done

repo_dir=
if [ -f "$0" ]; then
    candidate=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd -P)
    if [ -d "$candidate/config" ]; then repo_dir=$candidate; fi
fi

if [ -z "$repo_dir" ]; then
    for tool in curl tar mktemp; do
        command -v "$tool" >/dev/null 2>&1 || { printf '%s is required\n' "$tool" >&2; exit 1; }
    done
    work_dir=$(mktemp -d)
    trap 'rm -rf -- "$work_dir"' 0
    trap 'exit 1' HUP INT TERM
    printf 'downloading dotfiles...\n'
    curl -fsSL https://codeload.github.com/ritualchan/kanagawa-red-dark-dotfiles/tar.gz/refs/heads/main -o "$work_dir/dotfiles.tar.gz"
    mkdir "$work_dir/source"
    tar -xzf "$work_dir/dotfiles.tar.gz" -C "$work_dir/source" --strip-components=1
    repo_dir="$work_dir/source"
fi
[ -d "$repo_dir/config" ] || { printf 'config directory is missing\n' >&2; exit 1; }

# subshells keep function variables separate from callers in posix sh.
copy_file() (
    source=$1 target=$2 executable=${3:-false}
    if [ "$source" -ef "$target" ]; then
        printf 'skip same file: %s\n' "$target"
        return
    fi
    if [ -d "$target" ] && [ ! -L "$target" ]; then
        printf 'cannot replace a directory with a file: %s\n' "$target" >&2
        exit 1
    fi
    printf 'install: %s -> %s\n' "$source" "$target"
    mkdir -p -- "$(dirname -- "$target")"
    if [ -L "$target" ]; then unlink -- "$target"; fi
    cp -P -- "$source" "$target"
    if [ "$executable" = true ]; then chmod u+x -- "$target"; fi
)

copy_tree() (
    for source in "$1"/* "$1"/.[!.]* "$1"/..?*; do
        if [ -L "$source" ]; then
            copy_file "$source" "$2/${source##*/}"
        elif [ -d "$source" ]; then
            copy_tree "$source" "$2/${source##*/}"
        elif [ -f "$source" ]; then
            copy_file "$source" "$2/${source##*/}"
        fi
    done
)
copy_tree "$repo_dir/config" "$config_dir"

for collection in themes icons; do
    if [ -d "$repo_dir/$collection" ]; then
        copy_tree "$repo_dir/$collection" "$data_dir/$collection"
    fi
done

for name in .zshrc .zshenv; do
    if [ -s "$repo_dir/$name" ]; then
        if [ "$name" = .zshrc ] && [ ! -r "$HOME/.oh-my-zsh/oh-my-zsh.sh" ]; then
            printf 'warning: skipping .zshrc: install Oh My Zsh into %s/.oh-my-zsh and rerun the installer.\n' "$HOME" >&2
            continue
        fi
        copy_file "$repo_dir/$name" "$HOME/$name"
    fi
done

for source in "$repo_dir/bin/"* "$repo_dir/bin/".[!.]* "$repo_dir/bin/"..?*; do
    if [ -f "$source" ] && [ ! -L "$source" ] && [ -s "$source" ]; then
        copy_file "$source" "$bin_dir/${source##*/}" true
    fi
done

if [ -f "$repo_dir/assets/wallpaper.png" ]; then
    copy_file "$repo_dir/assets/wallpaper.png" "$HOME/Pictures/wallpaper.png"
fi

printf '\ndone. review the machine-specific settings in hypr/hyprland.lua before starting hyprland.\n'
