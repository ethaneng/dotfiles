# Launches a gum picker from sesh sessions and connects
function sesh-sessions() {
  {
    exec </dev/tty
    exec <&1
    local session
    session=$(sesh list -i | gum filter --limit 1 --no-sort --fuzzy --placeholder 'Pick a sesh' --height 50 --prompt='⚡')
    zle reset-prompt > /dev/null 2>&1 || true
    [[ -z "$session" ]] && return
    sesh connect $session
  }
}

function aws-profile() {
  # Check if gum is installed
  if ! command -v gum &> /dev/null; then
    echo "Error: 'gum' command not found. Please install Gum (https://github.com/charmbracelet/gum) to use the profile picker." >&2
    echo "Falling back to direct argument usage: aws-profile <profile_name>" >&2
    if [[ -z "$1" ]]; then
      echo "Usage: aws-profile <profile_name>"
      echo "Current AWS_PROFILE: ${AWS_PROFILE:-'not set'}"
      return 1
    fi
    local profile_name="$1"
  else
    # Check if aws-cli is installed
    if ! command -v aws &> /dev/null; then
      echo "Error: 'aws' command not found. Please install AWS CLI." >&2
      return 1
    fi

    # Get list of existing profiles using aws cli
    # This command lists profiles from both ~/.aws/config and ~/.aws/credentials
    local existing_profiles=$(aws configure list-profiles 2>/dev/null)
    
    if [[ -z "${existing_profiles}" ]]; then
      echo "Error: No AWS profiles found in ~/.aws/config or ~/.aws/credentials." >&2
      return 1
    fi

    local selected_profile
    selected_profile=$(echo "${existing_profiles}" | gum filter --prompt="Select AWS Profile: " --height=10)

    if [[ -z "${selected_profile}" ]]; then
      echo "No profile selected. AWS_PROFILE remains unchanged."
      return 0
    fi
    local profile_name="${selected_profile}"
  fi

  # Validate the selected/provided profile (only if using gum, or if argument was provided)
  if [[ -n "${profile_name}" ]]; then
    local check_profiles=$(aws configure list-profiles 2>/dev/null)
    if ! echo "${check_profiles}" | grep -q "^${profile_name}$"; then
      echo "Error: AWS profile '${profile_name}' does not exist. Available profiles:" >&2
      echo "${check_profiles}" | while IFS= read -r line; do echo "  - ${line}"; done >&2
      return 1
    fi
  fi

  export AWS_PROFILE="${profile_name}"
  echo "AWS_PROFILE set to '${AWS_PROFILE}'"
}

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}
