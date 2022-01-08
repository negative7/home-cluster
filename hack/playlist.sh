#!/usr/bin/env bash

#
# DANCE
#

while true; do
    figlet -f slant "media" | /usr/games/lolcat
    kubecolor get po -n media; sleep 5; clear;
    figlet -f slant "home" | /usr/games/lolcat
    kubecolor get po -n home; sleep 5; clear;
    figlet -f slant "nodes" | /usr/games/lolcat
    kubecolor get nodes; sleep 5; clear;
    figlet -f slant "media releases" | /usr/games/lolcat
    kubecolor get helmreleases -n media; sleep 5; clear;
    figlet -f slant "home" | /usr/games/lolcat
    kubecolor get helmreleases -n home; sleep 5; clear;
    figlet -f slant "kustomizations" | /usr/games/lolcat
    kubecolor get kustomizations -A; sleep 5; clear;
done
– Arrival Letter
