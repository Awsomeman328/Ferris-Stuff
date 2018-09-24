package {

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;

	/**
	 * This is the controller class for the entire Game.
	 */
	public class Game extends MovieClip {

		/** This array should only hold Snow objects. */
		var snowflakes: Array = new Array();
		/** The number frames to wait before spawning the next Snow object. */
		var spawnTimer: int = 0;

		/** This array holds only Bullet objects. */
		var bullets: Array = new Array();
		/** This number represents when spawnFallingObjects() is run, how likely it is that the spawned Object is a Powerup Object. */
		var powerupChance: Number = 0.95;
		/** This array should only hold Powerup objects. */
		var powerups: Array = new Array();
		/** This array should only hold other arrays of Updatable objects. */
		var updatables: Array = new Array();

		var isMouseDown: Boolean = false;

		var shootTimer: int = 0;

		var score: int = 0;

		var score1: int = 0;

		var score2: int = 0;

		var score3: int = 0;
		/** This value keeps track of what part of the game the player is currently as. 0 means the title screen, 1 means playing, 2 means gameover. */
		var gameState: int = 0;

		var groundBases: Array = new Array();

		//DONE LIST:
		//IMPLAMENTED UPDATABLE OBJECT STRUCTURE
		//ADD POWERUPS THAT THE PLAYER CAN SHOOT
		//ALL POWERUPS CAN CHANGE THE TYPE OF WEAPON THE PLAYER CONTROLS
		//TRACK THE PLAYER'S SCORE
		//TITLESCREEN

		//TODO LIST:
		//COMPLETE POWERUP IDEAS[PANZER SHOT, LINE SHOT, BOUNCING SHOT]
		//ADD SOME SORT OF WAY FOR THE PLAYER TO LOSE:[4 GROUND BASES THAT TAKE DAMAGE/EXPLODE ON CONTACT WITH SNOW.]
		//SCOREBOARD
		//RESKIN ARTWORK
		//SOUNDS
		//GAMEOVER SCREEN & RESET
		//FULLY DOCUMENT ALL OF THE CODE
		//TRY TO INTERGRATE THE GAMEPAD


		/**
		 * This is where we setup the game.
		 */
		public function Game() {
			groundBases.push(gb1);
			groundBases.push(gb2);
			groundBases.push(gb3);
			groundBases.push(gb4);
			updatables.push(bullets);
			updatables.push(powerups);
			updatables.push(snowflakes);
			updatables.push(groundBases);
			trace(updatables[3]);
			addEventListener(Event.ENTER_FRAME, gameLoop);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, handleMOUSEDOWN);
			stage.addEventListener(MouseEvent.MOUSE_UP, handleMOUSEUP);
		}
		/**
		 * This event-handler is called every time a new frame is drawn.
		 * It's our game loop!
		 * @param e The Event that triggered this event-handler.
		 */
		private function gameLoop(e: Event): void {
			if (gameState > 0) {
				tickTimer();
				updateAllObjects();
			}
			isMouseCurrentlyDown();
		} // function gameLoop

		private function handleMOUSEDOWN(e: MouseEvent): void {
			isMouseDown = true;
			if (e.target == titleScreen.textPlay) {
				gameState = 1;
				titleScreen.visible = false;
			}
		}

		private function handleMOUSEUP(e: MouseEvent): void {
			isMouseDown = false;
		}

		private function isMouseCurrentlyDown(): void {
			if (isMouseDown) {
				if (shootTimer <= 0) {
					spawnBullet();
				}
			}
		}

		private function spawnBullet(): void {
			switch (player.currentFrame) {
				case 1:
					//Shoot base bullets
					//Keep these values as defaults
					shootTimer = 10;
					var b: Bullet = new Bullet(player, 1);
					addChild(b);
					bullets.push(b);
					break;
				case 2:
					//Shoot Automatic bullets
					//Spawn the bullets faster
					shootTimer = 2;
					var b: Bullet = new Bullet(player, 2);
					addChild(b);
					bullets.push(b);
					break;
				case 3:
					//Shoot Triple bullets
					//Spawn 3 bullets at a time at different angles
					shootTimer = 10;
					var b1: Bullet = new Bullet(player, 3);
					addChild(b1);
					bullets.push(b1);

					var b2: Bullet = new Bullet(player, 3);
					addChild(b2);
					bullets.push(b2);
					var angleR2: Number = (player.rotation - 80) * Math.PI / 180;
					b2.vX = b2.SPEED * Math.cos(angleR2);
					b2.vY = b2.SPEED * Math.sin(angleR2);

					var b3: Bullet = new Bullet(player, 3);
					addChild(b3);
					bullets.push(b3);
					var angleR3: Number = (player.rotation - 100) * Math.PI / 180;
					b3.vX = b3.SPEED * Math.cos(angleR3);
					b3.vY = b3.SPEED * Math.sin(angleR3);
					break;
				case 4:
					//Shoot Turtle bullets
					//Spawn larger bullets
					shootTimer = 10;
					var b: Bullet = new Bullet(player, 4);
					addChild(b);
					bullets.push(b);
					b.scaleX = 2;
					b.scaleY = b.scaleX;
					b.radius *= b.scaleX;
					break;
				case 5:
					//Shoot Panzer bullets
					//Spawn bullets at a slower rate. These bullets should explode either on impact or after 1 second of life (30 frames)
					shootTimer = 30;
					var b: Bullet = new Bullet(player, 5);
					addChild(b);
					bullets.push(b);
					break;
				case 6:
					//Shoot Line Bullets
					//Spawn a bullet that spawns even smaller stationary bullets that shrink and disapear.
					shootTimer = 10;
					var b: Bullet = new Bullet(player, 6);
					addChild(b);
					bullets.push(b);
					break;
				case 7:
					//Shoot Bouncing bullets
					//Spawn bullets that can bounce once off of any non-player or powerup object.
					shootTimer = 10;
					var b: Bullet = new Bullet(player, 7);
					addChild(b);
					bullets.push(b);
					break;

			}

		}

		private function tickTimer(): void {
			//countdown timer
			spawnTimer--;
			if (spawnTimer <= 0) {
				spawnFallingObjects();
			}
			shootTimer--;
		}

		/**
		 * Decrements the countdown timer, when it hits 0, it spawns either a Snowflake or a Powerup Object.
		 */
		private function spawnFallingObjects(): void {
			var n: Number = Math.random();
			//spawn a Powerup
			if (n >= powerupChance) {
				var p: Powerup = new Powerup();
				addChild(p);
				powerups.push(p);
				spawnTimer = (int)(Math.random() * 10 + 10);
			}
			//spawn a Snowflake
			else {
				var s: Snow = new Snow();
				addChild(s);
				snowflakes.push(s);
				spawnTimer = (int)(Math.random() * 10 + 10);
			}
		}

		private function updateAllObjects(): void {
			//Update the player. Basically rotate him to face the mouse.
			player.update();
			//update the text
			textScore.text = "Score: " + score;
			//for every array within the updatables array
			for (var i = updatables.length - 1; i >= 0; i--) {
				//for every object within the nested updatables array (snow, powerups, bullets, etc)
				for (var j = updatables[i].length - 1; j >= 0; j--) {
					//update the object
					updatables[i][j].update();
					//if the object was killed and that object was a powerup, set player's current weapon.
					if (updatables[i][j].wasKilled && i == 1) player.gotoAndStop(updatables[i][j].powerType);
					//if the object was killed and that object was a snowflake, add to the score
					if (updatables[i][j].wasKilled && i == 2) score++;
					//if this object is flagged for death, remove the object from the array and the display tree.
					if (updatables[i][j].isDead) {
						removeChild(updatables[i][j]);
						updatables[i].splice(j, 1);
					}
					//After updating all objects, cycle through all bullets and detect collision between them and the snow and powerups in that order.
					//This if check should only be runned once within this entire loop, only after every object has already been updated.
					//if we are at the last updatable array (should be bullets) and we've updated all of those bullets, run this code. 
					if (i == 0 && j == 0) {
						collisionDetection();
					}
				}
			}
		}

		private function collisionDetection(): void {
			//for every bullet
			for (var k = 0; k < updatables[0].length; k++) {
				//for every object in the updatables array (except for bullets)
				for (var m = 1; m < updatables.length; m++) {
					//for every object within the chosen array of updatavles (snow or powerups)
					for (var n = 0; n < updatables[m].length; n++) {
						var disX: Number = updatables[m][n].x - updatables[0][k].x;
						var disY: Number = updatables[m][n].y - updatables[0][k].y;
						var dis: Number = Math.sqrt(disX * disX + disY * disY);
						if (dis < updatables[m][n].radius + updatables[0][k].radius) {
							trace("Collision! a " + updatables[m][n] + " just colided w/ a " + updatables[0][k]);
							updatables[m][n].wasKilled = true;
							updatables[0][k].wasKilled = true;
						}
					}
				}
			}
			//for every snowflake
			for (var s = 0; s < updatables[2].length; s++) {
				//for every groundbase
				for (var g = 0; g < updatables[3].length; g++) {
					var disX: Number = updatables[2][s].x - updatables[3][g].x;
					var disY: Number = updatables[2][s].y - updatables[3][g].y;
					var dis: Number = Math.sqrt(disX * disX + disY * disY);
					if (dis < updatables[2][s].radius + updatables[3][g].radius) {
						trace("Collision! a " + updatables[2][s] + " just colided w/ a " + updatables[3][g]);
						updatables[2][s].wasKilled = true;
						updatables[3][g].wasKilled = true;
					}
				}
			}
		}
	} // class Game
} // package