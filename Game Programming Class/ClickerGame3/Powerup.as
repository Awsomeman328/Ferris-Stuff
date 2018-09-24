package  {
	
	import flash.display.MovieClip;
	
	
	public class Powerup extends Updatable {
		
		private var speed:Number;
		
		public var radius:Number = 25;
		
		public var powerType:int;
		
		public var wasKilled:Boolean = false;
		
		
		public function Powerup() {
			// constructor code
			x = Math.random() * 550;
			y = -50;
			speed = Math.random() * 3 + 2; // 2 to 5?
			powerType = Math.random() * 3 + 2; // 2 to 5
			gotoAndStop(powerType);
		}
		override public function update():void {
			// fall
			y += speed;
			if(y > 450){
				isDead = true;
			}
			if(wasKilled){
				isDead = true;
				
			}
		}
	}
}