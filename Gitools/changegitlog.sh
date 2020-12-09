# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    sh.sh                                              :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: abarthel <abarthel@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2019/06/17 16:14:36 by abarthel          #+#    #+#              #
#    Updated: 2019/06/17 16:31:52 by abarthel         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!/bin/sh

git filter-branch -f --env-filter '
OLD_NAME="Antoine BARTHELEMY"
CORRECT_NAME="Ant0wan"
CORRECT_EMAIL="abarthel@student.42.fr"
if [ "$GIT_COMMITTER_NAME" = "$OLD_NAME" ]
then
	export GIT_COMMITTER_NAME="$CORRECT_NAME"
	export GIT_COMMITTER_EMAIL="$CORRECT_EMAIL"
fi
if [ "$GIT_AUTHOR_NAME" = "$OLD_NAME" ]
then
	export GIT_AUTHOR_NAME="$CORRECT_NAME"
	export GIT_AUTHOR_EMAIL="$CORRECT_EMAIL"
fi
' --tag-name-filter cat -- --branches --tags
