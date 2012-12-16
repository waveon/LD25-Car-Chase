package  
{
	import org.flixel.FlxBasic;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	
	/**
	 * ...
	 * @author Waveon Foxdale
	 */
	public class Title extends FlxState
	{
		//source of the sound
		[Embed(source = "sounds/select.mp3")] private var selectSnd:Class;
		
		//create variables for the texts
		private var titleText:FlxText, version:FlxText;
		private var storyText:FlxText, controlsText:FlxText, threatsText:FlxText;
		
		//variable for background image
		private var background:FlxGroup = new FlxGroup();
		
		//variables for the buttons
		private var startButton:Button, instructionButton:Button;
		private var backButton:Button, storyButton:Button, controlsButton:Button, threatsButton:Button;
		
		//groups for different parts for easy managing
		private var main:FlxGroup = new FlxGroup();
		private var instructItems:FlxGroup = new FlxGroup();
		private var instructTexts:FlxGroup = new FlxGroup();
		
		public function Title() 
		{
			//create a scrolling background
			add(this.background);
			this.background.add(new Background(0));
			this.background.add(new Background(FlxG.height * -1));
			
			//create the main items
			createMainItems();
			
			//create the instruction items
			createInstructItems();
		}
		
		private function createMainItems():void
		{
			//create the title
			this.titleText = new FlxText(8, 30, 800, "Car Chase");
			this.titleText.setFormat(null, 50, 0xffffff, "center");
			add(this.titleText);
			
			//create the buttons
			this.startButton = new Button(FlxG.width / 3 + 50, 200, "Start game");
			add(this.startButton);
			this.instructionButton = new Button(FlxG.width / 3 + 50, 300, "Instructions");
			add(this.instructionButton);
			
			//create the version
			this.version = new FlxText(8, FlxG.height - 30, 400, "Version 1.0");
			this.version.setFormat(null, 15, 0xffffff, "left");
			add(this.version);
			
			//add the main items in one group
			add(this.main);
			this.main.add(this.titleText);
			this.main.add(this.startButton);
			this.main.add(this.instructionButton);
			this.main.add(this.version);
		}
		
		private function createInstructItems():void
		{
			//this.version = new FlxText(8, FlxG.height - 30, 400, "Version 1.0");
			
			//create the buttons
			this.storyButton = new Button(10, FlxG.height - 75, "Story");
			add(this.storyButton);
			this.controlsButton = new Button(210, FlxG.height - 75, "Controls");
			add(this.controlsButton);
			this.threatsButton = new Button(410, FlxG.height - 75, "Threats");
			add(this.threatsButton);
			this.backButton = new Button(610, FlxG.height - 75, "Back");
			add(this.backButton);
			
			//create the texts
			[Embed(source = "texts/Story.txt", mimeType = "application/octet-stream")] var storyFile:Class;
			var storyString:String = new storyFile();
			this.storyText = new FlxText(10, 10, FlxG.width - 20, storyString);
			this.storyText.setFormat(null, 15, 0xffffff, "left");
			add(this.storyText);
			[Embed(source = "texts/Controls.txt", mimeType = "application/octet-stream")] var controlsFile:Class;
			var controlsString:String = new controlsFile();
			this.controlsText = new FlxText(10, 10, FlxG.width - 20, controlsString);
			this.controlsText.setFormat(null, 15, 0xffffff, "left");
			add(this.controlsText);
			[Embed(source = "texts/Threats.txt", mimeType = "application/octet-stream")] var threatsFile:Class;
			var threatsString:String = new threatsFile();
			this.threatsText = new FlxText(10, 10, FlxG.width - 20, threatsString);
			this.threatsText.setFormat(null, 15, 0xffffff, "left");
			add(this.threatsText);
			
			//add the instruction items in one group
			add(this.instructItems);
			this.instructItems.add(this.storyButton);
			this.instructItems.add(this.controlsButton);
			this.instructItems.add(this.threatsButton);
			this.instructItems.add(this.backButton);
			
			//add the instructions texts in their own group
			add(this.instructTexts);
			this.instructTexts.add(this.storyText);
			this.instructTexts.add(this.controlsText);
			this.instructTexts.add(this.threatsText);
			
			//hide the instructions by default
			this.instructItems.members.forEach(hideItems);
			this.instructTexts.members.forEach(hideItems);
		}
		
		override public function update():void
		{
			super.update();
			
			if (FlxG.mouse.justPressed())
			{
				//check where the player has clicked
				checkMousePosition(FlxG.mouse.screenX, FlxG.mouse.screenY);
			}
		}
		
		private function checkMousePosition(MX:int, MY:int):void
		{
			//check if clicked on start button
			if (this.startButton.visible && MX > this.startButton.buttonX && MX < this.startButton.buttonX + this.startButton.buttonW && MY > this.startButton.buttonY && MY < this.startButton.buttonY + this.startButton.buttonH)
			{
				//Fade out before switching to the playState
				FlxG.camera.fade(0x00000000, 1, changeState);
				FlxG.play(selectSnd);
			}
			
			//check if clicked on instruction button
			if (this.instructionButton.visible && MX > this.instructionButton.buttonX && MX < this.instructionButton.buttonX + this.instructionButton.buttonW && MY > this.instructionButton.buttonY && MY < this.instructionButton.buttonY + this.instructionButton.buttonH)
			{
				//show the instructions
				this.main.members.forEach(hideItems);
				this.instructItems.members.forEach(showItems);
				this.storyText.visible = true;
				FlxG.play(selectSnd);
			}
			
			//check if clicked on story button
			if (this.storyButton.visible && MX > this.storyButton.buttonX && MX < this.storyButton.buttonX + this.storyButton.buttonW && MY > this.storyButton.buttonY && MY < this.storyButton.buttonY + this.storyButton.buttonH)
			{
				//show the story text
				this.instructTexts.members.forEach(hideItems);
				this.storyText.visible = true;
				FlxG.play(selectSnd);
			}
			
			//check if clicked on controls button
			if (this.controlsButton.visible && MX > this.controlsButton.buttonX && MX < this.controlsButton.buttonX + this.controlsButton.buttonW && MY > this.controlsButton.buttonY && MY < this.controlsButton.buttonY + this.controlsButton.buttonH)
			{
				//show the controls text
				this.instructTexts.members.forEach(hideItems);
				this.controlsText.visible = true;
				FlxG.play(selectSnd);
			}
			
			//check if clicked on threats button
			if (this.threatsButton.visible && MX > this.threatsButton.buttonX && MX < this.threatsButton.buttonX + this.threatsButton.buttonW && MY > this.threatsButton.buttonY && MY < this.threatsButton.buttonY + this.threatsButton.buttonH)
			{
				//show the threats text
				this.instructTexts.members.forEach(hideItems);
				this.threatsText.visible = true;
				FlxG.play(selectSnd);
			}
			
			//check if clicked on back button
			if (this.backButton.visible && MX > this.backButton.buttonX && MX < this.backButton.buttonX + this.backButton.buttonW && MY > this.backButton.buttonY && MY < this.backButton.buttonY + this.backButton.buttonH)
			{
				//show the main screen
				this.main.members.forEach(showItems);
				this.instructItems.members.forEach(hideItems);
				this.instructTexts.members.forEach(hideItems);
				FlxG.play(selectSnd);
			}
		}
		
		private function changeState():void
		{
			//Switch to PlayState when enter has been pressed, thus starting the game
			FlxG.switchState(new Playstate());
		}
		
		private function hideItems(element:FlxBasic, index:int, array:Array):void
		{
			if (element != null)
			{
				element.visible = false;
			}
		}
		
		private function showItems(element:FlxBasic, index:int, array:Array):void
		{
			if (element != null)
			{
				element.visible = true;
			}
		}
	}
}