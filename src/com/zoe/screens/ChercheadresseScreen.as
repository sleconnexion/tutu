package com.zoe.screens
{
	import com.zoe.composants.Unshop;
	import com.zoe.objects.FBUserFactory;
	import com.zoe.objects.Partie;
	
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.media.StageWebView;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.List;
	import feathers.controls.Screen;
	import feathers.controls.ScrollContainer;
	import feathers.controls.TextInput;
	import feathers.data.ListCollection;
	import feathers.events.FeathersEventType;
	import feathers.layout.TiledRowsLayout;
	import feathers.layout.VerticalLayout;
	import feathers.themes.ZoeMobileTheme;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.events.Event;
	import starling.utils.Color;
	
	[Event(name="complete",type="starling.events.Event")]

	public class ChercheadresseScreen extends Screen
	{

		private var _backButton:Button;
		private var _iconmsg:Image;
		private var _labelico:Label;
		
		private var _labelnom:Label;
		private var _labeladresse:Label;
		private var _scrollvertical:ScrollContainer;
		public var partie:com.zoe.objects.Partie;
		private var container:ScrollContainer;
		private var _list:List;
		private var _textInput0:TextInput;
		private var _groceryList:ListCollection;
		public function ChercheadresseScreen()
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
			_labelico.text="Chercher une adresse";
			addChild(_labelico);
						
			
			
			
//			list.itemRendererProperties.iconSourceField = "thumbnail";
			
/*			
			_btnretour=new starling.display.Button(Root.assets.getTexture("btnretour"));
			_btnretour.addEventListener(starling.events.Event.TRIGGERED, btnretourButton_triggeredHandler);
			addChild(_btnretour);			
*/
			
/*			
			var st:StageWebView=new StageWebView();
			st.loadURL("http://www9.noomiz.com/ruecentrale/chercheadresse/iduser/11");
			st.stage=Starling.current.nativeStage;
			st.viewPort=new Rectangle(0,30,300,300);
*/	
			
			
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

		private function onError(e):void{
			trace("erreur");
			trace (e);
		}
	}
}