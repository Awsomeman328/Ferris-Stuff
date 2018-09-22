package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	public class Game extends MovieClip {
		
		var gameTime:int;
		
		public function Game() {
			// constructor code
			//trace("hello world");
			var john:Orc = new Orc();
			addChild(john);
			john.addEventListener(MouseEvent.CLICK, handleClick);
			john.addEventListener(KeyboardEvent.KEY_DOWN, handleKeyDown);
			john.addEventListener(KeyboardEvent.KEY_UP, handleKeyUp);
			john.x = 96;
			john.y = 490;
		} // ends constructor
		
		function handleClick(e:MouseEvent):void {
			trace("that tickled!");
		} // ends handleClick
		
		function handleKeyDown(e:KeyboardEvent):void {
			
		}

		function handleKeyUp(e:KeyboardEvent):void {
			
		}
	} // ends Game
} // ends package
