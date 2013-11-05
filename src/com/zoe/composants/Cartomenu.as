package com.zoe.composants
{
	
	import flash.geom.Rectangle;
	
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.display.Scale9Image;
	import feathers.layout.VerticalLayout;
	import feathers.textures.Scale9Textures;
	import feathers.themes.ZoeMobileTheme;
	
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	[Event(name="closemenug",type="starling.events.Event")]

	public class Cartomenu extends starling.display.Sprite
	{
		private var btnmsg:Boutonmenu;
		private var btncom:Boutonmenu;
		private var btnfid:Boutonmenu;
		private var btnadr:Boutonmenu;
		private var btnfnd:Boutonmenu;
		private var btnprf:Boutonmenu;
		private var btntut:Boutonmenu;
		
		
		public function Cartomenu()
		{
			super();
			// represente la popup de menu, sous forme d un sprite
			init();
		}
		private function init():void{
			var bgt:Scale9Textures=new Scale9Textures(Root.assets.getTexture("popupmenu"),new Rectangle(0,0,250,35));
			var uneimg:Scale9Image=new Scale9Image(bgt);
			addChild(uneimg);
			uneimg.height=400;
			uneimg.width=310;
			
			// header
			var qhdr:Quad=new Quad(307,30,0x000000);
			var labhdr:Label=new Label();
			labhdr.width=310;
			labhdr.text="MENU";
			labhdr.nameList.add(ZoeMobileTheme.COMMONLABHDRMENU);
			addChild(qhdr);
			addChild(labhdr);
				
			// btn fermer
			var btnclose:Button=new Button();
			btnclose.nameList.add(ZoeMobileTheme.COMMONBTNCLOSE);
			btnclose.x=285;
			btnclose.y=5,
			btnclose.addEventListener(starling.events.Event.TRIGGERED, closeButton_triggeredHandler);
			addChild(btnclose);
						
			// ajout des boutons
			btnmsg=new Boutonmenu(Boutonmenu.BOUTONMENU_MESSAGES);
			btncom=new Boutonmenu(Boutonmenu.BOUTONMENU_COMMERCANTS);
			btnfid=new Boutonmenu(Boutonmenu.BOUTONMENU_CARTEFIDELITE);
			btnadr=new Boutonmenu(Boutonmenu.BOUTONMENU_ADRESSES);
			btnfnd=new Boutonmenu(Boutonmenu.BOUTONMENU_CHERCHERADRESSE);
			btnprf=new Boutonmenu(Boutonmenu.BOUTONMENU_PROFIL);
			btntut=new Boutonmenu(Boutonmenu.BOUTONMENU_TUTORIAL);
			
			btnmsg.x=10;
			btnmsg.y=40;
			btncom.x=110;
			btncom.y=40;
			btnfid.x=210;
			btnfid.y=40;
			
			btnadr.x=10;
			btnadr.y=140;
			btnfnd.x=110;
			btnfnd.y=140;
			btnprf.x=210;
			btnprf.y=140;
			
			btntut.x=110;
			btntut.y=240;
			
			// aniation pour afficher les boutons
			addChild(btnmsg);
			addChild(btncom);
			addChild(btnfid);
			addChild(btnadr);
			addChild(btnfnd);
			addChild(btnprf);
			addChild(btntut);			
		}
		private function closeButton_triggeredHandler(event:starling.events.Event):void
		{
			trace("click fermer");
			this.dispatchEventWith("closemenug",true);
		}
	}
}