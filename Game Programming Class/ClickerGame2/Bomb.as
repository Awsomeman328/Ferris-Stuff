package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	public class Bomb extends Updatable {
		
		/** This value stores damage to hand off to the Game object when this gets clicked. */
		public var exploded:int = 0;
		
		/**
		 * This is the Bomb constructor, where we set up the game.
		 */
		public function Bomb() {
			// constructor code
			addEventListener(MouseEvent.MOUSE_DOWN, handleClick);
		}
		
		/**
		 *  This Function is called when this object is clicked. Neat.
		 * @param e The MouseEvent object that is triggering this event-handler.
		 */
		private function handleClick(e:MouseEvent):void {
			exploded += 10;
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
