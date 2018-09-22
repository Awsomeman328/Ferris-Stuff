package  {
	
	import flash.display.MovieClip;
	
	
	public class Bullet extends MovieClip {
		
		private const SPEED:Number = 10;
		
		private var vX:Number = 0;
		private var vY:Number = -10;
		
		public var isDead:Boolean = false;
		public var radius:Number = 10;
		
		public function Bullet(p:Player) {
			// constructor code
			x = p.x;
			y = p.y;
			
			var angleR:Number = (p.rotation - 90) * Math.PI / 180;
			
			vX = SPEED * Math.cos(angleR);
			vY = SPEED * Math.sin(angleR);
			
			// TODO: set vX & vY
		}
		
		public function update():void {
			x += vX;
			y += vY;
			
			if(!stage || y < -20 || y > stage.stageHeight + 20 || x < -20 || x > stage.stageWidth + 20) isDead = true;
		}
	}
	
}