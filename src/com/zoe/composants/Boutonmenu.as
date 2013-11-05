package com.zoe.composants
{
	import feathers.controls.Button;	
	import starling.events.Event;
	
	public class Boutonmenu extends Button
	{
		public static const BOUTONMENU_MESSAGES:uint=1;
		public static const BOUTONMENU_COMMERCANTS:uint=2;
		public static const BOUTONMENU_CARTEFIDELITE:uint=3;
		public static const BOUTONMENU_ADRESSES:uint=4;
		public static const BOUTONMENU_CHERCHERADRESSE:uint=5;
		public static const BOUTONMENU_PROFIL:uint=6;
		public static const BOUTONMENU_TUTORIAL:uint=7;
		public var idmenu:uint;
		public function Boutonmenu(zint:uint)
		{
			super();
			// represente la popup de menu, sous forme d un sprite
			idmenu=zint;
			init(zint);
		}
		private function init(zint:uint):void{
			
			majtype(zint);
			isSelected=true;
			addEventListener(starling.events.Event.TRIGGERED, btn_triggeredHandler);
		}
		
		private function btn_triggeredHandler(event:starling.events.Event):void
		{
			trace("click");
			
			switch (idmenu){
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
					trace("touch btn mesadresses");
					this.dispatchEventWith(Root.MESCARTEFIDS_SCREEN,true);
					break;
				case BOUTONMENU_ADRESSES:
					trace("touch btn mesadresses");
					this.dispatchEventWith(Root.MESADRESSES_SCREEN,true);
					break;
				case BOUTONMENU_CHERCHERADRESSE:
					trace("touch btn chercheadresse");
					Root.chercheradresse();
					this.dispatchEventWith(Root.HOME_SCREEN,true);
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
					label="Mes \nadresses";
					break;
				case BOUTONMENU_CARTEFIDELITE:
					label="Mes cartes \nde fidélité";
					break;
				case BOUTONMENU_CHERCHERADRESSE:
					label="Chercher une adresse";
					break;
				case BOUTONMENU_COMMERCANTS:
					label="Mes commerçants";
					break;
				case BOUTONMENU_MESSAGES:
					label="Mes \nmessages";
					break;
				case BOUTONMENU_PROFIL:
					label="Mon \nprofil";
					break;
				case BOUTONMENU_TUTORIAL:
					label="Tutorial";
					break;
			}			
		}
		public function majicon(ztext:String):void{
			
		}
	}
}