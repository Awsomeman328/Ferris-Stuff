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
		/** This Boolean keeps track of if the player is currently holding down the mouse with the use of the handleMOUSEUP & DOWN functions. */
		var isMouseDown: Boolean = false;
		/** This int is how long the player has to wait, in frames, until the game will spawn another bullet. */
		var shootTimer: int = 0;
		/** This int is the player's score for the current game. It is reset back to 0 when reset() is called. */
		var score: int = 0;
		/** This is the highest recorded score the player has gotten while playing this game. */
		var score1: int = 0;
		/** This is the second highest recorded score the player has gotten while playing this game. */
		var score2: int = 0;
		/** This is the third highest recorded score the player has gotten while playing this game. */
		var score3: int = 0;
		/** This is the fourth highest recorded score the player has gotten while playing this game. */
		var score4: int = 0;
		/** This is the fith highest recorded score the player has gotten while playing this game. */
		var score5: int = 0;
		/** This value keeps track of what part of the game the player is currently as. 0 means the title screen, 1 means playing, 2 means gameover. */
		var gameState: int = 0;
		/** This Array should only hold GroundBase Objects. */
		var groundBases: Array = new Array();

		//DONE LIST:
		//IMPLAMENTED UPDATABLE OBJECT STRUCTURE
		//ADD POWERUPS THAT THE PLAYER CAN SHOOT
		//ALL POWERUPS CAN CHANGE THE TYPE OF WEAPON THE PLAYER CONTROLS
		//TRACK THE PLAYER'S SCORE
		//TITLESCREEN
		//ADD SOME SORT OF WAY FOR THE PLAYER TO LOSE:[4 GROUND BASES THAT TAKE DAMAGE/EXPLODE ON CONTACT WITH SNOW.]
		//GAMEOVER SCREEN & RESET
		//SCOREBOARD
		//RESKIN ARTWORK
		//FULLY DOCUMENT ALL OF THE CODE

		//TODO LIST:
		//COMPLETE POWERUP IDEAS[PANZER SHOT, LINE SHOT, BOUNCING SHOT]
		//SOUNDS [Shoot Bullet, Destroy Show, Base Detroyed, GameOver?] (Have to wait until I can get into the class room.)
		//TRY TO INTERGRATE THE GAMEPAD (I don't have a gamepad on me. I forgot it at home and it is due today.)

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
			gameOverScreen.visible = false;
			addEventListener(Event.ENTER_FRAME, gameLoop);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, handleMOUSEDOWN);
			stage.addEventListener(MouseEvent.MOUSE_UP, handleMOUSEUP);
			stage.addEventListener(MouseEvent.CLICK, handleClick);
		} // end constructor
		/**
		 * This event-handler is called every time a new frame is drawn. It's our game loop!
		 * @param e The Event that triggered this event-handler.
		 */
		private function gameLoop(e: Event): void {
			if (gameState > 0) {
				tickTimer();
				updateAllObjects();
				collisionDetection();
				detectGameOver();
			}
			canPlayerShoot();
		} // end gameLoop
		/**
		 * This event-handler is called whenever the player clicks the mouse button. 
		 * @param e The Event that triggered this event-handler. 
		 */
		private function handleClick(e: MouseEvent): void {
			if (e.target == titleScreen.textPlay || e.target == gameOverScreen.textReset) reset();
		} // end handleClick
		/**
		 * This event-handler is called whenever the player presses the mouse button down. 
		 * @param e The Event that triggered this event-handler. 
		 */
		private function handleMOUSEDOWN(e: MouseEvent): void {
			isMouseDown = true;
		} // end handleMOUSEDOWN
		/**
		 * This event-handler is called whenever the player releases the mouse button up. 
		 * @param e The Event that triggered this event-handler. 
		 */
		private function handleMOUSEUP(e: MouseEvent): void {
			isMouseDown = false;
		} // end handleMOUSEUP
		/**
		 * This function asks if the mouse button is currently being pressed or held down. 
		 * If it is, it then checks if shootTimer has reset yet. If shootTimer is less than or equal to 0, it runs the spawnBullet function. 
		 */
		private function canPlayerShoot(): void {
			if (isMouseDown) {
				if (shootTimer <= 0) {
					spawnBullet();
				}
			}
		} // end canPlayerShoot
		/**
		 * This function handles the spawning of all types of bullets for the game. The type of bullet spawned is determined by what frame 
		 * the player is currently on. In the future, I would like to move some of this logic into the bullet class itself. 
		 */
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
		} // end spawnBullet
		/**
		 * This function gets called every frame when the gameState is 1 or higher (not in the titleScreen). When called, it incraments all of our 
		 * different timer variables (spawnTimer & shootTimer) and checks if spawnTimer is less than or equal to 0. 
		 * If so, it runs the spawnFallingObjects() function. 
		 */
		private function tickTimer(): void {
			//countdown timer
			spawnTimer--;
			if (spawnTimer <= 0) {
				spawnFallingObjects();
			}
			shootTimer--;
		} // end tickTimer
		/**
		 * When spawnTimer hits 0, this function gets called. It randomly spawns either a Snowflake or a Powerup Object, then resets the spawnTimer. 
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
		} // ends spawnFallingObjects
		/**
		 * This function gets called every frame when not in the title screen. First it updates the player and the in game text. 
		 * Next, it cycles through all of the Objects in the Arrays nested within updatables and calls their update functions. 
		 * It then checks if specific Objects wasKilled variable set to true for specific collision behavior. After that, it checks 
		 * if the Object's isDead variable true. If so, it removes that Object from the array and the display tree. If wasKilled was true, 
		 * then isDead is also true.
		 */
		private function updateAllObjects(): void {
			//Update the player. Basically rotate him to face the mouse.
			player.update();
			//update the text
			updateText();
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
						//used to be where I detected collision detection.
					}
				}
			}
			//where I thought about putting collision detection.
		} // end updateAllObjects
		/**
		 * This function gets called every frame when not in the titleScreen (gameState > 0). When called, it sets all of the in-game text 
		 * to accuratly portray what their tacked variables values are. That sounded confusing. I'm sorry. It makes sense. Trust me. 
		 */
		private function updateText(): void {
			textScore.text = "Score: " + score;
			gameOverScreen.textScoreboard.text = "\n";
			gameOverScreen.textScoreboard.text +=  "Scoreboard: "+ "\n";
			gameOverScreen.textScoreboard.text +=  "#1: " + score1 + "\n";
			gameOverScreen.textScoreboard.text +=  "#2: " + score2 + "\n";
			gameOverScreen.textScoreboard.text +=  "#3:  "+ score3 +"\n";
			gameOverScreen.textScoreboard.text +=  "#4: " + score4 + "\n";
			gameOverScreen.textScoreboard.text +=  "#5: " + score5 + "\n";
		} // end updateText
		/**
		 * This function gets called every frame after all Objects have been updated. Because all of our objects are mostly circular, 
		 * this function used radial collision detection between specific Objects to set wasKilled flags as true. 
		 */
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
							//trace("Collision! a " + updatables[m][n] + " just colided w/ a " + updatables[0][k]);
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
					var disX: Number = updatables[3][g].x - updatables[2][s].x;
					var disY: Number = updatables[3][g].y - updatables[2][s].y;
					var dis: Number = Math.sqrt(disX * disX + disY * disY);
					if (dis < updatables[3][g].radius + updatables[2][s].radius) {
						//trace("Collision! a " + updatables[3][g] + " just colided w/ a " + updatables[2][s]);
						updatables[3][g].wasKilled = true;
					}
				}
			}
		} // end collisionDetection
		/**
		 * This function gets called every frame. It checks the number of GroundBase Objects that are still on screen and if the gameState 
		 * needs to be changed ("game over" still hasn't happened yet). If both are true, it sets the gameState to 2 (gameOver), sets the 
		 * gameOverScreen visability to true and calls the setHighScores() function. Dispite being called every frame, all of the logic I 
		 * just listed out should only be runned once until the player resets the game. 
		 */
		private function detectGameOver(): void {
			if (updatables[3].length <= 0) {
				if (gameState == 1) {
					gameState = 2;
					gameOverScreen.visible = true;
					setHighScores();
				}
			}
		} // end detectGameOver
		/**
		 * This function is called when the player clicks on the textPlay or textReset Objects. This makes this function behaive both as a 
		 * "start play" function as well as a "reset" function. It sets the gameState to 1 (playing), turn both the titleScreen and
		 * gameOverScreen to not visible and sets the score to 0. It then deletes all Updatable Objects within their arrays and calls the 
		 * respawnGBs() function (respawnGroundBases). Lastly, it changes the player's current frame to 1.
		 */
		function reset(): void {
			gameState = 1;
			titleScreen.visible = false;
			gameOverScreen.visible = false;
			score = 0;
			for (var i = updatables.length - 1; i >= 0; i--) {
				for (var j = updatables[i].length -1; j >= 0; j--) {
					updatables[i][j].isDead = true;
				}
			}
			respawnGBs();
			player.gotoAndStop(1);
		} // end reset
		/**
		 * This function, called whenever reset() is called, spawns new GroundBase Objects, add them to the GroundBases Array and add them to the 
		 * display tree. Afterwards, it sets all of their positions to their proper placement.
		 */
		private function respawnGBs(): void {
			var gb1: GroundBase = new GroundBase;
			addChild(gb1);
			groundBases.push(gb1)
			gb1.x = 75;
			gb1.y = 400;
			
			var gb2: GroundBase = new GroundBase;
			addChild(gb2);
			groundBases.push(gb2)
			gb2.x = 175;
			gb2.y = 400;
			
			var gb3: GroundBase = new GroundBase;
			addChild(gb3);
			groundBases.push(gb3)
			gb3.x = 375;
			gb3.y = 400;
			
			var gb4: GroundBase = new GroundBase;
			addChild(gb4);
			groundBases.push(gb4)
			gb4.x = 475;
			gb4.y = 400;
			
		} // end respawnGBs
		/**
		 * This Function is called when the game ends. It calculates if the current score is higher than any of the previous highscores.
		 * If true, it sets all the values in accending order.
		 */
		function setHighScores(): void {
			if (score >= score1) {
				score5 = score4;
				score4 = score3;
				score3 = score2;
				score2 = score1;
				score1 = score;
				return;
			}
			if (score >= score2) {
				score5 = score4;
				score4 = score3;
				score3 = score2;
				score2 = score;
				return;
			}
			if (score >= score3) {
				score5 = score4;
				score4 = score3;
				score3 = score;
				return;
			}
			if (score >= score4) {
				score5 = score4;
				score4 = score;
				return;
			}
			if (score >= score5) {
				score5 = score;
				return;
			}
		} // end setHighScores		
	} // end class Game
} // end package