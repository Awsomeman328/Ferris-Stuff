package  {
	
	import flash.display.MovieClip;
	
	
	public class Bullet extends Updatable {
		
		public const SPEED:Number = 10;
		
		public var radius:Number = 10;
		
		public var wasKilled:Boolean = false;
		
		public function Bullet(p:Player, n:int) {
			// constructor code
			gotoAndStop(n);
			
			vY = -10;
			x = p.x;
			y = p.y;
			
			var angleR:Number = (p.rotation - 90) * Math.PI / 180;
			
			vX = SPEED * Math.cos(angleR);
			vY = SPEED * Math.sin(angleR);
			
			// TODO: set vX & vY
		}
		
		override public function update():void {
			x += vX;
			y += vY;
			
			if(!stage || y < -20 || y > stage.stageHeight + 20 || x < -20 || x > stage.stageWidth + 20) isDead = true;
			if(wasKilled){
				isDead = true;
			}
		}
	}
}