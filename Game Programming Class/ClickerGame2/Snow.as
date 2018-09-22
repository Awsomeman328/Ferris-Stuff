package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	public class Snow extends Updatable {
		
		/** This value stores points to hand off to the Game object when this gets clicked. */
		public var unscoredPoints:int = 0;
		
		/**
		 * This is the Snow constructor, where we set up the game.
		 */
		public function Snow() {
			// constructor code
			addEventListener(MouseEvent.MOUSE_DOWN, handleClick);
		}// ends constructor
		
		/**
		 *  This Function is called when this object is clicked. Neat.
		 * @param e The MouseEvent object that is triggering this event-handler.
		 */
		private function handleClick(e:MouseEvent):void {
			unscoredPoints = vY / scaleX + 1;
			//trace(unscoredPoints);
			isDead = true;
		}// ends handleClick
		
		/**
		 * This function's job is to prepare the object for removal. 
		 */
		public function dispose():void {
			removeEventListener(MouseEvent.MOUSE_DOWN, handleClick);
		}
	}//ends class Snow
}// ends package
