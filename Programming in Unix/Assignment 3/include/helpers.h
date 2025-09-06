#ifndef HELPERS_H
#define HELPERS_H

void board_init(void);
int board_get_key(void);
void board_put_char(int x, int y, int ch);
void board_put_str(int x, int y, const char *str);
void game_exit(void);

#endif
