# Bennett's Godot 2D Project Boilerplate

This is a small starter-project for 2d games in godot with some basic common features.

## Features

    - Generic folder structure (probably change this for your game)
    - Main scene:
      - Persistent state manager: just pauses/restarts/quits, add more to this
      - World node: Intended for actual game content, and is pausable.
        - Write level loading/unloading code in the state manager or other top-level node rather than calling `get_tree().change_scene...` type functions, just reference the World node and load scenes into it.
      - Main menu:
        - Basic start/quit/settings buttons
        - Settings menu which has volume sliders for master/music/sfx
    - Autoloads:
      - Event bus boilerplate (empty, but use globally important signals here)
      - globals boilerplate (empty, put enums and constants here)
      - sfx manager: exposes basic SFX.play() function for basic sounds that don't to exist in 2d space
    - Debug overlay:
      - Autoloaded scene which toggles on F3
      - Displays a dictionary that you can write to from anywhere
      - use Debug.display(key, value)
    - Basic audio bus (master/music/sfx)
    - Example components (Classes I made for common things):
      - Health
      - Hitbox
      - Hurtbox
      