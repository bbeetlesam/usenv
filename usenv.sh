export ENV_DIR="$ENV"

usenv() {
  local VERSION="v0.0.0" # what version? who knows.
  local HELPMSG="Deadass simple environment variable set loader and manager.\n$VERSION
    \nUsage:
    usenv <command> <args>\n\nCommands:
    set          Load environment variables from an .env file into the current shell
    unset        Remove environment variables previously loaded from an .env file
    list         List all available .env files in the configured path
    path         Set or display the path of the .env directory. Default to \$ENV
    help         Show this very informational message\n\nExamples:
    usenv set db
    usenv unset db
    usenv path \"\$HOME/.env\""

  if [ -z "$1" ]; then
    print $HELPMSG
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
    print $HELPMSG | sed '/^ /s/^  //'
  else
    echo "$0: Unknown command."
    return 1
  fi
}
