package com.zoe.screens
{
	import com.zoe.composants.Uneadresse;
	import com.zoe.objects.FBUserFactory;
	import com.zoe.objects.Partie;
	
	import flash.events.LocationChangeEvent;
	import flash.geom.Rectangle;
	import flash.media.StageWebView;
	
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.Screen;
	import feathers.controls.ScrollContainer;
	import feathers.themes.ZoeMobileTheme;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.events.Event;
	import starling.utils.Color;
	
	[Event(name="complete",type="starling.events.Event")]

	public class SaisiradresseScreen extends Screen
	{

		private var _backButton:Button;
		private var _iconmsg:Image;
		private var _labelico:Label;
		
		private var _labelnom:Label;
		private var _labeladresse:Label;
		private var _scrollvertical:ScrollContainer;
		public var partie:com.zoe.objects.Partie;

		private var stwv:StageWebView;
		
		public function SaisiradresseScreen()
		{
			super();	
		}
		
		override protected function initialize():void
		{
			trace("chercheadresse initialize");
			var q:Quad=new Quad(stage.width,stage.height,Color.BLACK);
			addChild(q);
			this._backButton = new Button();
			this._backButton.label = "retour";
			_backButton.nameList.add(ZoeMobileTheme.BOUTON_BACK);
			this._backButton.addEventListener(starling.events.Event.TRIGGERED, backButton_triggeredHandler);
			this.backButtonHandler = this.onBackButton;			
			addChild(_backButton);

			// zone du milieu
			_iconmsg=new Image(Root.assets.getTexture("pictoadresse"));
			addChild(_iconmsg);
			_labelico=new Label();
			_labelico.nameList.add(ZoeMobileTheme.LABEL_ICO);
			_labelico.text="Saisir une adresse";
			addChild(_labelico);
						
			// on regarde selo le type
			switch (Root.partie.typedata){
				case Uneadresse.MAISON:
					var imgpicto:Image=new Image(Root.assets.getTexture("maison"));
					imgpicto.x=20;
					imgpicto.y=40;
					addChild(imgpicto);
					
					var lablib:Label=new Label();
					lablib.nameList.add(ZoeMobileTheme.SAISIRADRESSESTITRE);
					lablib.text="Maison";
					lablib.x=45;
					lablib.width=150;
					lablib.y=42;
					addChild(lablib);
										
					break;
				case Uneadresse.BUREAU:
					break;
				default:
					break;				
			}
			
			
			
			// test
			
			stwv=new StageWebView();
			stwv.addEventListener(LocationChangeEvent.LOCATION_CHANGING,handleLocationChanging);

			stwv.loadURL(FBUserFactory.getUser().prefix+"/chercheadresse/iduser/"+FBUserFactory.getUser().user.IDUSER+"/type/"+Root.partie.typedata);
			trace("===========>"+FBUserFactory.getUser().prefix+"/chercheadresse/iduser/"+FBUserFactory.getUser().user.IDUSER+"/type/"+Root.partie.typedata);
			stwv.stage=Starling.current.nativeStage;
			stwv.viewPort=new Rectangle(0,80,300,300);			
		}
		override protected function draw():void
		{
			trace("draw message");
			_backButton.x=5;
			_backButton.y=5;
			
			_iconmsg.x=100;
			_iconmsg.y=10;
			
			_labelico.x=_iconmsg.x+30;
			_labelico.y=10;
			_labelico.width=200;
			
			//_scrollvertical.y=30;
//			_scrollvertical.height=this.actualHeight-30;
//			_scrollvertical.width=this.actualWidth;
			
		}
		
		private function handleLocationChanging( event:LocationChangeEvent ):void
		{
			trace("handleLocationChanging=>"+event.location);
			event.preventDefault();
			// on retourne
			stwv.stage=null;
			this.dispatchEventWith(Root.MESADRESSES_SCREEN,true);
			//			var data:Object = JSON.decode( event.location );
			//			trace( "Width: " + data.width + ", Height: " + data.height );
			
//			var data:Object = JSON.parse(event.location);
//			trace( "ok: " + data.ok + ", ok2: " + data.ok2);	
			//http://www9.noomiz.com/appelfiche/id/1331
			//om/appelfiche/id/1331
			trace(FBUserFactory.getUser().prefix);
			trace(FBUserFactory.getUser().prefix.length);
			var zaction:String=event.location.slice(FBUserFactory.getUser().prefix.length+1);
//			trace("zaction=>"+zaction);
//			switch (zaction){
//				case 'appelmenu':
//					break;
//				default:
//					break;
//			}
		}

		private function onBackButton():void
		{
			trace("bacckbutton");
			stwv.stage=null;
			this.dispatchEventWith(starling.events.Event.COMPLETE);
		}
		
		private function backButton_triggeredHandler(event:starling.events.Event):void
		{
			trace("click");
			this.onBackButton();
		}

		private function onError(e):void{
			trace("erreur");
			trace (e);
		}
	}
}