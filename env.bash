script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
export PATH="$script_dir/bin-nitrile:$PATH"
PLATFORM_ARCH=$(nitrile-target)
export PATH="$script_dir/bin-nitrile/prj/$PLATFORM_ARCH:$PATH"
