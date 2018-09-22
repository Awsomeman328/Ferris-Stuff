package {

	import flash.display.MovieClip;
	import flash.events.MouseEvent;

	public class Game extends MovieClip {

		var isPlayer1Turn: Boolean = true;
		var hasWinner: Boolean = false;

		public function Game() {
			// constructor code
			addEventListener(MouseEvent.CLICK, handleClick);
		} // ends constructor
		
		function handleClick(e: MouseEvent): void {
			if (e.target == resetText) {
				reset();
				return
			}
			if (hasWinner == false) {
				if (e.target.currentFrame != 1) return;
				if (isPlayer1Turn) {
					e.target.gotoAndStop(2);
				} else {
					e.target.gotoAndStop(3);
				}
				lookForWinner();
				declareWinner();
			}
		} // ends handleClick

		function lookForWinner(): void {
			if (b1.currentFrame != 1 && b1.currentFrame == b2.currentFrame && b1.currentFrame == b3.currentFrame) {
				hasWinner = true;
				return;
			}
			if (b1.currentFrame != 1 && b1.currentFrame == b5.currentFrame && b1.currentFrame == b9.currentFrame) {
				hasWinner = true;
				return;
			}
			if (b1.currentFrame != 1 && b1.currentFrame == b4.currentFrame && b1.currentFrame == b7.currentFrame) {
				hasWinner = true;
				return;
			}
			if (b4.currentFrame != 1 && b4.currentFrame == b5.currentFrame && b4.currentFrame == b6.currentFrame) {
				hasWinner = true;
				return;
			}
			if (b7.currentFrame != 1 && b7.currentFrame == b5.currentFrame && b7.currentFrame == b3.currentFrame) {
				hasWinner = true;
				return;
			}
			if (b7.currentFrame != 1 && b7.currentFrame == b8.currentFrame && b7.currentFrame == b9.currentFrame) {
				hasWinner = true;
				return;
			}
			if (b2.currentFrame != 1 && b2.currentFrame == b5.currentFrame && b2.currentFrame == b8.currentFrame) {
				hasWinner = true;
				return;
			}
			if (b3.currentFrame != 1 && b3.currentFrame == b6.currentFrame && b3.currentFrame == b9.currentFrame) {
				hasWinner = true;
				return;
			}
			
			if (b1.currentFrame != 1 && b2.currentFrame != 1 && b3.currentFrame != 1 && b4.currentFrame != 1 && b5.currentFrame != 1 && b6.currentFrame != 1 && b7.currentFrame != 1 && b8.currentFrame != 1 && b9.currentFrame != 1) {
				turnText.text = ("There's a Tie.");
				return;
			}
			
			if (isPlayer1Turn) {
				turnText.text = ("ploodyer 2oos tern...");
			} else {
				turnText.text = ("ploodyer 1xs tern...");
			}
			isPlayer1Turn = !isPlayer1Turn;
		} // ends lookForWinner()

		function declareWinner(): void {
			if (hasWinner == true) {
				if (isPlayer1Turn) {
					turnText.text = ("ploodyer 1x windid!");
				} else {
					turnText.text = ("ploodyer 2oo windid!");
				}
			}
		} // ends declareWinner

		function reset(): void {
			isPlayer1Turn = true;
			hasWinner = false;
			
			b1.gotoAndStop(1);
			b2.gotoAndStop(1);
			b3.gotoAndStop(1);
			b4.gotoAndStop(1);
			b5.gotoAndStop(1);
			b6.gotoAndStop(1);
			b7.gotoAndStop(1);
			b8.gotoAndStop(1);
			b9.gotoAndStop(1);
			
			turnText.text = ("ploodyer 1xs tern...");
		} // ends reset		
	} // ends Game class
} // ends package