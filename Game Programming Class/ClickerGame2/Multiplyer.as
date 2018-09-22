package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	public class Multiplyer extends Updatable {
		
		/** This value stores a multiplyer to hand off to the Game object when this gets clicked. */
		public var unscoredMultiplyer: int = 0;
		
		/**
		 * This is the Multiplyer constructor, where we set up the game.
		 */
		public function Multiplyer() {
			// constructor code
			addEventListener(MouseEvent.MOUSE_DOWN, handleClick);
		}
		
		/**
		 *  This Function is called when this object is clicked. Neat.
		 * @param e The MouseEvent object that is triggering this event-handler.
		 */
		private function handleClick(e:MouseEvent):void {
			unscoredMultiplyer = vY / scaleX + 1;
			isDead = true;
		}// ends handleClick
		
		/**
		 * This function's job is to prepare the object for removal. 
		 */
		public function dispose():void {
			removeEventListener(MouseEvent.MOUSE_DOWN, handleClick);
		}
	}
}
