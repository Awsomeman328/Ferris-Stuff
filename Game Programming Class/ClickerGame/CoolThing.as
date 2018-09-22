package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import fl.motion.easing.Back;
	
	public class CoolThing extends MovieClip {
		
		/** The x-component of the acceleration in pixels/tick^2. */
		var aX:Number = 0;
		/** The y-component of the acceleration in pixels/tick^2. */
		var aY:Number = .125;
		/** Rotational acceleration in degrees/tick. */
		var aR:Number = 0;
		
		/** The x-component of the velocity in pixels/tick. */
		var vX:Number = 0;
		/** The y-component of the velocity in pixels/tick. */
		var vY:Number = 0;
		/** Rotational velocity in degrees/tick. */
		var vR:Number = 1;
		
		/** When this falls off the screen, this falue is set to true. This value tells
		 *  the Game object if this thing needs to die or not. */
		public var isOutOfBounds:Boolean = false;
		/** This value stores points to hand off to the Game object when this gets clicked. */
		public var unscoredPoints:int = 0;

		/** The constructor of the CoolThing class. */
		public function CoolThing() {
			// constructor code
			addEventListener(MouseEvent.MOUSE_DOWN, handleClick);
		} //ends constructor
		
		/**
		 * This is our update function. This is called every frame to run this object's logic.
		 */
		public function update():void {
			vX += aX;
			vY += aY;
			
			x += vX;
			y += vY;
			rotation += vR;
			
			if(x < 0 || x > 1200) {
				aX *= -1;
				vX *= -1;
			}
			if (y > 750) {
				isOutOfBounds = true;
				/*Play deathsounds. Disabled for the health of everyone's ears. Only un-comment at your own risk.
				var soundNum:int = Math.random() * 2 + 1; // 1 to 3
				var deathSound1:soundDeath1 = new soundDeath1;
				var deathSound2:soundDeath2 = new soundDeath2;
				var deathSound3:soundDeath3 = new soundDeath3;
				var sounds:Array = new Array;
				sounds.push(deathSound1);
				sounds.push(deathSound2);
				sounds.push(deathSound3);
				sounds[soundNum].play();
				*/
			}
		} //ends update
		
		/**
		 * This Function is called when the 'thingy' is clicked. Neat.
		 * @param e The MouseEvent object that is triggering this event-handler.
		 */
		function handleClick (e:MouseEvent):void {
			vX = Math.random() * 20 - 10; // -10 to 10
			vY = Math.random() * -5 - 5; // -0 to -5
			vR = Math.random() * 4 - 2; // -2 to 2
			unscoredPoints += 100;
			var soundNum:int = Math.random() * 5 + 1; // 1 to 6
			var blip:SoundBlip = new SoundBlip();
			var jeremySound1:JeremySound1 = new JeremySound1();
			var jeremySound2:JeremySound2 = new JeremySound2();
			var jeremySound3:JeremySound3 = new JeremySound3();
			var jeremySound4:JeremySound4 = new JeremySound4();
			var jeremySound5:JeremySound5 = new JeremySound5();
			var jeremySound6:JeremySound6 = new JeremySound6();
			var sounds:Array = new Array;
			sounds.push(jeremySound1);
			sounds.push(jeremySound2);
			sounds.push(jeremySound3);
			sounds.push(jeremySound4);
			sounds.push(jeremySound5);
			sounds.push(jeremySound6);
			sounds[soundNum].play();
		} //ends handleClick
	} //ends CoolThing class
} //ends package