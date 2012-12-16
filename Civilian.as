package  
{
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	
	/**
	 * ...
	 * @author Waveon Foxdale
	 */
	public class Civilian extends CarBase
	{
		//source of the car image
		[Embed(source = "/images/civilian_car.png")] private var carImg:Class;
		
		public function Civilian(X:int, Y:int) 
		{
			//Set the initial position of the civilian
			super(X - 16, Y - 32);
			
			//load the sprite
			this.loadGraphic(carImg, false, false, 32, 64);
			
			//set the speed of the police
			this.maxVelocity.x = 100;
			this.maxVelocity.y = 100;
		}
		
		override public function update():void 
		{
			super.update();
			
			//move the civilian car down
			this.acceleration.y = this.maxVelocity.y * 4;
		}
		
	}

}