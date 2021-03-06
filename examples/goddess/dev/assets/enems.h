// MTE MK1 (la Churrera) v5.0
// Copyleft 2010-2014, 2020 by the Mojon Twins

// Generated by ene2h.exe from ..\enems\enems.ene
// Copyleft 2010, 2017 by The Mojon Twins

typedef struct {
	unsigned char x, y;
	unsigned char x1, y1, x2, y2;
	char mx, my;
	char t;
#ifdef PLAYER_CAN_FIRE
	unsigned char life;
#endif
} MALOTE;

MALOTE malotes [] = {
	// Pantalla 0
 	{0, 0, 0, 0, 0, 0, 0, 0, 0},
 	{0, 0, 0, 0, 0, 0, 0, 0, 0},
 	{0, 0, 0, 0, 0, 0, 0, 0, 0},

	// Pantalla 1
 	{192, 128, 192, 128, 32, 128, -2, 0, 4},
 	{0, 0, 0, 0, 0, 0, 0, 0, 0},
 	{0, 0, 0, 0, 0, 0, 0, 0, 0},

	// Pantalla 2
 	{208, 128, 208, 128, 208, 112, 0, -1, 6},
 	{0, 0, 0, 0, 0, 0, 0, 0, 0},
 	{0, 0, 0, 0, 0, 0, 0, 0, 0},

	// Pantalla 3
 	{128, 16, 128, 16, 128, 32, 0, 0, 6},
 	{0, 0, 0, 0, 0, 0, 0, 0, 0},
 	{0, 0, 0, 0, 0, 0, 0, 0, 0},

	// Pantalla 4
 	{176, 96, 176, 96, 176, 80, 0, -1, 6},
 	{0, 0, 0, 0, 0, 0, 0, 0, 0},
 	{0, 0, 0, 0, 0, 0, 0, 0, 0},

	// Pantalla 5
 	{144, 16, 144, 16, 144, 80, 0, 1, 2},
 	{96, 32, 96, 32, 96, 80, 0, 1, 2},
 	{0, 0, 0, 0, 0, 0, 0, 0, 0},

	// Pantalla 6
 	{16, 112, 16, 112, 208, 112, 2, 0, 4},
 	{80, 16, 80, 16, 80, 0, 0, 0, 6},
 	{0, 0, 0, 0, 0, 0, 0, 0, 0},

	// Pantalla 7
 	{0, 0, 0, 0, 0, 0, 0, 0, 0},
 	{0, 0, 0, 0, 0, 0, 0, 0, 0},
 	{0, 0, 0, 0, 0, 0, 0, 0, 0},

	// Pantalla 8
 	{176, 32, 176, 32, 176, 16, 0, 0, 6},
 	{160, 96, 160, 96, 160, 80, 0, 0, 6},
 	{0, 0, 0, 0, 0, 0, 0, 0, 0},

	// Pantalla 9
 	{96, 80, 96, 80, 96, 64, 0, 0, 6},
 	{176, 16, 176, 16, 176, 112, 0, 1, 2},
 	{0, 0, 0, 0, 0, 0, 0, 0, 0},

	// Pantalla 10
 	{32, 80, 32, 80, 32, 128, 0, 1, 2},
 	{208, 48, 208, 48, 208, 128, 0, 2, 2},
 	{0, 0, 0, 0, 0, 0, 0, 0, 0},

	// Pantalla 11
 	{176, 48, 176, 48, 112, 48, -2, 0, 1},
 	{0, 0, 0, 0, 0, 0, 0, 0, 0},
 	{0, 0, 0, 0, 0, 0, 0, 0, 0},

	// Pantalla 12
 	{64, 128, 64, 128, 64, 64, 0, -1, 4},
 	{80, 48, 80, 48, 144, 48, 2, 0, 2},
 	{16, 112, 16, 112, 208, 128, 1, 1, 3},

	// Pantalla 13
 	{16, 16, 16, 16, 16, 112, 0, 2, 4},
 	{192, 16, 192, 16, 176, 16, 0, 0, 6},
 	{0, 0, 0, 0, 0, 0, 0, 0, 0},

	// Pantalla 14
 	{96, 32, 96, 32, 192, 64, 2, 2, 3},
 	{80, 32, 80, 32, 80, 128, 0, 1, 2},
 	{32, 16, 32, 16, 32, 112, 0, 2, 2},

	// Pantalla 15
 	{48, 48, 48, 48, 48, 96, 0, 1, 2},
 	{128, 96, 128, 96, 128, 48, 0, -1, 2},
 	{0, 0, 0, 0, 0, 0, 0, 0, 0},

	// Pantalla 16
 	{192, 80, 192, 80, 160, 80, -1, 0, 1},
 	{32, 32, 32, 32, 32, 80, 0, 1, 2},
 	{208, 48, 208, 48, 208, 32, 0, 0, 2},

	// Pantalla 17
 	{208, 128, 208, 128, 80, 128, -1, 0, 1},
 	{144, 48, 144, 48, 128, 48, 0, 0, 6},
 	{0, 0, 0, 0, 0, 0, 0, 0, 0},

	// Pantalla 18
 	{208, 128, 208, 128, 144, 128, -1, 0, 1},
 	{48, 128, 48, 128, 16, 128, -1, 0, 2},
 	{16, 80, 16, 80, 208, 96, 1, 1, 3},

	// Pantalla 19
 	{16, 128, 16, 128, 112, 128, 2, 0, 1},
 	{128, 128, 128, 128, 192, 128, 1, 0, 1},
 	{96, 48, 96, 48, 96, 32, 0, 0, 6},

	// Pantalla 20
 	{80, 16, 80, 16, 80, 48, 0, 1, 2},
 	{32, 48, 32, 48, 48, 128, 2, 2, 3},
 	{208, 128, 208, 128, 144, 128, -1, 0, 1},

	// Pantalla 21
 	{48, 48, 48, 48, 64, 48, 0, 0, 6},
 	{192, 64, 192, 64, 208, 64, 0, 0, 6},
 	{16, 16, 16, 16, 16, 128, 0, 4, 2},

	// Pantalla 22
 	{16, 48, 16, 48, 80, 80, 1, 1, 3},
 	{112, 48, 112, 48, 112, 128, 0, 1, 2},
 	{0, 0, 0, 0, 0, 0, 0, 0, 0},

	// Pantalla 23
 	{144, 48, 144, 48, 160, 48, 0, 0, 6},
 	{80, 16, 80, 16, 96, 16, 0, 0, 6},
 	{0, 0, 0, 0, 0, 0, 0, 0, 0}

};

