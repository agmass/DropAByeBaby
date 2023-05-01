package;

import haxe.io.Bytes;
import lime.utils.AssetBundle;
import lime.utils.AssetLibrary;
import lime.utils.AssetManifest;
import lime.utils.Assets;

#if sys
import sys.FileSystem;
#end

#if disable_preloader_assets
@:dox(hide) class ManifestResources {
	public static var preloadLibraries:Array<Dynamic>;
	public static var preloadLibraryNames:Array<String>;
	public static var rootPath:String;

	public static function init (config:Dynamic):Void {
		preloadLibraries = new Array ();
		preloadLibraryNames = new Array ();
	}
}
#else
@:access(lime.utils.Assets)


@:keep @:dox(hide) class ManifestResources {


	public static var preloadLibraries:Array<AssetLibrary>;
	public static var preloadLibraryNames:Array<String>;
	public static var rootPath:String;


	public static function init (config:Dynamic):Void {

		preloadLibraries = new Array ();
		preloadLibraryNames = new Array ();

		rootPath = null;

		if (config != null && Reflect.hasField (config, "rootPath")) {

			rootPath = Reflect.field (config, "rootPath");

			if(!StringTools.endsWith (rootPath, "/")) {

				rootPath += "/";

			}

		}

		if (rootPath == null) {

			#if (ios || tvos || emscripten)
			rootPath = "assets/";
			#elseif android
			rootPath = "";
			#elseif console
			rootPath = lime.system.System.applicationDirectory;
			#else
			rootPath = "./";
			#end

		}

		#if (openfl && !flash && !display)
		openfl.text.Font.registerFont (__ASSET__OPENFL__flixel_fonts_nokiafc22_ttf);
		openfl.text.Font.registerFont (__ASSET__OPENFL__flixel_fonts_monsterrat_ttf);
		
		#end

		var data, manifest, library, bundle;

		#if kha

		null
		library = AssetLibrary.fromManifest (manifest);
		Assets.registerLibrary ("null", library);

		if (library != null) preloadLibraries.push (library);
		else preloadLibraryNames.push ("null");

		#else

		data = '{"name":null,"assets":"aoy4:pathy25:assets%2Fdata%2FDABB.ogmoy4:sizei5372y4:typey4:TEXTy2:idR1y7:preloadtgoR0y24:assets%2Fdata%2Flvl.jsonR2i74666R3R4R5R7R6tgoR0y34:assets%2Fdata%2Fdata-goes-here.txtR2zR3R4R5R8R6tgoR0y33:assets%2Fimages%2Fbuildsprite.pngR2i468R3y5:IMAGER5R9R6tgoR0y29:assets%2Fimages%2Ftilemap.pngR2i1976R3R10R5R11R6tgoR0y26:assets%2Fimages%2Fbird.pngR2i7516R3R10R5R12R6tgoR0y29:assets%2Fimages%2Fexclaim.pngR2i372R3R10R5R13R6tgoR0y27:assets%2Fimages%2Fcloud.pngR2i1904R3R10R5R14R6tgoR0y30:assets%2Fimages%2FTHEBABYE.pngR2i1905R3R10R5R15R6tgoR0y30:assets%2Fimages%2Fbirdside.pngR2i910R3R10R5R16R6tgoR0y23:assets%2Fimages%2Ft.pngR2i49691R3R10R5R17R6tgoR0y24:assets%2Fimages%2Fbg.pngR2i4800R3R10R5R18R6tgoR0y29:assets%2Fimages%2Ftrueart.pngR2i22161R3R10R5R19R6tgoR0y27:assets%2Fimages%2Fagmas.pngR2i2303R3R10R5R20R6tgoR0y30:assets%2Fimages%2Floadbirb.pngR2i720R3R10R5R21R6tgoR0y24:assets%2Fimages%2Fsw.pngR2i7615R3R10R5R22R6tgoR0y30:assets%2Fimages%2Fblumanje.pngR2i5160R3R10R5R23R6tgoR0y36:assets%2Fimages%2Fimages-go-here.txtR2zR3R4R5R24R6tgoR2i11924714R3y5:SOUNDR5y26:assets%2Fmusic%2Fbreak.wavy9:pathGroupaR26hR6tgoR2i16483750R3R25R5y39:assets%2Fmusic%2FcalmBeforeTheStorm.wavR27aR28hR6tgoR2i6407006R3R25R5y32:assets%2Fmusic%2FwinnersTune.wavR27aR29hR6tgoR2i7619290R3R25R5y33:assets%2Fmusic%2FaHitAndAMiss.wavR27aR30hR6tgoR2i5973362R3R25R5y55:assets%2Fmusic%2FtheCalmBeforeTheCalmBeforeTheStorm.wavR27aR31hR6tgoR2i8484910R3R25R5y81:assets%2Fmusic%2FtheVERYENERGETICTUNEBeforeTheCalmBeforeTheCalmBeforeTheStorm.wavR27aR32hR6tgoR2i14138R3R25R5y29:assets%2Fsounds%2FhitHurt.wavR27aR33hR6tgoR2i18808R3R25R5y31:assets%2Fsounds%2Fexplosion.wavR27aR34hR6tgoR2i506994R3R25R5y27:assets%2Fsounds%2Fsound.wavR27aR35hR6tgoR2i8873R3R25R5y26:assets%2Fsounds%2Fexpl.wavR27aR36hR6tgoR2i16120R3R25R5y26:assets%2Fsounds%2Fgood.wavR27aR37hR6tgoR2i1730350R3y5:MUSICR5y34:assets%2Fsounds%2FaHitAndAMiss.mp3R27aR39hR6tgoR0y36:assets%2Fsounds%2Fsounds-go-here.txtR2zR3R4R5R40R6tgoR2i39706R3R38R5y28:flixel%2Fsounds%2Fflixel.mp3R27aR41y28:flixel%2Fsounds%2Fflixel.ogghR6tgoR2i2114R3R38R5y26:flixel%2Fsounds%2Fbeep.mp3R27aR43y26:flixel%2Fsounds%2Fbeep.ogghR6tgoR2i33629R3R25R5R42R27aR41R42hgoR2i5794R3R25R5R44R27aR43R44hgoR2i15744R3y4:FONTy9:classNamey35:__ASSET__flixel_fonts_nokiafc22_ttfR5y30:flixel%2Ffonts%2Fnokiafc22.ttfR6tgoR2i29724R3R45R46y36:__ASSET__flixel_fonts_monsterrat_ttfR5y31:flixel%2Ffonts%2Fmonsterrat.ttfR6tgoR0y33:flixel%2Fimages%2Fui%2Fbutton.pngR2i519R3R10R5R51R6tgoR0y36:flixel%2Fimages%2Flogo%2Fdefault.pngR2i3280R3R10R5R52R6tgh","rootPath":null,"version":2,"libraryArgs":[],"libraryType":null}';
		manifest = AssetManifest.parse (data, rootPath);
		library = AssetLibrary.fromManifest (manifest);
		Assets.registerLibrary ("default", library);
		

		library = Assets.getLibrary ("default");
		if (library != null) preloadLibraries.push (library);
		else preloadLibraryNames.push ("default");
		

		#end

	}


}


