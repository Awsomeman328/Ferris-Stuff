package  {
	
	import flash.display.MovieClip;
	
	public class Game extends MovieClip {
		
		public function Game() {
			// constructor code
			
			var bg3 = new ArtBG3;
			var bg2 = new ArtBG2;
			var bg1 = new ArtBG1;
			var ground = new Ground;
			var crate1 = new ArtCrate;
			var crate2 = new ArtCrate;
			var player = new Player;
			var ui = new ArtUI;
			
			addChild(bg3);
			addChild(bg2);
			addChild(bg1);
			addChild(ground);
			addChild(crate1);
			addChild(crate2);
			addChild(player);
			addChild(ui);
			
			ground.y = stage.stageHeight - ground.height;
			bg1.y = 200;
			bg2.y = 100;
			
			crate1.y = stage.stageHeight - ground.height - crate1.height;
			crate1.x = 325;
			
			crate2.y = stage.stageHeight - ground.height - crate2.height;
			crate2.x = 600;
			
			player.y = stage.stageHeight - ground.height - player.height + 10;
			player.x = 50;
			
			ui.y = 10;
			ui.x = 10;
		} //ends constructor
	} //ends Game class
} //ends package