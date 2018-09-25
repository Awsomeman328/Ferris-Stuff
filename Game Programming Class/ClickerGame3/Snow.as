package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	/**
	 * This is the controller class for the Snow Object.  
	 */
	public class Snow extends Updatable {
		
		/** This variable controls how fast this Object will fall. */
		private var speed:Number;
		/** This variable keeps track of the collision radius of this Object. */
		public var radius:Number = 50;
		/** This variable is to set a specific flag for this Object when it collides with another specific Object. If set to true, isDead will be
		 *  set to true as well. */
		public var wasKilled:Boolean = false;
		/** This variable determines what frame will show when this Object is spawned */
		var snowType:int = 0;
		
		/**
		 * This is the Snow constructor, where we set up this Object. 
		 */
		public function Snow() {
			x = Math.random() * 550;
			y = -50;
			speed = Math.random() * 3 + 2; // 2 to 5?
			scaleX = Math.random() * .2 + .1; // .1 to .3
			scaleY = scaleX;
			radius *= scaleX
			snowType = Math.random() * 3 + 2; // 2 to 5
			gotoAndStop(snowType);
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
	} // end class Snow
} // end package