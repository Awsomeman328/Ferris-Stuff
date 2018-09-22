package {

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;

	/**
	 * This is the controller class for the entire game.
	 */
	public class Game extends MovieClip {

		/** This array should only hold Array Objects of Updatable Objects. */
		var updatables: Array = new Array();
		/** This array should only hold Snow objects. */
		var snowflakes: Array = new Array();
		/** This array should only hold Multiplyer objects. */
		var multiplyers: Array = new Array();
		/** This array should only hold Health objects. */
		var healths: Array = new Array();
		/** This array should only hold Bomb objects. */
		var bombs: Array = new Array();
		/** The number of frames to wait before spawning the next Snow object. */
		var delaySpawn: int = 0;
		/** The current score of the player in the current game. */
		var score: int = 0;
		/** This tells the script if the game is currently in progress.*/
		var isGameOver: Boolean = false;
		/** This value tracks how many times the player can miss clicking on an Updatable Object before getting a gameover. */
		var missClicks: int = 3;
		/** The 1st Highscore saved. */
		var score1: int = 0;
		/** The 2nd Highscore saved. */
		var score2: int = 0;
		/** The 3rd Highscore saved. */
		var score3: int = 0;
		/** The 4th Highscore saved. */
		var score4: int = 0;
		/** The 5th Highscore saved. */
		var score5: int = 0;
		/** This bool keeps track of whether or not the player needs to click the reset button. */
		var needToReset: Boolean = false;
		/** This value is what the score uses to multiply when tallying up the player's score for every click. */
		var multiplyer: int = 1;
		/** This difficulty amount keeps track of how long the game waits until it spawns more objects. Increases every 1000 points. */
		var difficultySnow: int = 1;
		/** This difficulty amount keeps track of how many objects the game spawns at once. Increases every 100 multiplyers. */
		var difficultyMult: int = 1;
		/** This difficulty amount keeps track of the ratio of clickable objects the game will spawn. Increases every 10 lives. */
		var difficultyHealth: int = 1;

		

		//DONE LIST:
		//SCORE
		//DIFFERENT AMOUNT OF POINTS BASED ON SIZE AND SPEED
		//GAMEOVER SKIN
		//SCOREBOARD
		//PLAY AGAIN BUTTON
		//POWERUPS/DIFFERENT KINDS OF CLICKABLE OBJECTS (1 to 2 powerups [Slow down / Multiplyer / Health] & 1 bad clickable [Bomb])
		//B/c I can't remember how to implament delta-time into this programming (& I don't want to look it up b/c he will teach us anyway), 
		//I will go with a multiplyer and a health powerup.
		//CHANGING SPAWN RATES OVER TIME/CHANGING DIFFICULTY OVER TIME (Time between spawns, number of spawns at a time, the chances of each spawn)
		//RESKIN (YOUR OWN BEUTIFLE ARTWORK [Just have to make snowflakes]) (tuesday)

		//TODO LIST:
		//SOUND EFFECTS (tuesday)
		
		//KEEP DOING:
		//FULLY DOCUMENT CODE
		//REMOVE ALL CODE SMELLS

		// Look for code smells:
		// -Every function must do only one thing
		// -Every function must be able to fit on your screen
		// -You must be able to tell what each function does just by reading and looking at it
		// -Remove your Trace()'s when you are done with them, or comment them out if you're going to keep/use them again.


		//FIXED LIST
		//SOMETIMES WHEN YOU RESET THE GAME, YOU ARE BROUGHT TO A NEW GAMEOVER SCREEN AND YOU HAVE TO RESET THE GAME AGAIN.
		//I'D LIKE TO ONLY HAVE TO CLICK RESET ONLY ONCE.

		//BUG LIST
		//IT IS POSSIBLE TO CLICK ON THE HUD TEXT ON THE SCREEN. THIS CAUSES AN EXPLOIT WHERE THE PLAYER CAN JUST SPAM CLICK THE TEXT WITHOUT LOOSING LIVES.
		//PLAYERS SHOULD BE PUNISHED FOR SPAM CLICKING.

		/**
		 * This is the Game constructor, where we set up the game.
		 */
		public function Game() {
			// constructor code
			addEventListeners();
			pushArraysIntoUpdatables();
			setGameOverScreenVisability(false);
		} //ends constructor
		
		/**
		 * This function adds all of the event listeners for this Game Object.
		 */
		private function addEventListeners(): void {
			addEventListener(Event.ENTER_FRAME, gameLoop);
			addEventListener(MouseEvent.MOUSE_DOWN, handleClick);
		}
		
		/**
		 * This function adds all of the Arrays with objects that extend Updatable into the updatables Array Object.
		 */
		private function pushArraysIntoUpdatables(): void {
			updatables.push(snowflakes);
			updatables.push(multiplyers);
			updatables.push(healths);
			updatables.push(bombs);
		}
		
		/**
		 * This function sets the visability of the gameOverScreen and the Reset button.
		 * @param b The Boolean value we wish to set our visability to.
		 */
		private function setGameOverScreenVisability(b: Boolean): void {
			gameOverScreen.visible = b;
			textReset.visible = b;
		}

		/**
		 * This event-handler is called every time a new frame is drawn. It's our game loop!
		 * @param e The Event that triggered this event-handler.
		 */
		private function gameLoop(e: Event): void {
			spawnObjects();
			updateObjects();
			updateHUD();
			checkBackgroundClicks();
			checkMissClicksNum();
			setDifficulty();
		} //ends gameLoop

		/**
		 * This function is a countdown timer. When it hits 0, it spawns a random object with Updatable as it's extention.
		 */
		private function spawnObjects(): void {
			delaySpawn--;
			if (delaySpawn <= 0) {
				for (var d: int = difficultyMult; d >= 0; d--) {
					var r: Number = Math.random() + (difficultyHealth / 10);
					if (r <= 0.85) {
						var s: Snow = new Snow();
						addChild(s);
						snowflakes.push(s);
					}
					if (r >= 0.85 && r <= 0.9) {
						var m: Multiplyer = new Multiplyer();
						addChild(m);
						multiplyers.push(m);
					}
					if (r >= 0.9 && r <= 0.95) {
						var h: Health = new Health();
						addChild(h);
						healths.push(h);
					}
					if (r >= 0.95) {
						var b: Bomb = new Bomb();
						addChild(b);
						bombs.push(b);
					}
				}
				delaySpawn = (Math.random() * 10 + 10) / difficultySnow; // 10 to 20 divided by difficulty
			}
		} //ends spawnSnow

		/**
		 * This function cycle through all Updatable Object Arrays within updateables, cycles through all of their objects and calls their update() function.
		 */
		private function updateObjects(): void {
			for (var j: int = updatables.length - 1; j >= 0; j--) {
				for (var i: int = snowflakes.length - 1; i >= 0; i--) {
					snowflakes[i].update();
					score += snowflakes[i].unscoredPoints * multiplyer;
					snowflakes[i].unscoredPoints = 0;
					if (snowflakes[i].isDead) {
						snowflakes[i].dispose;
						removeChild(snowflakes[i]);
						snowflakes.splice(i, 1);
					}
				}
				for (var k: int = multiplyers.length - 1; k >= 0; k--) {
					multiplyers[k].update();
					if (multiplyers[k].isDead) {
						multiplyer += multiplyers[k].unscoredMultiplyer;
						multiplyers[k].dispose;
						removeChild(multiplyers[k]);
						multiplyers.splice(k, 1);
					}
				}
				for (var m: int = healths.length - 1; m >= 0; m--) {
					healths[m].update();
					if (healths[m].isDead) {
						missClicks += healths[m].unscoredHealth;
						healths[m].dispose;
						removeChild(healths[m]);
						healths.splice(m, 1);
					}
				}
				for (var n: int = bombs.length - 1; n >= 0; n--) {
					bombs[n].update();
					if (bombs[n].isDead) {
						missClicks -= bombs[n].exploded;
						bombs[n].dispose;
						removeChild(bombs[n]);
						bombs.splice(n, 1);
					}
				}
			}
		} //ends updateSnow
		
		/**
		 * This function makes sure that all possible Number values given to the player in text on screen is valid.
		 */
		private function updateHUD(): void {
			textScore.text = "Score: " + score + " X" + multiplyer;
			textMissclicks.text = "Missclicks: " + missClicks;
			gameOverScreen.textScore1.text = "#1: " + score1;
			gameOverScreen.textScore2.text = "#2: " + score2;
			gameOverScreen.textScore3.text = "#3: " + score3;
			gameOverScreen.textScore4.text = "#4: " + score4;
			gameOverScreen.textScore5.text = "#5: " + score5;
		}
		
		/**
		 * This function checks if the BG Object was clicked on. If it was, it automatically subtracts from our missClicks value.
		 */
		private function checkBackgroundClicks(): void {
			if (bg.clicks > 0) {
				missClicks -= bg.clicks;
				bg.clicks = 0;
			}
		}
		
		/**
		 * This function checks if our number of allowed MissClicks is at or below 0. If it is, it automatically starts the proccess of giving the player 
		 * the game over screen.
		 */
		private function checkMissClicksNum(): void {
			if (missClicks <= 0 && needToReset == false) {
				isGameOver = true;
				setHighScores();
				setGameOverScreenVisability(true);
				needToReset = true;
			}
		}
		
		/**
		 * This function that is called every frame calculates how difficult to make the game based on the player's performance.
		 */
		private function setDifficulty(): void {
			difficultySnow = (score / 1000) + 1;
			difficultyMult = (multiplyer / 100) + 1;
			difficultyHealth = (missClicks / 10) + 1;
		}

		/**
		 *  This Function is called when the screen is clicked. Neat.
		 * @param e The MouseEvent object that is triggering this event-handler.
		 */
		private function handleClick(e: MouseEvent): void {
			if (isGameOver != true) {
				if (e.target == textMissclicks || e.target == textScore) missClicks--;
			}
			if (isGameOver && e.target == textReset) {
				for (var i: int = snowflakes.length - 1; i >= 0; i--) snowflakes[i].isDead = true;
				for (var k: int = multiplyers.length - 1; k >= 0; k--) multiplyers[k].isDead = true;
				for (var m: int = healths.length - 1; m >= 0; m--) healths[m].isDead = true;
				for (var n: int = bombs.length - 1; n >= 0; n--) bombs[n].isDead = true;
				score = 0;
				multiplyer = 1;
				missClicks = 3;
				isGameOver = false;
				setGameOverScreenVisability(false);
				needToReset = false;
			}
		} // ends handleClick

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
		} //ends setHighScores
	} //ends class Game
} //ends package