#define N_ENEMS_TYPE_0 26
#define N_ENEMS_TYPE_1 7
#define N_ENEMS_TYPE_2 16
#define N_ENEMS_TYPE_3 5
#define N_ENEMS_TYPE_5 0
#define N_ENEMS_TYPE_6 14
#define N_ENEMS_TYPE_7 0

// This is output the way it worked originally, please modify if you need
// You may want to add type 5 or 6's below.
#define BADDIES_COUNT (N_ENEMS_TYPE_1+N_ENEMS_TYPE_2+N_ENEMS_TYPE_3)

typedef struct {
	unsigned char xy, tipo, act;
} HOTSPOT;

HOTSPOT hotspots [] = {
	{37, 8, 0}, 
	{0, 0, 0}, 
	{118, 7, 0}, 
	{0, 0, 0}, 
	{0, 0, 0}, 
	{102, 5, 0}, 
	{0, 0, 0}, 
	{164, 4, 0}, 
	{0, 0, 0}, 
	{0, 0, 0}, 
	{0, 0, 0}, 
	{199, 3, 0}, 
	{116, 4, 0}, 
	{0, 0, 0}, 
	{0, 0, 0}, 
	{182, 3, 0}, 
	{0, 0, 0}, 
	{0, 0, 0}, 
	{103, 4, 0}, 
	{0, 0, 0}, 
	{0, 0, 0}, 
	{0, 0, 0}, 
	{71, 4, 0}, 
	{199, 6, 0}
};

#define N_HOTSPOTS_TYPE_0 14
#define N_HOTSPOTS_TYPE_1 0
#define N_HOTSPOTS_TYPE_2 0
#define N_HOTSPOTS_TYPE_3 2
#define N_HOTSPOTS_TYPE_4 4
#define N_HOTSPOTS_TYPE_5 1
#define N_HOTSPOTS_TYPE_6 1
#define N_HOTSPOTS_TYPE_7 1
#define N_HOTSPOTS_TYPE_8 1

