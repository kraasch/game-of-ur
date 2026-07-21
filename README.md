
# Royal Game of Ur

info:

  - github: https://github.com/kraasch/game-of-ur
  - itch.io: https://kraasch.itch.io/ur

version:

  - godot version 4.6
  - gdunit4 version 6.1.3

demo:

<table>
  <tr>
    <td><img src="./demo/image_7.png" width="400"></td>
    <td><img src="./demo/image_2.png" width="400"></td>
  </tr>
  <tr>
    <td><img src="./demo/image_6.png" width="400"></td>
    <td><img src="./demo/image_4.png" width="400"></td>
  </tr>
</table>

known bugs:

  - highlighting pieces to draw does reset properly when switching to next piece to draw.

what's next

  - [X] hide next/prev arrows when there is no choice (len(draws) == 1).
  - [X] add in shortcuts for button presses.
  - [X] add in controller support.
  - [X] fix visual bugs during piece selection.
  - [X] hide next/prev arrows when there is no choice to left or right(index == 0 or index == len(draws)).
  - [X] unite button input under universal button.
  - [X] fix bug of null reference when playing oen board and then moving to another.
  - [X] filter out draws onto heart tiles as possible moves.
  - [X] arrows above currently selected draw (from from_tile to to_tile).
  - [X] fix tests.
  - [X] visualize player's on-board routes with a graph.
  - [X] only allow controller 1 input for player 1, etc
  - [X] implement feature: overlapping paths are treated like intersections (on second traditional board).
  - [ ] write tests for the logic of the second traditional board (level #2) and playtest the level.

## credits

See license file [LICENSE.md](./LICENSE.md).

tools:

  - Godot
    - license: [MIT](https://godotengine.org/license/)
    - location: https://github.com/godotengine/godot

art:

  - Game Icons
    - license: [CC0 1.0](https://creativecommons.org/publicdomain/zero/1.0/)
    - location: https://kenney.nl/assets/game-icons

fonts:

  - Diogenes
    - license:  [100% free]()
    - location: https://www.dafont.com/diogenes.font

music:

  - cc-by 3.0 -- treasures of ancient dungeon and caves.
    - file:      ./godot/assets/music/intro/treasures-of-ancient-dungeon.ogg
    - source:    https://opengameart.org/content/treasures-of-ancient-dungeon-2
    - by:        Alexandr Zhelanov, Monday, November 23, 2015 - 04:31
    - notes:     https://soundcloud.com/alexandr-zhelanov
  - cc-by 3.0 -- Ancient Ruins - Loopable.ogg Ancient Ruins - Loopable.ogg.
    - file:      ./godot/assets/music/game/ancient-ruins.ogg
    - source:    https://opengameart.org/content/ancient-ruins
    - by:        Wolfgang_, Tuesday, November 21, 2017 - 18:54
    - notes:     Copyright/Attribution Notice: Ted Kerr 2017
  - cc-by 3.0 -- The Cave of Ancient Warriors #1a
    - file:      ./godot/assets/music/intro/caves.ogg
    - source:    https://opengameart.org/content/the-cave-of-ancient-warriors-1a-0
    - by:        Bjon12345abc, Sunday, July 24, 2016 - 13:54
    - notes:     Bijan
  - cc-by 4.0 -- Ancient Robot
    - file:      ./godot/assets/music/game/ancient_robot.ogg
    - source:    https://opengameart.org/content/ancient-robot
    - by:        StereoPhysics, Friday, November 6, 2020 - 11:12
    - notes:     Copyright/Attribution Notice: Stereophysics - Enrique Ceseña
  - cc-0 p.d. -- ancient fairytale
    - file:      ./godot/assets/music/game/abf.ogg
    - source:    https://opengameart.org/content/ancient-fairytale
    - by:        obscure music, Friday, August 19, 2016 - 06:12
  - cc-0 p.d. -- Doodle menu like song
    - file:      ./godot/assets/music/game/doodle.ogg
    - source:    https://opengameart.org/content/doodle-menu-like-song
    - by:        StumpyStrust, Wednesday, January 21, 2015 - 08:33
  - cc-0 p.d. -- 7 Assorted Sound Effects (Menu, Level Up)
    - file:      ./godot/assets/music/effects/*
    - source:    https://opengameart.org/content/7-assorted-sound-effects-menu-level-up
    - by:        Joth, Thursday, April 18, 2019 - 09:17
    - notes:     Copyright/Attribution Notice: Joth, opengameart.org/users/joth @Joth_Music twitter.com/Joth_Music
  - cc-0 p.d. -- Tragic ambient main menu
    - file:      ./godot/assets/music/game/ambient-main.ogg
    - source:    https://opengameart.org/content/tragic-ambient-main-menu
    - by:        brandon75689, (Submitted by HaelDB), Tuesday, December 14, 2010 - 23:29

