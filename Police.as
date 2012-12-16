package  
{
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	
	/**
	 * ...
	 * @author Waveon Foxdale
	 */
	public class Police extends CarBase
	{
		//source of the car image
		[Embed(source = "/images/police_car.png")] private var carImg:Class;
		
		//declare variables to store the player's data
		private var playerX:int, playerY:int;
		
		public function Police(X:int, Y:int) 
		{
			//Set the initial position of the police
			super(X - 16, Y - 32);
			
			//load the sprite
			this.loadGraphic(carImg, true, false, 32, 64);
			this.addAnimation("driving", [0, 1], 5, true);
			
			//set the speed of the police
			this.maxVelocity.x = 100;
			this.maxVelocity.y = 100;
			
			//play the car animation
			this.play("driving");
		}
		
		override public function update():void 
		{
			super.update();
			
			//move the police car up
			this.acceleration.y = -this.maxVelocity.y * 4;
			
			//"slow the police car down" when it's at the same height as the player
			if (this.y < this.playerY + 32)
			{
				this.y = this.playerY + 32;
			}
			
			//move the car to the same horizontal position as the player
			if (this.x > this.playerX)
			{
				this.acceleration.x = -this.maxVelocity.x * 4;
			}
			else if (this.x < this.playerX)
			{
				this.acceleration.x = this.maxVelocity.x * 4;
			}
		}
		
		public function getPlayerData(PX:int, PY:int):void
		{
			this.playerX = PX;
			this.playerY = PY;
		}
		
	}

}