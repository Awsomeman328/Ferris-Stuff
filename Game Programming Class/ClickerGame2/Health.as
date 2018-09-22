package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	public class Health extends Updatable {
		
		/** This value stores health to hand off to the Game object when this gets clicked. */
		public var unscoredHealth:int = 0;
		
		/**
		 * This is the Health constructor, where we set up the game.
		 */
		public function Health() {
			// constructor code
			addEventListener(MouseEvent.MOUSE_DOWN, handleClick);
		}
		
		/**
		 *  This Function is called when this object is clicked. Neat.
		 * @param e The MouseEvent object that is triggering this event-handler.
		 */
		private function handleClick(e:MouseEvent):void {
			unscoredHealth++;
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
