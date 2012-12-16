package  
{
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	
	/**
	 * ...
	 * @author Waveon Foxdale
	 */
	public class Player extends CarBase
	{
		//source of the car image
		[Embed(source = "/images/player_car.png")] private var carImg:Class;
		
		public function Player(X:int, Y:int) 
		{
			//Set the initial position of the player
			super(X - 16, Y - 32);
			
			//load the sprite
			this.loadGraphic(carImg, false, false, 32, 64);
			
			//set the speed of the player
			this.maxVelocity.x = 250;
			this.maxVelocity.y = 250;
		}
		
		override public function update():void 
		{
			super.update();
			
			//check if the player collides with the border of the screen
			checkBorderCollide();
			
			//check if the player presses a movement key
			checkMovement();
		}
		
		private function checkBorderCollide():void
		{
			//check the left side
			if (this.x <= 0)
			{
				this.x = 0;
			}
			
			//check the top side
			if (this.y <= 0)
			{
				this.y = 0;
			}
			
			//check the right side
			if (this.x + this.width >= FlxG.width)
			{
				this.x = FlxG.width - this.width;
			}
			
			//check the bottom side
			if (this.y + this.height >= FlxG.height)
			{
				this.y = FlxG.height - this.height;
			}
		}
		
		private function checkMovement():void
		{
			if (FlxG.keys.UP)
			{
				//move the sprite up
				this.acceleration.y = -this.maxVelocity.y * 4;
			}
			
			if (FlxG.keys.RIGHT)
			{
				//move the sprite to the right
				this.acceleration.x = this.maxVelocity.x * 4;
			}
			
			if (FlxG.keys.DOWN)
			{
				//move the sprite down
				this.acceleration.y = this.maxVelocity.y * 4;
			}
			
			if (FlxG.keys.LEFT)
			{
				//move the sprite to the left
				this.acceleration.x = -this.maxVelocity.x * 4;
			}
		}
		
	}

}