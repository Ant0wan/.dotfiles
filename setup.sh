#!/usr/bin/env bash
source assets/yaml
create_variables "config.yaml"

# 42
if [ "${_42_active}" = "true" ]
then
	USER=${_42_user}
	MAIL=${_42_email}
	export USER # parent shell
	export MAIL # parent shell
	if [ "${_42_recovery}" = "true" ]
	then
		bash ./assets/42recovery.sh
	fi
	tput setaf 32
	echo "[+] 42 credentials set."
	tput init
fi

# Git
if [ "${git_active}" = "true" ] && command -v git &>/dev/null
then
	git config --global user.name "${git_name}"
	git config --global user.email "${git_email}"
	git config credential.helper store
	tput setaf 32
	echo "[+] Git credentials set."
	tput init
fi

# Kubernetes
if [ "${kubernetes_active}" = "true" ] && command -v kubectl &>/dev/null
then
	if [ "${kubernetes_autocompletion}" = "true" ]
	then
		if ! cat ~/.bashrc | grep -a "source <(kubectl completion bash)" &> /dev/null
		then
			source <(kubectl completion bash) # should be export to the parent shell
			echo "source <(kubectl completion bash)" >> ~/.bashrc
			tput setaf 32
			echo "[+] Kubernetes bash autocompletion set."
			tput init
		fi
	fi
	if [ -n "${kubernetes_alias}" ]
	then
		tput setaf 32
		echo "[+] Kubectl 'k' alias and its autocompletion set."
		tput init
		alias k=kubectl # parent shell ?
		complete -F __start_kubectl k # parent shell ?
	fi
fi

# Vim
if [ "${vim_active}" = "true" ] && command -v vim &>/dev/null
then
	if [ "${vim_replace}" = "true" ] || ! [ -e ~/.vimrc ]
	then
		cp -f ./assets/vimrc ~/.vimrc
	else
		cat ./assets/vimrc | while read -r line
		do
    			if [ -n "$line" ]
    			then
    				if ! cat ~/.vimrc | grep -qxF "$line" &>/dev/null
				then
					echo "$line" >> ~/.vimrc
					((++APPEND))
				fi
    			fi
		done
		if ((APPEND > 0))
		then
			tput setaf 32
			echo "[+] Append missing vimrc config line to ~/.vimrc"
			tput init
		fi
	fi
	tput setaf 32
	echo "[+] Vim config ~/.vimrc set."
	tput init
fi
