#!/bin/sh

eval $(ssh-agent)
ssh-add
perl /clone_github_orga.pl $*
