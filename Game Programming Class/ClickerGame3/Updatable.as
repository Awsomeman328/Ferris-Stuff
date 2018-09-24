package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	public class Updatable extends MovieClip {
		
		/** If this is true, the object is flagged to be destroyed!! */
		var isDead:Boolean = false;
		/** The x-component of the velocity in pixels/tick. */
		var vX:Number = 0;
		/** The y-component of the velocity in pixels/tick. */
		var vY:Number = 0;
		/** Rotational velocity in degrees/tick. */
		var vR:Number = 0;
		
		/**
		 * This is the Updatable constructor, where we set up this Object.
		 */
		public function Updatable() {
			// constructor code

		}// ends constructor
		
		/**
		 * This function is called every frame. 
		 */
		public function update():void {
			
		}// ends update
	}// ends class Updatable
}// ends package