#if kha

null

#else

#if !display
#if flash

@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_dabb_ogmo extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_lvl_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_data_goes_here_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_buildsprite_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_tilemap_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_bird_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_exclaim_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_cloud_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_thebabye_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_birdside_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_t_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_bg_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_trueart_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_agmas_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_loadbirb_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_sw_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_blumanje_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_images_go_here_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_break_wav extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_calmbeforethestorm_wav extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_winnerstune_wav extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_ahitandamiss_wav extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_thecalmbeforethecalmbeforethestorm_wav extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_theveryenergetictunebeforethecalmbeforethecalmbeforethestorm_wav extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_hithurt_wav extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_explosion_wav extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_sound_wav extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_expl_wav extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_good_wav extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_ahitandamiss_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_sounds_go_here_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_sounds_flixel_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_sounds_beep_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_sounds_flixel_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_sounds_beep_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_images_ui_button_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_images_logo_default_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__manifest_default_json extends null { }


#elseif (desktop || cpp)

@:keep @:file("assets/data/DABB.ogmo") @:noCompletion #if display private #end class __ASSET__assets_data_dabb_ogmo extends haxe.io.Bytes {}
@:keep @:file("assets/data/lvl.json") @:noCompletion #if display private #end class __ASSET__assets_data_lvl_json extends haxe.io.Bytes {}
@:keep @:file("assets/data/data-goes-here.txt") @:noCompletion #if display private #end class __ASSET__assets_data_data_goes_here_txt extends haxe.io.Bytes {}
@:keep @:image("assets/images/buildsprite.png") @:noCompletion #if display private #end class __ASSET__assets_images_buildsprite_png extends lime.graphics.Image {}
@:keep @:image("assets/images/tilemap.png") @:noCompletion #if display private #end class __ASSET__assets_images_tilemap_png extends lime.graphics.Image {}
@:keep @:image("assets/images/bird.png") @:noCompletion #if display private #end class __ASSET__assets_images_bird_png extends lime.graphics.Image {}
@:keep @:image("assets/images/exclaim.png") @:noCompletion #if display private #end class __ASSET__assets_images_exclaim_png extends lime.graphics.Image {}
@:keep @:image("assets/images/cloud.png") @:noCompletion #if display private #end class __ASSET__assets_images_cloud_png extends lime.graphics.Image {}
@:keep @:image("assets/images/THEBABYE.png") @:noCompletion #if display private #end class __ASSET__assets_images_thebabye_png extends lime.graphics.Image {}
@:keep @:image("assets/images/birdside.png") @:noCompletion #if display private #end class __ASSET__assets_images_birdside_png extends lime.graphics.Image {}
@:keep @:image("assets/images/t.png") @:noCompletion #if display private #end class __ASSET__assets_images_t_png extends lime.graphics.Image {}
@:keep @:image("assets/images/bg.png") @:noCompletion #if display private #end class __ASSET__assets_images_bg_png extends lime.graphics.Image {}
@:keep @:image("assets/images/trueart.png") @:noCompletion #if display private #end class __ASSET__assets_images_trueart_png extends lime.graphics.Image {}
@:keep @:image("assets/images/agmas.png") @:noCompletion #if display private #end class __ASSET__assets_images_agmas_png extends lime.graphics.Image {}
@:keep @:image("assets/images/loadbirb.png") @:noCompletion #if display private #end class __ASSET__assets_images_loadbirb_png extends lime.graphics.Image {}
@:keep @:image("assets/images/sw.png") @:noCompletion #if display private #end class __ASSET__assets_images_sw_png extends lime.graphics.Image {}
@:keep @:image("assets/images/blumanje.png") @:noCompletion #if display private #end class __ASSET__assets_images_blumanje_png extends lime.graphics.Image {}
@:keep @:file("assets/images/images-go-here.txt") @:noCompletion #if display private #end class __ASSET__assets_images_images_go_here_txt extends haxe.io.Bytes {}
@:keep @:file("assets/music/break.wav") @:noCompletion #if display private #end class __ASSET__assets_music_break_wav extends haxe.io.Bytes {}
@:keep @:file("assets/music/calmBeforeTheStorm.wav") @:noCompletion #if display private #end class __ASSET__assets_music_calmbeforethestorm_wav extends haxe.io.Bytes {}
@:keep @:file("assets/music/winnersTune.wav") @:noCompletion #if display private #end class __ASSET__assets_music_winnerstune_wav extends haxe.io.Bytes {}
@:keep @:file("assets/music/aHitAndAMiss.wav") @:noCompletion #if display private #end class __ASSET__assets_music_ahitandamiss_wav extends haxe.io.Bytes {}
@:keep @:file("assets/music/theCalmBeforeTheCalmBeforeTheStorm.wav") @:noCompletion #if display private #end class __ASSET__assets_music_thecalmbeforethecalmbeforethestorm_wav extends haxe.io.Bytes {}
@:keep @:file("assets/music/theVERYENERGETICTUNEBeforeTheCalmBeforeTheCalmBeforeTheStorm.wav") @:noCompletion #if display private #end class __ASSET__assets_music_theveryenergetictunebeforethecalmbeforethecalmbeforethestorm_wav extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/hitHurt.wav") @:noCompletion #if display private #end class __ASSET__assets_sounds_hithurt_wav extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/explosion.wav") @:noCompletion #if display private #end class __ASSET__assets_sounds_explosion_wav extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/sound.wav") @:noCompletion #if display private #end class __ASSET__assets_sounds_sound_wav extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/expl.wav") @:noCompletion #if display private #end class __ASSET__assets_sounds_expl_wav extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/good.wav") @:noCompletion #if display private #end class __ASSET__assets_sounds_good_wav extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/aHitAndAMiss.mp3") @:noCompletion #if display private #end class __ASSET__assets_sounds_ahitandamiss_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/sounds-go-here.txt") @:noCompletion #if display private #end class __ASSET__assets_sounds_sounds_go_here_txt extends haxe.io.Bytes {}
@:keep @:file("/home/agmas/haxelib/flixel/5,2,2/assets/sounds/flixel.mp3") @:noCompletion #if display private #end class __ASSET__flixel_sounds_flixel_mp3 extends haxe.io.Bytes {}
@:keep @:file("/home/agmas/haxelib/flixel/5,2,2/assets/sounds/beep.mp3") @:noCompletion #if display private #end class __ASSET__flixel_sounds_beep_mp3 extends haxe.io.Bytes {}
@:keep @:file("/home/agmas/haxelib/flixel/5,2,2/assets/sounds/flixel.ogg") @:noCompletion #if display private #end class __ASSET__flixel_sounds_flixel_ogg extends haxe.io.Bytes {}
@:keep @:file("/home/agmas/haxelib/flixel/5,2,2/assets/sounds/beep.ogg") @:noCompletion #if display private #end class __ASSET__flixel_sounds_beep_ogg extends haxe.io.Bytes {}
@:keep @:font("export/html5/obj/webfont/nokiafc22.ttf") @:noCompletion #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends lime.text.Font {}
@:keep @:font("export/html5/obj/webfont/monsterrat.ttf") @:noCompletion #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends lime.text.Font {}
@:keep @:image("/home/agmas/haxelib/flixel/5,2,2/assets/images/ui/button.png") @:noCompletion #if display private #end class __ASSET__flixel_images_ui_button_png extends lime.graphics.Image {}
@:keep @:image("/home/agmas/haxelib/flixel/5,2,2/assets/images/logo/default.png") @:noCompletion #if display private #end class __ASSET__flixel_images_logo_default_png extends lime.graphics.Image {}
@:keep @:file("") @:noCompletion #if display private #end class __ASSET__manifest_default_json extends haxe.io.Bytes {}



