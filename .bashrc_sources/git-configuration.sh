#!/bin/bash

function grug {
    remote=${1:-origin}
    branch=${2:-`git name-rev --name-only HEAD`}
    remote_url=$(git remote -v | grep $remote | grep fetch | cut -f2 | ack -o '^[^ ]+')
    echo "resetting to $remote_url at $branch"
    git fetch $remote && git reset --hard $remote/$branch
}

function glorm {
    MASTER=${1:-master}
    TOPIC=${2:-HEAD}
    shift 2
    git log --oneline --reverse $MASTER..$TOPIC $@
}
alias glorom='glorm origin/master'

function grieve {
    MASTER=${1:-master}
    TOPIC=${2:-HEAD}
    shift 2
    git log -p --reverse --stat --no-prefix $MASTER..$TOPIC $@
}
alias grieveom='grieve origin/master'

alias gap &>/dev/null && unalias gap #this may've came in from scm_breeze but I want my own
function gap {
    path=${1:-.}
    shift 1
    git add -p `git_expand_args $path $@`
}

function gcot {
    ticket=$1
    if [ $ticket ]; then
      branch=`git branch | sed s/.// | ack $ticket`
      if [ $branch ]; then
        git checkout $branch
      else
        echo "no branch found for $ticket"
        return 2
      fi
    else
      echo "You need to give me a ticket"
      return 1
    fi
}

function gt {
    ticket=$1
    if [ $ticket ]; then
        branch=`git branch | sed s/.// | ack $ticket`
        if [ $branch ]; then
            echo $branch
        else
            echo "no branch found for $ticket" >&2
            return 2
        fi
    else
        echo "You need to give me a ticket" >&2
        return 1
    fi
}

function glone {
    repo=$1
    local_name=${2}
    if [ ! $local_name ]; then
        local_name=`echo $repo | perl -pe 's{.*?([^/]*)/?$}{$1}'`
    fi
    if [ $repo ]; then
        git clone $repo
        cd $local_name
    else
        echo "You need to give me a repo"
        return 1
    fi
}

alias cb="git symbolic-ref HEAD 2>/dev/null | sed 's|refs/heads/||'"
