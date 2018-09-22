package {

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;

	/**
	 *This is the document level class that runs our entire game.
	 */
	public class Game extends MovieClip {

		//DONE: GAME OVER MESSAGE
		//DONE: CREATE AN ARRAY OF THINGY'S AND SPAWN FIRST THINGY IN IT
		//DONE: RESET BUTTON
		//DONE: HIGH SCORES
		//DONE: CHANGE THE GAME MECHANICS: (SPAWN TONS OF OBJECTS [MORE CLICKABLES, PARTICLES])
		//DONE: add a timer and video url in the corners
		//DONE: make the reset button reset the bg music as well
		//DONE: RESKIN THE GAME (Rimmy Tim Themed)

		//KEEP DOING: SOUNDS (Rimmy Tim Themed)
		// -add more bouncing sounds and death sounds
		//KEEP DOING: COMPLETE DOCUMENT COMMENTARY

		//DONE: READ THE TEXTBOOK ON GAMELOOP
		//CAN I DO THIS?: COMPLETE THE QUIZ ON BLACKBOARD

		/** The current score of the player in the current game. */
		var score: int = 0;
		/** This tells the script if the game is currently in progress. If at least one
		 *  head is alive, this is set to false. When no heads are alive, its set to true.
		 */
		var isGameOver: Boolean = false;
		/** This is a value that tells the game if the first head needs to spawn yet. */
		var needToRepawn: Boolean = true;
		/** This array stores all of the head objects. */
		var thingys: Array = new Array;
		/** The 1st Highscore saved. */
		var score1: int = 0;
		/** The 2nd Highscore saved. */
		var score2: int = 0;
		/** The 3rd Highscore saved. */
		var score3: int = 0;
		/** This array stores all of the particle objects. */
		var particles: Array = new Array;
		/** This number that gets calculated every frame tells the player how much time
		 *  they have left until they win. */
		var timeLeft: int = 0;
		/** A Boolean that keeps track of if the player makes it to the end of the video to spawn extra Rimmy Tims. */
		var winTims: Boolean = false;
		/** This Boolean keeps track of if the game has started or not. This is automatically set to true after 5 seconds of runtime. First clickable
		 *  spawns after this is et to true. */
		var gameStart: Boolean = false;

		/** The constructor of the Game class. */
		public function Game() {
			// constructor code
			addEventListener(Event.ENTER_FRAME, gameLoop);
			addEventListener(MouseEvent.CLICK, handleClick);
			gameOverScores.alpha = 0;
			reset.alpha = 0;
			bg.alpha = 0.5;
		} //ends constructor

		/**
		 *  This is our game loop. It is an event-handler function that runs on the ENTER_FRAME event.
		 *  @param e The Event object that is triggering this event-handler
		 */
		function gameLoop(e: Event): void {
			// 1. measure how much time has passed
			// 2. get user input
			// 3. update everything
			if (gameStart) {
				instruct.alpha = 0;
				if (needToRepawn) {
					var thingy: CoolThing = new CoolThing;
					addChild(thingy);
					thingys.push(thingy);
					thingy.x = 245;
					thingy.y = 192;
					needToRepawn = false;
				}
				if (thingys.length >= 1) {
					for (var i: int = 0; i < thingys.length; ++i) {
						thingys[i].update();
						if (thingys[i].unscoredPoints > 0) {
							score += thingys[i].unscoredPoints
							thingys[i].unscoredPoints = 0;
							//spawn particles to fly out excitedly!
							for (var j: int = 0; j < (Math.random() * 10 + 100); ++j) {
								// 100 to 110 ^^^
								var newPart: Particle = new Particle;
								addChild(newPart);
								particles.push(newPart);
								newPart.x = thingys[i].x;
								newPart.y = thingys[i].y;
							}
							//spawn another Rimmy Tim Head
							var rimTim: CoolThing = new CoolThing;
							addChild(rimTim);
							thingys.push(rimTim);
							rimTim.x = thingys[i].x;
							rimTim.y = thingys[i].y;
							rimTim.vX = Math.random() * 20 - 10; // -10 to 10
							rimTim.vY = Math.random() * -5 - 5; // -0 to -5
							rimTim.vR = Math.random() * 4 - 2; // -2 to 2
						}
						if (thingys[i].isOutOfBounds) {
							thingys[i].removeEventListener(MouseEvent.MOUSE_DOWN, handleClick);
							removeChild(thingys[i]);
							thingys.removeAt(i);
						}
						score++ * thingys.length;
					}
				} else {
					if (isGameOver != true) {
						isGameOver = true;
						setHighScores();
						bg.stop();
						gameOverScores.alpha = 1;
						reset.alpha = 1;
					}
				}
				if (particles.length >= 1) {
					for (var p: int = 0; p < particles.length; ++p) {
						particles[p].update();
						if (particles[p].isOutOfBounds) {
							removeChild(particles[p]);
							particles.removeAt(p);
						}
					}
				}
			}

			timeLeft = Math.round(bg.totalTime - bg.playheadTime) - 5;
			if (bg.playheadTime > 5) gameStart = true;
			if (timeLeft < 0) {
				if (winTims == false && gameStart == true) {
					winTims = true;
					//trace("Rimmy Tim Wins!");
					/* This section of code is suposed to spawn multiple more heads at the location of each head already on screen.
					However it keeps crashing. Fix this so that it stops crashing. */
					for (var t: int = thingys.length; t > 0; t--) {
						//trace("thingy" + t);
						for (var r: int = 10; r > 0; r--) {
							//trace("thingy" + t + "." + r);
							//spawn another Rimmy Tim Head
							var rimTim: CoolThing = new CoolThing;
							addChild(rimTim);
							thingys.push(rimTim);
							rimTim.x = thingys[t].x;
							rimTim.y = thingys[t].y;
							rimTim.vX = 2 * Math.random() * 20 - 10; // -10 to 10
							rimTim.vY = 2 * Math.random() * -5 - 5; // -0 to -5
							rimTim.vR = 2 * Math.random() * 4 - 2; // -2 to 2
							//}
						}
					}
				}
			}

			scoreboard.text = "SCORE: " + score;
			multiplyer.text = "RimmyTims x" + thingys.length;
			gameOverScores.score1.text = "#1: " + score1;
			gameOverScores.score2.text = "#2: " + score2;
			gameOverScores.score3.text = "#3: " + score3;
			timer.text = "TIME LEFT: " + timeLeft;
			// 4. draw everything (in Animate, we don't have to worry about this)
		} //ends gameLoop

		/**
		 * This Function is called when the screen is clicked. Neat.
		 * @param e The MouseEvent object that is triggering this event-handler.
		 */
		function handleClick(e: MouseEvent): void {
			if (isGameOver && e.target == reset) {
				score = 0;
				isGameOver = false
				if (bg.playheadTime >= 6) bg.playheadTime = 6;
				else bg.playheadTime = 0;
				bg.play();
				gameOverScores.alpha = 0;
				reset.alpha = 0;
				needToRepawn = true;
			}
		} //ends handleClick

		/**
		 * This Function is called when the game ends. It calculates if the current score
		 * is higher than any of the previous highscores. If true, it sets all the values
		 * in accending order.
		 */
		function setHighScores(): void {
			if (score >= score1) {
				score3 = score2;
				score2 = score1;
				score1 = score;
				return;
			}
			if (score >= score2) {
				score3 = score2;
				score2 = score;
				return;
			}
			if (score >= score3) {
				score3 = score;
				return;
			}
		} //ends setHighScores
	} //ends Game class
} //ends package