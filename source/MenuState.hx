package;

import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxSubState;
import flixel.addons.plugin.taskManager.FlxTask;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

class MenuState extends FlxState
{
	var sprite:FlxSprite = new FlxSprite(0, 0);
	var title:FlxText;
	var play:FlxText;
	var menu:FlxText;
	var selection:Int = 0;
	var sine:Int = 0;

	override public function create():Void
	{
		FlxG.sound.music = new FlxSound();
		FlxG.sound.music.loadEmbedded(AssetPaths.theVERYENERGETICTUNEBeforeTheCalmBeforeTheCalmBeforeTheStorm__wav, true);
		FlxG.sound.music.play();
		FlxG.cameras.reset();
		sprite.loadGraphic(AssetPaths.trueart__png);
		sprite.alpha = 0.5;
		add(sprite);
		var hint:FlxText = new FlxText(0, FlxG.height - 32, 0, "Use the arrow keys & enter to navigate menus!", 16);
		add(hint);
		super.create();
		title = new FlxText(0, 0, 0, "Drop-a-bye, Baby!", 64);
		title.screenCenter();
		title.color = FlxColor.GRAY;
		title.scrollFactor.set(0, 0);
		title.y -= 128;
		title.alpha = 0;
		FlxTween.tween(title, {alpha: 1}, 0.1);
		title.setBorderStyle(FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, 1, 1);
		add(title);

		play = new FlxText(0, 0, 0, "Play", 32);
		play.screenCenter();
		play.scrollFactor.set(0, 0);

		play.y -= 48;
		play.alpha = 0;
		FlxTween.tween(play, {alpha: 0.75}, 0.1);
		play.setBorderStyle(FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, 1, 1);
		add(play);

		menu = new FlxText(0, 0, 0, "Credits", 32);
		menu.screenCenter();
		menu.scrollFactor.set(0, 0);
		menu.alpha = 0;
		FlxTween.tween(menu, {alpha: 0.75}, 0.1);
		menu.setBorderStyle(FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, 1, 1);
		add(menu);

		FlxTween.tween(title, {y: title.y - 32}, 2, {type: PINGPONG, ease: FlxEase.sineInOut});
	}

	override public function update(elapsed:Float):Void
	{
		if (selection != 100)
		{
			if (FlxG.keys.justPressed.UP)
			{
				selection -= 1;
			}
			if (FlxG.keys.justPressed.DOWN)
			{
				selection += 1;
			}
			if (selection <= -1)
			{
				selection = 50;
			}
			if (selection >= 2)
			{
				selection = 0;
			}
			/*menu.screenCenter();
				menu.scrollFactor.set(0, 0);
				title.screenCenter();
				title.scrollFactor.set(0, 0);
				title.y -= 64;
				play.screenCenter();
				play.scrollFactor.set(0, 0);
				play.y -= 16; */

			play.color = FlxColor.WHITE;
			play.scale.set(0.75, 0.75);
			play.alpha = 0.75;

			menu.color = FlxColor.WHITE;
			menu.scale.set(0.75, 0.75);
			menu.alpha = 0.75;

			switch (selection)
			{
				case 0:
					play.color = FlxColor.YELLOW;
					play.scale.set(1.25, 1.25);
					play.alpha = 1;
					if (FlxG.keys.justPressed.ENTER)
					{
						FlxG.sound.music.stop();
						selection = 100;
						FlxG.sound.play(AssetPaths.sound__wav);
						FlxG.camera.fade(FlxColor.BLACK, 0.5, false, function funny()
						{
							new FlxTimer().start(1.5, function(tmr)
							{
								FlxG.switchState(new TipSubstate());
							});
						});
					}
				case 1:
					menu.color = FlxColor.YELLOW;
					menu.scale.set(1.25, 1.25);
					menu.alpha = 1;
					if (FlxG.keys.justPressed.ENTER)
					{
						FlxG.sound.play(AssetPaths.sound__wav);
						var tempState:CreditsSubState = new CreditsSubState();
						openSubState(tempState);
					}
			}
		}
		super.update(elapsed);
	}
}
