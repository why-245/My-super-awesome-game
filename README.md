
A isometric top down survival horror game. That will have a inventory management system, levels,combat system with different types of enemy's. a gameplay will focus on solving puzzles and not dying. The story will probably be non existent as I will focus on the gameplay,

The game will have a ps 1 / psx style to it and the setting will be a 1920-40s sanitarium on a isolated island.

This is my second attempt at making a game and learning Godot,it will be coded in Gd-script and Gd-shaders. It will be developed without AI and is heavily inspired by Signalis (which you should play!!!).

Change log

v0.1.0
-Added player with Godots built in movent
-Added a world scene
-Added a basic shoot function for the player and a placeholder gun scene
-Added a interaction system with a RayCast3D
-Added basic objects
	1. Enemy that de spawns after being hit 3 times
	2. Intractable objects that dispersal or displays text when interacted with

v.0.2.0
-Started from scratch with the Inventory System, It now has a "carousel" type menu and reworked code.
-Added a Inventory item that you can pick up and that will display a Icon In the Inventory menu
-Added a "equip" function that highlights the inventory slot. Accessible from the inventory menu.
-Removed the intractable object from the world level due to the rework

v.0.3.0
-More Inventory work which is unfinished
-Added 2 shaders one for objects and another for the camera
-Started work on a combat system with a auto aim / target lock function which is unfinished.
-Player turns towards the direction they are moving and only looks at the mouse when you are aiming.

v.0.4.0
-Bug fix, The game no longer crashes when you interact with non inventory objects, Inventory is now correctly centered
-Inventory rework, the inventory is now separated in to two elements, a resource element that handles all the logic and a ui element.
-A equip function has been added for certain items (that actually equips a item)
-A use function has been added for certain items (that consumes a item upon use from the inventory)
-Reload function and ammo system for the place holder gun
-(UNFINISHED) work on a target lock / auto aim feature 

Only compatible with Windows!!!

How to download 

1. Install the latest release
2. Unzip the zip folder
3. Open the game folder
4. Run the .exe file from the game folder

How to run

1. Open "My super Awesome Game" by double clicking it
2. Ignore potential Windows security warnings


How to play

WASD: movement

SHIFT: Sprint

LMB: Shoot

"F": Interact

	"I": Inventory

		"A D" "Left arrow key, Right arrow key": Navigate Inventory menu

		"RMB" : On inventory slot to access options for inventory items

			"RMB" : On the different options for the inventory items (Equip, Use are the only functional options)






<img width="1129" height="618" alt="Screenshot 2026-11-05 222019" src="https://github.com/user-attachments/assets/1fac3e85-e3f1-4d8e-80c4-6e9b9e1fe066" />

<img width="1004" height="615" alt="Screenshot 2026-11-05 222005" src="https://github.com/user-attachments/assets/b91f5309-cd6b-426d-a210-db4f76445aac" />

