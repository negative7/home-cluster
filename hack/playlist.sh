#!/usr/bin/env bash

#
# DANCE
#

while true; do
    figlet -f slant "media" | /usr/games/lolcat
    kubecolor get po -n media; sleep 5; clear;
    figlet -f slant "home" | /usr/games/lolcat
    kubecolor get po -n home; sleep 5; clear;
    figlet -f slant "tools" | /usr/games/lolcat
    kubecolor get po -n tools; sleep 5; clear;
    figlet -f slant "openfaas-fn" | /usr/games/lolcat
    kubecolor get po -n openfaas-fn; sleep 5; clear;
    figlet -f slant "nodes" | /usr/games/lolcat
    kubecolor get nodes; sleep 5; clear;
done
