#!/bin/bash

aws ecr get-login-password --region ap-northeast-1 --profile tatsukoni | docker login --username AWS --password-stdin 083636136646.dkr.ecr.ap-northeast-1.amazonaws.com

docker buildx build --platform=linux/amd64 -t atlantis-demo .

docker tag atlantis-demo:latest 083636136646.dkr.ecr.ap-northeast-1.amazonaws.com/atlantis-demo:latest

docker push 083636136646.dkr.ecr.ap-northeast-1.amazonaws.com/atlantis-demo:latest
