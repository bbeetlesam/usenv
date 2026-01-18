export ENV_DIR="$ENV"

usenv() {
  if [ -z "$1" ]; then
    echo "$0: Missing command."
    return 1
  elif [ "$1" = "set" ]; then
    if [ -z "$2" ]; then
      echo "$0: Missing the .env file argument."
      return 1
    else
      local envfile="$ENV_DIR/$2.env"
      if [ -f "$envfile" ]; then 
        source "$envfile"
        echo "Loaded environment: $envfile"
        return 0
      else
        echo "$0: File '$2.env' not found in '$ENV_DIR'."
        return 1
      fi
    fi
  elif [ "$1" = "unset" ]; then
    echo "unset env file"
  elif [ "$1" = "path" ]; then
    echo "set the path"
  elif [ "$1" = "list" ]; then
    find "$ENV_DIR" -maxdepth 1 -type f -name "*.env"
  elif [ "$1" = "help" ]; then
    echo "by the beatles"
  else
    echo "$0: Unknown command."
    return 1
  fi
}
