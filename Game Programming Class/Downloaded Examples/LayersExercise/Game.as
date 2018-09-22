package  {
	
	import flash.display.MovieClip;
	
	
	public class Game extends MovieClip {
		
		public function Game() {
			// constructor code
			setChildIndex(letterA, 4);
			setChildIndex(letterB, 3);
			setChildIndex(letterC, 2);
			setChildIndex(letterD, 1);
			setChildIndex(letterE, 0);
		}
	}	
}