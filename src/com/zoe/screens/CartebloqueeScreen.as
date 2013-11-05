package com.zoe.screens
{
	import com.zoe.composants.Homercloader;
	import com.zoe.objects.FBUserFactory;
	import com.zoe.objects.Partie;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.geom.Rectangle;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.Screen;
	import feathers.controls.ScrollContainer;
	import feathers.controls.TextInput;
	import feathers.display.Scale3Image;
	import feathers.display.Scale9Image;
	import feathers.layout.HorizontalLayout;
	import feathers.layout.TiledRowsLayout;
	import feathers.layout.VerticalLayout;
	import feathers.textures.Scale3Textures;
	import feathers.textures.Scale9Textures;
	import feathers.themes.ZoeMobileTheme;
	
	import starling.display.Image;
	import starling.display.Quad;
	import starling.events.Event;
	import starling.utils.Color;
	
	[Event(name="complete",type="starling.events.Event")]
	[Event(name="validercartefidscreen",type="starling.events.Event")]
	
	public class CartebloqueeScreen extends Screen
	{

		private var _backButton:Button;
		private var _iconmsg:Image;
		private var _icondanger:Image;
		private var _labelico:Label;
		private var _labhaut:Label;
		
		public var partie:com.zoe.objects.Partie;
		private var _container:ScrollContainer;

		public function CartebloqueeScreen()
		{
			super();	
		}
		
		override protected function initialize():void
		{
			trace("cartefid initialize");
			var q:Quad=new Quad(stage.width,stage.height,Color.BLACK,true);
			q.alpha=0.7;
			addChild(q);
			this._backButton = new Button();
			this._backButton.label = "retour";
			_backButton.nameList.add(ZoeMobileTheme.BOUTON_BACK);
			this._backButton.addEventListener(starling.events.Event.TRIGGERED, backButton_triggeredHandler);
			this.backButtonHandler = this.onBackButton;			
			addChild(_backButton);

			// zone du milieu
			_iconmsg=new Image(Root.assets.getTexture("pictoadresse"));
//			addChild(_iconmsg);
			_labelico=new Label();
			_labelico.nameList.add(ZoeMobileTheme.LABEL_ICO);
			_labelico.text="Carte de fidélité";
//			addChild(_labelico);
			
			_container=new ScrollContainer();
			_container.backgroundSkin=new Scale9Image(new Scale9Textures(Root.assets.getTexture("fondorange"),new Rectangle(70,70,40,10)));
			var vl:VerticalLayout=new VerticalLayout();
			vl.horizontalAlign=HorizontalLayout.HORIZONTAL_ALIGN_CENTER;
			_container.layout=vl;
			vl.paddingTop=30;
			vl.gap=20;
			addChild(_container);

			_icondanger=new Image(Root.assets.getTexture("danger"));
			_container.addChild(_icondanger);
			
			_labhaut=new Label();
			_labhaut.nameList.add(ZoeMobileTheme.IDENTIFICATIONLABHAUT);
			_labhaut.text="Carte de fidélité bloquée jusqu'au "+partie.datebloque;
			_container.addChild(_labhaut);
			
					
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
			
			_container.y=100;
			_container.width=240;
			_container.x=(this.actualWidth-_container.width)/2;
			_container.height=160;
			
			_icondanger.x=(_container.width-_icondanger.width)/2;
			_labhaut.width=200;	
			_labhaut.x=(this.actualWidth-_labhaut.width)/2;
		}
		
		private function onBackButton():void
		{
			trace("bacckbutton");
			this.dispatchEventWith(starling.events.Event.COMPLETE);
		}		
		private function backButton_triggeredHandler(event:starling.events.Event):void
		{
			trace("click");
			this.onBackButton();
		}
	}
}