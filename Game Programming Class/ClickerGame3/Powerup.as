package  {
	
	import flash.display.MovieClip;
	
	/**
	 * This is the controller class for the Powerup Object.  
	 */
	public class Powerup extends Updatable {
		
		/** This variable controls how fast this Object will fall. */
		private var speed:Number;
		/** This variable keeps track of the collision radius of this Object. */
		public var radius:Number = 25;
		/** This variable determines what type of Powerup the player will recieve from this object when collected. */
		public var powerType:int;
		/** This variable is to set a specific flag for this Object when it collides with another specific Object. If set to true, isDead will be
		 *  set to true as well. */
		public var wasKilled:Boolean = false;
		
		/**
		 * This is the Powerup constructor, where we set up this Object. 
		 */
		public function Powerup() {
			// constructor code
			x = Math.random() * 550;
			y = -50;
			speed = Math.random() * 3 + 2; // 2 to 5?
			powerType = Math.random() * 3 + 2; // 2 to 5
			gotoAndStop(powerType);
		} // end constructor
		/**
		 * This function overrides the update function of it's Updatable parent.
		 */
		override public function update():void {
			// fall
			y += speed;
			if(y > 450){
				isDead = true;
			}
			if(wasKilled){
				isDead = true;
			}
		} // end update
	} // end class Powerup
} // end package