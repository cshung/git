#!/bin/bash
docker rmi localhost:46709/bookworm-git-patched 2>/dev/null
docker image prune -f