#else

@:keep @:expose('__ASSET__flixel_fonts_nokiafc22_ttf') @:noCompletion #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "flixel/fonts/nokiafc22"; #else ascender = 2048; descender = -512; height = 2816; numGlyphs = 172; underlinePosition = -640; underlineThickness = 256; unitsPerEM = 2048; #end name = "Nokia Cellphone FC Small"; super (); }}
@:keep @:expose('__ASSET__flixel_fonts_monsterrat_ttf') @:noCompletion #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "flixel/fonts/monsterrat"; #else ascender = 968; descender = -251; height = 1219; numGlyphs = 263; underlinePosition = -150; underlineThickness = 50; unitsPerEM = 1000; #end name = "Monsterrat"; super (); }}


#end

#if (openfl && !flash)

#if html5
@:keep @:expose('__ASSET__OPENFL__flixel_fonts_nokiafc22_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__flixel_fonts_nokiafc22_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__flixel_fonts_nokiafc22_ttf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__flixel_fonts_monsterrat_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__flixel_fonts_monsterrat_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__flixel_fonts_monsterrat_ttf ()); super (); }}

#else
@:keep @:expose('__ASSET__OPENFL__flixel_fonts_nokiafc22_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__flixel_fonts_nokiafc22_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__flixel_fonts_nokiafc22_ttf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__flixel_fonts_monsterrat_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__flixel_fonts_monsterrat_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__flixel_fonts_monsterrat_ttf ()); super (); }}

#end

#end
#end

#end

#end