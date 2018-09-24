﻿package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	
	public class Snow extends Updatable {
		
		private var speed:Number;
		
		public var radius:Number = 50;
		
		public var wasKilled:Boolean = false;
		
		public function Snow() {
			x = Math.random() * 550;
			y = -50;
			speed = Math.random() * 3 + 2; // 2 to 5?
			scaleX = Math.random() * .2 + .1; // .1 to .3
			scaleY = scaleX;
			radius *= scaleX
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