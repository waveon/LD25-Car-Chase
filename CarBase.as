package  
{
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	
	/**
	 * ...
	 * @author Waveon Foxdale
	 */
	public class CarBase extends FlxSprite
	{
		//source of the sound
		[Embed(source = "sounds/crash.mp3")] private var crashSnd:Class;
		
		public function CarBase(X:int, Y:int) 
		{
			//Set the initial position of the civilian
			super(X, Y);
			
			//set the drag of the cars
			this.drag.x = this.maxVelocity.x * 4;
			this.drag.y = this.maxVelocity.y * 4;
		}
		
		override public function update():void 
		{
			super.update();
			
			//set the speed to 0 so the car won't move unnecessary
			this.acceleration.x = 0;
			this.acceleration.y = 0;
			
			//move the car when it's too far off the screen
			if (this.y < -200)
			{
				this.y = FlxG.height + 100;
			}
			else if(this.y > FlxG.height + 200)
			{
				this.y = -100;
			}
			
			//kill the car if it's off the road
			if (this.x < 125 - this.width || this.x > 675)
			{
				this.kill();
				FlxG.play(crashSnd);
			}
		}
		
	}

}