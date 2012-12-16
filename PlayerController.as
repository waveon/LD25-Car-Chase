package  
{
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
	import org.flixel.FlxText;
	
	/**
	 * ...
	 * @author Waveon Foxdale
	 */
	public class PlayerController extends FlxGroup
	{
		//source of the shoot sound
		[Embed(source = "sounds/shoot.mp3")] private var shootSnd:Class;
		
		//variable for the actual player
		private var player:Player;
		
		//variables for the ammo
		private var ammo:int = 30, ammoText:FlxText;
		
		public function PlayerController(X:int, Y:int) 
		{
			//create the actual player
			this.player = new Player(X, Y);
			add(this.player);
			
			//Create the ammo text
			this.ammoText = new FlxText(8, 32, 150, "Ammo: " + this.ammo);
			this.ammoText.setFormat(null, 20);
			//Add the scrore text as last so it's on top of the sprites
			add(this.ammoText);
		}
		
		override public function update():void 
		{
			super.update();
			
			//check if the player pressed a shoot button
			if (this.playerIsAlive && this.ammo > 0)
			{
				checkShooting();
			}
		}
		
		private function checkShooting():void
		{
			//create a bullet in the right direction if the player presses a shoot button
			if (FlxG.keys.justPressed("W"))
			{
				Registry.Pbullets.add(new PlayerBullet(this.playerX + (this.player.width / 2), this.playerY + (this.player.height / 2), FlxObject.UP));
				updateAmmo();
				FlxG.play(shootSnd);
			}
			else if (FlxG.keys.justPressed("A"))
			{
				Registry.Pbullets.add(new PlayerBullet(this.playerX + (this.player.width / 2), this.playerY + (this.player.height / 2), FlxObject.LEFT));
				updateAmmo();
				FlxG.play(shootSnd);
			}
			else if (FlxG.keys.justPressed("S"))
			{
				Registry.Pbullets.add(new PlayerBullet(this.playerX + (this.player.width / 2), this.playerY + (this.player.height / 2), FlxObject.DOWN));
				updateAmmo();
				FlxG.play(shootSnd);
			}
			else if (FlxG.keys.justPressed("D"))
			{
				Registry.Pbullets.add(new PlayerBullet(this.playerX + (this.player.width / 2), this.playerY + (this.player.height / 2), FlxObject.RIGHT));
				updateAmmo();
				FlxG.play(shootSnd);
			}
		}
		
		private function updateAmmo():void
		{
			//update the player's ammo
			this.ammo--;
			this.ammoText.text = "Ammo: " + this.ammo;
		}
		
		//getters
		public function get playerX():int { return this.player.x; }
		public function get playerY():int { return this.player.y; }
		public function get playerIsAlive():Boolean { return this.player.alive; }
		
	}

}