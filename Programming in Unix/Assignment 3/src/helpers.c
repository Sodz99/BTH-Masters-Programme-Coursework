#include <ncurses.h>
#include <stdlib.h>
#include <time.h>
#include <unistd.h>
#include "helpers.h"

int board_get_key(void)
{
    int key = getch();
    return key;
}

void board_put_char(int x, int y, int ch)
{
    mvprintw(x, y, "%c", ch);
    refresh();
}

void board_put_str(int x, int y, const char *str)
{
    mvprintw(x, y, "%s", str);
    refresh();
}

void board_init(void)
{
    initscr(); // Initialize ncurses
    cbreak();
    start_color();         // Enable color support
    curs_set(0);           // Make cursor invisible
    noecho();              // Don't echo user input
    keypad(stdscr, TRUE);  // Enable special keys (arrows)
    nodelay(stdscr, TRUE); // Non-blocking input mode
    srand(time(0));        // Initialize random number generator
}

void game_exit(void)
{
    endwin(); // Clean up ncurses
    exit(0);
}
