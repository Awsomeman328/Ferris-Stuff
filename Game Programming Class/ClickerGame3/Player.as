package  {
	
	import flash.display.MovieClip;
	
	/**
	 * This is the controller class for the Player Object. This piece doesn't (currently) move, but will rotate to always point towards the mouse. 
	 */
	public class Player extends Updatable {
		
		/**
		 * This is the Player constructor, where we set up this Object.
		 */
		public function Player() {
			// constructor code
			stop();
		} // end constructor
		/**
		 * This function is called every frame. It sets this Object's rotation to always point towards the mouse. 
		 */
		override public function update():void {
			//trace(stage.mouseX + " , " + stage.mouseY);
			var tx: Number = parent.mouseX - x;
			var ty: Number = parent.mouseY- y;
			var angleR:Number = Math.atan2(ty, tx);
			var angleD:Number = (angleR * 180 / Math.PI);
			rotation = angleD + 90;
			// rotate player sprite so that the barrel points at the mouse.
		} // end update
	} // end class Player
} // end package