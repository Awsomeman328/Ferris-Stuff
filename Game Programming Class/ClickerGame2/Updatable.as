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
		var vR:Number = 1;
		
		/**
		 * This is the Updatavle constructor, where we set up the game.
		 */
		public function Updatable() {
			// constructor code
			x = Math.random() * 1100;
			y = -50;
			vY = Math.random() + .1; // .1 to 1.1
			scaleX = Math.random() * .3 + .1; // .1 to .3
			scaleY = scaleX;
		}// ends constructor
		
		/**
		 * This function is called every frame. By default, it causes the object to fall down the screen and check if it is currently offscreen. 
		 * If the object does find itself offscreen, then it flags itself to be killed by the Game Object.
		 */
		public function update():void {
			y += vY;
			if (y > 900) isDead = true;
		}// ends update
	}// ends class Updatable
}// ends package
