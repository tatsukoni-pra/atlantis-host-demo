FROM ghcr.io/runatlantis/atlantis:latest

COPY --chown=atlantis:atlantis repos.yaml /etc/atlantis/repos.yaml
COPY --chown=atlantis:atlantis config.yaml /etc/atlantis/config.yaml

USER atlantis
ENTRYPOINT ["/usr/bin/dumb-init", "atlantis", "server", "--config", "/etc/atlantis/config.yaml"]
