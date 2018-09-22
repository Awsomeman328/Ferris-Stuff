package  {
	
	import flash.display.MovieClip;
	
	
	public class Player extends MovieClip {
		
		
		public function Player() {
			// constructor code
		}
		
		public function update():void {
			//trace(stage.mouseX + " , " + stage.mouseY);
			var tx: Number = parent.mouseX - x;
			var ty: Number = parent.mouseY- y;
			var angleR:Number = Math.atan2(ty, tx);
			var angleD:Number = (angleR * 180 / Math.PI);
			rotation = angleD + 90;
			// rotate player sprite so that the barrel points at the mouse.
		}
	}
	
}
