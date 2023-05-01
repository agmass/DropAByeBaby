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

class TipSubstate extends FlxState
{
	var sprite:FlxSprite = new FlxSprite(0, 0);

	override public function create():Void
	{
		FlxG.sound.music = new FlxSound();
		FlxG.sound.music.loadEmbedded(AssetPaths.theCalmBeforeTheCalmBeforeTheStorm__wav, true);
		FlxG.sound.music.play();
		sprite.loadGraphic(AssetPaths.t__png);
		add(sprite);
		super.create();
	}

	override public function update(elapsed:Float):Void
	{
		if (FlxG.keys.justPressed.ENTER)
		{
			FlxG.sound.music.stop();
			FlxG.sound.play(AssetPaths.sound__wav);
			FlxG.camera.fade(FlxColor.BLACK, 0.5, false, function()
			{
				FlxG.switchState(new PlayState());
			});
		}
		super.update(elapsed);
	}
}
