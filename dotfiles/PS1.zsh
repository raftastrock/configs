#!/bin/zsh
# Author Drew Brokke
# Modified by Ryan Garant

# PS1 Stuff

## Reference: %F{color}text%f
prompt_color_purple="%F{183}"
prompt_color_blue="%F{123}"
prompt_color_end="%f"
prompt_color_white="%F{015}"
prompt_color_green="%F{119}"
prompt_color_red="%F{204}"
prompt_color_yellow="%F{011}"
prompt_bold_start="%B"
prompt_bold_stop="%b"

p_start="%B${prompt_color_green}✝ %b "
p_path="%B${prompt_color_purple}%4~${prompt_bold_stop}%b"
p_prompt="%B${prompt_color_green} =>%b"
p_redpipe="${prompt_color_red}|"

function isgit() {
	git rev-parse --is-inside-work-tree &>/dev/null || return 1
}

function git_branch () {
	echo "%B${prompt_color_blue}$(git rev-parse --abbrev-ref HEAD 2>/dev/null)%b"
}

function git_dirty () {
	git diff --quiet && git diff-index --cached --quiet HEAD -- && return

	echo "%B${prompt_color_yellow}*%b"
}

function git_prompt() {
	isgit || return 1

	echo "${prompt_color_white}($(git_branch)$(git_dirty)${prompt_color_white})"
}

export PS1=' ${p_start}${p_path}${p_redpipe}$(git_prompt)${p_prompt}${prompt_color_end} '
