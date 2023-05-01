package;

import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import haxe.Int64Helper;

class MenuSubState extends FlxSubState
{
	var selection:Int = 0;
	var title:FlxText;
	var play:FlxText;
	var menu:FlxText;
	var restart:FlxText;
	var saves:FlxText;
	var uiCam:FlxCamera;
	var sprite:FlxSprite = new FlxSprite(0, 0);

	override public function create():Void
	{
		PlayState.FuckYouTimer = true;
		FlxG.sound.music = new FlxSound();
		FlxG.sound.music.loadEmbedded(AssetPaths.break__wav, true);
		FlxG.sound.music.play();
		uiCam = new FlxCamera(0, -FlxG.height);
		uiCam.bgColor.alpha = 0;
		FlxG.cameras.add(uiCam);
		sprite.makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		sprite.alpha = 0;
		sprite.camera = uiCam;
		FlxTween.tween(sprite, {alpha: 0.5}, 0.25);
		FlxTween.tween(uiCam, {y: 0}, 1.5, {ease: FlxEase.bounceOut});
		add(sprite);
		super.create();
		title = new FlxText(0, 0, 0, "You died!", 32);
		title.screenCenter();
		title.color = FlxColor.RED;
		title.scrollFactor.set(0, 0);
		title.y -= 64;
		title.alpha = 0;
		FlxTween.tween(title, {alpha: 1}, 0.1);
		title.setBorderStyle(FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, 1, 1);
		add(title);
		title.camera = uiCam;

		play = new FlxText(0, 0, 0, "Try again?", 16);
		play.screenCenter();
		play.scrollFactor.set(0, 0);
		play.y -= 16;
		play.alpha = 0;
		FlxTween.tween(play, {alpha: 0.75}, 0.1);
		play.setBorderStyle(FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, 1, 1);
		add(play);
		play.camera = uiCam;

		menu = new FlxText(0, 0, 0, "Return to Menu", 16);
		menu.screenCenter();
		menu.scrollFactor.set(0, 0);
		menu.alpha = 0;
		FlxTween.tween(menu, {alpha: 0.75}, 0.1);
		menu.setBorderStyle(FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, 1, 1);
		add(menu);
		menu.camera = uiCam;
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
			menu.screenCenter();
			menu.scrollFactor.set(0, 0);
			title.screenCenter();
			title.color = FlxColor.RED;
			title.scrollFactor.set(0, 0);
			title.y -= 64;
			play.screenCenter();
			play.scrollFactor.set(0, 0);
			play.y -= 16;

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
						uiCam.fade(FlxColor.BLACK, 0.5, false, function funny()
						{
							new FlxTimer().start(1.5, function(tmr)
							{
								FlxG.switchState(new PlayState());
							});
						});
					}
				case 1:
					menu.color = FlxColor.YELLOW;
					menu.scale.set(1.25, 1.25);
					menu.alpha = 1;
					if (FlxG.keys.justPressed.ENTER)
					{
						FlxG.sound.music.stop();
						selection = 100;
						FlxG.sound.play(AssetPaths.sound__wav);
						uiCam.fade(FlxColor.BLACK, 0.5, false, function funny()
						{
							new FlxTimer().start(1.5, function(tmr)
							{
								FlxG.switchState(new MenuState());
							});
						});
					}
			}
		}
		super.update(elapsed);
	}
}
