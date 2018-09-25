package  {
	
	import flash.display.MovieClip;
	
	/**
	 * This is the controller class for the Bullet Object.  
	 */
	public class Bullet extends Updatable {
		
		/** This constant is used to calculate the velocity of this Object using vector math. */
		public const SPEED:Number = 10;
		/** This variable keeps track of the collision radius of this Object. */
		public var radius:Number = 10;
		/** This variable is to set a specific flag for this Object when it collides with another specific Object. If set to true, isDead will be
		 *  set to true as well. */
		public var wasKilled:Boolean = false;
		
		/**
		 * This is the Bullet constructor, where we set up this Object. It requires a Player object and the Player's current frame to create. 
		 */
		public function Bullet(p:Player, n:int) {
			// constructor code
			gotoAndStop(n);
			
			vY = -10;
			x = p.x;
			y = p.y;
			
			var angleR:Number = (p.rotation - 90) * Math.PI / 180;
			
			vX = SPEED * Math.cos(angleR);
			vY = SPEED * Math.sin(angleR);
		} // end constructor
		/**
		 * This function overrides the update function of it's Updatable parent.
		 */
		override public function update():void {
			x += vX;
			y += vY;
			
			if(!stage || y < -20 || y > stage.stageHeight + 20 || x < -20 || x > stage.stageWidth + 20) isDead = true;
			if(wasKilled){
				isDead = true;
			}
		} // end update
	} // end class Bullet
} // end package