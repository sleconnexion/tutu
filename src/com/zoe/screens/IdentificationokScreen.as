package com.zoe.screens
{
	import com.zoe.objects.FBUserFactory;
	import com.zoe.objects.Partie;
	
	import flash.geom.Rectangle;
	
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.Screen;
	import feathers.controls.ScrollContainer;
	import feathers.display.Scale9Image;
	import feathers.layout.HorizontalLayout;
	import feathers.layout.VerticalLayout;
	import feathers.textures.Scale9Textures;
	import feathers.themes.ZoeMobileTheme;
	
	import starling.display.Image;
	import starling.display.Quad;
	import starling.events.Event;
	import starling.utils.Color;
	
	[Event(name="complete",type="starling.events.Event")]

	public class IdentificationokScreen extends Screen
	{

		private var _backButton:Button;
		private var _iconmsg:Image;
		private var _labelico:Label;
		
		private var _labelnom:Label;
		private var _labeladresse:Label;
		private var _scrollvertical:ScrollContainer;
		public var partie:com.zoe.objects.Partie;
		private var _container:ScrollContainer;
		
		private var _labderniereadresse:Label;
		private var _labm:Label;
		
		private var _laberror:Label;
		private var _laberrormdp:Label;
		private var _laberrormail:Label;
		
		public function IdentificationokScreen()
		{
			super();	
		}
		
		override protected function initialize():void
		{
			trace("Identificationok initialize");
			var q:Quad=new Quad(stage.width,stage.height,Color.BLACK,true);
			q.alpha=0.7
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
			_labelico.text="S'identifier";
//			addChild(_labelico);
			
			_container=new ScrollContainer();
			_container.backgroundSkin=new Scale9Image(new Scale9Textures(Root.assets.getTexture("fondorange"),new Rectangle(70,70,40,10)));
			var vl:VerticalLayout=new VerticalLayout();
			vl.horizontalAlign=HorizontalLayout.HORIZONTAL_ALIGN_CENTER;
			_container.layout=vl;
			vl.paddingTop=20;
			vl.gap=5;
			addChild(_container);
			
			var labhaut:Label=new Label();
			labhaut.nameList.add(ZoeMobileTheme.IDENTIFICATIONLABHAUT);
			labhaut.text="Bravo "+FBUserFactory.getUser().user.PSEUDO+" !";
			_container.addChild(labhaut);
			labhaut.width=240;
			
			_labm=new Label();
			_labm.nameList.add(ZoeMobileTheme.IDENTIFICATIONLABM);
			_labm.text="Votre compte est maintenant créé.\n Vous pouvez accéder à l'ensemble des fonctionnalité de RueCentrale";
			_container.addChild(_labm);
			_labm.width=200;

			var btncontinuer:Button=new Button();
			btncontinuer.nameList.add(ZoeMobileTheme.IDENTIFICATIONBTNNOIR);
			btncontinuer.label="Continuer";
			btncontinuer.addEventListener(starling.events.Event.TRIGGERED, continuerButton_triggeredHandler);
			_container.addChild(btncontinuer);
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
			
			_container.y=140;
			_container.width=260;
			_container.x=(this.actualWidth-_container.width)/2;
			_container.height=200;			
		}
		
		private function onBackButton():void
		{
			trace("bacckbutton");
			this.dispatchEventWith(starling.events.Event.COMPLETE);
		}
		
		private function continuerButton_triggeredHandler(event:starling.events.Event):void
		{
			trace("click");
			this.dispatchEventWith(starling.events.Event.COMPLETE);
		}
		private function backButton_triggeredHandler(event:starling.events.Event):void
		{
			trace("click");
			this.onBackButton();
		}
	}
}