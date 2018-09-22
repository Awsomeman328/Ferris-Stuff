package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	public class BG extends MovieClip {
		
		var clicks: int = 0;
		
		public function BG() {
			// constructor code
			addEventListener(MouseEvent.MOUSE_DOWN, handleClick);
		}// ends constructor
		
		/**
		 *  This Function is called when this object is clicked. Neat.
		 * @param e The MouseEvent object that is triggering this event-handler.
		 */
		private function handleClick(e:MouseEvent):void {
			clicks++;
		}// ends handleClick
	}// ends class BG
}// ends package
