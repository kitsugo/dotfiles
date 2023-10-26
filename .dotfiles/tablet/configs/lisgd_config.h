/*
  distancethreshold: Minimum cutoff for a gestures to take effect
  degreesleniency: Offset degrees within which gesture is recognized (max=45)
  timeoutms: Maximum duration for a gesture to take place in miliseconds
  orientation: Number of 90 degree turns to shift gestures by
  verbose: 1=enabled, 0=disabled; helpful for debugging
  device: Path to the /dev/ filesystem device events should be read from
  gestures: Array of gestures; binds num of fingers / gesturetypes to commands
            Supported gestures: SwipeLR, SwipeRL, SwipeDU, SwipeUD,
                                SwipeDLUR, SwipeURDL, SwipeDRUL, SwipeULDR
*/
unsigned int distancethreshold = 125;
unsigned int distancethreshold_pressed = 60;
unsigned int degreesleniency = 15;
unsigned int timeoutms = 800;
unsigned int orientation = 0;
unsigned int verbose = 0;
double edgesizeleft = 50.0;
double edgesizetop = 50.0;
double edgesizeright = 50.0;
double edgesizebottom = 50.0;
// input_device: Use /dev/input/by-path/ to locate touchscreen device. Or rely on external script to pass device via -d flag
char *device = "";

Gesture gestures[] = {
	/* nfingers  gesturetype  command */
	{ 2,         SwipeRL,     EdgeAny, DistanceAny, ActModeReleased, "swaymsg workspace next" },
	{ 2,         SwipeLR,     EdgeAny, DistanceAny, ActModeReleased, "swaymsg workspace prev" },
	{ 3,         SwipeLR,     EdgeAny, DistanceAny, ActModeReleased, "move_window.sh 1" },
	{ 3,         SwipeRL,     EdgeAny, DistanceAny, ActModeReleased, "move_window.sh -1" },
	{ 3,         SwipeDU,     EdgeAny, DistanceAny, ActModeReleased, "tablet_util.sh toggle-keyboard" },
	{ 3,         SwipeUD,     EdgeAny, DistanceAny, ActModeReleased, "swaymsg bar mode toggle touch-bar" },
};
