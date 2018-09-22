package  {
	
	import flash.display.MovieClip;
	
	public class Particle extends MovieClip {
		
		/** The x-component of the acceleration in pixels/tick^2. */
		var aX:Number = 0;
		/** The y-component of the acceleration in pixels/tick^2. */
		var aY:Number = .125;
		/** Rotational acceleration in degrees/tick. */
		var aR:Number = 0;
		
		/** The x-component of the velocity in pixels/tick. */
		var vX:Number = 0;
		/** The y-component of the velocity in pixels/tick. */
		var vY:Number = 0;
		/** Rotational velocity in degrees/tick. */
		var vR:Number = 1;
		
		/** When this falls off the screen, this falue is set to true. This value tells
		 *  the Game object if this thing needs to die or not. */
		public var isOutOfBounds:Boolean = false;
		
		/** The constructor of the Particle class. */
		public function Particle() {
			// constructor code
			vX = Math.random() * 20 - 10; // -10 to 10
			vY = Math.random() * 10 - 5; // -5 to -5
			vR = Math.random() * 4 - 2; // -2 to 2
		} //ends constructor
		
		/**
		 * This is our update function. This is called every frame to run this object's logic.
		 */
		public function update():void {
			vX += aX;
			vY += aY;
			
			x += vX;
			y += vY;
			rotation += vR;
			
			if(x < 0 || x > 1200) {
				aX *= -1;
				vX *= -1;
			}
			if (y > 750) isOutOfBounds = true;
		} //ends update
	} //ends class Particle
} //ends package
