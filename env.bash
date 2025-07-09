script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
PLATFORM_ARCH=$($script_dir/bin-nitrile/nitrile-target)
# note: bin-nitrile must be in the PATH earlier to prefer bin-nitrile/cleanide
#       over bin-nitrile/prj/windows-x64/CleanIDE.exe on windows
export PATH="$script_dir/bin-nitrile:$script_dir/bin-nitrile/prj/$PLATFORM_ARCH:$PATH"
