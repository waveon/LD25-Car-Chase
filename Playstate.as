package  
{
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	
	import org.flixel.plugin.photonstorm.FlxDelay;
	
	/**
	 * ...
	 * @author Waveon Foxdale
	 */
	public class Playstate extends FlxState
	{
		//source of the sound
		[Embed(source = "sounds/crash.mp3")] private var crashSnd:Class;
		
		//variables to store the background
		private var background:FlxGroup = new FlxGroup();
		
		//variables to store the player, police and civilians
		private var player:PlayerController, police:FlxGroup = new FlxGroup(), civilians:FlxGroup = new FlxGroup();
		
		//delays for new civilian and enemy spawning
		private var enemySpawnTimer:FlxDelay = new FlxDelay(5000);
		private var civilianSpawnTimer:FlxDelay = new FlxDelay(2500);
		private var extraPoliceTimer:FlxDelay = new FlxDelay(30000);
		
		//variables for the score and various text
		private var score:int = 0, scoreText:FlxText, endText:FlxText;
		
		//counter for how many police spawn at once
		private var policeSpawn:int = 1;
		
		override public function create():void 
		{
			//create the background first so it's behind everything
			//two are created for an endless background illusion
			add(this.background);
			this.background.add(new Background(0));
			this.background.add(new Background(FlxG.height * -1));
			
			//create the player
			this.player = new PlayerController(FlxG.width / 2, FlxG.height/ 2);
			add(player);
			
			//initialize and add the bullets so they can be used
			Registry.Pbullets = new FlxGroup();
			add(Registry.Pbullets);
			
			//create a police
			add(police);
			this.police.add(new Police((FlxG.random() * 513) + 128, FlxG.height + 100));
			
			//create a civilian
			add(civilians);
			this.civilians.add(new Civilian((FlxG.random() * 513) + 128, -100));
			
			//create the score text last so it's on top of everything
			this.scoreText = new FlxText(8, 8, 150, "Score: " + this.score);
			this.scoreText.setFormat(null, 20);
			//Add the scrore text as last so it's on top of the sprites
			add(this.scoreText);
			
			//create the game over text and set it invisible
			this.endText = new FlxText(200, 200, 450, "Game Over!\n\nPress enter to try again");
			this.endText.setFormat(null, 30, 0xffffff, "center");
			this.endText.visible = false;
			add(endText);
			
			//start the timers
			this.enemySpawnTimer.start();
			this.civilianSpawnTimer.start();
			this.extraPoliceTimer.start();
		}
		
		override public function update():void 
		{
			super.update();
			
			//update the score
			updateScore();
			
			//send the player position to the police car
			police.members.forEach(sendPlayerData);
			
			//check if a spawn timer has expired
			checkSpawnTimer();
			
			//check if the cars collide with each other
			checkCollide();
			
			if (!this.player.playerIsAlive)
			{
				//show the game over text if the player is dead
				endGame();
				
				//reset the game when the player presses enter
				if(FlxG.keys.justPressed("ENTER"))
				{
					//Fade out before resetting the state
					FlxG.camera.fade(0x00000000, 1, resetState);
				}
			}
		}
		
		override public function destroy():void
		{
			//override the destroy function so objects in the registry are destroyed properly
			Registry.destroy();
			
			//continue destroying other objects
			super.destroy();
		}
		
		private function updateScore():void
		{
			//update the score if the player is still alive
			if (this.player.playerIsAlive)
			{
				this.score++;
				this.scoreText.text = "Score: " + this.score;
			}
		}
		
		private function sendPlayerData(element:Police, index:int, array:Array):void
		{
			//check if the police entity isn't empty, undefined or null
			if (element != null)
			{
				//Pass the player's position to the police
				element.getPlayerData(this.player.playerX, this.player.playerY)
			}
		}
		
		private function checkSpawnTimer():void
		{
			//spawn a new civilian or police when the timer is expired
			if (this.civilianSpawnTimer.hasExpired)
			{
				this.civilians.add(new Civilian((FlxG.random() * 513) + 128, -100));
				
				this.civilianSpawnTimer = new FlxDelay(7500);
				this.civilianSpawnTimer.start();
			}
			
			if (this.enemySpawnTimer.hasExpired)
			{
				for (var i:int = 0; i < this.policeSpawn; i++) 
				{
					this.police.add(new Police((FlxG.random() * 513) + 128, FlxG.height + 100));
				}
				
				this.enemySpawnTimer = new FlxDelay(12000);
				this.enemySpawnTimer.start();
			}
			
			//raise the counter when the timer has expired
			if (this.extraPoliceTimer.hasExpired) 
			{
				this.policeSpawn++;
				
				this.extraPoliceTimer = new FlxDelay(30000);
				this.extraPoliceTimer.start();
			}
		}
		
		private function checkCollide():void
		{
			//check if the cars collide with each other
			//note: civilians are allowed to collide with each other
			//Same goes for the police
			FlxG.collide(this.player, this.police, carKill);
			FlxG.collide(this.player, this.civilians, carKill);
			FlxG.collide(this.police, this.civilians, carKill);
			FlxG.collide(this.civilians, this.civilians, carKill);
			
			//check if the player's bullets hit a car
			FlxG.collide(Registry.Pbullets, this.police, BulletHitCar);
			FlxG.collide(Registry.Pbullets, this.civilians, BulletHitCar);
		}
		
		private function carKill(obj1:CarBase, obj2:CarBase):void
		{
			//Kill the cars
			//Check first if the cars exists to prevent null errors
			if (obj1 != null && obj2 != null)
			{
				obj1.kill();
				obj2.kill();
				
				FlxG.play(crashSnd);
			}
		}
		
		private function BulletHitCar(obj1:PlayerBullet, obj2:CarBase):void
		{
			//kill the bullet and car
			//check first if the objects exists to prevent null errors
			if (obj1 != null && obj2 != null)
			{
				obj1.kill();
				obj2.kill();
				
				FlxG.play(crashSnd);
			}
		}
		
		private function endGame():void
		{
			if (!this.endText.visible)
			{
				//make the game over text visible
				this.endText.visible = true;
			}
		}
		
		private function resetState():void
		{
			//Reset the PlayState
			FlxG.resetState();
		}
	}
}