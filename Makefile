include .variables.mk

export AWS_PROFILE

.PHONY: build test all deploy_pipeline

all: test

build:
	go get ./...
	go build

test:
	go get -t ./...
	go test

deploy_pipeline:
	aws cloudformation update-stack --stack-name lambda1-pipeline --template-body "$$(cat pipeline.yaml)" \
	                   --capabilities CAPABILITY_IAM --parameters \
	                     "ParameterKey=GithubToken,ParameterValue=$PIPELINE_GITHUB_TOKEN"
