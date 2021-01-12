#!/usr/bin/env bash
source assets/yaml
create_variables "config.yaml"

if ! command -v ${shell} &>/dev/null
then
	echo "No shell found!"
	exit 1
fi

# 42
if [ "${_42_active}" = "true" ]
then
	USER=${_42_user}
	MAIL=${_42_email}
	export USER # parent shell
	export MAIL # parent shell
	if [ "${_42_recovery}" = "true" ]
	then
		${shell} ./assets/42recovery.sh
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
		if ! cat ~/.${shell}rc | grep -a "source <(kubectl completion ${shell})" &> /dev/null
		then
			echo "source <(kubectl completion ${shell})
complete -F __start_kubectl k" >> ~/.${shell}rc
			tput setaf 32
			echo "[+] Kubernetes ${shell} autocompletion set."
			tput init
		fi
	fi
	if [ "${kubernetes_alias}" = "true" ] && ! cat ~/.${shell}rc | grep -a "[ -f ~/.kubectl_aliases ] && source ~/.kubectl_aliases" &> /dev/null
	then
		wget https://raw.githubusercontent.com/ahmetb/kubectl-alias/master/.kubectl_aliases -O ~/.kubectl_aliases
		echo '[ -f ~/.kubectl_aliases ] && source ~/.kubectl_aliases' >> ~/.${shell}rc
		tput setaf 32
		echo "[+] Kubectl aliases and their autocompletion set."
		tput init
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

# Zsh_powerlevel10k
if [ "${zsh_powerlevel10k_active}" = "true" ] && command -v zsh &>/dev/null && command -v git &>/dev/null
then
	if ! [ -e ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k ]
	then
		git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
		echo 'ZSH_THEME="powerlevel10k/powerlevel10k"' >> ~/.zshrc
	fi
	tput setaf 32
	echo "[+] Zsh config ~/.zshrc set."
	tput init
fi
