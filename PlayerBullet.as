package  
{
	import org.flixel.FlxSprite;
	
	/**
	 * ...
	 * @author Waveon Foxdale
	 */
	public class PlayerBullet extends FlxSprite
	{
		//source of the bullet image
		[Embed(source = "/images/player_bullet.png")] private var bulletImg:Class;
		
		public function PlayerBullet(X:int, Y:int, Pfacing:uint) 
		{
			//Place the bullet at the given position
			super(X - 4, Y - 4);
			
			//load the sprite
			this.loadGraphic(bulletImg, false, false, 8, 8);
			
			//set the actual direction/angle
			var angle:int = 0;
			switch(Pfacing)
			{
				case 1:
					angle = -180;
					this.x -= 10;
					this.y += 5;
					break;
				case 256:
					angle = -90;
					this.x -= 20;
					this.y += 15;
					break;
				case 16:
					angle = 0;
					this.x += 10;
					this.y -= 5;
					break;
				case 4096:
					angle = 90;
					this.x += 20;
					this.y -= 15;
					break;
			}
			
			//calculate the radius of the angle
			var radius:Number = angle * (Math.PI / 180);
			
			//move the bullet in the direction of the angle
			this.velocity.x = Math.cos(radius) * 500;
			this.velocity.y = Math.sin(radius) * 500;
		}
		
		override public function update():void 
		{
			super.update();
			
			//destroy the bullet when it's off the screen
			if(!this.onScreen())
			{
				this.kill();
			}
		}
		
	}

}