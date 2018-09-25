package  {
	
	import flash.display.MovieClip;
	
	/**
	 * This is the controller class for the Snow Object.  
	 */
	public class GroundBase extends Updatable {
		
		/** This variable is to set a specific flag for this Object when it collides with another specific Object. If set to true, isDead will be
		 *  set to true as well. */
		var wasKilled: Boolean = false;
		/** This variable keeps track of the collision radius of this Object. */
		var radius:Number = 25;
		
		/**
		 * This is the GroundBase constructor, where we set up this Object. 
		 */
		public function GroundBase() {
			// constructor code
		} // end constructor
		/**
		 * This function overrides the update function of it's Updatable parent.
		 */
		override public function update():void {
			if (wasKilled) isDead = true;
		} // end update
	} // end class GroundBase
} // end package
