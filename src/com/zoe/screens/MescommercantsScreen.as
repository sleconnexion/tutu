package com.zoe.screens
{
	import com.zoe.composants.Homercloader;
	import com.zoe.composants.Unshop;
	import com.zoe.objects.FBUserFactory;
	import com.zoe.objects.Partie;
	
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	
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

	public class MescommercantsScreen extends Screen
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
		private var _icorech:Image;
		private var _groceryList:ListCollection;

		private var rcl:Homercloader;
		private var _labelmsg:Label;

		public function MescommercantsScreen()
		{
			super();	
		}
		
		override protected function initialize():void
		{
			trace("messagescreen initialize");
			Root.afficherbg();
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
			_iconmsg=new Image(Root.assets.getTexture("pictocommerce"));
			addChild(_iconmsg);
			_labelico=new Label();
			_labelico.nameList.add(ZoeMobileTheme.LABEL_ICO);
			_labelico.text="Mes commerçants";
			addChild(_labelico);
						
		
			
			_textInput0= new TextInput();
			_textInput0.addEventListener(flash.events.Event.CHANGE, input_changeHandler);
			
			_textInput0.nameList.add(ZoeMobileTheme.MESCOMRECHERCHE);
			_textInput0.prompt="Rechercher un commerçant par nom";
			addChild(_textInput0);
						
			_icorech=new Image(Root.assets.getTexture("loupe"));
			addChild(_icorech);
			
//			list.itemRendererProperties.iconSourceField = "thumbnail";
			
/*			
			_btnretour=new starling.display.Button(Root.assets.getTexture("btnretour"));
			_btnretour.addEventListener(starling.events.Event.TRIGGERED, btnretourButton_triggeredHandler);
			addChild(_btnretour);			
*/
						
			_scrollvertical=new ScrollContainer();
//			addChild(_scrollvertical);
			
			_labelnom=new Label();
			_labelnom.y=10;
			_scrollvertical.addChild(_labelnom);
			
			var layout:TiledRowsLayout= new TiledRowsLayout();
			layout.typicalItemHeight=200;
			container= new ScrollContainer()
			//container.layout = layout;
			
				var ll:VerticalLayout=new VerticalLayout();
				ll.horizontalAlign=VerticalLayout.HORIZONTAL_ALIGN_CENTER;
				ll.gap=10;
				container.layout=ll;
			
			addChild(container);
			_list= new List();
			
			_list.width = 300;
			_list.height = 300;
			this.addChild(_list);
			_list.visible=false;
			_list.y=60;
			_list.x=10;
			_groceryList= new ListCollection(
				[
					{ text: "Milk"},
					{ text: "Eggs"},
					{ text: "Bread"},
					{ text: "Chicken" },
				]);
			_list.dataProvider = _groceryList;
			_list.itemRendererProperties.labelField = "text";

			
			rcl=new Homercloader();
			addChild(rcl);	
			rcl.start();
			_labelmsg=new Label();
			_labelmsg.nameList.add(ZoeMobileTheme.ROOT_LABPRG);
			addChild(_labelmsg);
			_labelmsg.text="Récupération de la \n liste de vos commerçants";
			
			container.visible=false;
			recupmescommerces();
			
			// test
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
			
			_textInput0.x=10;
			_textInput0.y=40;
			_textInput0.width=280;
			
			_icorech.x=_textInput0.x+_textInput0.width;
			_icorech.y=_textInput0.y;
			
			
			container.y=70;
			container.width=this.actualWidth;
			container.height=this.actualHeight-70;
			
			rcl.x=this.actualWidth/2;
			rcl.y=220;
			_labelmsg.width=this.actualWidth;
			_labelmsg.y=rcl.y+60;
			
		}
				
		private function input_changeHandler(e:starling.events.Event):void{
			trace("changing=>"+_textInput0.text);
//			var obj:Object=new Object();
			//obj.text=_textInput0.text;
			
			
			for (var i:int=0;i< container.numChildren;i++){
				// on filtre la liste
				var unshop:Unshop=container.getChildAt(i) as Unshop;
				unshop.filtrer(_textInput0.text);
//					container.width=320;
//					container.invalidate();
//					container.validate();
			}
		
			container.scrollToPosition(0,10);
		
			return;
			var filteredarray:ListCollection=new ListCollection();
			var _dataLen:int = _groceryList.length;
			for(var i:int = 0; i < _dataLen; i++) {
				if((_groceryList.getItemAt(i)).text=="Milk"){
				trace((_groceryList.getItemAt(i)).text);
				filteredarray.push(_groceryList.getItemAt(i));
				}
			}
			
			_groceryList.push({text:_textInput0.text});
			_list.dataProvider=filteredarray;
			// filtre les elts qui conviennet
			_list.visible=true;
			
			
		}
		private function onEnter(e:FeathersEventType):void{
			trace("enter");
//			setTimeout(textInput1.setFocus,200);
		}

		private function recupmescommerces():void{
			var xloaderq:URLLoader= new URLLoader();
			xloaderq.addEventListener(flash.events.Event.COMPLETE, xmlinfosLoaded);
			var zurl:URLRequest=new URLRequest(FBUserFactory.getUser().prefix+"/jsonrecupmescommerces");
			zurl.method = URLRequestMethod.POST;
			var zdata:URLVariables=new URLVariables();
			zdata.iduser=FBUserFactory.getUser().user.IDUSER;
			zurl.data=zdata;
			xloaderq.load (zurl);
		}
		private function xmlinfosLoaded(event:flash.events.Event):void {
			var loader:URLLoader = URLLoader(event.target);
			var zret:Object =JSON.parse(loader.data);
			if(zret.ok==1){
				trace("xmlinfosLoaded ok");
				trace(zret.msg);
				// on affiche en conséquence
				// parcours des msg
				rcl.stop();
				_labelmsg.text="";
				container.visible=true;
				if(zret.shops){
					if(zret.shops.length>0){
						for(var ii:uint=0;ii<zret.shops.length;ii++){
							trace("MSG=>"+ii+zret.shops[ii].NOMSHOP);
							ajoutershop(zret.shops[ii]);
						}
						if(zret.shops.length==1){
							_labelico.text="Mon commerçant";
						} else {
							_labelico.text="Mes "+zret.shops.length+" commerçants";
						}

					} else {
						// pas de shop suivi
						_labelmsg.y=60;
						_labelmsg.text="Vous ne suivez actuellement aucun commerçant.";
						var _labelmsg2:Label=new Label();
						_labelmsg2.nameList.add(ZoeMobileTheme.COMMONLABNOCO);
						_labelmsg2.text="Pour suivre un commerçant et recevoir ses bons plans,\ncliquez sur le bouton « Suivre » depuis sa fiche.";
						addChild(_labelmsg2);
						_labelmsg2.width=320;
						_labelmsg2.y=75;
						
						var imgsuivi:Image=new Image(Root.assets.getTexture("imagesuivicommerce"));
						addChild(imgsuivi);
						imgsuivi.y=105;
						imgsuivi.x=20;						
					}
				} else {
					rcl.stop();
					_labelmsg.text="Nous sommes désolé, \nune erreur technique est survenue";
				}
			}
		}
		private function ajoutershop(zshop:Object):void{
			trace("magasin:"+zshop.NOMSHOP);
			container.addChild(new Unshop(zshop));
		}
		
		private function clickmsg(event:starling.events.Event):void
		{
			// 
			trace("clickmsg")
			this.dispatchEventWith("messagescreen");
		}
		
		private function onBackButton():void
		{
			trace("bacckbutton");
			partie.typenav=1;
			if(partie.fromscreen=="root"){
				partie.typenav=0;	
			} 
			
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