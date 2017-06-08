(
  cd -- "$(dirname "$BASH_SOURCE")"
  while true; do sleep 5; ./deploy.sh; done
)
