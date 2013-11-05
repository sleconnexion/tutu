package com.zoe.composants
{
	
	import flash.geom.Rectangle;
	
	import feathers.controls.Label;
	import feathers.display.Scale9Image;
	import feathers.layout.VerticalLayout;
	import feathers.textures.Scale9Textures;
	import feathers.themes.ZoeMobileTheme;
	
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class Boutonmenu extends starling.display.Sprite
	{
		public static const BOUTONMENU_MESSAGES:uint=1;
		public static const BOUTONMENU_COMMERCANTS:uint=2;
		public static const BOUTONMENU_CARTEFIDELITE:uint=3;
		public static const BOUTONMENU_ADRESSES:uint=4;
		public static const BOUTONMENU_CHERCHERADRESSE:uint=5;
		public static const BOUTONMENU_PROFIL:uint=6;
		public static const BOUTONMENU_TUTORIAL:uint=7;
		private var type:uint;
		public function Boutonmenu(zint:uint)
		{
			super();
			// represente la popup de menu, sous forme d un sprite
			type=zint;
			init(zint);
		}
		private function init(zint:uint):void{
			var bgt:Scale9Textures=new Scale9Textures(Root.assets.getTexture("btnblanc"),new Rectangle(10,5,55,10));
			var uneimg:Scale9Image=new Scale9Image(bgt);
			addChild(uneimg);
			uneimg.height=90;
			uneimg.width=90;
			majtype(zint);
			addEventListener(TouchEvent.TOUCH,onTouchbtn);
		}
		
		private function onTouchbtn(e:TouchEvent):void
		{
			var touch:Touch= e.getTouch(stage, TouchPhase.BEGAN);
			if (touch == null) return;
			// recup du btn
			trace("touch btn");
			switch (type){
				case BOUTONMENU_MESSAGES:
					//Root.partie.carto.viewPort=new Rectangle(-Root.partie.carto.viewPort.width,30,Root.partie.carto.viewPort.width,Root.partie.carto.viewPort.height);
					//partie.idshop=zaction;
					trace("touch btn message");
					this.dispatchEventWith(Root.MESMESSAGES_SCREEN,true);
					break;
				case BOUTONMENU_COMMERCANTS:
					trace("touch btn commercants");
					this.dispatchEventWith(Root.MESCOMERCANTS_SCREEN,true);
					break;
				case BOUTONMENU_CARTEFIDELITE:
					break;
				case BOUTONMENU_ADRESSES:
					trace("touch btn mesadresses");
					this.dispatchEventWith(Root.MESADRESSES_SCREEN,true);
					break;
				case BOUTONMENU_CHERCHERADRESSE:
					trace("touch btn chercheadresse");
					this.dispatchEventWith(Root.CHERCHEADRESSE_SCREEN,true);
					break;
				case BOUTONMENU_PROFIL:
					// check si identifie ou pas
					// si non identifié
					this.dispatchEventWith(Root.IDENTIFICATION_SCREEN,true);
					break;
				case BOUTONMENU_TUTORIAL:
					this.dispatchEventWith(Root.TUTO_SCREEN,true);
					break;				
			}
		}

		
		public function majtype(zint:uint):void{
			switch (zint){
				case BOUTONMENU_ADRESSES:
					var icoadresse:Image=new Image(Root.assets.getTexture("menupictoadresse"));
					icoadresse.x=20;
					icoadresse.y=7;
					var zlabadr:Label=new Label();
					zlabadr.nameList.add(ZoeMobileTheme.CARTOMENU_TITRE);
					zlabadr.text="Mes adresses";
					zlabadr.x=0;//-12;
					zlabadr.y=25;
					zlabadr.width=90;
					addChild(icoadresse);
					addChild(zlabadr);
					break;
				case BOUTONMENU_CARTEFIDELITE:
					var icofid:Image=new Image(Root.assets.getTexture("menupictofid"));
					icofid.x=20;
					icofid.y=7;
					var zlabfid:Label=new Label();
					zlabfid.nameList.add(ZoeMobileTheme.CARTOMENU_TITRE);
					zlabfid.text="Mes cartes de fidélité";
					zlabfid.x=0;
					zlabfid.y=25;
					zlabfid.width=90;
					addChild(icofid);
					addChild(zlabfid);
					break;
				case BOUTONMENU_CHERCHERADRESSE:
					var icofadresse:Image=new Image(Root.assets.getTexture("menupictochercher"));
					icofadresse.x=20;
					icofadresse.y=7;
					var zlabfad:Label=new Label();
					zlabfad.nameList.add(ZoeMobileTheme.CARTOMENU_TITRE);
					zlabfad.text="Chercher une adresse";
					zlabfad.x=0;
					zlabfad.y=25;
					zlabfad.width=90;
					addChild(icofadresse);
					addChild(zlabfad);
					break;
				case BOUTONMENU_COMMERCANTS:
					var icoco:Image=new Image(Root.assets.getTexture("menupictocommercants"));
					icoco.x=20;
					icoco.y=7;
					var zlabcom:Label=new Label();
					zlabcom.nameList.add(ZoeMobileTheme.CARTOMENU_TITRE);
					zlabcom.text="Mes commerçants";
					zlabcom.x=0;
					zlabcom.y=25;					
					zlabcom.width=90;
					addChild(icoco);
					addChild(zlabcom);
					break;
				case BOUTONMENU_MESSAGES:
					var icomsg:Image=new Image(Root.assets.getTexture("menupictomessage"));
					icomsg.x=20;
					icomsg.y=7;
					var zlabmsg:Label=new Label();
					zlabmsg.nameList.add(ZoeMobileTheme.CARTOMENU_TITRE);
					zlabmsg.text="Mes messages";
					zlabmsg.x=0;
					zlabmsg.y=25;
					zlabmsg.width=90;
					addChild(icomsg);
					addChild(zlabmsg);
					break;
				case BOUTONMENU_PROFIL:
					var icoprf:Image=new Image(Root.assets.getTexture("menupictoprofil"));
					icoprf.x=20;
					icoprf.y=7;
					var zlabprf:Label=new Label();
					zlabprf.nameList.add(ZoeMobileTheme.CARTOMENU_TITRE);
					zlabprf.text="\nMon profil";
					zlabprf.x=0;
					zlabprf.y=25;
					zlabprf.width=90;
					addChild(icoprf);
					addChild(zlabprf);
					break;
				case BOUTONMENU_TUTORIAL:
					var icotut:Image=new Image(Root.assets.getTexture("menupictotuto"));
					icotut.x=20;
					icotut.y=7;
					var zlabtut:Label=new Label();
					zlabtut.nameList.add(ZoeMobileTheme.CARTOMENU_TITRE);
					zlabtut.text="Tutorial";
					zlabtut.x=0;
					zlabtut.y=30;
					zlabtut.width=90;
					zlabtut.height=35;
					addChild(icotut);
					addChild(zlabtut);
					break;
			}			
		}
		public function majicon(ztext:String):void{
			
		}
	}
}