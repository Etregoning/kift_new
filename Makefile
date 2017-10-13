# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: etregoni <marvin@42.fr>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2017/04/21 14:58:27 by etregoni          #+#    #+#              #
#    Updated: 2017/10/07 19:13:28 by etregoni         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME_C = client
NAME_S = server
CFLAGS = -Wall -Werror -Wextra -g
SPHX_FLAGS = -DMODELDIR=\"`pkg-config --variable=modeldir pocketsphinx`\"
SPHX_LIBS = `pkg-config --cflags --libs pocketsphinx sphinxbase`

SRC_S = server.c
SRC_C = client.c
# SRC_H - Helper functions that are used in both client and server
SRC_H = helpers.c

OBJ_FILES = $(SRC_FILES:.c=.o)

# H_DIR/OBJ_H = Same as above, for helper functions used in client and server
H_DIR = ./src/
CLNT_DIR = ./src/client/
SVR_DIR = ./src/server/
CMD_DIR = ./src/server/cmds/
OBJ_C = ./obj/client/
OBJ_S = ./obj/server/
OBJ_H = .obj/helpers/
INC_DIR = ./include/
LIBFT_DIR = ./libft/
SPHX_DIR = ./cmusphinx/

SRC = $(addprefix $(SRC_DIR), $(SRC_H))
CLNT = $(addprefix $(CLNT_DIR), $(SRC_C))
SVR = $(addprefix $(SVR_DIR), $(SRC_S))
OBJ = $(addprefix $(OBJ_DIR), $(OBJ_FILES))
LIBFT = $(addprefix $(LIBFT_DIR), libft.a)

LINK = -L $(LIBFT_DIR) -lft

all: obj $(LIBFT) $(MLX) $(NAME)

obj:
	@mkdir -p $(OBJ_C)
	@mkdir -p $(OBJ_S)
	@mkdir -p $(OBJ_H)

$(OBJ_C)%.o:$(SRC_C)%.c
	@gcc $(CFLAGS) $(SPHX_FLAGS) $(SPHX_LIBS) -I $(LIBFT_DIR) -I $(INC_DIR) \
		-o $@ -c $<

$(OBJ_S)%.o:$(SRC_S)%.c
	@gcc $(CFLAGS) $(SPHX_FLAGS) $(SPHX_LIBS) -I $(LIBFT_DIR) -I $(INC_DIR) \
		-o $@ -c $<

$(OBJ_H)%.o:$(SRC_H)%.c
	@gcc $(CFLAGS) $(SPHX_FLAGS) $(SPHX_LIBS) -I $(LIBFT_DIR) -I $(INC_DIR) \
		-o $@ -c $<

$(LIBFT):
	@echo "\033[32mCompiling libft...\033[0m"
	@make -C $(LIBFT_DIR)
	@echo "\033[1;4;32mlibft created.\033[0m"

$(NAME_C): $(OBJ_C) $(OBJ_H)
	@echo "\033[32mCompiling $(NAME_C)...\033[0m"
	@gcc $(OBJ_C) $(OBJ_H) $(LINK) -lm -o $(NAME_C)
	@echo "\033[1;4;32m$(NAME_C) Created.\033[0m"

$(NAME_S): $(OBJ_S) $(OBJ_H)
	@echo "\033[32mCompiling $(NAME_S)...\033[0m"
	@gcc $(OBJ) $(LINK) -lm -o $(NAME_S)
	@echo "\033[1;4;32m$(NAME_S) Created.\033[0m"

clean:
	@echo "\033[31mRemoving objects...\033[0m"
	@rm -rf $(OBJ_C)
	@rm -rf $(OBJ_S)
	@rm -rf $(OBJ_H)
	@make -C $(LIBFT_DIR) clean
	@echo "\033[1;4;31mAll Objects removed!\033[0m"

clean_clnt:
	@echo "\033[31mRemoving client objects...\033[0m"
	@rm -rf $(OBJ_C)
	@rm -rf $(OBJ_H)
	@make -C $(LIBFT_DIR) clean
	@echo "\033[1;4;31mClient Objects removed!\033[0m"

clean_svr:
	@echo "\033[31mRemoving server objects...\033[0m"
	@rm -rf $(OBJ_S)
	@rm -rf $(OBJ_H)
	@make -C $(LIBFT_DIR) clean
	@echo "\033[1;4;31mServer Objects removed!\033[0m"

fclean: clean
	@echo "\033[31mRemoving $(NAME_C)...\033[0m"
	@rm -f $(NAME_C)
	@echo "\033[1;4;31m$(NAME_C) removed!\033[0m"
	@echo "\033[31mRemoving $(NAME_S)...\033[0m"
	@rm -f $(NAME_S)
	@echo "\033[1;4;31m$(NAME_S) removed!\033[0m"
	@make -C $(LIBFT_DIR) fclean

re: fclean all

.PHONY: clean clean_clnt clean_svr fclean all re
